package com.trad.dao;

import java.util.List;

import com.trad.bean.Loan;

public interface LoanMapper {
	
    int deleteByPrimaryKey(Integer id);

    int insert(Loan record);

    int insertSelective(Loan record);

    Loan selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Loan record);

    int updateByPrimaryKey(Loan record);
    
    List<Loan> getLoanAll();
    
    int getCount();
}