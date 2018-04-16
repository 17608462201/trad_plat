package com.trad.dao;

import java.util.List;
import java.util.Map;

import com.trad.bean.PaymentBad;

public interface PaymentBadMapper {
    int deleteByPrimaryKey(String id);

    int insert(PaymentBad record);

    int insertSelective(PaymentBad record);

    PaymentBad selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(PaymentBad paymentBad);

    int updateByPrimaryKey(PaymentBad record);
    
    List<Map<String, Object>> selPaymentBad(Map<String, Object> map);
    
    int countPaymentBad(Map<String, Object> map);
    
    List<Map<String, Object>> selPaymentBadAll(Map<String, Object> map);
    
    int countPaymentBadAll(Map<String, Object> map);
}