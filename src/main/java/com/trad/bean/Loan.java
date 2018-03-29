package com.trad.bean;

import java.util.Date;

public class Loan {
    private String id;
    
    private String loanContractNo;

    private String productId;

    private String productName;

    private String loanPer;

    private String loanMobile;

    private String loanMoney;

    private String loanLimit;

    private String loanStatus;

    private String applyTime;

    private String customerId;

    private String customerName;

    private String managerId;

    private String managerName;

    private String pawnAdd;

    private String remark;

    private Date createTime;

    private Date updateTime;

    private String createPer;
    
    private String loanState;
    
    private String loanPurpose;
    
    private String loanSource;
    
    private String loanOperate;

    private String updatePer;
    
    public String getLoanState() {
		return loanState;
	}

	public void setLoanState(String loanState) {
		this.loanState = loanState;
	}

	public String getLoanPurpose() {
		return loanPurpose;
	}

	public void setLoanPurpose(String loanPurpose) {
		this.loanPurpose = loanPurpose;
	}

	public String getLoanSource() {
		return loanSource;
	}

	public void setLoanSource(String loanSource) {
		this.loanSource = loanSource;
	}

	public String getLoanOperate() {
		return loanOperate;
	}

	public void setLoanOperate(String loanOperate) {
		this.loanOperate = loanOperate;
	}

	public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    public String getLoanContractNo() {
		return loanContractNo;
	}

	public void setLoanContractNo(String loanContractNo) {
		this.loanContractNo = loanContractNo;
	}

	public String getProductId() {
        return productId;
    }

    public void setProductId(String productId) {
        this.productId = productId == null ? null : productId.trim();
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName == null ? null : productName.trim();
    }

    public String getLoanPer() {
        return loanPer;
    }

    public void setLoanPer(String loanPer) {
        this.loanPer = loanPer == null ? null : loanPer.trim();
    }

    public String getLoanMobile() {
        return loanMobile;
    }

    public void setLoanMobile(String loanMobile) {
        this.loanMobile = loanMobile == null ? null : loanMobile.trim();
    }

    public String getLoanMoney() {
        return loanMoney;
    }

    public void setLoanMoney(String loanMoney) {
        this.loanMoney = loanMoney == null ? null : loanMoney.trim();
    }

    public String getLoanLimit() {
        return loanLimit;
    }

    public void setLoanLimit(String loanLimit) {
        this.loanLimit = loanLimit == null ? null : loanLimit.trim();
    }

    public String getLoanStatus() {
        return loanStatus;
    }

    public void setLoanStatus(String loanStatus) {
    	this.loanStatus = loanStatus;
    	/*if(loanStatus.equals("1")) {
    		this.loanStatus = "待初审";
    	}else if(loanStatus.equals("2")) {
    		this.loanStatus = "待下户";
    	}else if(loanStatus.equals("3")) {
    		this.loanStatus = "待核算";
    	}else if(loanStatus.equals("4")) {
    		this.loanStatus = "待签约";
    	}else if(loanStatus.equals("5")) {
    		this.loanStatus = "待公证";
    	}else if(loanStatus.equals("6")) {
    		this.loanStatus = "待放款";
    	}else if(loanStatus.equals("7")) {
    		this.loanStatus = "放款审核";
    	}else if(loanStatus.equals("8")) {
    		this.loanStatus = "总经理审核";
    	}else if(loanStatus.equals("9")) {
    		this.loanStatus = "财务放款";
    	}*/
    }

    public String getApplyTime() {
        return applyTime;
    }

    public void setApplyTime(String applyTime) {
        this.applyTime = applyTime == null ? null : applyTime.trim();
    }

    public String getCustomerId() {
        return customerId;
    }

    public void setCustomerId(String customerId) {
        this.customerId = customerId == null ? null : customerId.trim();
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName == null ? null : customerName.trim();
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

    public String getPawnAdd() {
        return pawnAdd;
    }

    public void setPawnAdd(String pawnAdd) {
        this.pawnAdd = pawnAdd == null ? null : pawnAdd.trim();
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