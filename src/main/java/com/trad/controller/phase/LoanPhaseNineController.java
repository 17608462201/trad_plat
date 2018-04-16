package com.trad.controller.phase;

import java.math.BigDecimal;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.trad.bean.CommonGgdm;
import com.trad.bean.Customer;
import com.trad.bean.Loan;
import com.trad.bean.LoanOffer;
import com.trad.bean.LoanStatus;
import com.trad.bean.Payment;
import com.trad.bean.ReceiptsLoanOffer;
import com.trad.bean.User;
import com.trad.bean.common.LayuiTable;
import com.trad.service.CommonFileuploadService;
import com.trad.service.CustomerService;
import com.trad.service.LoanOfferService;
import com.trad.service.LoanService;
import com.trad.service.LoanStatusService;
import com.trad.service.PaymentService;
import com.trad.service.ProductService;
import com.trad.service.ReceiptsLoanOfferService;
import com.trad.util.DateUtil;
import com.trad.util.EntityToMap;
import com.trad.util.ReplyCode;
import com.trad.util.SessionHelper;

@Controller
@RequestMapping("/loanPhaseNine")
public class LoanPhaseNineController {
	
	@Autowired
	private ReceiptsLoanOfferService receiptsLoanOfferService;
	@Autowired
	private LoanService loanServiceImpl;
	@Autowired
	private LoanStatusService loanStatusService;
	@Autowired
	private PaymentService paymentService;

	Logger logger = LoggerFactory.getLogger(LoanPhaseNineController.class);

	@RequestMapping("/init")
	public String init(HttpServletRequest request, Model model) {
		return "loan/phaseNine/phaseNineList";
	}

	@RequestMapping("/getList")
	@ResponseBody
	public String getList(@RequestParam(value = "page", defaultValue = "0") int page,
			@RequestParam(value = "limit", defaultValue = "4") int limit, HttpServletRequest request, Model model) {
		Map<String, Object> map=new HashMap<>();
		map.put("page", page-1);
		map.put("pageSize", limit);
		List<Map<String, Object>> list = receiptsLoanOfferService.selReceiptsLoanOfferAll(map);
		int count = receiptsLoanOfferService.getCount(map);
		LayuiTable returnMsg = new LayuiTable();
		returnMsg.setData(list);
		returnMsg.setCount(count);
		return JSONObject.toJSONString(returnMsg);
	}
	
	@RequestMapping("/upReceiptsLoanOffer")
	public String upReceiptsLoanOffer(HttpServletRequest request, Model model) {
		String receiptsId = request.getParameter("receiptsId");
		ReceiptsLoanOffer receiptsLoanOffer=receiptsLoanOfferService.selReceiptsLoanOffer(receiptsId);
		model.addAttribute("receiptsLoanOffer", receiptsLoanOffer);
		model.addAttribute("loanOfferId", receiptsId);
		return "loan/phaseNine/loanNineEdit";
	}
	
	@RequestMapping("/upLoan")
	@ResponseBody
	public String upLoan(HttpServletRequest request,Model model) {
		try {
			ReceiptsLoanOffer receiptsLoanOffer=new ReceiptsLoanOffer();
			ServletRequestDataBinder binder = new ServletRequestDataBinder(receiptsLoanOffer);
			binder.bind(request);
			
			receiptsLoanOfferService.updateByPrimaryKeySelective(receiptsLoanOffer);
			return ReplyCode.SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ReplyCode.INSIDEERROR;
		}
	}
	
	@RequestMapping("/upLoanStatus")
	@ResponseBody
	public String upLoanStatus(HttpServletRequest request,Model model) {
		try {
			String loanId=request.getParameter("loanId");
			Map<String, Object> map=new HashMap<>();
			map.put("loanId", loanId);
			map.put("loanStatus", 10);
			
			User user = new SessionHelper(request).getLoginUser();
			LoanStatus loanStatus=new LoanStatus();
			loanStatus.setLoanId(loanId);
			loanStatus.setLoanStatus(10);
			loanStatus.setCreateUserId(user.getUserId());
			
			loanStatusService.insert(loanStatus);
			loanServiceImpl.upLoanStatus(map);
			
			List<Map<String, Object>> planList=loanServiceImpl.selPlanByLoanId(map);
			for (int i = 0; i < planList.size(); i++) {
				Map<String, Object> planMap=planList.get(i);
				Payment payment=new Payment();
				payment.setId(UUID.randomUUID().toString().replaceAll("-", ""));
				payment.setContractId(planMap.get("id").toString());
				payment.setPaymentName(planMap.get("payment_name").toString());
				payment.setPaymentPhone(planMap.get("payment_contract").toString());
				payment.setLoanId(planMap.get("id").toString());
				payment.setLoanPhone(planMap.get("loan_mobile").toString());
				payment.setManagerId(planMap.get("manager_id").toString());
				payment.setManagerName(planMap.get("manager_name").toString());
				payment.setPaymentDay(DateUtil.parse(planMap.get("payment_time").toString()));
				if(planMap.get("principal")!=null && planMap.get("interest")!=null) {
					double principal=Double.valueOf(planMap.get("principal").toString());
					double interest=Double.valueOf(planMap.get("interest").toString());
					payment.setPaymentMoney(String.valueOf(add(principal, interest)));
				}
				payment.setLoanPer(planMap.get("customer_id").toString());
				payment.setPaymentStatus("0");
				payment.setHandlerName(user.getUserName());
				payment.setLoanPrecent(planMap.get("month_scale").toString());
				payment.setPaymentNum(planMap.get("stage_number").toString());
				payment.setCreatePer(String.valueOf(user.getUserId()));
				payment.setUpdatePer(String.valueOf(user.getUserId()));
				paymentService.insert(payment);
			}
			
			return ReplyCode.SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ReplyCode.INSIDEERROR;
		}
	}
	
	public static double add(double v1, double v2) {  
        BigDecimal b1 = new BigDecimal(Double.toString(v1));  
        BigDecimal b2 = new BigDecimal(Double.toString(v2));  
        return b1.add(b2).doubleValue();  
    }  
}
