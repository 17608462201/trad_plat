package com.trad.controller;

import java.text.ParseException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.trad.bean.Payment;
import com.trad.bean.PaymentBad;
import com.trad.bean.PaymentOver;
import com.trad.service.PaymentBadService;
import com.trad.service.PaymentOverService;
import com.trad.service.PaymentService;
import com.trad.util.DateUtil;

@Component
public class RepayQuartz {
	
	@Autowired
	private PaymentService paymentService;
	@Autowired
	private PaymentOverService paymentOverService;
	@Autowired
	private PaymentBadService paymentBadService;
	
//	@Scheduled(cron="0 * */1 * * ?")
//	@Scheduled(cron="0/10 * * * * ?")
	public void repay() throws ParseException {
		List<Payment> list=paymentService.selPaymentStatus();
		for (int i = 0; i < list.size(); i++) {
			Payment p=list.get(i);
			int d=DateUtil.dayInterval(p.getPaymentDay(), new Date());
			if(d==1) {
				PaymentOver paymentOver=new PaymentOver();
				paymentOver.setLoanId(p.getLoanId());
				paymentOver.setPayNum(p.getPaymentNum());
				paymentOver.setPayDay(p.getPaymentDay());
				paymentOver.setOrginDay(DateUtil.format(p.getPaymentDay()));
				paymentOver.setOverdue(String.valueOf(Math.abs(d)));
				paymentOver.setOriginPay(p.getPaymentMoney());
				String offMoney=paymentService.selOffMoney(p.getLoanId());
				double defaultInter = PaymentController.multiply(Double.valueOf(offMoney), 6000*d);
				paymentOver.setDefaultInter(String.valueOf(defaultInter));			//罚息
				double sumMoney=PaymentController.add(defaultInter, Double.valueOf(p.getReallyPayment()));
				paymentOver.setSumMoney(String.valueOf(sumMoney));
				paymentOver.setRemark(p.getRemark());
				paymentOver.setId(UUID.randomUUID().toString().replaceAll("-", ""));
				paymentOverService.insert(paymentOver);
				System.out.println("逾期计算完成");
				
				Map<String, Object> map=new HashMap<>();
				map.put("paymentId", p.getId());
				map.put("status", "2");
				paymentService.updatePaymentStatus(map);
			}
		}
		
		List<Map<String, Object>> overList=paymentOverService.selOver();
		for (int i = 0; i < overList.size(); i++) {
			Map<String, Object> map=overList.get(i);
			int d=DateUtil.dayInterval(DateUtil.parse(map.get("pay_day").toString()), new Date());
			if(d>=10) {
				PaymentBad paymentBad=new PaymentBad();
				paymentBad.setPaymentId(map.get("payment_id").toString());
				paymentBad.setLoanId(map.get("loan_id").toString());
				paymentBad.setPayTime(DateUtil.parse(map.get("").toString()));
				paymentBad.setBadDebtStatus(map.get("").toString());
				paymentBad.setIsSettle(map.get("").toString());
				paymentBad.setRemark(map.get("remark").toString());
				paymentBadService.insert(paymentBad);
			}
		}
        System.out.println("sping 定时任务");
    }
}
