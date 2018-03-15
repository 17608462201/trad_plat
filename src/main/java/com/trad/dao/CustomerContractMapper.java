package com.trad.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.trad.bean.CustomerContract;

public interface CustomerContractMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(CustomerContract record);

    int insertSelective(CustomerContract record);

    CustomerContract selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(CustomerContract record);

    int updateByPrimaryKey(CustomerContract record);
    
    public int countContract(@Param("customerId")Integer customerId);
	//分页查询数据
	public List<CustomerContract> queryContractByPaged(@Param("customerId")Integer customerId,int start,int end);
	
	CustomerContract selectByCustomerId(Integer customerId);
	
	int deleteByCustomerId(Integer customerId);
}