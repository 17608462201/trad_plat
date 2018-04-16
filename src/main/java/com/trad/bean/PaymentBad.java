package com.trad.bean;

import java.util.Date;

public class PaymentBad {
    private String id;

    private String paymentId;
    
    private String loanId;

    private Date payTime;

    private String badDebtStatus;

    private String isSettle;

    private String remark;

    private String handler;

    private Date createTime;

    private Date updateTime;

    private String createPer;

    private String updatePer;

    public String getLoanId() {
		return loanId;
	}

	public void setLoanId(String loanId) {
		this.loanId = loanId;
	}

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
        this.paymentId = paymentId == null ? null : paymentId.trim();
    }

    public Date getPayTime() {
        return payTime;
    }

    public void setPayTime(Date payTime) {
        this.payTime = payTime;
    }

    public String getBadDebtStatus() {
        return badDebtStatus;
    }

    public void setBadDebtStatus(String badDebtStatus) {
        this.badDebtStatus = badDebtStatus == null ? null : badDebtStatus.trim();
    }

    public String getIsSettle() {
        return isSettle;
    }

    public void setIsSettle(String isSettle) {
        this.isSettle = isSettle == null ? null : isSettle.trim();
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark == null ? null : remark.trim();
    }

    public String getHandler() {
        return handler;
    }

    public void setHandler(String handler) {
        this.handler = handler == null ? null : handler.trim();
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