package com.trad.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.trad.bean.PaymentBad;
import com.trad.bean.common.LayuiTable;
import com.trad.service.PaymentBadService;
import com.trad.util.ReplyCode;

@Controller
@RequestMapping("paymentBad")
public class PaymentBadController {
	
	@Autowired
	private PaymentBadService paymentBadService;
	
	@RequestMapping("/init")
	 public String init(HttpServletRequest request,Model model){  
		String loanId=request.getParameter("loanId");
		model.addAttribute("loanId", loanId);
		return  "payment/bad/paymentBad"; 
	}
	
	@RequestMapping("/getList")
	@ResponseBody
	public String getList(@RequestParam(value = "page", defaultValue = "1") int page,
			@RequestParam(value = "limit", defaultValue = "4") int limit, HttpServletRequest request, Model model) {
		Map<String, Object> map=new HashMap<>();
		map.put("page", page-1);
		map.put("pageSize", limit);
		map.put("loanId", request.getParameter("loanId"));
		List<Map<String, Object>> list = paymentBadService.selPaymentBad(map);
		
		for (int i = 0; i < list.size(); i++) {
			Map<String, Object> badMap=list.get(i);
			if(badMap.get("bad_debt_status").toString().equals("0")) {
				badMap.put("badDebtStatus", "失联");
			}else if(badMap.get("bad_debt_status").toString().equals("1")) {
				badMap.put("badDebtStatus", "司法程序");
			}else if(badMap.get("bad_debt_status").toString().equals("2")) {
				badMap.put("badDebtStatus", "变卖资产");
			}else if(badMap.get("bad_debt_status").toString().equals("3")) {
				badMap.put("badDebtStatus", "自垫");
			}else if(badMap.get("bad_debt_status").toString().equals("4")) {
				badMap.put("badDebtStatus", "正常");
			}
			
			if(badMap.get("is_settle").toString().equals("0")) {
				badMap.put("isSettle", "已结清");
			}else if(badMap.get("is_settle").toString().equals("1")) {
				badMap.put("isSettle", "未结清");
			}
		}
		
		int count = paymentBadService.countPaymentBad(map);
		LayuiTable returnMsg = new LayuiTable();
		returnMsg.setData(list);
		returnMsg.setCount(count);
		return JSONObject.toJSONString(returnMsg);
	}
	
	@RequestMapping("/toUpdate")
	 public String toUpdate(HttpServletRequest request,Model model){  
		String id=request.getParameter("id");
		String status=request.getParameter("status");
		String isSettle=request.getParameter("isSettle");
		model.addAttribute("id", id);
		model.addAttribute("status", status);
		model.addAttribute("isSettle", isSettle);
		return  "payment/bad/upPaymentBadStatus"; 
	}
	
	@RequestMapping("/upLoanStatus")
	@ResponseBody
	public String upLoanStatus(HttpServletRequest request,Model model) {
		try {
			PaymentBad paymentBad=new PaymentBad();
			
			ServletRequestDataBinder binder = new ServletRequestDataBinder(paymentBad);
			binder.bind(request);
			
			paymentBadService.updateByPrimaryKeySelective(paymentBad);
			return ReplyCode.SUCCESS;
		} catch (Exception e) {
			return ReplyCode.INSIDEERROR;
		}
	}
	
	@RequestMapping("/initAll")
	 public String initAll(HttpServletRequest request,Model model){  
		String loanId=request.getParameter("loanId");
		model.addAttribute("loanId", loanId);
		return  "payment/bad/paymentBadAll"; 
	}
	
	@RequestMapping("/getListAll")
	@ResponseBody
	public String getListAll(@RequestParam(value = "page", defaultValue = "1") int page,
			@RequestParam(value = "limit", defaultValue = "4") int limit, HttpServletRequest request, Model model) {
		Map<String, Object> map=new HashMap<>();
		map.put("page", page-1);
		map.put("pageSize", limit);
		map.put("loanId", request.getParameter("loanId"));
		List<Map<String, Object>> list = paymentBadService.selPaymentBadAll(map);
		
		for (int i = 0; i < list.size(); i++) {
			Map<String, Object> listMap=list.get(i);
			if(listMap.get("bad_debt_status").toString().equals("1")) {
				listMap.put("status", "司法程序");
			}else if(listMap.get("bad_debt_status").toString().equals("2")) {
				listMap.put("status", "变卖资产");
			}else if(listMap.get("bad_debt_status").toString().equals("3")) {
				listMap.put("status", "自垫");
			}else if(listMap.get("bad_debt_status").toString().equals("4")) {
				listMap.put("status", "正常");
			}else if(listMap.get("bad_debt_status").toString().equals("0")) {
				listMap.put("status", "失联");
			}
		}
		
		int count = paymentBadService.countPaymentBadAll(map);
		LayuiTable returnMsg = new LayuiTable();
		returnMsg.setData(list);
		returnMsg.setCount(count);
		return JSONObject.toJSONString(returnMsg);
	}
}
