package com.trad.dao;

import com.trad.bean.RolePermission;

public interface RolePermissionMapper {
    int insert(RolePermission record);

    int insertSelective(RolePermission record);
    
    int deleteById(Integer roleId,Integer treeId);
    
    int deleteRolePerByRoleId(Integer roleId);
    
    int deleteRolePerByTreeId(Integer treeId);
}