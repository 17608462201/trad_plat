package com.trad.service;

import java.util.List;
import java.util.Map;

import com.trad.bean.PaymentOver;

public interface PaymentOverService {
	 int insert(PaymentOver paymentOver);
	 List<Map<String, Object>> getOverAll(Map<String, Object> map);
	 int countOver(Map<String, Object> map);
	 int updateByPrimaryKeySelective(PaymentOver record);
	 List<Map<String, Object>> selPaymentOver(Map<String, Object> map);
	 int countPaymentOver(Map<String, Object> map);
	 List<Map<String, Object>> selOver();
}
