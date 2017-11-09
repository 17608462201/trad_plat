package com.trad.service;

import java.util.List;

import com.trad.bean.RolePermission;
import com.trad.bean.Tree;

public interface TreeService {
	//生成树目录
	//public void BindTree(TreeView treeView,int userID); 
   //递归函数生成树结点
	//public void CreateChildNode(TreeNode parentnode,DataTable dataTable); 
    //由用户ID 得到用户权限集动态生成用户权限树
	
	//得到用户的所有菜单集
    public List<Tree> getTreeListById(int parentId); 
    
    public List<Tree> getTreeList(); 
    //插入t_role_permission数据
    public int insertRolePermission(RolePermission record);
    //删除t_role_permission数据
    public int deleteRolePermission(RolePermission record);
    
  //删除t_role_permission数据
    public int deleteRolePerByRoleId(Integer roleId);
}
