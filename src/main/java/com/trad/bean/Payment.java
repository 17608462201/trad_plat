package com.trad.bean;

import java.util.Date;

public class Payment {
    private String id;

    private String contractId;

    private String paymentName;

    private String paymentPhone;

    private String loanId;

    private String loanPhone;

    private String managerId;

    private String managerName;

    private Date paymentDay;

    private Date paymentTime;

    private String paymentMoney;

    private String defaultInter;

    private String reallyPayment;

    private String paymentAdvance;

    private String paymentStatus;

    private String handlerName;

    private String loanPrecent;

    private String paymentNum;

    private String paymentWay;

    private String remark;

    private Date createTime;

    private Date updateTime;

    private String createPer;

    private String updatePer;

    private String loanPer;
    
    private Loan loan;
    
    private LoanOffer loanOffer;
    
    private String allPrecent;

    public LoanOffer getLoanOffer() {
		return loanOffer;
	}

	public void setLoanOffer(LoanOffer loanOffer) {
		this.loanOffer = loanOffer;
	}

	public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    public String getContractId() {
        return contractId;
    }

    public void setContractId(String contractId) {
        this.contractId = contractId == null ? null : contractId.trim();
    }

    public String getPaymentName() {
        return paymentName;
    }

    public void setPaymentName(String paymentName) {
        this.paymentName = paymentName == null ? null : paymentName.trim();
    }

    public String getPaymentPhone() {
        return paymentPhone;
    }

    public void setPaymentPhone(String paymentPhone) {
        this.paymentPhone = paymentPhone == null ? null : paymentPhone.trim();
    }

    public String getLoanId() {
        return loanId;
    }

    public void setLoanId(String loanId) {
        this.loanId = loanId == null ? null : loanId.trim();
    }

    public String getLoanPhone() {
        return loanPhone;
    }

    public void setLoanPhone(String loanPhone) {
        this.loanPhone = loanPhone == null ? null : loanPhone.trim();
    }

    public String getManagerId() {
        return managerId;
    }

    public void setManagerId(String managerId) {
        this.managerId = managerId == null ? null : managerId.trim();
    }

    public String getManagerName() {
        return managerName;
    }

    public void setManagerName(String managerName) {
        this.managerName = managerName == null ? null : managerName.trim();
    }

    public Date getPaymentDay() {
        return paymentDay;
    }

    public void setPaymentDay(Date paymentDay) {
        this.paymentDay = paymentDay;
    }

    public Date getPaymentTime() {
        return paymentTime;
    }

    public void setPaymentTime(Date paymentTime) {
        this.paymentTime = paymentTime;
    }

    public String getPaymentMoney() {
        return paymentMoney;
    }

    public void setPaymentMoney(String paymentMoney) {
        this.paymentMoney = paymentMoney == null ? null : paymentMoney.trim();
    }

    public String getDefaultInter() {
        return defaultInter;
    }

    public void setDefaultInter(String defaultInter) {
        this.defaultInter = defaultInter == null ? null : defaultInter.trim();
    }

    public String getReallyPayment() {
        return reallyPayment;
    }

    public void setReallyPayment(String reallyPayment) {
        this.reallyPayment = reallyPayment == null ? null : reallyPayment.trim();
    }

    public String getPaymentAdvance() {
        return paymentAdvance;
    }

    public void setPaymentAdvance(String paymentAdvance) {
        this.paymentAdvance = paymentAdvance == null ? null : paymentAdvance.trim();
    }

    public String getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus == null ? null : paymentStatus.trim();
    }

    public String getHandlerName() {
        return handlerName;
    }

    public void setHandlerName(String handlerName) {
        this.handlerName = handlerName == null ? null : handlerName.trim();
    }

    public String getLoanPrecent() {
        return loanPrecent;
    }

    public void setLoanPrecent(String loanPrecent) {
        this.loanPrecent = loanPrecent == null ? null : loanPrecent.trim();
    }

    public String getPaymentNum() {
		return paymentNum;
	}

	public void setPaymentNum(String paymentNum) {
		this.paymentNum = paymentNum;
	}

	public String getPaymentWay() {
        return paymentWay;
    }

    public void setPaymentWay(String paymentWay) {
        this.paymentWay = paymentWay == null ? null : paymentWay.trim();
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

    public String getLoanPer() {
        return loanPer;
    }

    public void setLoanPer(String loanPer) {
        this.loanPer = loanPer == null ? null : loanPer.trim();
    }

	public Loan getLoan() {
		return loan;
	}

	public void setLoan(Loan loan) {
		this.loan = loan;
	}

	public String getAllPrecent() {
		return allPrecent;
	}

	public void setAllPrecent(String allPrecent) {
		this.allPrecent = allPrecent;
	}
	
}