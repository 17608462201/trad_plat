package com.trad.dao;

import com.trad.bean.PaymentAdvance;

public interface PaymentAdvanceMapper {
    int deleteByPrimaryKey(String id);

    int insert(PaymentAdvance record);

    int insertSelective(PaymentAdvance record);

    PaymentAdvance selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(PaymentAdvance record);

    int updateByPrimaryKey(PaymentAdvance record);
}