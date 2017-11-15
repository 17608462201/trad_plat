package com.trad.service;

import java.util.List;

import com.trad.bean.User;

public interface UserService {
	//用户登录验证
    public User getUserLogin(String sUserName,String sPassword);
    
    public int insertUser(User user);
    
    public User checkUserName(String sUserName);
    
    public User selectUserRole(Integer userId);
    //获取用户总数
  	public int count(String filter);
    //分页查询数据
  	public List<User> queryByPaged(String filter,int start,int end);
  	//查询所有数据
  	public List<User> getAllUser();
  	
  	public int deleteByPrimaryKey(Integer userId);
  	
  	public int deleteUserRole(Integer userId);
  	
  	public int updateByPrimaryKeySelective(User record);
  	
}
