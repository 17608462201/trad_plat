package com.trad.service.impl;

import java.util.List;
import java.util.Map;

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

	@Override
	public List<Map<String, Object>> getLoanOfferList(Map<String, Object> map) {
		return loanOfferMapper.getLoanOfferList(map);
	}

	@Override
	public int getCount(Map<String, Object> map) {
		return loanOfferMapper.getCount(map);
	}

	@Override
	public Map<String, Object> selectByPrimaryKey(String id) {
		return loanOfferMapper.selectByPrimaryKey(id);
	}

	@Override
	public int updateByPrimaryKeySelective(LoanOffer loanOffer) {
		return loanOfferMapper.updateByPrimaryKeySelective(loanOffer);
	}

	@Override
	public Map<String, Object> selloanOfferByloanId(String loanId) {
		return loanOfferMapper.selloanOfferByloanId(loanId);
	}
	
}
