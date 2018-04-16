package com.trad.controller;

import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;
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
import com.trad.bean.Payment;
import com.trad.bean.PaymentAdvance;
import com.trad.bean.PaymentOver;
import com.trad.bean.common.LayuiTable;
import com.trad.bean.common.PageStatus;
import com.trad.bean.vo.PaymentVo;
import com.trad.exception.TradBusinessException;
import com.trad.service.PaymentAdvanceService;
import com.trad.service.PaymentOverService;
import com.trad.service.PaymentService;
import com.trad.util.CommonUtils;
import com.trad.util.DateUtil;
import com.trad.util.ReplyCode;
@Controller
@RequestMapping("/payment")
public class PaymentController {
	
	@Resource
	private PaymentService payService;
	@Autowired
	private PaymentOverService paymentOverService;
	
	@Autowired
	private PaymentAdvanceService paymentAdvanceService;
	
	Logger logger = LoggerFactory.getLogger(PaymentController.class);
	
	@RequestMapping("/init")
	 public String init(HttpServletRequest request,Model model){  
		return  "payment/payment"; 
	}
	
	@RequestMapping("/add")
	 public String add(HttpServletRequest request,Model model){  
		return  "payment/paymentEdit"; 
	}
	
	@RequestMapping("/savePayment")
	@ResponseBody
	 public String savepayment(HttpServletRequest request,Model model){
		try{
			Payment pay = new Payment();
			ServletRequestDataBinder binder = new ServletRequestDataBinder(pay);  
			binder.bind(request); 
			pay.setCreateTime(new Date());
			pay.setUpdateTime(new Date());
			int count = payService.savePayment(pay);
			if(count == 1){
				  return ReplyCode.SUCCESS;
			  }else{
				  return ReplyCode.INSIDEERROR;
			  }
		}catch(Exception e){
			e.printStackTrace();
			logger.error("保存产品出错！");
			return ReplyCode.INSIDEERROR;
		}
	}
	
	@RequestMapping("/list")
	@ResponseBody
	 public String list(@RequestParam(value="page",defaultValue="1") int page, @RequestParam(value = "limit",defaultValue = "4") int limit,HttpServletRequest request,Model model){  
		LayuiTable returnMsg =  new LayuiTable();
		try{
			  String filter = request.getParameter("filter");
		      if(!StringUtils.isEmpty(filter)){
		    	  filter = URLDecoder.decode(filter,"UTF-8");
		    	  filter = "%"+filter+"%";
		    	  logger.info("传入的filter={}",filter);	
		      }
		      Map<String, Object> map=new HashMap<>();
		      map.put("filter", filter);
		      if(request.getParameter("paymentDay")!=null) {
		    	  if(!request.getParameter("paymentDay").equals("请选择")) {
		    		  map.put("paymentDay", request.getParameter("paymentDay"));
		    	  }
		      }
		      if(request.getParameter("paymentStatus")!=null) {
		    	  if(!request.getParameter("paymentStatus").equals("请选择")) {
		    		  map.put("paymentStatus", request.getParameter("paymentStatus"));
		    	  }
		      }
		      int count = payService.count(map);
			  PageStatus pageSta = new PageStatus();
			  pageSta.setCount(count);
		      pageSta.setPage(page);
		      pageSta.setLimit(limit);
		      map.put("page", pageSta.getStartNum());
		      map.put("pageSize", limit);
		      //mysql limit 后面是数据条数
		      List<Payment> pageProList = payService.queryByPaged(map);
		      
		      List<PaymentVo> payVoList = new ArrayList<>();
		      for(Payment pay : pageProList){
		    	  PaymentVo payVo = new PaymentVo();
		    	  BeanUtils.copyProperties(payVo,pay);
		    	  if(pay.getLoan() != null){
		    		  payVo.setLoanName(pay.getLoan().getCustomerName());
		    		  payVo.setProductName(pay.getLoan().getProductName());
		    		  payVo.setPrecentStr(pay.getPaymentNum()+"/"+pay.getAllPrecent());
		    	  }
		    	  Date payDay = pay.getPaymentDay();
		    	  if(payDay != null){
	    			  payVo.setPaymentDayStr(new SimpleDateFormat("yyyy-MM-dd").format(payDay));
	    		  }
		    	  payVoList.add(payVo);
		      }
		      returnMsg.setData(payVoList);
		      returnMsg.setCount(count);
		      
      }catch(UnsupportedEncodingException e){
    	  e.printStackTrace();
      }catch (Exception e) {
    	  e.printStackTrace();
	}
      return JSONObject.toJSONString(returnMsg);
	}
	
	@RequestMapping("/upPaymentStatus")
	@ResponseBody
	public String upPaymentStatus(HttpServletRequest request,Model model) {
		try {
			String paymentId=request.getParameter("paymentId");
			Map<String, Object> map=new HashMap<>();
			map.put("paymentId", paymentId);
			map.put("status", "1");
			
			payService.updatePaymentStatus(map);
			return ReplyCode.SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ReplyCode.INSIDEERROR;
		}
	}
	
	@RequestMapping("PaymentCheck")
	public String PaymentCheck(HttpServletRequest request,Model model) {
		String paymentId=request.getParameter("paymentId");
		String loanId=request.getParameter("loanId");
		model.addAttribute("loanId", loanId);
		model.addAttribute("paymentId", paymentId);
		return "payment/paymentCheckAll";
	}
	
	@RequestMapping("/loanCheck")
	public String loanCheck(HttpServletRequest request, Model model) {
		String paymentId=request.getParameter("paymentId");
		Map<String, Object> map=payService.selPaymentById(paymentId);
		model.addAttribute("payment", map);
		return "payment/paymentCheck";
	}
	
	@RequestMapping("/toUpPayment")
	public String toUpPayment(HttpServletRequest request, Model model) {
		String paymentId=request.getParameter("paymentId");
		Map<String, Object> map=payService.selPaymentById(paymentId);
		model.addAttribute("payment", map);
		return "payment/paymentEdit";
	}
	
	@RequestMapping("/upPayment")
	@ResponseBody
	public String upPayment(HttpServletRequest request,Model model) {
		try {
			String paymentTime=request.getParameter("paymentTime");
			Payment payment=new Payment();
			ServletRequestDataBinder binder = new ServletRequestDataBinder(payment);
			binder.bind(request);
			payment.setPaymentTime(DateUtil.parse(paymentTime));
			Payment p=payService.selectByPrimaryKey(payment.getId());
//			payment.getPaymentTime()-p.getPaymentDay();
			int a=DateUtil.differentDays(payment.getPaymentTime(), p.getPaymentDay());
			
			if(payment.getPaymentStatus().equals("1")) {			//已还
				if(a>0) {									//提前还款
					PaymentAdvance advance=new PaymentAdvance();
					advance.setId(UUID.randomUUID().toString().replaceAll("-", ""));
					advance.setPaymentId(p.getId());
					advance.setPayMoney(p.getPaymentMoney());
					advance.setRealPayMoney(p.getReallyPayment());
					advance.setRemark(payment.getRemark());
					paymentAdvanceService.insert(advance);
				}else if(a==0) {							//正常还款
					payment.setPaymentStatus("1");
				}else {										//逾期
					PaymentOver paymentOver=new PaymentOver();
					paymentOver.setLoanId(p.getLoanId());
					paymentOver.setPayNum(p.getPaymentNum());
					paymentOver.setPayDay(p.getPaymentDay());
					paymentOver.setOrginDay(DateUtil.format(payment.getPaymentTime()));
					paymentOver.setOverdue(String.valueOf(Math.abs(a)));
					paymentOver.setOriginPay(p.getPaymentMoney());
					String offMoney=payService.selOffMoney(p.getLoanId());
					double defaultInter = multiply(Double.valueOf(offMoney), 6000*Math.abs(a));
					paymentOver.setDefaultInter(String.valueOf(defaultInter));			//罚息
					double sumMoney=add(defaultInter, Double.valueOf(p.getReallyPayment()));
					paymentOver.setSumMoney(String.valueOf(sumMoney));
					paymentOver.setRemark(payment.getRemark());
					paymentOver.setId(UUID.randomUUID().toString().replaceAll("-", ""));
					paymentOverService.insert(paymentOver);
				}
			}else {													//未还
				PaymentOver paymentOver=new PaymentOver();
				paymentOver.setLoanId(p.getLoanId());
				paymentOver.setPayNum(p.getPaymentNum());
				paymentOver.setPayDay(p.getPaymentDay());
				paymentOver.setOrginDay(DateUtil.format(payment.getPaymentDay()));
				paymentOver.setOverdue(String.valueOf(Math.abs(a)));
				paymentOver.setOriginPay(p.getPaymentMoney());
				String offMoney=payService.selOffMoney(p.getLoanId());
				double defaultInter = multiply(Double.valueOf(offMoney), 6000*a);
				paymentOver.setDefaultInter(String.valueOf(defaultInter));			//罚息
				double sumMoney=add(defaultInter, Double.valueOf(p.getReallyPayment()));
				paymentOver.setSumMoney(String.valueOf(sumMoney));
				paymentOver.setRemark(payment.getRemark());
				paymentOver.setId(UUID.randomUUID().toString().replaceAll("-", ""));
				paymentOverService.insert(paymentOver);
			}
			payService.updateByPrimaryKeySelective(payment);
			return ReplyCode.SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ReplyCode.INSIDEERROR;
		}
	}
	
	public static double multiply(double d,double d1) {
		 BigDecimal a1 = new BigDecimal(Double.toString(d));  
	     BigDecimal b1 = new BigDecimal(Double.toString(d1));   
	     BigDecimal result = a1.multiply(b1);// 相乘结果  
	     System.out.println(result);  
	     BigDecimal one = new BigDecimal("1");  
	     return result.divide(one,2,BigDecimal.ROUND_HALF_UP).doubleValue();//保留1位数
	}
	
	public static double add(double v1, double v2) {  
        BigDecimal b1 = new BigDecimal(Double.toString(v1));  
        BigDecimal b2 = new BigDecimal(Double.toString(v2));  
        return b1.add(b2).doubleValue();  
    } 
	
	@RequestMapping("getPaymentByLoanId")
	public String getPaymentByLoanId(HttpServletRequest request,Model model) {
		String loanId=request.getParameter("loanId");
		model.addAttribute("loanId", loanId);
		return "payment/paymentRecord";
	}
	
	@RequestMapping("/paymentRecord")
	@ResponseBody
	public String paymentRecord(@RequestParam(value = "page", defaultValue = "1") int page,
			@RequestParam(value = "limit", defaultValue = "4") int limit, HttpServletRequest request, Model model) {
		LayuiTable returnMsg = new LayuiTable();
		try {
			Map<String, Object> map = new HashMap<>();
			map.put("loanId", request.getParameter("loanId"));
			int count = payService.countPaymentByLoanId(map);
			PageStatus pageSta = new PageStatus();
			pageSta.setCount(count);
			pageSta.setPage(page);
			pageSta.setLimit(limit);
			map.put("page", pageSta.getStartNum());
			map.put("pageSize", limit);
			// mysql limit 后面是数据条数
			List<Payment> pageProList = payService.selPaymentByLoanId(map);

			List<PaymentVo> payVoList = new ArrayList<>();
			for (Payment pay : pageProList) {
				PaymentVo payVo = new PaymentVo();
				BeanUtils.copyProperties(payVo, pay);
				if (pay.getLoan() != null) {
					payVo.setLoanName(pay.getLoan().getCustomerName());
					payVo.setProductName(pay.getLoan().getProductName());
					payVo.setPrecentStr(pay.getPaymentNum() + "/" + pay.getAllPrecent());
				}
				Date payDay = pay.getPaymentDay();
				if (payDay != null) {
					payVo.setPaymentDayStr(new SimpleDateFormat("yyyy-MM-dd").format(payDay));
				}
				payVoList.add(payVo);
			}
			returnMsg.setData(payVoList);
			returnMsg.setCount(count);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return JSONObject.toJSONString(returnMsg);
	}
	
	@RequestMapping("paymentDetails")
	public String paymentDetails(HttpServletRequest request,Model model) {
		String loanId=request.getParameter("loanId");
		model.addAttribute("loanId", loanId);
		return "payment/paymentDetails";
	}
	
	/**
	 * 还款记录
	 * @param page
	 * @param limit
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("getPaymentDetails")
	@ResponseBody
	public String getPaymentDetails(@RequestParam(value = "page", defaultValue = "1") int page,
		@RequestParam(value = "limit", defaultValue = "4") int limit, HttpServletRequest request, Model model) {
		String loanId=request.getParameter("loanId");
		model.addAttribute("loanId", loanId);
		Map<String, Object> map=new HashMap<>();
		map.put("page", page-1);
		map.put("pageSize", limit);
		map.put("loanId", loanId);
		
		List<Map<String, Object>> list=payService.selPaymentDetails(map);
		for (int i = 0; i < list.size(); i++) {
			Map<String, Object> payMap=list.get(i);
			if(payMap.get("payment_status").toString().equals("0")) {
				payMap.put("paymentStatus", "待还款");
			}else if(payMap.get("payment_status").toString().equals("1")) {
				payMap.put("paymentStatus", "正常还款");
			}else if(payMap.get("payment_status").toString().equals("2")) {
				payMap.put("paymentStatus", "逾期还款");
			}else if(payMap.get("payment_status").toString().equals("3")) {
				payMap.put("paymentStatus", "坏账");
			}else if(payMap.get("payment_status").toString().equals("4")) {
				payMap.put("paymentStatus", "提前结清");
			}
		}
		int count=payService.countPaymentDetails(map);
		
		LayuiTable returnMsg = new LayuiTable();
		returnMsg.setData(list);
		returnMsg.setCount(count);
		return JSONObject.toJSONString(returnMsg);
	}
	
	@RequestMapping("paymentPlan")
	public String paymentPlan(HttpServletRequest request,Model model) {
		String loanId=request.getParameter("loanId");
		model.addAttribute("loanId", loanId);
		return "payment/paymentPlan";
	}
	
	/**
	 * 还款计划书
	 * @param page
	 * @param limit
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("getPaymentPlan")
	@ResponseBody
	public String getPaymentPlan(@RequestParam(value = "page", defaultValue = "1") int page,
		@RequestParam(value = "limit", defaultValue = "4") int limit, HttpServletRequest request, Model model) {
		String loanId=request.getParameter("loanId");
		model.addAttribute("loanId", loanId);
		Map<String, Object> map=new HashMap<>();
		map.put("page", page-1);
		map.put("pageSize", limit);
		map.put("loanId", loanId);
		
		List<Map<String, Object>> list=payService.selPaymentPlan(map);
		for (int i = 0; i < list.size(); i++) {
			Map<String, Object> payMap=list.get(i);
			System.out.println(payMap.get("payment_status"));
			if(payMap.get("payment_status").toString().equals("0")) {
				payMap.put("paymentStatus", "待还款");
			}else if(payMap.get("payment_status").toString().equals("1")) {
				payMap.put("paymentStatus", "正常还款");
			}else if(payMap.get("payment_status").toString().equals("2")) {
				payMap.put("paymentStatus", "逾期还款");
			}else if(payMap.get("payment_status").toString().equals("3")) {
				payMap.put("paymentStatus", "坏账");
			}else if(payMap.get("payment_status").toString().equals("4")) {
				payMap.put("paymentStatus", "提前结清");
			}
		}
		int count=payService.countPaymentPlan(map);
		
		LayuiTable returnMsg = new LayuiTable();
		returnMsg.setData(list);
		returnMsg.setCount(count);
		return JSONObject.toJSONString(returnMsg);
	}
	
	
	@RequestMapping("toUpRemark")
	public String toUpRemark(HttpServletRequest request,Model model) {
		String paymentId=request.getParameter("paymentId");
		String loanId=request.getParameter("loanId");
		model.addAttribute("loanId", loanId);
		model.addAttribute("paymentId", paymentId);
		return "payment/paymentRemark";
	}
	
	@RequestMapping("/upPaymentRemark")
	@ResponseBody
	public String upPaymentRemark(HttpServletRequest request,Model model) {
		try {
			Payment payment=new Payment();
			ServletRequestDataBinder binder = new ServletRequestDataBinder(payment);
			binder.bind(request);
			payService.updateByPrimaryKeySelective(payment);
			return ReplyCode.SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ReplyCode.INSIDEERROR;
		}
	}
	
	@RequestMapping("/toPaymentAdvance")
	public String toPaymentAdvance(HttpServletRequest request,Model model) {
		String loanId=request.getParameter("loanId");
		model.addAttribute("loanId", loanId);
		String paymentId=request.getParameter("paymentId");
		model.addAttribute("paymentId", paymentId);
		String paymentMoney=payService.selPaymentSum(loanId);
		model.addAttribute("paymentMoney", paymentMoney);
		return "payment/paymentAdvance";
	}
	
}
