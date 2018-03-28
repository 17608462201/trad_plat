package com.trad.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.trad.bean.LoanStatus;
import com.trad.dao.LoanStatusMapper;
import com.trad.service.LoanStatusService;

@Service
public class LoanStatusServiceImpl implements LoanStatusService {
	
	@Autowired
	private LoanStatusMapper loanStatusMapper;

	@Override
	public int insert(LoanStatus record) {
		return loanStatusMapper.insert(record);
	}
	
}
