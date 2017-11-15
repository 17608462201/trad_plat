package  com.trad.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.trad.bean.RolePermission;
import com.trad.bean.Tree;
import com.trad.dao.RolePermissionMapper;
import com.trad.dao.TreeMapper;
import com.trad.service.TreeService;

@Service("treeService")
public class TreeServiceImpl implements TreeService{
	@Resource  
    private TreeMapper treeDao;
	@Resource  
    private RolePermissionMapper rolePerDao;
	
	@Override
	public List<Tree> getTreeListById(int parentId) {
		return treeDao.getTreeListById(parentId);
	}

	@Override
	public List<Tree> getTreeList() {
		return treeDao.getTreeList();
	}

	@Override
	public int insertRolePermission(RolePermission record) {
		return rolePerDao.insert(record);
	}

	@Override
	public int deleteRolePermission(RolePermission record) {
		return rolePerDao.deleteById(record.getRoleId(), record.getTreeId());
	}

	@Override
	public int deleteRolePerByRoleId(Integer roleId) {
		return rolePerDao.deleteRolePerByRoleId(roleId);
	}

	@Override
	public int count(String filter) {
		return treeDao.count(filter);
	}

	@Override
	public List<Tree> queryByPaged(String filter,int start, int end) {
		return treeDao.queryByPaged(filter,start, end);
	}

	@Override
	public List<Tree> getAllTree() {
		return treeDao.getAllTree();
	}

	@Override
	public int deleteByPrimaryKey(Integer treeId) {
		return treeDao.deleteByPrimaryKey(treeId);
	}

	@Override
	public int deleteTreePerm(Integer treeId) {
		return rolePerDao.deleteRolePerByTreeId(treeId);
	}

	@Override
	public int saveTree(Tree tree) {
		return treeDao.insertSelective(tree);
	}

	@Override
	public int updateByPrimaryKeySelective(Tree tree) {
		return treeDao.updateByPrimaryKeySelective(tree);
	}


	 
}
