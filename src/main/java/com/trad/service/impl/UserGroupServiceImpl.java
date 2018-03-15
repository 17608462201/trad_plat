package  com.trad.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.trad.bean.User;
import com.trad.bean.UserGroup;
import com.trad.dao.UserGroupMapper;
import com.trad.dao.UserMapper;
import com.trad.service.UserGroupService;

@Service("userGroupService")
public class UserGroupServiceImpl implements UserGroupService{
	@Resource  
    private UserGroupMapper userGroupDao;
	@Resource
	private UserMapper userDao;

	@Override
	public List<UserGroup> getAllGroup(Integer groupId) {
		return userGroupDao.getAllGroup(groupId);
	}

	@Override
	public List<UserGroup> queryAll() {
		return userGroupDao.queryAll();
	}

	@Override
	public int count(String filter) {
		return userGroupDao.count(filter);
	}

	@Override
	public List<UserGroup> queryByPaged(String filter, int start, int end) {
		return userGroupDao.queryByPaged(filter, start, end);
	}

	@Override
	public int deleteByPrimaryKey(Integer id) {
		return userGroupDao.deleteByPrimaryKey(id);
	}

	@Override
	public int updateByPrimaryKeySelective(UserGroup record) {
		return userGroupDao.updateByPrimaryKeySelective(record);
	}

	@Override
	public int deleteUsers(Integer groupId) {
		return userDao.deleteUsers(groupId);
	}

	@Override
	public int insert(UserGroup record) {
		return userGroupDao.insert(record);
	}

	@Override
	public int updateUsers(User user) {
		return userDao.updateByPrimaryKeySelective(user);
	}
	
}
