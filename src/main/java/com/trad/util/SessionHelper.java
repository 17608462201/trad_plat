package com.trad.util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.trad.bean.User;

public class SessionHelper {
	
	public HttpServletRequest request;
	
    public SessionHelper(HttpServletRequest request) {
    	this.request = request;
	}
	
	public HttpSession getHttpSession() {
		return request.getSession();
	}
	
	//获取用户登陆信息
	public User getLoginUser() {
		return (User) request.getSession().getAttribute(Constant.USER_SESSEION);
	}
	
	//清楚session缓存
	public void clearSession(){
		getHttpSession().setMaxInactiveInterval(0);
		getHttpSession().setAttribute(Constant.USER_SESSEION, "");
	}
}
