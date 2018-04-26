package com.trad.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.trad.bean.LoanPlan;
import com.trad.dao.LoanPlanMapper;
import com.trad.service.LoanPlanService;

@Service
public class LoanPlanServiceImpl implements LoanPlanService {
	
	@Autowired
	private LoanPlanMapper loanPlanMapper;

	@Override
	public int insert(LoanPlan record) {
		return loanPlanMapper.insert(record);
	}

	@Override
	public List<Map<String, Object>> selPlanByLoanId(String loanId) {
		return loanPlanMapper.selPlanByLoanId(loanId);
	}

	@Override
	public int updateByPrimaryKeySelective(LoanPlan record) {
		return loanPlanMapper.updateByPrimaryKeySelective(record);
	}

	@Override
	public int deleteByPrimaryKey(String loanPlanId) {
		return loanPlanMapper.deleteByPrimaryKey(loanPlanId);
	}
	
}
