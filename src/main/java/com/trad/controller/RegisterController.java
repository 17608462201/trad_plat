package com.trad.controller;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.trad.bean.User;
import com.trad.bean.UserGroup;
import com.trad.service.UserGroupService;
import com.trad.service.UserService;
import com.trad.util.DataConvertUtil;
import com.trad.util.SercurityUtils;

@Controller
@RequestMapping("/register")
public class RegisterController {
	@Resource
	private UserService userSer;
	@Resource
	private UserGroupService userGroupService;
	
	@RequestMapping("/init")
	public String init(HttpServletRequest request,Model model){
		String showPic = request.getParameter("showPic");
		if(!StringUtils.isEmpty(showPic)){
			model.addAttribute("showPic", showPic);
		}
		return "register";
	}
	
	@RequestMapping("/checkUserName")
	@ResponseBody
	public String checkUserName(HttpServletRequest request,Model model){
		String sUserName = request.getParameter("sName");
		if(!StringUtils.isEmpty(sUserName)){
			User user = userSer.checkUserName(sUserName);
			if(user !=null){
				return "failed";
			}
		}
		return "success";
	}
	
	@RequestMapping("/getGroup")
	@ResponseBody
	public String getGroupName(HttpServletRequest request,Model model){
		List<UserGroup> groupList = userGroupService.queryAll();
		return JSONObject.toJSONString(groupList);
	}
	
	
	@RequestMapping("/doReg")
	public String register(HttpServletRequest request,Model model){
		User user = new User();
		String result = "";
		HttpSession session = request.getSession();
		//获取绑定对象并绑定前端值
		try{
			ServletRequestDataBinder binder = new ServletRequestDataBinder(user);  
			binder.bind(request); 
			String password = user.getPassword();
			String encryptPass = DataConvertUtil.byte2HexString(SercurityUtils.encryptDES(password.getBytes()));
			user.setPassword(encryptPass);
			user.setCreateTime(new Date());
			user.setUpdateTime(new Date());
			user.setUpdatePer(user.getRealName());
			user.setCreatePer(user.getRealName());
			userSer.insertUser(user);
			session.setAttribute("viewer", "success");
			result = "redirect:/login/init";
		}catch(Exception e){
			session.setAttribute("viewer", "failed");
			result = "redirect:/register/init";
			e.printStackTrace();
		}
		return result;
	}
}
