package  com.trad.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.trad.bean.Roles;
import com.trad.bean.UserRoles;
import com.trad.dao.RolesMapper;
import com.trad.dao.UserRolesMapper;
import com.trad.service.RolesService;

@Service("rolesService")
public class RolesServiceImpl implements RolesService{
	@Resource  
    private RolesMapper rolesDao;
	@Resource
	private UserRolesMapper userRolesDao;

	@Override
	public int count(String filter) {
		return rolesDao.count(filter);
	}

	@Override
	public List<Roles> queryByPaged(String filter,int start, int end) {
		return rolesDao.queryByPaged(filter,start, end);
	}

	@Override
	public List<Roles> queryRoleById(String roleIds) {
		return rolesDao.queryRoleById(roleIds);
	}

	@Override
	public int updateByPrimaryKeySelective(Roles record) {
		return rolesDao.updateByPrimaryKeySelective(record);
	}

	@Override
	public List<Roles> getUserTree(int roleId) {
		return rolesDao.getUserTree(roleId);
	}

	@Override
	public int insertUserRoles(UserRoles record) {
		return userRolesDao.insert(record);
	}

	@Override
	public int deleteUserRoles(UserRoles record) {
		return userRolesDao.deleteById(record.getRoleId(), record.getUserId());
	}

	@Override
	public List<Roles> getMenuTree(String roleIds) {
		return rolesDao.queryRoleById(roleIds);
	}

	@Override
	public int delUserRolesByRoleId(Integer roleId) {
		return userRolesDao.deleteByRoleId(roleId);
	}

	@Override
	public int deleteByPrimaryKey(Integer roleId) {
		return rolesDao.deleteByPrimaryKey(roleId);
	}

	@Override
	public int insert(Roles record) {
		return rolesDao.insert(record);
	}

	@Override
	public List<Roles> queryAll() {
		return rolesDao.queryAll();
	}
	
}
