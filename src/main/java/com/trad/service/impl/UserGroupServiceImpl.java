package  com.trad.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.trad.bean.UserGroup;
import com.trad.dao.UserGroupMapper;
import com.trad.service.UserGroupService;

@Service("userGroupService")
public class UserGroupServiceImpl implements UserGroupService{
	@Resource  
    private UserGroupMapper userGroupDao;

	@Override
	public List<UserGroup> getAllGroup() {
		return userGroupDao.getAllGroup();
	}

	@Override
	public List<UserGroup> queryAll() {
		return userGroupDao.queryAll();
	}
	
}
