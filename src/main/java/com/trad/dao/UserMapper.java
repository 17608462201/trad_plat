package com.trad.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.trad.bean.User;

public interface UserMapper {
    int deleteByPrimaryKey(Integer userId);

    int insert(User record);

    int insertSelective(User record);

    User selectByPrimaryKey(Integer userId);

    int updateByPrimaryKeySelective(User record);

    int updateByPrimaryKey(User record);
    
    User selectByNameAndPass(User record);
    
    User checkUserName(String userName);
    
    User selectUserRole(Integer userId);
    
    List<User> getAllUser();
    
    int count(@Param("filter")String filter);
    
    public List<User> queryByPaged(@Param("filter")String filter,Integer start,Integer end);
    
    int deleteUsers(Integer groupId);
}