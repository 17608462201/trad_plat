package com.trad.service;

import java.util.List;

import com.trad.bean.Roles;
import com.trad.bean.User;

public interface UserService {
	//用户登录验证
    public User getUserLogin(String sUserName,String sPassword);
    //由用户ID 返回该用户所有的角色集
    public List<Roles> getRoleByUser(int nUserID);
	//为用户分配角色
    public void  addUserRole(int nUserID,int nRoleID); 
    
    public int insertUser(User user);
    
    public User checkUserName(String sUserName);
    
    public User selectUserRole(Integer userId);
    
}
