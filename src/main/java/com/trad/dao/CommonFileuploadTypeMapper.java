package com.trad.dao;

import com.trad.bean.CommonFileuploadType;

public interface CommonFileuploadTypeMapper {
    int deleteByPrimaryKey(String id);

    int insert(CommonFileuploadType record);

    int insertSelective(CommonFileuploadType record);

    CommonFileuploadType selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(CommonFileuploadType record);

    int updateByPrimaryKey(CommonFileuploadType record);
}