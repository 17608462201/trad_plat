package com.trad.dao;

import java.util.List;

import com.trad.bean.UserGroup;

public interface UserGroupMapper {
    int deleteByPrimaryKey(String id);

    int insert(UserGroup record);

    int insertSelective(UserGroup record);

    UserGroup selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(UserGroup record);

    int updateByPrimaryKey(UserGroup record);
    
    List<UserGroup> queryAll();
    
    List<UserGroup> getAllGroup();
}