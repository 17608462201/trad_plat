package com.trad.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.trad.service.UserService;

@Controller
@RequestMapping("/user")
public class UserController {
	@Resource
	private UserService userSer;
	
	@RequestMapping("/showUser")
	 public String toIndex(HttpServletRequest request,Model model){  
        int userId = Integer.parseInt(request.getParameter("id"));  
        //User user = this.userSer.getUserById(userId);  
        //model.addAttribute("user", user.getUserName());  
        return "showUser"; 
	}
	
	@ResponseBody
	@RequestMapping("/queryAll")
	 public String queryAll(HttpServletRequest request,Model model){  
       //List<User> users = this.userSer.queryAll();
       String json ="{\"code\":0,\"msg\":\"\",\"count\":1000,\"data\":[{\"id\":10000,\"username\":\"user-0\",\"password\":\"123412\",\"password\":\"12\"},{\"id\":20000,\"username\":\"user-1\",\"password\":\"123412\",\"password\":\"15\"}]}";
       return  json; 
	}
}
