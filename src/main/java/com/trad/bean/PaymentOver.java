package com.trad.bean;

import java.util.Date;

public class PaymentOver {
    private String id;

    private String loanId;
    
    private String paymentId;

    private String payNum;

    private Date payDay;

    private String orginDay;

    private String overdue;

    private String originPay;

    private String defaultInter;

    private String sumMoney;

    private String remark;

    private Date createTime;

    private Date updateTime;

    private String createPer;

    private String updatePer;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    public String getPaymentId() {
		return paymentId;
	}

	public void setPaymentId(String paymentId) {
		this.paymentId = paymentId;
	}

	public String getLoanId() {
        return loanId;
    }

    public void setLoanId(String loanId) {
        this.loanId = loanId == null ? null : loanId.trim();
    }

    public String getPayNum() {
        return payNum;
    }

    public void setPayNum(String payNum) {
        this.payNum = payNum == null ? null : payNum.trim();
    }

    public Date getPayDay() {
        return payDay;
    }

    public void setPayDay(Date payDay) {
        this.payDay = payDay;
    }

    public String getOrginDay() {
        return orginDay;
    }

    public void setOrginDay(String orginDay) {
        this.orginDay = orginDay == null ? null : orginDay.trim();
    }

    public String getOverdue() {
        return overdue;
    }

    public void setOverdue(String overdue) {
        this.overdue = overdue == null ? null : overdue.trim();
    }

    public String getOriginPay() {
        return originPay;
    }

    public void setOriginPay(String originPay) {
        this.originPay = originPay == null ? null : originPay.trim();
    }

    public String getDefaultInter() {
        return defaultInter;
    }

    public void setDefaultInter(String defaultInter) {
        this.defaultInter = defaultInter == null ? null : defaultInter.trim();
    }

    public String getSumMoney() {
        return sumMoney;
    }

    public void setSumMoney(String sumMoney) {
        this.sumMoney = sumMoney == null ? null : sumMoney.trim();
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark == null ? null : remark.trim();
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

    public String getCreatePer() {
        return createPer;
    }

    public void setCreatePer(String createPer) {
        this.createPer = createPer == null ? null : createPer.trim();
    }

    public String getUpdatePer() {
        return updatePer;
    }

    public void setUpdatePer(String updatePer) {
        this.updatePer = updatePer == null ? null : updatePer.trim();
    }
}