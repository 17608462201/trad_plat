package com.trad.controller;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.trad.bean.RolePermission;
import com.trad.bean.Roles;
import com.trad.bean.Tree;
import com.trad.bean.TreeVo;
import com.trad.bean.User;
import com.trad.bean.UserRoles;
import com.trad.service.RolesService;
import com.trad.service.UserService;
import com.trad.util.Constant;
import com.trad.util.CookieHelper;
import com.trad.util.TreeUtil;
import com.trad.util.VerifyCodeUtil;

import sun.misc.BASE64Encoder;

@Controller
@RequestMapping("/login")
public class LoginController{
	
	@Resource
	private UserService userService;
	@Resource  
    private RolesService rolesService;
	
	private Logger logger = LoggerFactory.getLogger(LoginController.class);
	
	@RequestMapping("/init")
	public String init(HttpServletRequest request,Model model){
		return "login";
	}
	
	@RequestMapping("/index")
	public String index(HttpServletRequest request,Model model){
		return "index";
	}
	@RequestMapping("/getImage")
	public String getImage(HttpServletRequest request,HttpServletResponse response,Model model){
		response.setContentType("image/jpeg");    
        // 生成随机字串  
        String verifyCode = VerifyCodeUtil.generateVerifyCode(4);
        request.getSession().setAttribute("randomCode", verifyCode.toLowerCase());
        // 生成图片  
        int w = 100, h = 40;  
        try {
			VerifyCodeUtil.outputImage(w, h, response.getOutputStream(),  
			        verifyCode, response);
		} catch (IOException e) {
			e.printStackTrace();
		}  
        return null;
	}
	
	@RequestMapping("/validateImage")
	@ResponseBody
	public String validateImage(HttpServletRequest request,Model model){
		String imageCode = request.getParameter("imageCode");
		String sessionRandomCode = (String) request.getSession().getAttribute("randomCode");
		if(!StringUtils.isEmpty(imageCode) && sessionRandomCode.equals(imageCode.toLowerCase())){
			return "success";
		}else{
			return "falied";
		}
	    
	}
	
	@RequestMapping("/submit")
	public String login(HttpServletRequest request,HttpServletResponse response,Model model){
		
		try{
					//保存用户session
					HttpSession session =request.getSession();
					User user = new User();
					ServletRequestDataBinder binder = new ServletRequestDataBinder(user);  
					binder.bind(request);
					String imageCode = request.getParameter("imageCode");
					String sessionRandomCode = (String) request.getSession().getAttribute("randomCode");
					String remeberPass = request.getParameter("remeberPass");
					//后台校验验证码是否正确
					if(!StringUtils.isEmpty(imageCode) && sessionRandomCode.equals(imageCode.toLowerCase())){
						//验证该用户是否存在
						User record = userService.getUserLogin(user.getUserName(), user.getPassword());
						if(record != null){
							//处理session
							session.setAttribute(Constant.USER_SESSEION, user);
							session.setMaxInactiveInterval(2 * 3600);  // Session保存两小时
						    //处理cookie
							boolean hasCookie  = CookieHelper.findNameCookie(request, Constant.COOKIE_NAME);
							if(!hasCookie && !StringUtils.isEmpty(remeberPass) && "on".equals(remeberPass)){
								//首次登陆保存cookie，并设置永不过期
								 response.addCookie(CookieHelper.initCookie(Constant.COOKIE_NAME, new BASE64Encoder().encode(record.getUserName().getBytes()), 365 * 24 * 3600, request.getServletContext().getContextPath()));
								 response.addCookie(CookieHelper.initCookie(Constant.COOKIE_PASS, record.getPassword(), 7 * 24 * 3600, request.getServletContext().getContextPath()));
							}else if(StringUtils.isEmpty(remeberPass)){
								//清除cookie
								Cookie [] cookies = request.getCookies();
								int num = 0;
								 for(Cookie cookie: cookies)
									{
									    CookieHelper.destoryCookie(cookie, response); 
										if(!StringUtils.isEmpty(cookie.getName()) &&Constant.COOKIE_NAME.equals(cookie.getName())){
											 CookieHelper.destoryCookie(cookie, response); 
											 num++;
										}
										if(!StringUtils.isEmpty(cookie.getName()) &&Constant.COOKIE_PASS.equals(cookie.getName())){
											 CookieHelper.destoryCookie(cookie, response); 
											 num++;
										}
										if(num==2){
											break;
										}
									}
							}
							
							//获取用户菜单
							User userRoles = userService.selectUserRole(record.getUserId());
							if(userRoles ==null || userRoles.getUserRoles() == null || userRoles.getUserRoles().size()<=0){
								logger.error("查询出的当前用户的菜单为空,请检查菜单配置！");
							}
							List<TreeVo> treeVoList =  getTreeVo(userRoles.getUserRoles());
							logger.info("获取到的该用户菜单树为："+JSONObject.toJSON(treeVoList));
							model.addAttribute("loginUser", record);
                            model.addAttribute("treeListVo", treeVoList);
						    return "index";
					}else{
						request.setAttribute("failedText", "对不起，用户名或密码输入错误，请重试！");
						return "/login/init";
					}
				}else{
					request.setAttribute("failedText", "验证码输入错误，请重试！");
					return "/login/init";
				}
			
		}catch (IllegalAccessException e) {
			logger.error("初始化菜单树出错！");
			e.printStackTrace();
		}catch (InvocationTargetException e) {
			logger.error("初始化菜单树出错！");
			e.printStackTrace();
		}catch (Exception e) {
			logger.error("登陆出错！");
			e.printStackTrace();
		}
		return "redirect:/login/init";
	}
	
	public List<TreeVo> getTreeVo(List<UserRoles> userRoleList) throws IllegalAccessException, InvocationTargetException{
		//角色列表转换为角色数
	   String roleIds = "";
		for(UserRoles userRole : userRoleList){
			Roles roles = userRole.getRoles();
			roleIds += roles.getRoleId()+",";
		}
		
		List<Roles> rolesList = null ;
		if(!StringUtils.isEmpty(roleIds)){
			rolesList = rolesService.queryRoleById(roleIds.substring(0,roleIds.length()-1));
		}
		//根据角色列表获取菜单树
		List<Tree> treeList = new ArrayList<>();
		if(rolesList !=null && rolesList.size() >0){
			for(Roles role : rolesList){
				List<RolePermission> rolePers  =role.getRolePers();
				for(RolePermission perm : rolePers){
					treeList.add(perm.getTree());
				}
			}
		}
		//根据用户菜单获取用户权限树
		List<TreeVo> treeVoList = TreeUtil.queryTreeVoList(treeList,true);
		return treeVoList;
	}
	
}
