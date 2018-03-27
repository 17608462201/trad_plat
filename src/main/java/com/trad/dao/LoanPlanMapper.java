package com.trad.dao;

import com.trad.bean.LoanPlan;

public interface LoanPlanMapper {
    int deleteByPrimaryKey(Integer loanPlanId);

    int insert(LoanPlan record);

    int insertSelective(LoanPlan record);

    LoanPlan selectByPrimaryKey(Integer loanPlanId);

    int updateByPrimaryKeySelective(LoanPlan record);

    int updateByPrimaryKey(LoanPlan record);
}