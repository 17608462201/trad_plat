package com.trad.controller;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.trad.bean.Roles;
import com.trad.bean.UserRoles;
import com.trad.bean.common.LayuiTable;
import com.trad.bean.common.PageStatus;
import com.trad.service.RolesService;
import com.trad.service.TreeService;
import com.trad.util.ReplyCode;

@Controller
@RequestMapping("/roles")
public class RolesController {
	@Resource
	private RolesService rolesService;
	@Resource
	private TreeService treeService;
	
	@RequestMapping("/list")
	@ResponseBody
	 public String list(@RequestParam(value="page",defaultValue="1") int page, @RequestParam(value = "limit",defaultValue = "4") int limit,HttpServletRequest request,Model model){  
       PageStatus pageSta = new PageStatus();
       int count = rolesService.count();
       pageSta.setCount(count);
       pageSta.setPage(page);
       pageSta.setLimit(limit);
       List<Roles> rolesList = rolesService.queryByPaged(pageSta.getStartNum(), pageSta.getEndNum());
       if(rolesList !=null && rolesList.size()>0){
    	   for(Roles role : rolesList){
    		   List<UserRoles> userList = role.getUserRoles();
    		   StringBuffer userNamesBuffer = new StringBuffer();
    		   if(userList !=null && userList.size()>0){
    			   for(UserRoles ur : userList){
    				   userNamesBuffer.append(ur.getUser().getRealName()+",");
    			   }
    		   }
    		   String userNames = userNamesBuffer.toString();
    		   if(!StringUtils.isEmpty(userNames)){
    			   role.setUserNames(userNames.substring(0,userNames.length()-1));
    		   }
    	   }
       }
       LayuiTable returnMsg =  new LayuiTable();
       returnMsg.setData(rolesList);
       returnMsg.setCount(count);
       return JSONObject.toJSONString(returnMsg);
	}
	
	@RequestMapping("/init")
	 public String queryAll(HttpServletRequest request,Model model){  
       return  "permission/role"; 
	}
	
	@RequestMapping("/modify")
	@ResponseBody
	 public String detail(HttpServletRequest request, HttpServletResponse response,Model model){
	  String nRoleID =request.getParameter("nRoleID");
	  String nRoleName = request.getParameter("nRoleName");
	  if(StringUtils.isEmpty(nRoleID) || StringUtils.isEmpty(nRoleName)){
		   return ReplyCode.INSIDEERROR;
	  }
	  Roles record = new Roles();
	  record.setRoleId(Integer.parseInt(nRoleID));
	  record.setRoleDesc(nRoleName);
	  record.setRoleName(nRoleName);
	  int count = rolesService.updateByPrimaryKeySelective(record);
	  if(count == 1){
		  return ReplyCode.SUCCESS;
	  }else{
		  return ReplyCode.INSIDEERROR;
	  }
	}
	
	@RequestMapping("/deleteRoles")
	@ResponseBody
	 public String deleteRoles(HttpServletRequest request,Model model){
      try{
    	  String roleId = request.getParameter("roleId");
    	  if(!StringUtils.isEmpty(roleId)){
    		  Integer roleIdInt = Integer.parseInt(roleId);
    		  //删除角色表
    		  rolesService.deleteByPrimaryKey(roleIdInt);
    		  //删除用户角色表
    		  rolesService.delUserRolesByRoleId(roleIdInt);
    		  //删除角色菜单表
    		  treeService.deleteRolePerByRoleId(roleIdInt);
    	  }
		  return ReplyCode.SUCCESS;
	  }catch(Exception e){
		  e.printStackTrace();
		  return ReplyCode.INSIDEERROR;
	  }
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
