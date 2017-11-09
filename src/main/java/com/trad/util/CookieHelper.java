package com.trad.util;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.util.StringUtils;

public class CookieHelper {
	 /**
	  * 初始化cookie数据
	  * @param name
	  * @param value
	  * @param maxAge
	  * @param path
	  * @return
	  */
		public static Cookie initCookie(String name,String value,int maxAge,String path){
			if(StringUtils.isEmpty(name)||StringUtils.isEmpty(value)){
				return null;
			}
			Cookie newCookie = new Cookie(name, value);
			newCookie.setMaxAge(maxAge); 
			newCookie.setPath(path);    
			return newCookie;
		}
		
		/**
		 * 销毁cookie
		 * @param cookie
		 * @param response
		 */
		public static void destoryCookie(Cookie cookie,HttpServletResponse response){
			 cookie.setValue(null);  
             cookie.setMaxAge(0);
             cookie.setPath("/");  
             response.addCookie(cookie);
		}
		
		/**
		 * 根据name查找cookie
		 * @param request
		 * @param name
		 * @return
		 */
		public static boolean findNameCookie(HttpServletRequest request,String name){
			Cookie [] cookies = request.getCookies();
			 for(Cookie cookie: cookies)
				{
					if(!StringUtils.isEmpty(cookie.getName()) &&name.equals(cookie.getName())){
						return true;
					}
				} 
			return false;
		}
}
