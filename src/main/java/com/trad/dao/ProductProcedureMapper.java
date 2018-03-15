package com.trad.dao;

import com.trad.bean.ProductProcedure;

public interface ProductProcedureMapper {
    int deleteByPrimaryKey(String id);

    int insert(ProductProcedure record);

    int insertSelective(ProductProcedure record);

    ProductProcedure selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(ProductProcedure record);

    int updateByPrimaryKey(ProductProcedure record);
}