package com.trad.service;

import java.util.List;

import com.trad.bean.User;
import com.trad.bean.UserGroup;

public interface UserGroupService {
	
    public List<UserGroup> getAllGroup(Integer groupId);
    
    public List<UserGroup> queryAll();
    //获取用户总数
  	public int count(String filter);
    //分页查询数据
  	public List<UserGroup> queryByPaged(String filter,int start,int end);
  	
  	public int deleteByPrimaryKey(Integer id);
  	
  	 public int updateByPrimaryKeySelective(UserGroup record);
    
  	 public int deleteUsers(Integer groupId);
  	 
  	 public int insert(UserGroup record);
  	 
  	 public int updateUsers(User user);
}
