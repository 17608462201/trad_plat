package com.trad.bean.common;

public class PageStatus {
	
    // 当前页数（第几页）
    private int page;

    // 数据总数
    private int count;// 从数据库查处的总记录数

    //每页显示条数
    private int limit;
    //查询开始条数
    private int startNum=0;
    //查询结束条数
    private int endNum=0;

	public int getPage() {
		if(page<1){
			page=1;
		}
		if(page>count){
			page=count;
		}
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public int getLimit() {
		if(limit<1){
			limit =1;
		}
		return limit;
	}

	public void setLimit(int limit) {
		this.limit = limit;
	}

	public int getStartNum() {
		if(startNum == 0){
			//自动计算需要查询的条数
			startNum =(getPage()-1)*limit;
		}
		return startNum;
	}

	public void setStartNum(int startNum) {
		this.startNum = startNum;
	}

	public int getEndNum() {
		if(endNum == 0){
			//自动计算需要查询的条数
			endNum =(getPage())*limit;
		}
		return endNum;
	}

	public void setEndNum(int endNum) {
		this.endNum = endNum;
	}
    
}
