package com.trad.bean.common;

import java.util.List;

public class LayuiTable {

	 //layui表格默认Json格式参数code，默认值为0
	private int code = 0;
	// layui表格默认Json格式参数msg，默认值为""
	private String msg ="success";
	// layui表格默认Json格式参数count，记录总数
    private int count;
	
	private List data;

	public int getCode() {
		return code;
	}

	public void setCode(int code) {
		this.code = code;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public List getData() {
		return data;
	}

	public void setData(List data) {
		this.data = data;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}
	
}
