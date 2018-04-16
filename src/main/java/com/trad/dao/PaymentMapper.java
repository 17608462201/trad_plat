package com.trad.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.trad.bean.Payment;

public interface PaymentMapper {
    int deleteByPrimaryKey(String id);

    int insert(Payment record);

    int insertSelective(Payment record);

    Payment selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(Payment record);

    int updateByPrimaryKey(Payment record);
    
    int count(Map<String, Object> map);
    
    int loanCount(@Param("filter")String filter);
    
    public List<Payment> queryByPaged(Map<String, Object> map);
    
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