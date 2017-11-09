package com.trad.interceptor;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.trad.util.Constant;

public class LoginInterceptor extends HandlerInterceptorAdapter{
	
	private List<String> excludedUrls;
	
    public void setExcludedUrls(List<String> excludedUrls) {
        this.excludedUrls = excludedUrls;
    }

    
	 @Override
	    public boolean preHandle(HttpServletRequest request,
	            HttpServletResponse response, Object handler) throws Exception {
		 response.setCharacterEncoding("UTF-8");
		 String requestUri = request.getRequestURI();
		 //配置不需要拦截的url 
        for (String url : excludedUrls) {
            if (requestUri.contains(url) || requestUri.endsWith(url)) {
                return true;
            }
        }
	    //验证当前用户是否登陆，如果未登陆则拦截
	    HttpSession session = request.getSession();
	    if (session.getAttribute(Constant.USER_SESSEION) == null) {
	    	request.setAttribute("relogin", "1");    
            request.getRequestDispatcher("/pages/login.jsp").forward(request, response);   
            return false;
	    } else {
	        return true;
	    }
	 }
}
