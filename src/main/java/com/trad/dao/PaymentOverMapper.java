package com.trad.dao;

import java.util.List;
import java.util.Map;

import com.trad.bean.PaymentOver;

public interface PaymentOverMapper {
    int deleteByPrimaryKey(String id);

    int insert(PaymentOver paymentOver);

    int insertSelective(PaymentOver record);

    PaymentOver selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(PaymentOver record);

    int updateByPrimaryKey(PaymentOver record);
    
    List<Map<String, Object>> getOverAll(Map<String, Object> map);
    
    int countOver(Map<String, Object> map);
    
    List<Map<String, Object>> selPaymentOver(Map<String, Object> map);
    
    int countPaymentOver(Map<String, Object> map);
    
    List<Map<String, Object>> selOver();
}