package com.trad.bean;

import java.util.Date;

public class ReceiptsLoanOffer {
    private String receiptsId;

    private String receiptsLoadId;

    private String receiptsBailScale;

    private String receiptsBailMoney;

    private String receiptsEvalueMoney;

    private String receiptsOfferPound;

    private String receiptsZhMoney;

    private String receiptsPlatMoney;

    private String receiptsOfferMoney;

    private String receiptsMonthScale;

    private String receiptsOfferLimit;
    
    private String loanExpenses;
    
    private String loanCollection;

    private Date createTime;

    private Date updateTime;

    private String createPer;

    private String updatePer;

    public String getLoanExpenses() {
		return loanExpenses;
	}

	public void setLoanExpenses(String loanExpenses) {
		this.loanExpenses = loanExpenses;
	}

	public String getLoanCollection() {
		return loanCollection;
	}

	public void setLoanCollection(String loanCollection) {
		this.loanCollection = loanCollection;
	}

	public String getReceiptsId() {
        return receiptsId;
    }

    public void setReceiptsId(String receiptsId) {
        this.receiptsId = receiptsId == null ? null : receiptsId.trim();
    }

    public String getReceiptsLoadId() {
        return receiptsLoadId;
    }

    public void setReceiptsLoadId(String receiptsLoadId) {
        this.receiptsLoadId = receiptsLoadId == null ? null : receiptsLoadId.trim();
    }

    public String getReceiptsBailScale() {
        return receiptsBailScale;
    }

    public void setReceiptsBailScale(String receiptsBailScale) {
        this.receiptsBailScale = receiptsBailScale == null ? null : receiptsBailScale.trim();
    }

    public String getReceiptsBailMoney() {
        return receiptsBailMoney;
    }

    public void setReceiptsBailMoney(String receiptsBailMoney) {
        this.receiptsBailMoney = receiptsBailMoney == null ? null : receiptsBailMoney.trim();
    }

    public String getReceiptsEvalueMoney() {
        return receiptsEvalueMoney;
    }

    public void setReceiptsEvalueMoney(String receiptsEvalueMoney) {
        this.receiptsEvalueMoney = receiptsEvalueMoney == null ? null : receiptsEvalueMoney.trim();
    }

    public String getReceiptsOfferPound() {
        return receiptsOfferPound;
    }

    public void setReceiptsOfferPound(String receiptsOfferPound) {
        this.receiptsOfferPound = receiptsOfferPound == null ? null : receiptsOfferPound.trim();
    }

    public String getReceiptsZhMoney() {
        return receiptsZhMoney;
    }

    public void setReceiptsZhMoney(String receiptsZhMoney) {
        this.receiptsZhMoney = receiptsZhMoney == null ? null : receiptsZhMoney.trim();
    }

    public String getReceiptsPlatMoney() {
        return receiptsPlatMoney;
    }

    public void setReceiptsPlatMoney(String receiptsPlatMoney) {
        this.receiptsPlatMoney = receiptsPlatMoney == null ? null : receiptsPlatMoney.trim();
    }

    public String getReceiptsOfferMoney() {
        return receiptsOfferMoney;
    }

    public void setReceiptsOfferMoney(String receiptsOfferMoney) {
        this.receiptsOfferMoney = receiptsOfferMoney == null ? null : receiptsOfferMoney.trim();
    }

    public String getReceiptsMonthScale() {
        return receiptsMonthScale;
    }

    public void setReceiptsMonthScale(String receiptsMonthScale) {
        this.receiptsMonthScale = receiptsMonthScale == null ? null : receiptsMonthScale.trim();
    }

    public String getReceiptsOfferLimit() {
        return receiptsOfferLimit;
    }

    public void setReceiptsOfferLimit(String receiptsOfferLimit) {
        this.receiptsOfferLimit = receiptsOfferLimit == null ? null : receiptsOfferLimit.trim();
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