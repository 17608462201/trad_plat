package com.trad.service;

import java.util.List;
import java.util.Map;

import com.trad.bean.LoanOffer;

public interface LoanOfferService {
	int insert(LoanOffer record);
	
	List<Map<String, Object>> getLoanOfferList(Map<String, Object> map);
    
    int getCount(Map<String, Object> map);
    
    Map<String, Object> selectByPrimaryKey(String id);
    
    int updateByPrimaryKeySelective(LoanOffer loanOffer);
    
    Map<String, Object> selloanOfferByloanId(String loanId);
}
