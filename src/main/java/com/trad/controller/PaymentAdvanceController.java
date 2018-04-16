package com.trad.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.beanutils.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.trad.bean.Payment;
import com.trad.bean.PaymentAdvance;
import com.trad.bean.common.LayuiTable;
import com.trad.bean.common.PageStatus;
import com.trad.bean.vo.PaymentVo;
import com.trad.service.PaymentAdvanceService;
import com.trad.util.ReplyCode;

@Controller
@RequestMapping("paymentAdvance")
public class PaymentAdvanceController {

	@Autowired
	private PaymentAdvanceService paymentAdvanceService;

	@RequestMapping("insPaymentAdvance")
	public String insPaymentAdvance(HttpServletRequest request, Model model) {
		try {
			PaymentAdvance p = new PaymentAdvance();
			ServletRequestDataBinder binder = new ServletRequestDataBinder(p);
			binder.bind(request);
			System.out.println(p);
			p.setId(UUID.randomUUID().toString().replaceAll("-", ""));
			paymentAdvanceService.insert(p);
			return ReplyCode.SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ReplyCode.INSIDEERROR;
		}
	}

	@RequestMapping("/init")
	public String init(HttpServletRequest request, Model model) {
		return "payment/advance/paymentAdvance";
	}

	@RequestMapping("/list")
	@ResponseBody
	public String list(@RequestParam(value = "page", defaultValue = "1") int page,
			@RequestParam(value = "limit", defaultValue = "4") int limit, HttpServletRequest request, Model model) {
		LayuiTable returnMsg = new LayuiTable();
		try {
			Map<String, Object> map = new HashMap<>();
			map.put("loanId", request.getParameter("loanId"));
			int count = paymentAdvanceService.countPaymentAdvance(map);
			PageStatus pageSta = new PageStatus();
			pageSta.setCount(count);
			pageSta.setPage(page);
			pageSta.setLimit(limit);
			map.put("page", pageSta.getStartNum());
			map.put("pageSize", limit);
			// mysql limit 后面是数据条数
			List<Map<String, Object>> list=paymentAdvanceService.selPaymentAdvance(map);
			for (int i = 0; i < list.size(); i++) {
				Map<String, Object> listMap=list.get(i);
				double interests=Double.valueOf(listMap.get("interests").toString());
				double principal=Double.valueOf(listMap.get("principals").toString());
				double a=PaymentController.add(interests, principal);
				map.put("principals", a);
			}

			returnMsg.setData(list);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return JSONObject.toJSONString(returnMsg);
	}

}
