package com.trad.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.trad.bean.Roles;

public interface RolesMapper {
    int deleteByPrimaryKey(Integer roleId);

    int insert(Roles record);

    int insertSelective(Roles record);

    Roles selectByPrimaryKey(Integer roleId);

    int updateByPrimaryKeySelective(Roles record);

    int updateByPrimaryKey(Roles record);
    
    int count(@Param("filter")String filter);
    
   public List<Roles> queryByPaged(@Param("filter")String filter,Integer start,Integer end);
    
    public  List<Roles> queryRoleById(String roleIds);
    
    public List<Roles> getUserTree(int roleId);
    
    public List<Roles> queryAll();
    
}