package com.trad.service;

import java.util.List;
import java.util.Map;

import com.trad.bean.PaymentAdvance;

public interface PaymentAdvanceService {
	int insert(PaymentAdvance record);
	
	List<Map<String, Object>> selPaymentAdvance(Map<String, Object> map);
    
    int countPaymentAdvance(Map<String, Object> map);
}
