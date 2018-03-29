package com.trad.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.trad.bean.CommonFileupload;
import com.trad.dao.CommonFileuploadMapper;
import com.trad.service.CommonFileuploadService;

@Service
public class CommonFileuploadServiceImpl implements CommonFileuploadService {

	@Autowired
	private CommonFileuploadMapper commonFileuploadMapper;
	
	@Override
	public int insert(CommonFileupload commonFileupload) {
		return commonFileuploadMapper.insert(commonFileupload);
	}

	@Override
	public List<Map<String, Object>> selFileByLoanId(Map<String, Object> map) {
		return commonFileuploadMapper.selFileByLoanId(map);
	}

	@Override
	public void delFile(Map<String, Object> map) {
		commonFileuploadMapper.delFile(map);
	}
	
}
