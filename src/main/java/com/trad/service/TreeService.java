package com.trad.service;

import java.util.List;

import com.trad.bean.RolePermission;
import com.trad.bean.Tree;

public interface TreeService {
	//得到用户的所有菜单集
    public List<Tree> getTreeListById(int parentId); 
    
    public List<Tree> getTreeList(); 
    //插入t_role_permission数据
    public int insertRolePermission(RolePermission record);
    //删除t_role_permission数据
    public int deleteRolePermission(RolePermission record);
    
  //删除t_role_permission数据
    public int deleteRolePerByRoleId(Integer roleId);
    
    //获取用户总数
  	public int count(String filter);
    //分页查询数据
  	public List<Tree> queryByPaged(String filter,int start,int end);
  	//查询所有数据
  	public List<Tree> getAllTree();
  	
  	public int deleteByPrimaryKey(Integer treeId);
  	
  	public int deleteTreePerm(Integer treeId);
  	
  	public int saveTree(Tree tree);
  	
  	public int updateByPrimaryKeySelective(Tree tree);
}
