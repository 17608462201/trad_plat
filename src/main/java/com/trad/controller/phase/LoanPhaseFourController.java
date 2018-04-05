package com.trad.controller.phase;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.trad.bean.Loan;
import com.trad.bean.LoanOffer;
import com.trad.bean.LoanPlan;
import com.trad.bean.LoanStatus;
import com.trad.bean.User;
import com.trad.bean.common.LayuiTable;
import com.trad.service.LoanOfferService;
import com.trad.service.LoanPlanService;
import com.trad.service.LoanService;
import com.trad.service.LoanStatusService;
import com.trad.util.DateUtil;
import com.trad.util.ReplyCode;
import com.trad.util.SessionHelper;

@Controller
@RequestMapping("loanPhaseFour")
public class LoanPhaseFourController {
	
	@Autowired
	private LoanOfferService loanOfferService;
	@Autowired
	private LoanPlanService loanPlanService;
	
	@Autowired
	private LoanService loanServiceImpl;
	@Autowired
	private LoanStatusService loanStatusService;
	
	@RequestMapping("/init")
	public String init(HttpServletRequest request, Model model) {
		return "loan/phaseFour/phaseFourList";
	}
	
	@RequestMapping("/getList")
	@ResponseBody
	public String getList(@RequestParam(value = "page", defaultValue = "0") int page,
			@RequestParam(value = "limit", defaultValue = "4") int limit, HttpServletRequest request, Model model) {
		Map<String, Object> map=new HashMap<>();
		List<Map<String, Object>> list = loanOfferService.getLoanOfferList(map);
		int count = loanOfferService.getCount(map);
		
		LayuiTable returnMsg = new LayuiTable();
		returnMsg.setData(list);
		returnMsg.setCount(count);
		return JSONObject.toJSONString(returnMsg);
	}
	
	@RequestMapping("/editLoanOffer")
	public String loanExamine(HttpServletRequest request, Model model) {
		String loanOfferId = request.getParameter("loanOfferId");
		Map<String, Object> loanOffer=loanOfferService.selectByPrimaryKey(loanOfferId);
		model.addAttribute("loanOffer", loanOffer);
		model.addAttribute("loanOfferId", loanOfferId);
		return "loan/phaseFour/loanOfferEdit";
	}
	
	@RequestMapping("/upLoan")
	@ResponseBody
	public String upLoan(HttpServletRequest request,Model model) {
		try {
			LoanOffer loanOffer=new LoanOffer();
			ServletRequestDataBinder binder = new ServletRequestDataBinder(loanOffer);
			binder.bind(request);
			
			loanOfferService.updateByPrimaryKeySelective(loanOffer);
			return ReplyCode.SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ReplyCode.INSIDEERROR;
		}
	}
	
	@RequestMapping("/insPlan")
	@ResponseBody
	public String insPlan(HttpServletRequest request,Model model) {
		try {
			String loanId=request.getParameter("loanId");
			String offerDay=request.getParameter("offerDay");
			String offerMoney=request.getParameter("offerMoney");
			String monthScale=request.getParameter("monthScale");
			String firstPayment=request.getParameter("firstPayment");
			String lastPayment=request.getParameter("lastPayment");
			String offerLimit=request.getParameter("offerLimit");
			
			LoanPlan loanPlan=new LoanPlan();
			loanPlan.setLoanId(loanId);
			
			loanPlan.setGuarantee("");
			loanPlan.setService("");
			
			if(offerDay.equals(firstPayment)) {
				for (int i = 1; i < Integer.parseInt(offerLimit)+2; i++) {
					Date date = date=DateUtil.parse(firstPayment);
					if(i==1) {								//第一个月时间
						loanPlan.setInterest(String.valueOf(Integer.parseInt(offerMoney)*(Double.valueOf(monthScale)/100)));
					}else if(i==Integer.parseInt(offerLimit)+1) {
						date=DateUtil.addMonths(date, i-1);	//获取最后一个月时间
						date=DateUtil.addDays(date, -1);	//最后一个月减一天
						loanPlan.setInterest("");
						loanPlan.setPrincipal(offerMoney);
					}else {									//中间月份的时间
						date=DateUtil.addMonths(date, i-1);
						loanPlan.setInterest(String.valueOf(Integer.parseInt(offerMoney)*(Double.valueOf(monthScale)/100)));
					}
					loanPlan.setPaymentTime(DateUtil.format(date));
					loanPlan.setStageNumber(i);
					loanPlanService.insert(loanPlan);
					System.out.println(DateUtil.format(date));
				}
			}else {
				for (int i = 1; i < Integer.parseInt(offerLimit)+1; i++) {
					Date date = date=DateUtil.parse(firstPayment);
					if(i==1) {								//第一个月时间
						loanPlan.setInterest(String.valueOf(Integer.parseInt(offerMoney)*(Double.valueOf(monthScale)/100)));
					}else if(i==Integer.parseInt(offerLimit)) {
						date=DateUtil.addMonths(date, i);	//获取最后一个月时间
						loanPlan.setPrincipal(offerMoney);
						loanPlan.setInterest(String.valueOf(Integer.parseInt(offerMoney)*(Double.valueOf(monthScale)/100)));
					}else {									//中间月份的时间
						date=DateUtil.addMonths(date, i);
						loanPlan.setInterest(String.valueOf(Integer.parseInt(offerMoney)*(Double.valueOf(monthScale)/100)));
					}
					loanPlan.setPaymentTime(DateUtil.format(date));
					System.out.println(DateUtil.format(date));
					loanPlan.setStageNumber(i);
					loanPlanService.insert(loanPlan);
				}
			}
			return ReplyCode.SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ReplyCode.INSIDEERROR;
		}
	}
	
	@RequestMapping("/getPlanAll")
	@ResponseBody
	public String getPlanAll(HttpServletRequest request, Model model) {
		String loanId=request.getParameter("loanId");
		List<Map<String, Object>> planList=loanPlanService.selPlanByLoanId(loanId);
		LayuiTable returnMsg = new LayuiTable();
		returnMsg.setData(planList);
		return JSONObject.toJSONString(returnMsg);
	}
	
	@RequestMapping("/upPlan")
	@ResponseBody
	public String upPlan(HttpServletRequest request,Model model) {
		try {
			LoanPlan plan=new LoanPlan();
			ServletRequestDataBinder binder = new ServletRequestDataBinder(plan);
			binder.bind(request);
			
			loanPlanService.updateByPrimaryKeySelective(plan);
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
				model.addAttribute("map", map);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "loan/phaseFour/loanCheck";
	}
	
	@RequestMapping("/upLoanStatus")
	@ResponseBody
	public String upLoanStatus(HttpServletRequest request,Model model) {
		try {
			String loanId=request.getParameter("loanId");
			Map<String, Object> map=new HashMap<>();
			map.put("loanId", loanId);
			map.put("loanStatus", 5);
			
			User user = new SessionHelper(request).getLoginUser();
			LoanStatus loanStatus=new LoanStatus();
			loanStatus.setLoanId(loanId);
			loanStatus.setLoanStatus(5);
			loanStatus.setCreateUserId(user.getUserId());
			
			loanStatusService.insert(loanStatus);
			loanServiceImpl.upLoanStatus(map);
			return ReplyCode.SUCCESS;
		} catch (Exception e) {
			return ReplyCode.INSIDEERROR;
		}
	}
	
}
