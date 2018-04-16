package com.trad.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.trad.bean.PaymentBad;
import com.trad.bean.PaymentOver;
import com.trad.dao.PaymentBadMapper;
import com.trad.service.PaymentBadService;

@Service
public class PaymentBadServiceImpl implements PaymentBadService {
	@Autowired
	public PaymentBadMapper paymentBadMapper;

	@Override
	public List<Map<String, Object>> selPaymentBad(Map<String, Object> map) {
		return paymentBadMapper.selPaymentBad(map);
	}

	@Override
	public int countPaymentBad(Map<String, Object> map) {
		return paymentBadMapper.countPaymentBad(map);
	}

	@Override
	public List<Map<String, Object>> selPaymentBadAll(Map<String, Object> map) {
		return paymentBadMapper.selPaymentBadAll(map);
	}

	@Override
	public int countPaymentBadAll(Map<String, Object> map) {
		return paymentBadMapper.countPaymentBadAll(map);
	}

	@Override
	public int insert(PaymentBad record) {
		return paymentBadMapper.insert(record);
	}

	@Override
	public int updateByPrimaryKeySelective(PaymentBad paymentBad) {
		return paymentBadMapper.updateByPrimaryKeySelective(paymentBad);
	}
	
	
}
