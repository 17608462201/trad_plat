package com.trad.controller.phase;

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
import com.trad.bean.ReceiptsLoanOffer;
import com.trad.bean.User;
import com.trad.bean.common.LayuiTable;
import com.trad.service.CommonFileuploadService;
import com.trad.service.CustomerService;
import com.trad.service.LoanOfferService;
import com.trad.service.LoanService;
import com.trad.service.LoanStatusService;
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
			return ReplyCode.SUCCESS;
		} catch (Exception e) {
			return ReplyCode.INSIDEERROR;
		}
	}
}
