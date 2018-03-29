package com.trad.service;

import java.util.List;
import java.util.Map;

import com.trad.bean.CommonFileupload;

public interface CommonFileuploadService {
	int insert(CommonFileupload commonFileupload);
	List<Map<String, Object>> selFileByLoanId(Map<String, Object> map);
	void delFile(Map<String, Object> map);
}
