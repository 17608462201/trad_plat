package com.trad.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.trad.bean.Payment;

public interface PaymentMapper {
    int deleteByPrimaryKey(String id);

    int insert(Payment record);

    int insertSelective(Payment record);

    Payment selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(Payment record);

    int updateByPrimaryKey(Payment record);
    
    int count(@Param("filter")String filter);
    
    int loanCount(@Param("filter")String filter);
    
    public List<Payment> queryByPaged(@Param("filter")String filter,Integer start,Integer end);
}