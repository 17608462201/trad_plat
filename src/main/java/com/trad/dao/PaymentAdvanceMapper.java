package com.trad.dao;

import java.util.List;
import java.util.Map;

import com.trad.bean.PaymentAdvance;

public interface PaymentAdvanceMapper {
    int deleteByPrimaryKey(String id);

    int insert(PaymentAdvance record);

    int insertSelective(PaymentAdvance record);

    PaymentAdvance selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(PaymentAdvance record);

    int updateByPrimaryKey(PaymentAdvance record);
    
    List<Map<String, Object>> selPaymentAdvance(Map<String, Object> map);
    
    int countPaymentAdvance(Map<String, Object> map);
}