package com.trad.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import com.trad.bean.CustomerPrivate;

public interface CustomerPrivateMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(CustomerPrivate record);

    int insertSelective(CustomerPrivate record);

    CustomerPrivate selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(CustomerPrivate record);

    int updateByPrimaryKey(CustomerPrivate record);
    
    public int countPrivate(@Param("customerId")Integer customerId);
   	//分页查询数据
   	public List<CustomerPrivate> queryPrivateByPaged(@Param("customerId")Integer customerId,int start,int end);
   	
   	CustomerPrivate selectByCustomerId(Integer id);
   	
    int deleteByCustomer(Integer customerId);
}