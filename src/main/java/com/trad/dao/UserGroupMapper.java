package com.trad.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.trad.bean.UserGroup;

public interface UserGroupMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(UserGroup record);

    int insertSelective(UserGroup record);

    UserGroup selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(UserGroup record);

    int updateByPrimaryKey(UserGroup record);
    
    List<UserGroup> queryAll();
    
    List<UserGroup> getAllGroup(@Param("groupId")Integer groupId);
    
    int count(@Param("filter")String filter);
    
    public List<UserGroup> queryByPaged(@Param("filter")String filter,Integer start,Integer end);
}