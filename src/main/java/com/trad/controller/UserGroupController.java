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
import com.trad.bean.UserGroup;
import com.trad.bean.common.LayuiTable;
import com.trad.bean.common.PageStatus;
import com.trad.exception.TradBusinessException;
import com.trad.service.UserGroupService;
import com.trad.util.CommonUtils;
import com.trad.util.ReplyCode;
import com.trad.util.SessionHelper;

@Controller
@RequestMapping("/userGroup")
public class UserGroupController {
	@Resource
	private UserGroupService userGroupSer;
	Logger logger = LoggerFactory.getLogger(UserGroupController.class);
	
	@RequestMapping("/init")
	 public String init(HttpServletRequest request,Model model){  
		return  "permission/userGroup"; 
	}
	
	@RequestMapping("/editGroup")
	 public String editGroup(HttpServletRequest request,Model model){  
		return  "permission/groupEdit"; 
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
	       int count = userGroupSer.count(filter);
	       pageSta.setCount(count);
	       pageSta.setPage(page);
	       pageSta.setLimit(limit);
	       //mysql limit 后面是数据条数
	       List<UserGroup> pageUserGroupList = userGroupSer.queryByPaged(filter,pageSta.getStartNum(), limit);
	       List<UserGroup> returnList = new ArrayList<>();
	       if(pageUserGroupList !=null && pageUserGroupList.size()>0){
	    	   for(UserGroup ug : pageUserGroupList){
	    		   List<User> userList = ug.getUsers();
	    		   StringBuffer userNames = new StringBuffer();
	    		   for(User user : userList){
	    			   if(ug.getId().equals(user.getGroupId())){
	    				   userNames.append(user.getRealName()+",");
	    			   }
	    		   }
	    		   if(!StringUtils.isEmpty(userNames.toString()) && userNames.lastIndexOf(",") == userNames.length()-1){
	    			   ug.setUserNames(userNames.substring(0, userNames.length()-1));
	    		   }else{
	    			   ug.setUserNames(userNames.toString());
	    		   }
	    		   returnList.add(ug);
	    	   }
	       }
	       returnMsg.setData(returnList);
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
			  logger.info("传入的id={},filed={}，value={}",nUserID,nUserFiled,nUserValue);
			  if(StringUtils.isEmpty(nUserID) || StringUtils.isEmpty(nUserFiled) || StringUtils.isEmpty(nUserValue)){
				   return ReplyCode.INSIDEERROR;
			  }
			  UserGroup record = new UserGroup();
			  CommonUtils.getInstance().setField(record, nUserFiled, nUserValue);
			  record.setId(Integer.parseInt(nUserID));
			  record.setUpdateTime(new Date());
			  int count = userGroupSer.updateByPrimaryKeySelective(record);
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

	@RequestMapping("/deleteGroups")
	@ResponseBody
	 public String deleteRoles(HttpServletRequest request,Model model){
      try{
    	  String ids = request.getParameter("ids");
    	  if(!StringUtils.isEmpty(ids)){
    		  String [] idsStr = ids.split(",");
    		  //批量删除角色信息
    		  for(String id : idsStr){
    			  Integer idInt = Integer.parseInt(id);
        		  //删除角色表
    			  userGroupSer.deleteByPrimaryKey(idInt);
    		  }
    	  }
		  return ReplyCode.SUCCESS;
	  }catch(Exception e){
		  e.printStackTrace();
		  return ReplyCode.INSIDEERROR;
	  }
	}
	
	@RequestMapping("/saveGroup")
	 public String saveGroup(HttpServletRequest request,Model model){
		String groupName = request.getParameter("groupName");
		String groupMaster = request.getParameter("groupMaster");
		String roleUsers = request.getParameter("roleUsers");
		String groupMasterName = request.getParameter("groupMasterName");
		try{
			User user = new SessionHelper(request).getLoginUser();
			UserGroup group = new UserGroup();
			group.setGroupName(groupName);
			if(!StringUtils.isEmpty(groupMaster) && groupMaster.indexOf(",") >0){
				groupMaster = groupMaster.substring(0, groupMaster.indexOf(","));
				group.setMasterId(Integer.parseInt(groupMaster));
			}
			if(!StringUtils.isEmpty(groupMasterName) && groupMasterName.indexOf(",") >0){
				groupMasterName = groupMasterName.substring(0, groupMasterName.indexOf(","));
				group.setMasterName(groupMasterName);
			}
			group.setCreateTime(new Date());
			group.setUpdateTime(new Date());
			group.setCreatePer(user == null ? "": user.getRealName());
			group.setUpdatePer(user == null ? "": user.getRealName());
			int insertId = userGroupSer.insert(group);
			if(insertId == 1){
				//更新选中结果
				  if(!StringUtils.isEmpty(roleUsers)){
					  String [] ids = roleUsers.split(",");
					  for(String id : ids){
						  if(!StringUtils.isEmpty(id)){
							  User u = new User();
							  u.setUserId(Integer.parseInt(id));
							  u.setGroupId(insertId);
							  //保存数据库数据
							  userGroupSer.updateUsers(u);
						  }
					  }
				  }
			}
		}catch(Exception e){
			e.printStackTrace();
			return "groupEdit";
		}
		return "redirect:/userGroup/init";
	}
	
	@RequestMapping("/updateMaster")
	@ResponseBody
	 public String updateMaster(HttpServletRequest request,Model model){
	  String groupId = request.getParameter("groupId");
	  String ids = request.getParameter("ids");
	  String names = request.getParameter("names");
	  if(StringUtils.isEmpty(groupId) || StringUtils.isEmpty(ids) || StringUtils.isEmpty(names)){
		  logger.error("传入的参数为空，groupId={},ids={},names={}",groupId,ids,names);
		  return ReplyCode.INSIDEERROR;
	  }
	  try{
		  String masterName = URLDecoder.decode(names);
		  logger.info("收到的更新数据为:groupId={},ids={},names={}",groupId,ids,masterName);
		  UserGroup ug = new UserGroup();
		  ug.setId(Integer.parseInt(groupId));
		  ug.setMasterId(Integer.parseInt(ids));
		  ug.setMasterName(masterName);
		  userGroupSer.updateByPrimaryKeySelective(ug);
		  return ReplyCode.SUCCESS;
	  }catch(Exception e){
		  e.printStackTrace();
		  return ReplyCode.INSIDEERROR;
	  }
	}
}
