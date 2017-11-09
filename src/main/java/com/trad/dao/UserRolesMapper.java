package com.trad.dao;

import com.trad.bean.UserRoles;

public interface UserRolesMapper {
    int insert(UserRoles record);

    int insertSelective(UserRoles record);
    
    int deleteById(Integer roleId,Integer userId);
    
    int deleteByRoleId(Integer roleId);
}