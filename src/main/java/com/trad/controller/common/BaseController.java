package com.trad.controller.common;

import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.fastjson.JSONObject;
import com.trad.bean.RolePermission;
import com.trad.bean.Roles;
import com.trad.bean.Tree;
import com.trad.bean.TreeVo;
import com.trad.bean.User;
import com.trad.bean.UserGroup;
import com.trad.bean.UserRoles;
import com.trad.service.RolesService;
import com.trad.service.TreeService;
import com.trad.service.UserGroupService;
import com.trad.util.TreeUtil;

@Controller
@RequestMapping("/base")
public class BaseController {
	
	@Resource
	private UserGroupService userGroupService;
	@Resource
	private RolesService rolesService;
	@Resource
	private TreeService treeService;
	
	Logger logger = LoggerFactory.getLogger(BaseController.class);
	
	@RequestMapping("/getUserTree")
	 public String getUserTree(HttpServletRequest request,Model model){  
		String roleId  = request.getParameter("roleId");
		List<Roles> roleList = rolesService.getUserTree(Integer.parseInt(roleId));
		List<Integer> roleUserList = new ArrayList<>();
		//根据角色ID获取该角色用户组数据
		if(roleList !=null && roleList.size()>0){
			for(Roles role :roleList){
				List<UserRoles> userRoles = role.getUserRoles();
				if(userRoles !=null && userRoles.size()>0){
					for(UserRoles userRole : userRoles){
						User user = userRole.getUser();
						roleUserList.add(user.getUserId());
					}
				}
			}
		}
		//获取用户组数据
		List<UserGroup> groupList = userGroupService.getAllGroup();
		//标记当前选中的用户数据
		if(groupList !=null && groupList.size()>0){
			for(UserGroup group :groupList){
				if(group.getUsers() !=null && group.getUsers().size()>0){
					for(User u : group.getUsers()){
						for(Integer userId : roleUserList){
							if(u.getUserId().equals(userId)){
								u.setChecked(true);
								break;
							}
						}
				}
				}
		}
		}
		model.addAttribute("userTree", groupList);
       return  "/common/userTree"; 
	}
	
	@RequestMapping(value="/getMenuTree",produces = "application/json;charset=UTF-8")
	 public String getMenuTree(HttpServletRequest request,Model model){
		try{
			List<TreeVo> treeVoList = null;
			String roleId  = request.getParameter("roleId");
			List<Roles> roleList = rolesService.getMenuTree(roleId);
			List<Tree> trees = treeService.getTreeList();
			//根据角色ID获取该角色用户组数据
			if(trees !=null && trees.size()>0 && roleList !=null && roleList.size()>0){
				    Roles role = roleList.get(0);
					List<RolePermission> rolePers = role.getRolePers();
					if(rolePers !=null && rolePers.size()>0){
						for(RolePermission rolePer : rolePers){
							Tree tree= rolePer.getTree();
							 for(Tree tr : trees){
								 if(tr.getTreeId().equals(tree.getTreeId())){
									 tr.setChecked(true);
								 }
							 }
						}
					}
					
			    //根据用户菜单获取用户权限树,不需要url
			    treeVoList = TreeUtil.queryTreeVoList(trees,false);
			}
			
             
			logger.info("获取到的该用户菜单树为："+JSONObject.toJSON(treeVoList));
			model.addAttribute("treeValue", JSONObject.toJSONString(treeVoList));
		}catch (IllegalAccessException e) {
			logger.error("初始化菜单树出错！");
			e.printStackTrace();
		}catch (InvocationTargetException e) {
			logger.error("初始化菜单树出错！");
			e.printStackTrace();
		}catch (Exception e) {
			logger.error("初始化过程出错！");
			e.printStackTrace();
		}
		return  "/common/menuTree"; 
	}
	
	
}
