package com.trad.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.trad.bean.CommonGgdm;
import com.trad.bean.CommonGgdmKey;
import com.trad.bean.User;
import com.trad.bean.common.LayuiTable;
import com.trad.bean.common.PageStatus;
import com.trad.exception.TradBusinessException;
import com.trad.service.CommonGgdmService;
import com.trad.util.CommonUtils;
import com.trad.util.ReplyCode;
import com.trad.util.SessionHelper;
@Controller
@RequestMapping("/ggdm")
public class CommonGgdmController {
	
	@Resource
	private CommonGgdmService ggdmService;
	Logger logger = LoggerFactory.getLogger(CommonGgdmController.class);
	
	@RequestMapping("/init")
	 public String init(HttpServletRequest request,Model model){  
		return  "common/ggdm"; 
	}
	
	@RequestMapping("/add")
	 public String add(HttpServletRequest request,Model model){  
		return  "common/ggdmEdit"; 
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
		      int count = ggdmService.count(filter);
		      pageSta.setCount(count);
		      pageSta.setPage(page);
		      pageSta.setLimit(limit);
		      //mysql limit 后面是数据条数
		      List<CommonGgdm> pageCommonList = ggdmService.queryByPaged(filter,pageSta.getStartNum(), limit);
		      returnMsg.setData(pageCommonList);
		      returnMsg.setCount(count);
      }catch(UnsupportedEncodingException e){
    	  e.printStackTrace();
      }catch (Exception e) {
    	  e.printStackTrace();
	}
      return JSONObject.toJSONString(returnMsg);
	}
	
	@RequestMapping("/deleteDms")
	@ResponseBody
	 public String deleteDms(HttpServletRequest request,Model model){
     try{
      String dmjbhs = request.getParameter("dmjbhs");
   	  String dms = request.getParameter("dms");
   	  logger.info("传入的dmjbhs={}, dms={}",dmjbhs, dms);
   	  if(!StringUtils.isEmpty(dmjbhs) && !StringUtils.isEmpty(dms)){
   		  String [] dmjbhStr = dmjbhs.split(",");
   		  String [] dmStr = dms.split(",");
   		  //批量公共代码信息
   		  for(int i = 0 ;i< dmjbhStr.length ; i++){
   			  CommonGgdmKey key = new CommonGgdmKey();
   			  key.setDm(dmStr[i]);
   		      key.setDmjbh(dmjbhStr[i]);
       		  //删除公共代码表
   			  ggdmService.deleteByPrimaryKey(key);
   		  }
   	  }
		  return ReplyCode.SUCCESS;
	  }catch(Exception e){
		  e.printStackTrace();
		  logger.error("删除公共代码集出错！");
		  return ReplyCode.INSIDEERROR;
	  }
	}
	
	@RequestMapping("/saveGgdm")
	@ResponseBody
	 public String saveGgdm(HttpServletRequest request,Model model){
		try{
			User user = new SessionHelper(request).getLoginUser();
			String dmjbh = request.getParameter("dmjbh");
			String dm = request.getParameter("dm");
			String dmnr = request.getParameter("dmnr");
			String parentId = request.getParameter("parentId");
			String remark = request.getParameter("remark");
			String orderNum = request.getParameter("orderNum");
			String isValid = request.getParameter("isValid");
			 logger.info("传入的dmjbh={},dm={},parentId={},dmnr={},remark={},orderNum={},isValid={}",dmjbh,dm,parentId,dmnr,remark,orderNum,isValid);
			if(StringUtils.isEmpty(dmjbh) || StringUtils.isEmpty(dm)){
				 return ReplyCode.INSIDEERROR;
			}
			CommonGgdm ggdm = new CommonGgdm();
			ggdm.setDmjbh(dmjbh);
			ggdm.setDm(dm);
			ggdm.setDmnr(dmnr);
			ggdm.setFdm(parentId);
			ggdm.setRemark(remark);
			ggdm.setOrderNum(Integer.parseInt(orderNum));
			ggdm.setCreatePer(user == null ? "": user.getRealName());
			ggdm.setUpdatePer(user == null ? "": user.getRealName());
			ggdm.setIsValid(isValid);
			int count = ggdmService.insertSelective(ggdm);
			if(count == 1){
				  return ReplyCode.SUCCESS;
			  }else{
				  return ReplyCode.INSIDEERROR;
			  }
		}catch(Exception e){
			e.printStackTrace();
			logger.error("保存公共代码集出错！");
			return ReplyCode.INSIDEERROR;
		}
	}
	
	@RequestMapping("/modify")
	@ResponseBody
	 public String detail(HttpServletRequest request, HttpServletResponse response,Model model){
		try {
		          String dmjbh =request.getParameter("dmjbh");
				  String dm =request.getParameter("dm");
				  String filed = request.getParameter("filed");
				  String value = request.getParameter("value");
				  logger.info("传入的ID1={},ID2={},filed={}，value={}",dmjbh,dm,filed,value);
				  if(StringUtils.isEmpty(dmjbh) || StringUtils.isEmpty(dm) || StringUtils.isEmpty(filed) || StringUtils.isEmpty(value)){
					   return ReplyCode.INSIDEERROR;
				  }
				  CommonGgdm ggdm = new CommonGgdm();
				  CommonUtils.getInstance().setField(ggdm, filed, value);
				  ggdm.setDm(dm);
				  ggdm.setDmjbh(dmjbh);
				  ggdm.setUpdateTime(new Date());
				  int count = ggdmService.updateByPrimaryKeySelective(ggdm);
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
			logger.error("修改ggdm信息出错！");
			e.printStackTrace();
		}
		return ReplyCode.INSIDEERROR;
	}
}
