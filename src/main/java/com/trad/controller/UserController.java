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
import com.trad.bean.User;
import com.trad.bean.UserRoles;
import com.trad.bean.common.LayuiTable;
import com.trad.bean.common.PageStatus;
import com.trad.exception.TradBusinessException;
import com.trad.service.UserService;
import com.trad.util.CommonUtils;
import com.trad.util.ReplyCode;

@Controller
@RequestMapping("/user")
public class UserController {
	@Resource
	private UserService userSer;
	Logger logger = LoggerFactory.getLogger(UserController.class);
	
	@RequestMapping("/init")
	 public String init(HttpServletRequest request,Model model){  
		return  "permission/user"; 
	}
	
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
	       int count = userSer.count(filter);
	       pageSta.setCount(count);
	       pageSta.setPage(page);
	       pageSta.setLimit(limit);
	       //mysql limit 后面是数据条数
	       List<User> pageUserList = userSer.queryByPaged(filter,pageSta.getStartNum(), limit);
	       List<User> userList = userSer.getAllUser();
	       List<User> resultList = new ArrayList<>();
	       if(pageUserList !=null && pageUserList.size()>0 && userList !=null && userList.size()>0){
	    	   for(int i=0;i<pageUserList.size();i++){
	    		   for(User user : userList){
	    			   //当此时的roleId与遍历id相等时，则生成treeNames,userNames
	    			   if(pageUserList.get(i).getUserId() == user.getUserId()){
	    				   List<UserRoles> userRoles = user.getUserRoles();
	    	    		   StringBuffer roleNamesBuffer = new StringBuffer();
	    	    		   //生成角色组合
	    	    		   if(userRoles !=null && userRoles.size()>0){
	    	    			   for(UserRoles ur : userRoles){
	    	    				   if(ur.getRoles() != null && !StringUtils.isEmpty(ur.getRoles().getRoleName())){
	    	    					   roleNamesBuffer.append(ur.getRoles().getRoleName()+",");
	    	    				   }
	    	    			   }
	    	    		   }
	    	    		   String roleNames = roleNamesBuffer.toString();
	    	    		   if(!StringUtils.isEmpty(roleNames)){
	    	    			   user.setRoleNames(roleNames.substring(0,roleNames.length()-1));
	    	    		   }
	    	    		   
	    	    		   resultList.add(user);
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
	
	@RequestMapping("/modify")
	@ResponseBody
	 public String detail(HttpServletRequest request, HttpServletResponse response,Model model){
		
		try {
	          String nUserID =request.getParameter("nUserID");
			  String nUserFiled =request.getParameter("nUserFiled");
			  String nUserValue = request.getParameter("nUserValue");
			  logger.info("传入的nUserID={},nUserFiled={}，nUserValue={}",nUserID,nUserFiled,nUserValue);
			  if(StringUtils.isEmpty(nUserID) || StringUtils.isEmpty(nUserFiled) || StringUtils.isEmpty(nUserValue)){
				   return ReplyCode.INSIDEERROR;
			  }
			  User record = new User();
			  CommonUtils.getInstance().setField(record, nUserFiled, nUserValue);
			  record.setUserId(Integer.parseInt(nUserID));
			  record.setUpdateTime(new Date());
			  int count = userSer.updateByPrimaryKeySelective(record);
			  if(count == 1){
				  return ReplyCode.SUCCESS;
			  }
	} catch (NoSuchFieldException e) {
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
		logger.error("修改user信息出错！");
		e.printStackTrace();
	}
	return ReplyCode.INSIDEERROR;
}

	@RequestMapping("/deleteUsers")
	@ResponseBody
	 public String deleteUsers(HttpServletRequest request,Model model){
      try{
    	  String userIds = request.getParameter("userIds");
    	  if(!StringUtils.isEmpty(userIds)){
    		  String [] userIdsStr = userIds.split(",");
    		  //批量删除角色信息
    		  for(String userId : userIdsStr){
    			  Integer userIdInt = Integer.parseInt(userId);
        		  //删除角色表
    			  userSer.deleteByPrimaryKey(userIdInt);
        		  //删除用户角色表
    			  userSer.deleteUserRole(userIdInt);
    		  }
    	  }
		  return ReplyCode.SUCCESS;
	  }catch(Exception e){
		  e.printStackTrace();
		  return ReplyCode.INSIDEERROR;
	  }
	}
	
	
	@RequestMapping("/updateUserGroup")
	@ResponseBody
	 public String updateUserGroup(HttpServletRequest request,Model model){
	  String groupId = request.getParameter("groupId");
	  String userIdsCheck = request.getParameter("userIdsCheck");
	  String userIdsUnCheck = request.getParameter("userIdsUnCheck");
	  try{
		  if(!StringUtils.isEmpty(groupId)){
			  //更新选中结果
			  if(!StringUtils.isEmpty(userIdsCheck)){
				  String [] ids = userIdsCheck.split(",");
				  for(String id : ids){
					  if(!StringUtils.isEmpty(id)){
						  User user = new User();
						  user.setGroupId(Integer.parseInt(groupId));
						  user.setUserId(Integer.parseInt(id));
						  //保存数据库数据
						  userSer.updateByPrimaryKeySelective(user);
					  }
				  }
			  }
			  //更新未选中结果
			  if(!StringUtils.isEmpty(userIdsUnCheck)){
				  String [] uids = userIdsUnCheck.split(",");
				  for(String id : uids){
					  if(!StringUtils.isEmpty(id)){
						  User user = new User();
						  user.setGroupId(0);
						  user.setUserId(Integer.parseInt(id));
						  //保存数据库数据
						  userSer.updateByPrimaryKeySelective(user);
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
