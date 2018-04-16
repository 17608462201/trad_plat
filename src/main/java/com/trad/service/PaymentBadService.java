package com.trad.service;

import java.util.List;
import java.util.Map;

import com.trad.bean.PaymentBad;
import com.trad.bean.PaymentOver;

public interface PaymentBadService {
	List<Map<String, Object>> selPaymentBad(Map<String, Object> map);
    
    int countPaymentBad(Map<String, Object> map);
    
    List<Map<String, Object>> selPaymentBadAll(Map<String, Object> map);
    
    int countPaymentBadAll(Map<String, Object> map);
    
    int insert(PaymentBad record);
    
    int updateByPrimaryKeySelective(PaymentBad paymentBad);
}
