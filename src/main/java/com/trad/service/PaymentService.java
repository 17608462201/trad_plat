package com.trad.service;

import java.util.List;
import java.util.Map;

import com.trad.bean.Payment;

public interface PaymentService {
    //获取用户总数
  	public int count(Map<String, Object> map);
    //分页查询数据
  	public List<Payment> queryByPaged(Map<String, Object> map);
  	
  	public int deleteByPrimaryKey(String id);
  	
  	public int savePayment(Payment record);
  	
  	public int updateByPrimaryKeySelective(Payment record);
  	
  	public Payment selectByPrimaryKey(String id);
  	
  	int insert(Payment record);
  	
  	void updatePaymentStatus(Map<String, Object> map);
  	
  	Map<String, Object> selPaymentById(String id);
  	
  	List<Payment> selPaymentByLoanId(Map<String, Object> map);
    
    int countPaymentByLoanId(Map<String, Object> map);
    
    List<Map<String, Object>> selPaymentDetails(Map<String, Object> map);
    
    int countPaymentDetails(Map<String, Object> map);
    
    List<Map<String, Object>> selPaymentPlan(Map<String, Object> map);
    
    int countPaymentPlan(Map<String, Object> map);
    
    String selOffMoney(String id);
    
    String selPaymentSum(String loanId);
    
    List<Payment> selPaymentStatus();
}
