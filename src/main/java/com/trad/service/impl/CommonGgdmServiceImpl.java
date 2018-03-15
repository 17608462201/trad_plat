package  com.trad.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.trad.bean.CommonGgdm;
import com.trad.bean.CommonGgdmKey;
import com.trad.dao.CommonGgdmMapper;
import com.trad.service.CommonGgdmService;

@Service("commonGgdmService")
public class CommonGgdmServiceImpl implements CommonGgdmService{

	@Resource  
    private CommonGgdmMapper commonGdgmDao;
	
	@Override
	public int count(String filter) {
		return commonGdgmDao.count(filter);
	}

	@Override
	public List<CommonGgdm> queryByPaged(String filter, int start, int end) {
		return commonGdgmDao.queryByPaged(filter, start, end);
	}

	@Override
	public int deleteByPrimaryKey(CommonGgdmKey key) {
		return commonGdgmDao.deleteByPrimaryKey(key);
	}

	@Override
	public int insert(CommonGgdm record) {
		return commonGdgmDao.insert(record);
	}

	@Override
	public int insertSelective(CommonGgdm record) {
		return commonGdgmDao.insertSelective(record);
	}

	@Override
	public CommonGgdm selectByPrimaryKey(CommonGgdmKey key) {
		return commonGdgmDao.selectByPrimaryKey(key);
	}

	@Override
	public int updateByPrimaryKeySelective(CommonGgdm record) {
		return commonGdgmDao.updateByPrimaryKeySelective(record);
	}

	@Override
	public int updateByPrimaryKey(CommonGgdm record) {
		return commonGdgmDao.updateByPrimaryKey(record);
	}

	@Override
	public List<CommonGgdm> queryByDmjbh(String[] dmjbhs) {
		return commonGdgmDao.queryByDmjbh(dmjbhs);
	}

}
