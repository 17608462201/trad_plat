package com.trad.dao;

import com.trad.bean.PaymentOver;

public interface PaymentOverMapper {
    int deleteByPrimaryKey(String id);

    int insert(PaymentOver record);

    int insertSelective(PaymentOver record);

    PaymentOver selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(PaymentOver record);

    int updateByPrimaryKey(PaymentOver record);
}