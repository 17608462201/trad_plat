package com.trad.dao;

import java.util.List;
import java.util.Map;

import com.trad.bean.Loan;

public interface LoanMapper {
	
    int deleteByPrimaryKey(String id);

    int insert(Map<String, Object> map);

    int insertSelective(Loan record);

    Loan selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(Map<String, Object> map);

    int updateByPrimaryKey(Loan record);
    
    List<Loan> getLoanAll(Map<String, Object> map);
    
    int getCount();
    
    void upLoanStatus(Map<String, Object> map);
    
    List<Map<String, Object>> selPlanByLoanId(Map<String, Object> map);
}