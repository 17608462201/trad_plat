package  com.trad.service.impl;

import java.util.List;
import java.util.Map;

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
	public int count(Map<String, Object> map) {
		return payDao.count(map);
	}

	@Override
	public List<Payment> queryByPaged(Map<String, Object> map) {
		return payDao.queryByPaged(map);
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

	@Override
	public int insert(Payment record) {
		return payDao.insert(record);
	}

	@Override
	public void updatePaymentStatus(Map<String, Object> map) {
		payDao.updatePaymentStatus(map);
	}

	@Override
	public Map<String, Object> selPaymentById(String id) {
		return payDao.selPaymentById(id);
	}

	@Override
	public List<Payment> selPaymentByLoanId(Map<String, Object> map) {
		return payDao.selPaymentByLoanId(map);
	}

	@Override
	public int countPaymentByLoanId(Map<String, Object> map) {
		return payDao.countPaymentByLoanId(map);
	}

	@Override
	public List<Map<String, Object>> selPaymentDetails(Map<String, Object> map) {
		return payDao.selPaymentDetails(map);
	}

	@Override
	public int countPaymentDetails(Map<String, Object> map) {
		return payDao.countPaymentDetails(map);
	}

	@Override
	public List<Map<String, Object>> selPaymentPlan(Map<String, Object> map) {
		return payDao.selPaymentPlan(map);
	}

	@Override
	public int countPaymentPlan(Map<String, Object> map) {
		return payDao.countPaymentPlan(map);
	}

	@Override
	public String selOffMoney(String id) {
		return payDao.selOffMoney(id);
	}

	@Override
	public String selPaymentSum(String loanId) {
		return payDao.selPaymentSum(loanId);
	}

	@Override
	public List<Payment> selPaymentStatus() {
		return payDao.selPaymentStatus();
	}
}
