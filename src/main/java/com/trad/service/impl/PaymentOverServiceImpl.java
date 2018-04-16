package com.trad.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.trad.bean.PaymentOver;
import com.trad.dao.PaymentOverMapper;
import com.trad.service.PaymentOverService;

@Service
public class PaymentOverServiceImpl implements PaymentOverService {
	
	@Autowired
	private PaymentOverMapper paymentOverMapper;

	@Override
	public int insert(PaymentOver paymentOver) {
		return paymentOverMapper.insert(paymentOver);
	}

	@Override
	public List<Map<String, Object>> getOverAll(Map<String, Object> map) {
		return paymentOverMapper.getOverAll(map);
	}

	@Override
	public int countOver(Map<String, Object> map) {
		return paymentOverMapper.countOver(map);
	}

	@Override
	public int updateByPrimaryKeySelective(PaymentOver record) {
		return paymentOverMapper.updateByPrimaryKeySelective(record);
	}

	@Override
	public List<Map<String, Object>> selPaymentOver(Map<String, Object> map) {
		return paymentOverMapper.selPaymentOver(map);
	}

	@Override
	public int countPaymentOver(Map<String, Object> map) {
		return paymentOverMapper.countPaymentOver(map);
	}

	@Override
	public List<Map<String, Object>> selOver() {
		return paymentOverMapper.selOver();
	}

}
