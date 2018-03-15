package com.trad.controller;

import java.io.UnsupportedEncodingException;
import java.lang.reflect.Field;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import com.trad.bean.Customer;
import com.trad.bean.CustomerContract;
import com.trad.bean.CustomerPrivate;
import com.trad.bean.CustomerWork;
import com.trad.bean.User;
import com.trad.bean.common.LayuiTable;
import com.trad.bean.common.PageStatus;
import com.trad.service.CustomerService;
import com.trad.util.ReplyCode;
import com.trad.util.SessionHelper;

@Controller
@RequestMapping("/customer")
public class CustomerController {
	@Resource
	private CustomerService customerService;
	Logger logger = LoggerFactory.getLogger(CustomerService.class);

	@RequestMapping("/init")
	public String init(HttpServletRequest request,Model model){
		String customerId = request.getParameter("customerId");
		logger.info("收到的customerId={}",customerId);
		model.addAttribute("customerId", customerId);
       return  "customer/customer"; 
	}
	
	@RequestMapping("/customerEdit")
	public String customerEdit(HttpServletRequest request,Model model){
		String customerId = request.getParameter("customerId");
		logger.info("收到的customerId={}",customerId);
		model.addAttribute("customerId", customerId);
       return  "customer/customerEdit"; 
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
	       int count = customerService.count(filter);
	       pageSta.setCount(count);
	       pageSta.setPage(page);
	       pageSta.setLimit(limit);
	     //mysql limit 后面是数据条数
	       List<Customer> pageCustomerList = customerService.queryByPaged(filter,pageSta.getStartNum(), limit);
	       returnMsg.setData(pageCustomerList);
	       returnMsg.setCount(count);
		}catch(UnsupportedEncodingException e){
	    	  e.printStackTrace();
	      }catch (Exception e) {
	    	  e.printStackTrace();
		}
	      return JSONObject.toJSONString(returnMsg);
		}
	
	@RequestMapping("/contractList")
	@ResponseBody
	 public String contractList(@RequestParam(value="page",defaultValue="1") int page, @RequestParam(value = "limit",defaultValue = "4") int limit,HttpServletRequest request,Model model){  
		LayuiTable returnMsg =  new LayuiTable();
		try{
		   String customerId = request.getParameter("customerId");
		   PageStatus pageSta = new PageStatus();
	       int count = customerService.countContract(StringUtils.isEmpty(customerId)?null:Integer.parseInt(customerId));
	       List<CustomerContract> pageContractList = customerService.queryContractByPaged(StringUtils.isEmpty(customerId)?null:Integer.parseInt(customerId), pageSta.getStartNum(), limit);
	       pageSta.setCount(count);
	       pageSta.setPage(page);
	       pageSta.setLimit(limit);
	     //mysql limit 后面是数据条数
	       returnMsg.setData(pageContractList);
	       returnMsg.setCount(count);
		 }catch (Exception e) {
	    	  e.printStackTrace();
		}
	      return JSONObject.toJSONString(returnMsg);
		}
	
	@RequestMapping("/privateList")
	@ResponseBody
	 public String privateList(@RequestParam(value="page",defaultValue="1") int page, @RequestParam(value = "limit",defaultValue = "4") int limit,HttpServletRequest request,Model model){  
		LayuiTable returnMsg =  new LayuiTable();
		try{
		   String customerId = request.getParameter("customerId");
		   PageStatus pageSta = new PageStatus();
	       int count = customerService.countPrivate(StringUtils.isEmpty(customerId)?null:Integer.parseInt(customerId));
	       List<CustomerPrivate> pagePrivateList = customerService.queryPrivateByPaged(StringUtils.isEmpty(customerId)?null:Integer.parseInt(customerId), pageSta.getStartNum(), limit);
	       List<CustomerPrivate> priVoList = new ArrayList<>();
	       for(CustomerPrivate pri : pagePrivateList){
	    	  Date registerTime = pri.getRegisterTime();
	    	  SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
	    	  pri.setRegisterTimeStr(sf.format(registerTime));
	    	  priVoList.add(pri);
	      }
	       pageSta.setCount(count);
	       pageSta.setPage(page);
	       pageSta.setLimit(limit);
	     //mysql limit 后面是数据条数
	       returnMsg.setData(priVoList);
	       returnMsg.setCount(count);
		 }catch (Exception e) {
	    	  e.printStackTrace();
		}
	      return JSONObject.toJSONString(returnMsg);
		}

	@RequestMapping("/add")
	 public String add(HttpServletRequest request,Model model){
		String customerId = request.getParameter("customerId");
		model.addAttribute("customerId", customerId);
      return  "customer/customerEdit"; 
	}
	
	@RequestMapping("/addContract")
	 public String addContract(HttpServletRequest request,Model model){
		String customerId = request.getParameter("customerId");
		model.addAttribute("customerId", customerId);
     return  "customer/customerContractEdit"; 
	}
	
	@RequestMapping("/addPrivate")
	 public String addPrivate(HttpServletRequest request,Model model){
		String customerId = request.getParameter("customerId");
		model.addAttribute("customerId", customerId);
    return  "customer/customerPrivateEdit"; 
	}
	
	@RequestMapping("/commonEdit")
	 public String baseEdit(HttpServletRequest request,Model model){
		String customerId = request.getParameter("customerId");
		logger.info("收到的customerId={}",customerId);
		Customer cus = null;
		if(!StringUtils.isEmpty(customerId)){
			cus = customerService.queryCustomerById(Integer.parseInt(customerId));
			model.addAttribute("customer", cus);
		}
        return  "customer/customerBaseEdit"; 
	}
	
	@RequestMapping("/workEdit")
	 public String workEdit(HttpServletRequest request,Model model){
		String customerId = request.getParameter("customerId");
		logger.info("收到的customerId={}",customerId);
		CustomerWork work = null;
		if(!StringUtils.isEmpty(customerId)){
			work = customerService.queryWorkById(Integer.parseInt(customerId));
			model.addAttribute("customerId", customerId);
			model.addAttribute("customerWork", work);
		}
       return  "customer/customerWorkEdit"; 
	}
	
	@RequestMapping("/contractEdit")
	public String contractEdit(HttpServletRequest request,Model model){
		String customerId = request.getParameter("customerId");
		logger.info("收到的customerId={}",customerId);
		model.addAttribute("customerId", customerId);
       return  "customer/customerContract"; 
	}
	
	@RequestMapping("/privateEdit")
	public String privateEdit(HttpServletRequest request,Model model){
		String customerId = request.getParameter("customerId");
		logger.info("收到的customerId={}",customerId);
		model.addAttribute("customerId", customerId);
       return  "customer/customerPrivate"; 
	}
	
	@RequestMapping("/modify")
	@ResponseBody
	 public String modify(HttpServletRequest request, HttpServletResponse response,Model model){
		try {
			 String nID =request.getParameter("nID");
			  String nFiled =request.getParameter("nFiled");
			  String nValue = request.getParameter("nValue");
			  logger.info("传入的nID={},nFiled={}，nValue={}",nID,nFiled,nValue);
			  if(StringUtils.isEmpty(nID) || StringUtils.isEmpty(nFiled) || StringUtils.isEmpty(nValue)){
				   return ReplyCode.INSIDEERROR;
			  }
			  Customer cus = new Customer();
			  Field treeFiled = cus.getClass().getDeclaredField(nFiled);
			  treeFiled.setAccessible(true);  
			  treeFiled.set(cus,nValue);
			  cus.setId(Integer.parseInt(nID));
			  cus.setUpdateTime(new Date());
			  int count = customerService.updateByPrimaryKeySelective(cus);
			  if(count == 1){
				  return ReplyCode.SUCCESS;
			  }
	} catch (NoSuchFieldException e) {
		logger.error("设置反射字段出错！");
		e.printStackTrace();
	} catch (SecurityException e) {
		logger.error("设置反射字段出错！");
		e.printStackTrace();
	} catch (IllegalArgumentException e) {
		logger.error("设置反射字段出错！");
		e.printStackTrace();
	} catch (IllegalAccessException e) {
		logger.error("设置反射字段出错！");
		e.printStackTrace();
	}catch (Exception e) {
		logger.error("修改tree信息出错！");
		e.printStackTrace();
	}
	return ReplyCode.INSIDEERROR;
}
	
	@RequestMapping("/contractModify")
	@ResponseBody
	 public String contractModify(HttpServletRequest request, HttpServletResponse response,Model model){
		
		try {
	          String nID =request.getParameter("nId");
			  String nFiled =request.getParameter("nFiled");
			  String nValue = request.getParameter("nValue");
			  logger.info("传入的nID={},nFiled={}，nName={}",nID,nFiled,nValue);
			  if(StringUtils.isEmpty(nID) || StringUtils.isEmpty(nFiled) || StringUtils.isEmpty(nValue)){
				   return ReplyCode.INSIDEERROR;
			  }
			  CustomerContract cc = new CustomerContract();
			  Field treeFiled = cc.getClass().getDeclaredField(nFiled);
			  treeFiled.setAccessible(true);  
			  treeFiled.set(cc,nValue);
			  cc.setCustomerId(Integer.parseInt(nID));
			  cc.setUpdateTime(new Date());
			  int count = customerService.updateByContractSelective(cc);
			  if(count == 1){
				  return ReplyCode.SUCCESS;
			  }
	} catch (NoSuchFieldException e) {
		logger.error("设置反射字段出错！");
		e.printStackTrace();
	} catch (SecurityException e) {
		logger.error("设置反射字段出错！");
		e.printStackTrace();
	} catch (IllegalArgumentException e) {
		logger.error("设置反射字段出错！");
		e.printStackTrace();
	} catch (IllegalAccessException e) {
		logger.error("设置反射字段出错！");
		e.printStackTrace();
	}catch (Exception e) {
		logger.error("修改tree信息出错！");
		e.printStackTrace();
	}
	return ReplyCode.INSIDEERROR;
}
	
	@RequestMapping("/privateModify")
	@ResponseBody
	 public String privateModify(HttpServletRequest request, HttpServletResponse response,Model model){
		
		try {
	          String nID =request.getParameter("nId");
			  String nFiled =request.getParameter("nFiled");
			  String nValue = request.getParameter("nValue");
			  logger.info("传入的nID={},nFiled={}，nName={}",nID,nFiled,nValue);
			  if(StringUtils.isEmpty(nID) || StringUtils.isEmpty(nFiled) || StringUtils.isEmpty(nValue)){
				   return ReplyCode.INSIDEERROR;
			  }
			  CustomerPrivate cp = new CustomerPrivate();
			  Field treeFiled = cp.getClass().getDeclaredField(nFiled);
			  treeFiled.setAccessible(true);  
			  treeFiled.set(cp,nValue);
			  cp.setCustomerId(Integer.parseInt(nID));
			  cp.setUpdateTime(new Date());
			 int count = customerService.updateByPrivateSelective(cp);
			  if(count == 1){
				  return ReplyCode.SUCCESS;
			  }
	} catch (NoSuchFieldException e) {
		logger.error("设置反射字段出错！");
		e.printStackTrace();
	} catch (SecurityException e) {
		logger.error("设置反射字段出错！");
		e.printStackTrace();
	} catch (IllegalArgumentException e) {
		logger.error("设置反射字段出错！");
		e.printStackTrace();
	} catch (IllegalAccessException e) {
		logger.error("设置反射字段出错！");
		e.printStackTrace();
	}catch (Exception e) {
		logger.error("修改tree信息出错！");
		e.printStackTrace();
	}
	return ReplyCode.INSIDEERROR;
}
	
	@RequestMapping("/saveCustomerWork")
	 public String saveCustomerWork(HttpServletRequest request,Model model){
		CustomerWork cusWork = new CustomerWork();
		String customerId = request.getParameter("customerId");
		try{
			if(StringUtils.isEmpty(customerId)){
				logger.error("传入的customerId为空！");
				return "customer/customerWorkEdit";
			}
			User user = new SessionHelper(request).getLoginUser();
			cusWork.setUpdatePer(user == null ? "": user.getRealName());
			ServletRequestDataBinder binder = new ServletRequestDataBinder(cusWork);  
			binder.bind(request); 
			cusWork.setUpdateTime(new Date());
			Integer id = cusWork.getId();
			//id不为空时更新，id为空时保存
			if(id !=null && id > 0){
				cusWork.setCreatePer(user == null ? "": user.getRealName());
				customerService.updateByWorkSelective(cusWork);
				cusWork = customerService.queryWorkById(Integer.parseInt(customerId));
			}else{
				cusWork.setCreateTime(new Date());
				customerService.insertWork(cusWork);
			}
			model.addAttribute("customerWork", cusWork);
			return "customer/customerWorkEdit"; 
		}catch(Exception e){
			e.printStackTrace();
			return "customer/customerWorkEdit";
		}
	}
	
	@RequestMapping("/saveCustomerContract")
	 public String saveCustomerContract(HttpServletRequest request,Model model){
		CustomerContract cusCon = new CustomerContract();
		try{
			User user = new SessionHelper(request).getLoginUser();
			ServletRequestDataBinder binder = new ServletRequestDataBinder(cusCon);  
			binder.bind(request); 
			cusCon.setUpdateTime(new Date());
			cusCon.setUpdatePer(user == null ? "": user.getRealName());
			Integer customerId = cusCon.getCustomerId();
			//id不为空时更新，id为空时保存
			if(customerId !=null && customerId > 0){
				cusCon.setCustomerId(customerId);
				cusCon.setCreateTime(new Date());
				cusCon.setCreatePer(user == null ? "": user.getRealName());
				customerService.insertContract(cusCon);
			}else{
				logger.error("获取到的customerId为空，保存失败！");
				return "customerContractEdit";
			}
			model.addAttribute("customerId", customerId);
			return "redirect:/customer/contractList"; 
		}catch(Exception e){
			e.printStackTrace();
			return "customerContractEdit";
		}
	}
	
	@RequestMapping("/saveCustomerPrivate")
	 public String saveCustomerPrivate(HttpServletRequest request,Model model){
		CustomerPrivate cp = new CustomerPrivate();
		try{
			User user = new SessionHelper(request).getLoginUser();
			ServletRequestDataBinder binder = new ServletRequestDataBinder(cp);  
			binder.bind(request); 
			cp.setUpdateTime(new Date());
			cp.setUpdatePer(user == null ? "": user.getRealName());
			Integer customerId = cp.getCustomerId();
			//id不为空时更新，id为空时保存
			if(customerId !=null && customerId > 0){
				cp.setCustomerId(customerId);
				cp.setCreateTime(new Date());
				cp.setCreatePer(user == null ? "": user.getRealName());
			    customerService.insertPrivate(cp);
			}else{
				logger.error("获取到的customerId为空，保存失败！");
				return "customerPrivateEdit";
			}
			model.addAttribute("customerId", customerId);
			return "redirect:/customer/privateList"; 
		}catch(Exception e){
			e.printStackTrace();
			return "customerPrivateEdit";
		}
	}
	
	@RequestMapping("/deleteCustomer")
	@ResponseBody
	 public String deleteCustomer(HttpServletRequest request,Model model){
      try{
    	  String ids = request.getParameter("ids");
    	  if(!StringUtils.isEmpty(ids)){
    		  String [] idsStr = ids.split(",");
    		  for(String  id : idsStr){
    			  Integer  idInt = Integer.parseInt( id);
    			  customerService.deleteCustomer(idInt);
    		  }
    	  }
		  return ReplyCode.SUCCESS;
	  }catch(Exception e){
		  e.printStackTrace();
		  return ReplyCode.INSIDEERROR;
	  }
	}
	
	@RequestMapping("/deleteContract")
	@ResponseBody
	 public String deleteContract(HttpServletRequest request,Model model){
      try{
    	  String customerIds = request.getParameter("customerIds");
    	  if(!StringUtils.isEmpty(customerIds)){
    		  String [] customerIdsStr = customerIds.split(",");
    		  for(String customerId : customerIdsStr){
    			  Integer customerIdInt = Integer.parseInt(customerId);
    			  customerService.deleteContract(customerIdInt);
    		  }
    	  }
		  return ReplyCode.SUCCESS;
	  }catch(Exception e){
		  e.printStackTrace();
		  return ReplyCode.INSIDEERROR;
	  }
	}
	
	@RequestMapping("/deletePrivate")
	@ResponseBody
	 public String deletePrivate(HttpServletRequest request,Model model){
      try{
    	  String customerIds = request.getParameter("customerIds");
    	  if(!StringUtils.isEmpty(customerIds)){
    		  String [] customerIdsStr = customerIds.split(",");
    		  for(String customerId : customerIdsStr){
    			  Integer customerIdInt = Integer.parseInt(customerId);
    			  customerService.deletePrivate(customerIdInt);
    		  }
    	  }
		  return ReplyCode.SUCCESS;
	  }catch(Exception e){
		  e.printStackTrace();
		  return ReplyCode.INSIDEERROR;
	  }
	}
	
	@RequestMapping("/saveCustomer")
	 public String saveCustomer(HttpServletRequest request,Model model){
		Customer cus = new Customer();
		try{
			User user = new SessionHelper(request).getLoginUser();
			ServletRequestDataBinder binder = new ServletRequestDataBinder(cus);  
			binder.bind(request); 
			cus.setUpdateTime(new Date());
			cus.setUpdatePer(user == null ? "": user.getRealName());
			Integer customerId = cus.getId();
			cus.setCreatePer(user == null ? "": user.getRealName());
			cus.setUpdatePer(user == null ? "": user.getRealName());
			//id不为空时更新，id为空时保存
			if(customerId !=null && customerId > 0){
				customerService.updateByPrimaryKeySelective(cus);
				cus = customerService.queryCustomerById(cus.getId());
			}else{
				cus.setCreateTime(new Date());
				cus.setCreatePer(user == null ? "": user.getRealName());
				customerId = customerService.insert(cus);
			}
			model.addAttribute("customer", cus);
			return "customer/customerBaseEdit"; 
		}catch(Exception e){
			e.printStackTrace();
			return "customer/customerBaseEdit";
		}
	}
	
}
