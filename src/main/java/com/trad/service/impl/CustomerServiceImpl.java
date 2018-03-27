package  com.trad.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.trad.bean.Customer;
import com.trad.bean.CustomerContract;
import com.trad.bean.CustomerPrivate;
import com.trad.bean.CustomerWork;
import com.trad.dao.CustomerContractMapper;
import com.trad.dao.CustomerMapper;
import com.trad.dao.CustomerPrivateMapper;
import com.trad.dao.CustomerWorkMapper;
import com.trad.service.CustomerService;

@Service("customerService")
public class CustomerServiceImpl implements CustomerService{
	@Resource  
    private CustomerMapper customerDao;
	@Resource
	private CustomerWorkMapper workDao;
	@Resource
	private CustomerContractMapper contractDao;
	@Resource
	private CustomerPrivateMapper privateDao;
	
	@Override
	public int updateByPrimaryKeySelective(Customer record) {
		return customerDao.updateByPrimaryKeySelective(record);
	}

	@Override
	public int count(String filter) {
		return customerDao.count(filter);
	}

	@Override
	public int insert(Customer record) {
		return customerDao.insert(record);
	}

	@Override
	public List<Customer> queryByPaged(String filter, int start, int end) {
		return customerDao.queryByPaged(filter, start, end);
	}

	@Override
	public int deleteByPrimaryKey(Integer id) {
		return customerDao.deleteByPrimaryKey(id);
	}

	@Override
	public List<Customer> queryAll() {
		return customerDao.queryAll();
	}

	@Override
	public Customer queryCustomerById(Integer id) {
		return customerDao.selectByPrimaryKey(id);
	}

	@Override
	public int insertWork(CustomerWork record) {
		return workDao.insert(record);
	}

	@Override
	public CustomerWork queryWorkById(Integer customerId) {
		return workDao.selectByCustomerId(customerId);
	}
	
	@Override
	public int updateByWorkSelective(CustomerWork record) {
		return workDao.updateByPrimaryKeySelective(record);
	}

	@Override
	public int countContract(Integer customerId) {
		return contractDao.countContract(customerId);
	}

	@Override
	public List<CustomerContract> queryContractByPaged(Integer customerId,int start, int end) {
		return contractDao.queryContractByPaged(customerId,start, end);
	}

	@Override
	public int insertContract(CustomerContract record) {
		return contractDao.insert(record);
	}

	@Override
	public CustomerContract queryContractkById(Integer id) {
		return contractDao.selectByCustomerId(id);
	}

	@Override
	public int updateByContractSelective(CustomerContract record) {
		return contractDao.updateByPrimaryKeySelective(record);
	}

	@Override
	public int deleteContract(Integer id) {
		return contractDao.deleteByPrimaryKey(id);
	}

	@Override
	public int countPrivate(Integer id) {
		return privateDao.countPrivate(id);
	}

	@Override
	public List<CustomerPrivate> queryPrivateByPaged(Integer id, int start, int end) {
		return privateDao.queryPrivateByPaged(id, start, end);
	}

	@Override
	public int insertPrivate(CustomerPrivate record) {
		return privateDao.insert(record);
	}

	@Override
	public CustomerPrivate queryPrivatekById(Integer id) {
		return privateDao.selectByCustomerId(id);
	}

	@Override
	public int updateByPrivateSelective(CustomerPrivate record) {
		return privateDao.updateByPrimaryKeySelective(record);
	}

	@Override
	public int deletePrivate(Integer id) {
		return privateDao.deleteByPrimaryKey(id);
	}

	@Override
	public int deleteCustomer(Integer customerId) {
		try{
			//1.删除customer_private
			privateDao.deleteByCustomer(customerId);
			//2.删除customer_contract
			contractDao.deleteByCustomerId(customerId);
			//3.删除customer_work
			workDao.deleteByCustomerId(customerId);
			//4.删除主表
			customerDao.deleteByPrimaryKey(customerId);
			return 1;
		}catch(Exception e){
			e.printStackTrace();
		}
		return 0;
	}

	@Override
	public List<Customer> getCustomerAll() {
		return customerDao.getCustomerAll();
	}

}
