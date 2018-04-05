package com.trad.bean;

import java.util.Date;

public class PaymentAdvance {
    private String id;

    private String paymentId;

    private String payMoney;

    private String realPayMoney;

    private Date settleTime;

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
        this.paymentId = paymentId == null ? null : paymentId.trim();
    }

    public String getPayMoney() {
        return payMoney;
    }

    public void setPayMoney(String payMoney) {
        this.payMoney = payMoney == null ? null : payMoney.trim();
    }

    public String getRealPayMoney() {
        return realPayMoney;
    }

    public void setRealPayMoney(String realPayMoney) {
        this.realPayMoney = realPayMoney == null ? null : realPayMoney.trim();
    }

    public Date getSettleTime() {
        return settleTime;
    }

    public void setSettleTime(Date settleTime) {
        this.settleTime = settleTime;
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