package com.trad.controller.common;

import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.trad.bean.CommonGgdm;
import com.trad.bean.RolePermission;
import com.trad.bean.Roles;
import com.trad.bean.Tree;
import com.trad.bean.User;
import com.trad.bean.UserGroup;
import com.trad.bean.UserRoles;
import com.trad.bean.vo.TreeVo;
import com.trad.service.CommonGgdmService;
import com.trad.service.RolesService;
import com.trad.service.TreeService;
import com.trad.service.UserGroupService;
import com.trad.util.TreeUtil;

@Controller
@RequestMapping("/common")
public class CommonController {
	
	@Resource
	private UserGroupService userGroupService;
	@Resource
	private RolesService rolesService;
	@Resource
	private TreeService treeService;
	@Resource
	private CommonGgdmService ggdmService;
	
	Logger logger = LoggerFactory.getLogger(CommonController.class);
	
	@RequestMapping("/getUserTree")
	 public String getUserTree(HttpServletRequest request,Model model){  
		String roleId  = request.getParameter("roleId");
		String groupId  = request.getParameter("groupId");
		String onlySelect =  request.getParameter("onlySelect");
		String masterId = request.getParameter("masterId");
		List<UserGroup> groupList = null;
		try{
			groupList = userGroupService.getAllGroup(null);
			List<UserGroup> selectGroupList = null;
			List<Integer> roleUserList = new ArrayList<>();
			if(!StringUtils.isEmpty(masterId)){
				roleUserList.add(Integer.parseInt(masterId));
			}
			
			//获取小组选中对象
			if(!StringUtils.isEmpty(groupId)){
				selectGroupList = userGroupService.getAllGroup(Integer.parseInt(groupId));
				for(UserGroup ur : selectGroupList){
					List<User> users  = ur.getUsers();
					for(User user : users){
						roleUserList.add(user.getUserId());
					}
				}
			}
	
			if(!StringUtils.isEmpty(roleId)){
				List<Roles> roleList = rolesService.getUserTree(Integer.parseInt(roleId));
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
			}
			
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
		}catch(Exception e){
			e.printStackTrace();
		}
	   model.addAttribute("onlySelect", onlySelect);
	   model.addAttribute("userTree", groupList);
       return  "/common/userTree"; 
	}
	
	@RequestMapping(value="/getMenuTree",produces = "application/json;charset=UTF-8")
	 public String getMenuTree(HttpServletRequest request,Model model){
		try{
			List<TreeVo> treeVoList = null;
			String roleId  = request.getParameter("roleId");
			List<Tree> trees = treeService.getTreeList();
			if(!StringUtils.isEmpty(roleId)){
				List<Roles> roleList = rolesService.getMenuTree(roleId);
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
			    }
			}
			 //根据用户菜单获取用户权限树,不需要url
		    treeVoList = TreeUtil.queryTreeVoList(trees,false);
             
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
	
	
	@RequestMapping("/getGGdmj")
	@ResponseBody
	public String getGgdm(HttpServletRequest request,Model model,@RequestParam(value="dmjbhs",defaultValue="")String dmjbhs){
	    logger.info("传入的dmjbhs={}",dmjbhs);
		if(StringUtils.isEmpty(dmjbhs)){
			logger.error("传入的dmjbhs为空！");
			return "";
		}
	    String [] dmjbhArr = dmjbhs.split(",");
	    List<CommonGgdm> listGgdms = ggdmService.queryByDmjbh(dmjbhArr);
	    if(listGgdms == null || listGgdms.size() <=0){
	    	logger.error("根据代码集编号查询到的公共代码为空！");
			return "";
	    }
	    Map<String,List<CommonGgdm>> ggdmMap = new HashMap<>();
	    List<CommonGgdm> listDm = new ArrayList<>();
	    for(CommonGgdm ggdm : listGgdms){
	    	if(ggdmMap.isEmpty()){
	    		listDm.add(ggdm);
	    		ggdmMap.put(ggdm.getDmjbh(), listDm);
	    	}else{
	    		boolean flag = false;
		    	for(String mapkey : ggdmMap.keySet()){
		    		if(mapkey.equals(ggdm.getDmjbh())){
		    			listDm.add(ggdm);
		    			flag = true;
		    		}
		    	}
		    	if(!flag){
		    		listDm = new ArrayList<>();
	    			listDm.add(ggdm);
		    	}
		    	ggdmMap.put(ggdm.getDmjbh(), listDm);
	    	}
	    }
		return JSONObject.toJSONString(ggdmMap);
	}
	
}
