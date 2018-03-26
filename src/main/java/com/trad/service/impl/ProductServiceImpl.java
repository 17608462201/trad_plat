package  com.trad.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.trad.bean.Product;
import com.trad.dao.ProductMapper;
import com.trad.service.ProductService;

@Service("proService")
public class ProductServiceImpl implements ProductService{
	@Resource  
    private ProductMapper proDao;

	@Override
	public int count(String filter) {
		return proDao.count(filter);
	}

	@Override
	public List<Product> queryByPaged(String filter, int start, int end) {
		return proDao.queryByPaged(filter, start, end);
	}

	@Override
	public int deleteByPrimaryKey(Integer id) {
		return proDao.deleteByPrimaryKey(id);
	}

	@Override
	public int saveProduct(Product record) {
		return proDao.insertSelective(record);
	}

	@Override
	public int updateByPrimaryKeySelective(Product record) {
		return proDao.updateByPrimaryKeySelective(record);
	}

	@Override
	public Product selectByPrimaryKey(Integer id) {
		return proDao.selectByPrimaryKey(id);
	}

	@Override
	public List<Map<String, Object>> getProductAll() {
		return proDao.getProductAll();
	}
	
}
