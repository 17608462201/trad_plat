package com.trad.service;

import java.util.List;
import java.util.Map;

import com.trad.bean.LoanPlan;

public interface LoanPlanService {
	int insert(LoanPlan record);
	List<Map<String, Object>> selPlanByLoanId(String loanId);
	int updateByPrimaryKeySelective(LoanPlan record);
}
