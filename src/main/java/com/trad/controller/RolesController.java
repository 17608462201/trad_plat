package com.trad.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.trad.bean.RolePermission;
import com.trad.bean.Roles;
import com.trad.bean.User;
import com.trad.bean.UserRoles;
import com.trad.bean.common.LayuiTable;
import com.trad.bean.common.PageStatus;
import com.trad.exception.TradBusinessException;
import com.trad.service.RolesService;
import com.trad.service.TreeService;
import com.trad.util.CommonUtils;
import com.trad.util.ReplyCode;
import com.trad.util.SessionHelper;

@Controller
@RequestMapping("/roles")
public class RolesController {
	@Resource
	private RolesService rolesService;
	@Resource
	private TreeService treeService;
	Logger logger = LoggerFactory.getLogger(RolesController.class);

	
	@RequestMapping("/list")
	@ResponseBody
	 public String list(@RequestParam(value="page",defaultValue="1") int page, @RequestParam(value = "limit",defaultValue = "4") int limit,HttpServletRequest request,Model model){  
		LayuiTable returnMsg =  new LayuiTable();
		try{
			  String filter = request.getParameter("filter");
		      if(!StringUtils.isEmpty(filter)){
		    	  filter = URLDecoder.decode(filter,"UTF-8");
		    	  filter = "%"+filter+"%";
		    	  logger.info("传入的filter={}",filter);	
		      }
		   PageStatus pageSta = new PageStatus();
	       int count = rolesService.count(filter);
	       pageSta.setCount(count);
	       pageSta.setPage(page);
	       pageSta.setLimit(limit);
	     //mysql limit 后面是数据条数
	       List<Roles> pageRoleList = rolesService.queryByPaged(filter,pageSta.getStartNum(), limit);
	       List<Roles> roleList = rolesService.queryAll();
	       List<Roles> resultList = new ArrayList<>();
	       if(pageRoleList !=null && pageRoleList.size()>0 && roleList !=null && roleList.size()>0){
	    	   for(int i=0;i<pageRoleList.size();i++){
	    		   for(Roles role : roleList){
	    			   //当此时的roleId与遍历id相等时，则生成treeNames,userNames
	    			   if(pageRoleList.get(i).getRoleId() == role.getRoleId()){
	    				   List<UserRoles> userRoles = role.getUserRoles();
	    	    		   List<RolePermission> rolePers = role.getRolePers();
	    	    		   StringBuffer userNamesBuffer = new StringBuffer();
	    	    		   StringBuffer  treeNamesBuffer = new StringBuffer();
	    	    		   //生产用户名组合
	    	    		   if(userRoles !=null && userRoles.size()>0){
	    	    			   for(UserRoles ur : userRoles){
	    	    				   if(ur.getUser() != null && !StringUtils.isEmpty(ur.getUser().getRealName())){
	    	    					   userNamesBuffer.append(ur.getUser().getRealName()+",");
	    	    				   }
	    	    			   }
	    	    		   }
	    	    		   //生产菜单树组合
	    	    		   if(rolePers !=null && rolePers.size()>0){
	    	    			   for(RolePermission rp : rolePers){
	    	    				   if(rp.getTree() != null && !StringUtils.isEmpty(rp.getTree().getTreeName())){
	    	    					   treeNamesBuffer.append(rp.getTree().getTreeName()+",");
	    	    				   }
	    	    			   }
	    	    		   }
	    	    		   String userNames = userNamesBuffer.toString();
	    	    		   String treeNames = treeNamesBuffer.toString();
	    	    		   if(!StringUtils.isEmpty(userNames)){
	    	    			   role.setUserNames(userNames.substring(0,userNames.length()-1));
	    	    		   }
	    	    		   
	    	    		   if(!StringUtils.isEmpty(treeNames)){
	    	    			   role.setTreeNames(treeNames.substring(0,treeNames.length()-1));
	    	    		   }
	    	    		   resultList.add(role);
	    			   }
	    		   }
	    	   }
	       }
	       returnMsg.setData(resultList);
	       returnMsg.setCount(count);
		}catch(UnsupportedEncodingException e){
	    	  e.printStackTrace();
	      }catch (Exception e) {
	    	  e.printStackTrace();
		}
	      return JSONObject.toJSONString(returnMsg);
		}
	
	@RequestMapping("/init")
	 public String init(HttpServletRequest request,Model model){  
       return  "permission/role"; 
	}
	
	@RequestMapping("/add")
	 public String edit(HttpServletRequest request,Model model){
      return  "permission/roleEdit"; 
	}
	
	@RequestMapping("/modify")
	@ResponseBody
	 public String detail(HttpServletRequest request, HttpServletResponse response,Model model){
		
		try {
	          String nRoleID =request.getParameter("nRoleID");
			  String nRoleFiled =request.getParameter("nRoleFiled");
			  String nRoleValue = request.getParameter("nRoleValue");
			  logger.info("传入的nRoleID={},nRoleFiled={}，nRoleValue={}",nRoleID,nRoleFiled,nRoleValue);
			  if(StringUtils.isEmpty(nRoleID) || StringUtils.isEmpty(nRoleFiled) || StringUtils.isEmpty(nRoleValue)){
				   return ReplyCode.INSIDEERROR;
			  }
			  Roles record = new Roles();
			  CommonUtils.getInstance().setField(record, nRoleFiled, nRoleValue);
			  record.setRoleId(Integer.parseInt(nRoleID));
			  record.setUpdateTime(new Date());
			  int count = rolesService.updateByPrimaryKeySelective(record);
			  if(count == 1){
				  return ReplyCode.SUCCESS;
			  }
	}  catch (NoSuchFieldException e) {
		logger.error("无法从找到传入参数对应的field！");
		e.printStackTrace();
	} catch (SecurityException e) {
		logger.error("该映射不是安全的映射！");
		e.printStackTrace();
	} catch (IllegalArgumentException e) {
		logger.error("设置值传入的参数不合法！");
		e.printStackTrace();
	} catch (IllegalAccessException e) {
		logger.error("set方法不可访问！");
		e.printStackTrace();
	}catch (TradBusinessException e) {
		logger.error("传入的对象为空或者methodName为空！");
		e.printStackTrace();
	}catch (Exception e) {
		logger.error("修改roles信息出错！");
		e.printStackTrace();
	}
	return ReplyCode.INSIDEERROR;
}
	
	@RequestMapping("/deleteRoles")
	@ResponseBody
	 public String deleteRoles(HttpServletRequest request,Model model){
      try{
    	  String roleIds = request.getParameter("roleIds");
    	  if(!StringUtils.isEmpty(roleIds)){
    		  String [] roleIdsStr = roleIds.split(",");
    		  //批量删除角色信息
    		  for(String roleId : roleIdsStr){
    			  Integer roleIdInt = Integer.parseInt(roleId);
        		  //删除角色表
        		  rolesService.deleteByPrimaryKey(roleIdInt);
        		  //删除用户角色表
        		  rolesService.delUserRolesByRoleId(roleIdInt);
        		  //删除角色菜单表
        		  treeService.deleteRolePerByRoleId(roleIdInt);
    		  }
    	  }
		  return ReplyCode.SUCCESS;
	  }catch(Exception e){
		  e.printStackTrace();
		  return ReplyCode.INSIDEERROR;
	  }
	}
	
	@RequestMapping("/saveNewRole")
	 public String saveNewRole(HttpServletRequest request,Model model){
		String roleName = request.getParameter("roleName");
		String roleDesc = request.getParameter("roleDesc"); 
		String roleUsers = request.getParameter("roleUsers");
		String roleMenus = request.getParameter("roleMenus"); 
		String recordStatus = request.getParameter("recordStatus"); 
		try{
			User user = new SessionHelper(request).getLoginUser();
			Roles roles = new Roles();
			roles.setRoleName(roleName);
			roles.setRoleDesc(roleDesc);
			roles.setCreateTime(new Date());
			roles.setUpdateTime(new Date());
			roles.setCreatePer(user == null ? "": user.getRealName());
			roles.setUpdatePer(user == null ? "": user.getRealName());
			roles.setRecordStatus(recordStatus);
			int insertId = rolesService.insert(roles);
			if(insertId == 1){
				//更新选中结果
				  if(!StringUtils.isEmpty(roleUsers)){
					  String [] ids = roleUsers.split(",");
					  for(String id : ids){
						  if(!StringUtils.isEmpty(id)){
							  UserRoles ur = new UserRoles();
							  ur.setCreateTime(new Date());
							  ur.setUpdateTime(new Date());
							  ur.setUserId(Integer.parseInt(id));
							  ur.setRoleId(roles.getRoleId());
							  //保存数据库数据
							  rolesService.insertUserRoles(ur);
						  }
					  }
				  }
				  
				  //更新选中结果
				  if(!StringUtils.isEmpty(roleMenus)){
					  String [] uids = roleMenus.split(",");
					  for(String id : uids){
						  if(!StringUtils.isEmpty(id)){
							  RolePermission rp = new RolePermission();
							  rp.setRoleId(roles.getRoleId());
							  rp.setTreeId(Integer.parseInt(id));
							  rp.setCreateTime(new Date());
							  rp.setUpdateTime(new Date());
							  //保存数据库数据
							  treeService.insertRolePermission(rp);
						  }
					  }
				  }
			}
		}catch(Exception e){
			e.printStackTrace();
			return "roleEdit";
		}
		return "redirect:/roles/init";
	}
	
	@RequestMapping("/saveRoleUser")
	@ResponseBody
	 public String saveRoleUser(HttpServletRequest request,Model model){
	  String roleId = request.getParameter("roleId");
	  String userIdsCheck = request.getParameter("userIdsCheck");
	  String userIdsUnCheck = request.getParameter("userIdsUnCheck");
	  try{
		  if(!StringUtils.isEmpty(roleId)){
			  //更新选中结果
			  if(!StringUtils.isEmpty(userIdsCheck)){
				  String [] ids = userIdsCheck.split(",");
				  for(String id : ids){
					  if(!StringUtils.isEmpty(id)){
						  UserRoles ur = new UserRoles();
						  ur.setCreateTime(new Date());
						  ur.setUpdateTime(new Date());
						  ur.setUserId(Integer.parseInt(id));
						  ur.setRoleId(Integer.parseInt(roleId));
						  //保存数据库数据
						  rolesService.insertUserRoles(ur);
					  }
				  }
			  }
			  //更新未选中结果
			  if(!StringUtils.isEmpty(userIdsUnCheck)){
				  String [] uids = userIdsUnCheck.split(",");
				  for(String id : uids){
					  if(!StringUtils.isEmpty(id)){
						  UserRoles ur = new UserRoles();
						  ur.setUserId(Integer.parseInt(id));
						  ur.setRoleId(Integer.parseInt(roleId));
						  //保存数据库数据
						  rolesService.deleteUserRoles(ur);
					  }
				  }
			  }
		  }
		  return ReplyCode.SUCCESS;
	  }catch(Exception e){
		  e.printStackTrace();
		  return ReplyCode.INSIDEERROR;
	  }
	}
}
