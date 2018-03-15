package com.trad.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.trad.bean.CommonGgdm;
import com.trad.bean.CommonGgdmKey;

public interface CommonGgdmMapper {
    int insert(CommonGgdm record);

    int insertSelective(CommonGgdm record);
    
    int deleteByPrimaryKey(CommonGgdmKey key);
    
    CommonGgdm selectByPrimaryKey(CommonGgdmKey key);

    int updateByPrimaryKeySelective(CommonGgdm record);

    int updateByPrimaryKey(CommonGgdm record);
    
    int count(@Param("filter")String filter);
    
    public List<CommonGgdm> queryByPaged(@Param("filter")String filter,Integer start,Integer end);
    
    public List<CommonGgdm> queryByDmjbh(String [] dmjbhs);
}