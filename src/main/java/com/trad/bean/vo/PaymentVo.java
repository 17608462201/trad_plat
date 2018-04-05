package com.trad.bean.vo;

import com.trad.bean.Payment;

public class PaymentVo extends Payment{

	private String loanName;

    private String paymentDayStr;
    
    private String productName;
    
    private String precentStr;

	public String getLoanName() {
		return loanName;
	}

	public String getPaymentDayStr() {
		return paymentDayStr;
	}

	public void setLoanName(String loanName) {
		this.loanName = loanName;
	}

	public void setPaymentDayStr(String paymentDayStr) {
		this.paymentDayStr = paymentDayStr;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public String getPrecentStr() {
		return precentStr;
	}

	public void setPrecentStr(String precentStr) {
		this.precentStr = precentStr;
	}
	
	
    
}