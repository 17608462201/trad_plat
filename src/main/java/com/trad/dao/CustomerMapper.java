package com.trad.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.trad.bean.Customer;

public interface CustomerMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Customer record);

    int insertSelective(Customer record);

    Customer selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Customer record);

    int updateByPrimaryKeyWithBLOBs(Customer record);

    int updateByPrimaryKey(Customer record);
    
    int count(@Param("filter")String filter);
    
    public List<Customer> queryByPaged(@Param("filter")String filter,Integer start,Integer end);
    
    public List<Customer> queryAll();
}