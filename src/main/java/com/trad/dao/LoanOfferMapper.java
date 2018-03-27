package com.trad.dao;

import com.trad.bean.LoanOffer;

public interface LoanOfferMapper {
    int deleteByPrimaryKey(String id);

    int insert(LoanOffer record);

    int insertSelective(LoanOffer record);

    LoanOffer selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(LoanOffer record);

    int updateByPrimaryKey(LoanOffer record);
}