package com.trad.dao;

import java.util.List;
import java.util.Map;

import com.trad.bean.CommonFileupload;

public interface CommonFileuploadMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(CommonFileupload record);

    int insertSelective(CommonFileupload record);

    CommonFileupload selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(CommonFileupload record);

    int updateByPrimaryKey(CommonFileupload record);
    
    List<Map<String, Object>> selFileByLoanId(Map<String, Object> map);
    
    void delFile(Map<String, Object> map);
}