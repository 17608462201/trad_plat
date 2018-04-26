package com.trad.dao;

import java.util.List;
import java.util.Map;

import com.trad.bean.LoanPlan;

public interface LoanPlanMapper {
    int deleteByPrimaryKey(String loanPlanId);

    int insert(LoanPlan record);

    int insertSelective(LoanPlan record);

    LoanPlan selectByPrimaryKey(Integer loanPlanId);

    int updateByPrimaryKeySelective(LoanPlan record);

    int updateByPrimaryKey(LoanPlan record);
    
    List<Map<String, Object>> selPlanByLoanId(String loanId);
}