package com.trad.service;

import java.util.List;
import java.util.Map;

import com.trad.bean.Product;

public interface ProductService {
    //获取用户总数
  	public int count(String filter);
    //分页查询数据
  	public List<Product> queryByPaged(String filter,int start,int end);
  	
  	public int deleteByPrimaryKey(Integer id);
  	
  	public int saveProduct(Product record);
  	
  	public int updateByPrimaryKeySelective(Product record);
  	
  	public Product selectByPrimaryKey(Integer id);
  	
  	List<Map<String, Object>> getProductAll();
}
