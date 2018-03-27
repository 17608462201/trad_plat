package com.trad.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.trad.bean.LoanOffer;
import com.trad.dao.LoanOfferMapper;
import com.trad.service.LoanOfferService;

@Service
public class LoanOfferServiceImpl implements LoanOfferService {

	@Autowired
	private LoanOfferMapper loanOfferMapper;
	
	@Override
	public int insert(LoanOffer record) {
		return loanOfferMapper.insert(record);
	}
	
}
