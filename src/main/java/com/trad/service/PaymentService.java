package com.trad.service;

import java.util.List;

import com.trad.bean.Payment;

public interface PaymentService {
    //获取用户总数
  	public int count(String filter);
    //分页查询数据
  	public List<Payment> queryByPaged(String filter,int start,int end);
  	
  	public int deleteByPrimaryKey(String id);
  	
  	public int savePayment(Payment record);
  	
  	public int updateByPrimaryKeySelective(Payment record);
  	
  	public Payment selectByPrimaryKey(String id);
  	
  	int insert(Payment record);
}
