package com.trad.dao;

import com.trad.bean.LoanStatus;

public interface LoanStatusMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(LoanStatus record);

    int insertSelective(LoanStatus record);

    LoanStatus selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(LoanStatus record);

    int updateByPrimaryKey(LoanStatus record);
}