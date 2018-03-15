package com.trad.dao;

import com.trad.bean.CustomerWork;

public interface CustomerWorkMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(CustomerWork record);

    int insertSelective(CustomerWork record);

    CustomerWork selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(CustomerWork record);

    int updateByPrimaryKey(CustomerWork record);
    
    CustomerWork selectByCustomerId(Integer customerId);
    
    int deleteByCustomerId(Integer customerId);
}