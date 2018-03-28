package com.trad.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.trad.bean.Loan;
import com.trad.dao.LoanMapper;
import com.trad.service.LoanService;

@Service
public class LoanServiceImpl implements LoanService {
	@Autowired
	private LoanMapper loanMapper;

	@Override
	public List<Loan> getLoanAll() {
		return loanMapper.getLoanAll();
	}
	
	public int getCount() {
		return loanMapper.getCount();
	}

	@Override
	public int deleteByPrimaryKey(String id) {
		return loanMapper.deleteByPrimaryKey(id);
	}

	@Override
	public Loan selectByPrimaryKey(String id) {
		return loanMapper.selectByPrimaryKey(id);
	}

	@Override
	public int insert(Map<String, Object> map) {
		return loanMapper.insert(map);
	}

	@Override
	public int updateByPrimaryKeySelective(Map<String, Object> map) {
		return loanMapper.updateByPrimaryKeySelective(map);
	}

	@Override
	public void upLoanStatus(Map<String, Object> map) {
		loanMapper.upLoanStatus(map);
	}
}
