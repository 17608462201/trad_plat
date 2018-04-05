package com.trad.bean.vo;

import com.trad.bean.Product;

/**
 * @author it
 *
 */
public class ProductVo  extends Product{
    
    private String payNameDec;
    
    private String punishTypeDec;
    
    private String payObjDec;
    
    private String createTimeStr;
    
    private String updateTimeStr;

	public String getPayNameDec() {
		return payNameDec;
	}

	public String getPunishTypeDec() {
		return punishTypeDec;
	}

	public String getPayObjDec() {
		return payObjDec;
	}

	public void setPayNameDec(String payNameDec) {
		this.payNameDec = payNameDec;
	}

	public void setPunishTypeDec(String punishTypeDec) {
		this.punishTypeDec = punishTypeDec;
	}

	public void setPayObjDec(String payObjDec) {
		this.payObjDec = payObjDec;
	}

	public String getCreateTimeStr() {
		return createTimeStr;
	}

	public String getUpdateTimeStr() {
		return updateTimeStr;
	}

	public void setCreateTimeStr(String createTimeStr) {
		this.createTimeStr = createTimeStr;
	}

	public void setUpdateTimeStr(String updateTimeStr) {
		this.updateTimeStr = updateTimeStr;
	}

}