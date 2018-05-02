package com.trad.controller;

import java.text.ParseException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.trad.bean.CommonGgdm;
import com.trad.bean.Loan;
import com.trad.bean.PaymentOver;
import com.trad.bean.common.LayuiTable;
import com.trad.service.CommonGgdmService;
import com.trad.service.LoanOfferService;
import com.trad.service.PaymentOverService;
import com.trad.util.DateUtil;
import com.trad.util.ReplyCode;

@Controller
@RequestMapping("paymentOvre")
public class PaymentOverController {
	
	@Autowired
	private PaymentOverService paymentOverService;
	@Autowired
	private LoanOfferService loanOfferService;
	@Autowired
	private CommonGgdmService ggdmService;
	
	@RequestMapping("/init")
	 public String init(HttpServletRequest request,Model model){  
		String loanId=request.getParameter("loanId");
		model.addAttribute("loanId", loanId);
		return  "payment/over/paymentOver"; 
	}
	
	@RequestMapping("/getList")
	@ResponseBody
	public String getList(@RequestParam(value = "page", defaultValue = "1") int page,
			@RequestParam(value = "limit", defaultValue = "4") int limit, HttpServletRequest request, Model model) {
		Map<String, Object> map=new HashMap<>();
		map.put("page", page-1);
		map.put("pageSize", limit);
		map.put("loanId", request.getParameter("loanId"));
		List<Map<String, Object>> list = paymentOverService.getOverAll(map);
		
		int count = paymentOverService.countOver(map);
		LayuiTable returnMsg = new LayuiTable();
		returnMsg.setData(list);
		returnMsg.setCount(count);
		return JSONObject.toJSONString(returnMsg);
	}
	
	@RequestMapping("getPaymentByLoanId")
	public String getPaymentByLoanId(HttpServletRequest request,Model model) {
		String id=request.getParameter("id");
		model.addAttribute("id", id);
		return "payment/over/upPaymentOver";
	}
	
	@RequestMapping("/upPayment")
	@ResponseBody
	public String upPayment(HttpServletRequest request,Model model) {
		try {
			String remark=request.getParameter("remark");
			String id=request.getParameter("paymentOverId");
			PaymentOver p=new PaymentOver();
			p.setId(id);
			p.setRemark(remark);
			paymentOverService.updateByPrimaryKeySelective(p);
			return ReplyCode.SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ReplyCode.INSIDEERROR;
		}
	}
	
	@RequestMapping("/loanCheck")
	public String loanCheck(HttpServletRequest request, Model model) {
		try {
			String loanId = request.getParameter("loanId");
			if (!StringUtils.isEmpty(loanId)) {
				Map<String, Object> map=loanOfferService.selloanOfferByloanId(loanId);
				
				String [] dmjbhArr = new String[] {"type"};
				List<CommonGgdm> listGgdms = ggdmService.queryByDmjbh(dmjbhArr);
					for (int j = 0; j < listGgdms.size(); j++) {
						CommonGgdm commonGgdm=listGgdms.get(j);
						if(map.get("load_type")!=null) {
							if(map.get("load_type").toString().equals(commonGgdm.getDm())) {
								map.put("load_type", commonGgdm.getDmnr());
							}
						}
					}
				model.addAttribute("map", map);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "payment/over/loanCheck";
	}
	
	@RequestMapping("/over/init")
	 public String paymentOverInit(HttpServletRequest request,Model model){  
		String loanId=request.getParameter("loanId");
		model.addAttribute("loanId", loanId);
		return  "payment/over/paymentOverList"; 
	}
	
	@RequestMapping("/getPaymentOverList")
	@ResponseBody
	public String getPaymentOverList(@RequestParam(value = "page", defaultValue = "1") int page,
			@RequestParam(value = "limit", defaultValue = "4") int limit, HttpServletRequest request, Model model) throws ParseException {
		Map<String, Object> map=new HashMap<>();
		map.put("page", page-1);
		map.put("pageSize", limit);
		map.put("loanId", request.getParameter("loanId"));
		map.put("productId", request.getParameter("productId"));
		List<Map<String, Object>> list = paymentOverService.selPaymentOver(map);
		
		for (int i = 0; i < list.size(); i++) {
			Map<String, Object> overMap=list.get(i);
			int num=DateUtil.differentDays(new Date(), DateUtil.parse(overMap.get("pay_day").toString()));
			overMap.put("day", Math.abs(num));
			double money=PaymentController.multiply(Double.valueOf(overMap.get("offer_money").toString()), 6000*Math.abs(num));
			double sumMoney=PaymentController.add(money, Double.valueOf(overMap.get("origin_pay").toString()));
			overMap.put("money", money);
			overMap.put("sumMoney", sumMoney);
		}
		int count = paymentOverService.countPaymentOver(map);
		LayuiTable returnMsg = new LayuiTable();
		returnMsg.setData(list);
		returnMsg.setCount(count);
		return JSONObject.toJSONString(returnMsg);
	}
}
