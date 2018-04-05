package com.trad.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.trad.bean.Payment;
import com.trad.bean.common.LayuiTable;
import com.trad.bean.common.PageStatus;
import com.trad.bean.vo.PaymentVo;
import com.trad.exception.TradBusinessException;
import com.trad.service.PaymentService;
import com.trad.util.CommonUtils;
import com.trad.util.ReplyCode;
@Controller
@RequestMapping("/payment")
public class PaymentController {
	
	@Resource
	private PaymentService payService;
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
			  PageStatus pageSta = new PageStatus();
		      int count = payService.count(filter);
		      pageSta.setCount(count);
		      pageSta.setPage(page);
		      pageSta.setLimit(limit);
		      //mysql limit 后面是数据条数
		      List<Payment> pageProList = payService.queryByPaged(filter,pageSta.getStartNum(), limit);
		      
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
	
	@RequestMapping("/editPro")
	 public String editPro(HttpServletRequest request,Model model){
     try{
   	  String paymentId = request.getParameter("paymentId");
   	  logger.info("传入的paymentId={}",paymentId);
   	  if(!StringUtils.isEmpty(paymentId)){
   			  Payment pay = payService.selectByPrimaryKey(paymentId);
   			  model.addAttribute("pro", pay);
   	  }
	  }catch(Exception e){
		  e.printStackTrace();
		  logger.error("编辑产品详情出错！");
	  }
     return "payment/paymentEdit";
	}
	
	@RequestMapping("/deletePros")
	@ResponseBody
	 public String deletePros(HttpServletRequest request,Model model){
     try{
   	  String paymentId = request.getParameter("paymentId");
   	  logger.info("传入的paymentId={}",paymentId);
   	  if(!StringUtils.isEmpty(paymentId)){
   		  String [] idStr = paymentId.split(",");
   		  //批量删除菜单信息
   		  for(String id : idStr){
       		  //删除菜单表
   			  payService.deleteByPrimaryKey(id);
   		  }
   	  }
		  return ReplyCode.SUCCESS;
	  }catch(Exception e){
		  e.printStackTrace();
		  logger.error("删除菜单树出错！");
		  return ReplyCode.INSIDEERROR;
	  }
	}
	
	@RequestMapping("/modify")
	@ResponseBody
	 public String detail(HttpServletRequest request, HttpServletResponse response,Model model){
		try {
		          String proID =request.getParameter("proID");
				  String proFiled =request.getParameter("proFiled");
				  String proValue = request.getParameter("proValue");
				  logger.info("传入的proID={},proFiled={}，nTreeValue={}",proID,proFiled,proValue);
				  if(StringUtils.isEmpty(proID) || StringUtils.isEmpty(proFiled) || StringUtils.isEmpty(proValue)){
					   return ReplyCode.INSIDEERROR;
				  }
				  Payment pro = new Payment();
				  CommonUtils.getInstance().setField(pro, proFiled, proValue);
				  pro.setId(proID);
				  pro.setUpdateTime(new Date());
				  int count = payService.updateByPrimaryKeySelective(pro);
				  if(count == 1){
					  return ReplyCode.SUCCESS;
				  }
		} catch (NoSuchFieldException e) {
			logger.error("无法从找到传入参数对应的field！");
			e.printStackTrace();
		} catch (SecurityException e) {
			logger.error("该映射不是安全的映射！");
			e.printStackTrace();
		} catch (IllegalArgumentException e) {
			logger.error("设置值传入的参数不合法！");
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			logger.error("set方法不可访问！");
			e.printStackTrace();
		}catch (TradBusinessException e) {
			logger.error("传入的对象为空或者methodName为空！");
			e.printStackTrace();
		}catch (Exception e) {
			logger.error("修改tree信息出错！");
			e.printStackTrace();
		}
		return ReplyCode.INSIDEERROR;
	}
	
}
