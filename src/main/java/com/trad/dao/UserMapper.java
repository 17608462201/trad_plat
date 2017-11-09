package com.trad.dao;

import java.util.List;

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
}