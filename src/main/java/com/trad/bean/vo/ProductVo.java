package com.trad.bean.vo;

import java.util.Date;

import com.trad.bean.Product;

/**
 * @author it
 *
 */
public class ProductVo {
	private Integer id;

    private String name;

    private String decription;

    private String payName;

    private Integer payTimes;

    private Double trad;

    private String paytype;

    private String punishtype;

    private Double punishtrad;

    private Integer mostmon;

    private String payobj;

    private String remark;

    private String createTime;

    private String updateTime;

    private String createPer;

    private String updatePer;

    private String recordStatus="1";
    
    private String payNameDec;
    
    private String punishTypeDec;
    
    private String payObjDec;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDecription() {
		return decription;
	}

	public void setDecription(String decription) {
		this.decription = decription;
	}

	public String getPayName() {
		return payName;
	}

	public void setPayName(String payName) {
		this.payName = payName;
	}

	public Integer getPayTimes() {
		return payTimes;
	}

	public void setPayTimes(Integer payTimes) {
		this.payTimes = payTimes;
	}

	public Double getTrad() {
		return trad;
	}

	public void setTrad(Double trad) {
		this.trad = trad;
	}

	public String getPaytype() {
		return paytype;
	}

	public void setPaytype(String paytype) {
		this.paytype = paytype;
	}

	public String getPunishtype() {
		return punishtype;
	}

	public void setPunishtype(String punishtype) {
		this.punishtype = punishtype;
	}

	public Double getPunishtrad() {
		return punishtrad;
	}

	public void setPunishtrad(Double punishtrad) {
		this.punishtrad = punishtrad;
	}

	public Integer getMostmon() {
		return mostmon;
	}

	public void setMostmon(Integer mostmon) {
		this.mostmon = mostmon;
	}

	public String getPayobj() {
		return payobj;
	}

	public void setPayobj(String payobj) {
		this.payobj = payobj;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getCreatePer() {
		return createPer;
	}

	public void setCreatePer(String createPer) {
		this.createPer = createPer;
	}

	public String getUpdatePer() {
		return updatePer;
	}

	public void setUpdatePer(String updatePer) {
		this.updatePer = updatePer;
	}

	public String getRecordStatus() {
		return recordStatus;
	}

	public void setRecordStatus(String recordStatus) {
		this.recordStatus = recordStatus;
	}

	public String getPayNameDec() {
		return payNameDec;
	}

	public void setPayNameDec(String payNameDec) {
		this.payNameDec = payNameDec;
	}

	public String getPunishTypeDec() {
		return punishTypeDec;
	}

	public void setPunishTypeDec(String punishTypeDec) {
		this.punishTypeDec = punishTypeDec;
	}

	public String getPayObjDec() {
		return payObjDec;
	}

	public void setPayObjDec(String payObjDec) {
		this.payObjDec = payObjDec;
	}

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	public String getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(String updateTime) {
		this.updateTime = updateTime;
	}

}