package com.trad.service;

import java.util.List;

import com.trad.bean.CommonGgdm;
import com.trad.bean.CommonGgdmKey;

public interface CommonGgdmService {
    //获取总数
  	public int count(String filter);
    //分页查询数据
  	public List<CommonGgdm> queryByPaged(String filter,int start,int end);
  	
  	int deleteByPrimaryKey(CommonGgdmKey key);

    int insert(CommonGgdm record);

    int insertSelective(CommonGgdm record);

    CommonGgdm selectByPrimaryKey(CommonGgdmKey key);

    int updateByPrimaryKeySelective(CommonGgdm record);

    int updateByPrimaryKey(CommonGgdm record);
  	
    public List<CommonGgdm> queryByDmjbh(String[] dmjbhs);
}
