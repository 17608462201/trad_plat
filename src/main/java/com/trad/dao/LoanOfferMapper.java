package com.trad.dao;

import java.util.List;
import java.util.Map;

import com.trad.bean.LoanOffer;

public interface LoanOfferMapper {
    int deleteByPrimaryKey(String id);

    int insert(LoanOffer record);

    int insertSelective(LoanOffer record);

    Map<String, Object> selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(LoanOffer loanOffer);

    int updateByPrimaryKey(LoanOffer record);
    
    List<Map<String, Object>> getLoanOfferList(Map<String, Object> map);
    
    int getCount(Map<String, Object> map);
    
    Map<String, Object> selloanOfferByloanId(String loanId);
}