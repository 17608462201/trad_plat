package com.trad.service;

import java.util.List;

import com.trad.bean.Roles;
import com.trad.bean.UserRoles;

public interface RolesService {
	public int updateByPrimaryKeySelective(Roles record);
	//获取角色总数
	public int count(String filter);
	//插入选中信息
	int insert(Roles record);
	//分页查询数据
	public List<Roles> queryByPaged(String filter,int start,int end);
	 //根据roleId集合查找Roles集合，参数类似1,2,3
	public List<Roles> queryRoleById(String roleIds);
	//获取角色所属用户信息
	public List<Roles> getUserTree(int roleId);
	//获取角色所属菜单信息
	public List<Roles> getMenuTree(String roleIds);
	//插入角色用户信息
	int insertUserRoles(UserRoles record);
	//删除UserRole信息
	int deleteUserRoles(UserRoles record);
	//删除UserRole信息
	int delUserRolesByRoleId(Integer roleId);
	
	int deleteByPrimaryKey(Integer roleId);
	
	public List<Roles> queryAll();
}
