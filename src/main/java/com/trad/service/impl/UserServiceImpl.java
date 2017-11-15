package  com.trad.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.trad.bean.User;
import com.trad.dao.UserMapper;
import com.trad.dao.UserRolesMapper;
import com.trad.service.UserService;
import com.trad.util.DataConvertUtil;
import com.trad.util.SercurityUtils;

@Service("userService")
public class UserServiceImpl implements UserService{
	@Resource  
    private UserMapper userDao;
	@Resource
	private UserRolesMapper userRolesDao;

	@Override
	public User getUserLogin(String sUserName, String sPassword) {
        if(StringUtils.isEmpty(sUserName) || StringUtils.isEmpty(sPassword)){
        	return null;
        }
        User user = new User();
        user.setUserName(sUserName);
        //对password进行加密处理
        String decryptPwd = DataConvertUtil.byte2HexString(SercurityUtils.encryptDES(sPassword.getBytes()));
        user.setPassword(decryptPwd);
        User record = userDao.selectByNameAndPass(user);
        if(record != null){
        	return record;
        }
		return null;
	}


	@Override
	public int insertUser(User user) {
         return userDao.insert(user);		
	}

	@Override
	public User checkUserName(String sUserName) {
		return userDao.checkUserName(sUserName);
	}

	@Override
	public User selectUserRole(Integer userId) {
		return userDao.selectUserRole(userId);
	}

	@Override
	public int count(String filter) {
		return userDao.count(filter);
	}

	@Override
	public List<User> queryByPaged(String filter,int start, int end) {
		return userDao.queryByPaged(filter,start, end);
	}


	@Override
	public List<User> getAllUser(){
		return userDao.getAllUser();
	}


	@Override
	public int deleteByPrimaryKey(Integer userId) {
		return userDao.deleteByPrimaryKey(userId);
	}


	@Override
	public int deleteUserRole(Integer userId) {
		return userRolesDao.deleteByUserId(userId);
	}


	@Override
	public int updateByPrimaryKeySelective(User record) {
		return userDao.updateByPrimaryKeySelective(record);
	}
	
}
