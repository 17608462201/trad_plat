package com.trad.service;

import java.util.List;

import com.trad.bean.Customer;
import com.trad.bean.CustomerContract;
import com.trad.bean.CustomerPrivate;
import com.trad.bean.CustomerWork;

public interface CustomerService {
	public int updateByPrimaryKeySelective(Customer record);
	//获取角色总数
	public int count(String filter);
	//插入选中信息
	int insert(Customer record);
	//分页查询数据
	public List<Customer> queryByPaged(String filter,int start,int end);
	
	int deleteCustomer(Integer id);
	
	int deleteByPrimaryKey(Integer id);
	
	public List<Customer> queryAll();
	
	Customer queryCustomerById(Integer id);
	
	int insertWork(CustomerWork record);
	
	CustomerWork queryWorkById(Integer customerId);
	
	public int updateByWorkSelective(CustomerWork record);
	
	public int countContract(Integer id);
	//分页查询数据
	public List<CustomerContract> queryContractByPaged(Integer id,int start,int end);
	
    int insertContract(CustomerContract record);
	
	CustomerContract queryContractkById(Integer id);
	
	public int updateByContractSelective(CustomerContract record);
	
	public int deleteContract(Integer id);
	
	public int countPrivate(Integer id);
	
	//分页查询数据
	public List<CustomerPrivate> queryPrivateByPaged(Integer id,int start,int end);
	
    int insertPrivate(CustomerPrivate record);
	
	CustomerPrivate queryPrivatekById(Integer id);
	
	public int updateByPrivateSelective(CustomerPrivate record);
	
	public int deletePrivate(Integer id);
}
