package com.trad.service;

import java.util.List;

import com.trad.bean.Loan;

public interface LoanService {
	List<Loan> getLoanAll();
	int getCount();
	int deleteByPrimaryKey(Integer id);
	Loan selectByPrimaryKey(Integer id);
	int insert(Loan record);
}
