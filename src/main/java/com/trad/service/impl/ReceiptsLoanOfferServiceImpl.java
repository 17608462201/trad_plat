package com.trad.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.trad.bean.ReceiptsLoanOffer;
import com.trad.dao.ReceiptsLoanOfferMapper;
import com.trad.service.ReceiptsLoanOfferService;

@Service
public class ReceiptsLoanOfferServiceImpl implements ReceiptsLoanOfferService {
	@Autowired
	private ReceiptsLoanOfferMapper receiptsLoanOfferMapper;

	@Override
	public List<Map<String, Object>> selReceiptsLoanOfferAll(Map<String, Object> map) {
		return receiptsLoanOfferMapper.selReceiptsLoanOfferAll(map);
	}

	@Override
	public int getCount(Map<String, Object> map) {
		return receiptsLoanOfferMapper.getCount(map);
	}

	@Override
	public int insert(ReceiptsLoanOffer record) {
		return receiptsLoanOfferMapper.insert(record);
	}

	@Override
	public ReceiptsLoanOffer selReceiptsLoanOffer(String receiptsId) {
		return receiptsLoanOfferMapper.selReceiptsLoanOffer(receiptsId);
	}

	@Override
	public int updateByPrimaryKeySelective(ReceiptsLoanOffer record) {
		return receiptsLoanOfferMapper.updateByPrimaryKeySelective(record);
	}
}
