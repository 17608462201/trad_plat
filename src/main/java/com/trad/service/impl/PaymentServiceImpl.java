package  com.trad.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.trad.bean.Payment;
import com.trad.dao.PaymentMapper;
import com.trad.service.PaymentService;

@Service("payService")
public class PaymentServiceImpl implements PaymentService{
	@Resource  
    private PaymentMapper payDao;
	
	@Override
	public int count(String filter) {
		return payDao.count(filter);
	}

	@Override
	public List<Payment> queryByPaged(String filter, int start, int end) {
		return payDao.queryByPaged(filter, start, end);
	}

	@Override
	public int deleteByPrimaryKey(String id) {
		return payDao.deleteByPrimaryKey(id);
	}

	@Override
	public int savePayment(Payment record) {
		return payDao.insertSelective(record);
	}

	@Override
	public int updateByPrimaryKeySelective(Payment record) {
		return payDao.updateByPrimaryKeySelective(record);
	}

	@Override
	public Payment selectByPrimaryKey(String id) {
		return payDao.selectByPrimaryKey(id);
	}

}
