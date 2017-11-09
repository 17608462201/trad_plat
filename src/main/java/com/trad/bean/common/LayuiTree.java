package com.trad.bean.common;

import java.util.List;

public class LayuiTree {

	private String name;
	//是否展开状态（默认false）
	private String spread;
	//子节点
	private List children;
	//节点链接（可选），未设则不会跳转
	private String href;
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getSpread() {
		return spread;
	}
	public void setSpread(String spread) {
		this.spread = spread;
	}
	public List getChildren() {
		return children;
	}
	public void setChildren(List children) {
		this.children = children;
	}
	public String getHref() {
		return href;
	}
	public void setHref(String href) {
		this.href = href;
	}
	
}
