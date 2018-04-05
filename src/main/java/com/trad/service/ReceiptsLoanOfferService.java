package com.trad.service;

import java.util.List;
import java.util.Map;

import com.trad.bean.ReceiptsLoanOffer;

public interface ReceiptsLoanOfferService {
	int insert(ReceiptsLoanOffer record);
	
	List<Map<String, Object>> selReceiptsLoanOfferAll(Map<String, Object> map);
    
    int getCount(Map<String, Object> map);
    
    ReceiptsLoanOffer selReceiptsLoanOffer(String receiptsId);
    
    int updateByPrimaryKeySelective(ReceiptsLoanOffer record);
}
