package com.trad.dao;

import java.util.List;
import java.util.Map;

import com.trad.bean.ReceiptsLoanOffer;

public interface ReceiptsLoanOfferMapper {
    int deleteByPrimaryKey(String receiptsId);

    int insert(ReceiptsLoanOffer record);

    int insertSelective(ReceiptsLoanOffer record);

    ReceiptsLoanOffer selectByPrimaryKey(String receiptsId);

    int updateByPrimaryKeySelective(ReceiptsLoanOffer record);

    int updateByPrimaryKey(ReceiptsLoanOffer record);
    
    List<Map<String, Object>> selReceiptsLoanOfferAll(Map<String, Object> map);
    
    int getCount(Map<String, Object> map);
    
    ReceiptsLoanOffer selReceiptsLoanOffer(String receiptsId);
}