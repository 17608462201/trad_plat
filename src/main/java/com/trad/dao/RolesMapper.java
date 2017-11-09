package com.trad.dao;

import java.util.List;
import com.trad.bean.Roles;

public interface RolesMapper {
    int deleteByPrimaryKey(Integer roleId);

    int insert(Roles record);

    int insertSelective(Roles record);

    Roles selectByPrimaryKey(Integer roleId);

    int updateByPrimaryKeySelective(Roles record);

    int updateByPrimaryKey(Roles record);
    
    int count();
    
   public List<Roles> queryByPaged(Integer start,Integer end);
    
    public  List<Roles> queryRoleById(String roleIds);
    
    public List<Roles> getUserTree(int roleId);
    
}