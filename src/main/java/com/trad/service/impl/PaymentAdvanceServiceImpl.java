package com.trad.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.trad.bean.PaymentAdvance;
import com.trad.dao.PaymentAdvanceMapper;
import com.trad.service.PaymentAdvanceService;

@Service
public class PaymentAdvanceServiceImpl implements PaymentAdvanceService {
	@Autowired
	private PaymentAdvanceMapper paymentAdvanceMapper;

	@Override
	public int insert(PaymentAdvance record) {
		return paymentAdvanceMapper.insert(record);
	}

	@Override
	public List<Map<String, Object>> selPaymentAdvance(Map<String, Object> map) {
		return paymentAdvanceMapper.selPaymentAdvance(map);
	}

	@Override
	public int countPaymentAdvance(Map<String, Object> map) {
		return paymentAdvanceMapper.countPaymentAdvance(map);
	}
}
