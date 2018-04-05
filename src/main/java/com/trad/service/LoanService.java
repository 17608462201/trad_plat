package com.trad.service;

import java.util.List;
import java.util.Map;

import com.trad.bean.Loan;

public interface LoanService {
	List<Loan> getLoanAll(Map<String, Object> map);
	int getCount();
	int deleteByPrimaryKey(String id);
	Loan selectByPrimaryKey(String id);
	int insert(Map<String, Object> map);
	int updateByPrimaryKeySelective(Map<String, Object> map);
	void upLoanStatus(Map<String, Object> map);
}
