package  com.trad.service.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import com.trad.bean.Roles;
import com.trad.bean.User;
import com.trad.dao.UserMapper;
import com.trad.service.UserService;
import com.trad.util.DataConvertUtil;
import com.trad.util.SercurityUtils;

@Service("userService")
public class UserServiceImpl implements UserService{
	@Resource  
    private UserMapper userDao;

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
	public List<Roles> getRoleByUser(int nUserID) {
		return null;
	}
	
	

	@Override
	public void addUserRole(int nUserID, int nRoleID) {
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
	
}
