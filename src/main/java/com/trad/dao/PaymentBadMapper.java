package com.trad.dao;

import com.trad.bean.PaymentBad;

public interface PaymentBadMapper {
    int deleteByPrimaryKey(String id);

    int insert(PaymentBad record);

    int insertSelective(PaymentBad record);

    PaymentBad selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(PaymentBad record);

    int updateByPrimaryKey(PaymentBad record);
}