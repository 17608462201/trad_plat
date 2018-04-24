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
import com.trad.service.CommonFileuploadService;
import com.trad.service.LoanOfferService;
import com.trad.service.LoanPlanService;
import com.trad.service.LoanService;
import com.trad.service.LoanStatusService;
import com.trad.util.DateUtil;
import com.trad.util.ReplyCode;
import com.trad.util.SessionHelper;

@Controller
@RequestMapping("loanPhaseFive")
public class LoanPhaseFiveController {
	
	@Autowired
	private LoanOfferService loanOfferService;
	@Autowired
	private CommonFileuploadService commonFileuploadService;
	@Autowired
	private LoanService loanServiceImpl;
	@Autowired
	private LoanStatusService loanStatusService;
	
	@RequestMapping("/init")
	public String init(HttpServletRequest request, Model model) {
		return "loan/phaseFive/phaseFiveList";
	}
	
	@RequestMapping("/getList")
	@ResponseBody
	public String getList(@RequestParam(value = "page", defaultValue = "0") int page,
			@RequestParam(value = "limit", defaultValue = "4") int limit, HttpServletRequest request, Model model) {
		Map<String, Object> map=new HashMap<>();
		map.put("page", page-1);
		map.put("pageSize", limit);
		map.put("loanStatus", 5);
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
		Map<String, Object> map=new HashMap<>();
		map.put("loanId", loanOffer.get("loadId"));
		map.put("type", "3");
		List<Map<String, Object>> fileList=commonFileuploadService.selFileByLoanId(map);
		model.addAttribute("fileList", fileList);
		model.addAttribute("loanOffer", loanOffer);
		return "loan/phaseFive/phaseFiveEdit";
	}
	
	@RequestMapping("/upLoanStatus")
	@ResponseBody
	public String upLoanStatus(HttpServletRequest request,Model model) {
		try {
			String loanId=request.getParameter("loanId");
			Map<String, Object> map=new HashMap<>();
			map.put("loanId", loanId);
			map.put("loanStatus", 6);
			
			User user = new SessionHelper(request).getLoginUser();
			LoanStatus loanStatus=new LoanStatus();
			loanStatus.setLoanId(loanId);
			loanStatus.setLoanStatus(6);
			loanStatus.setCreateUserId(user.getUserId());
			
			loanStatusService.insert(loanStatus);
			loanServiceImpl.upLoanStatus(map);
			return ReplyCode.SUCCESS;
		} catch (Exception e) {
			return ReplyCode.INSIDEERROR;
		}
	}
	
	@RequestMapping("/toLoanCheck")
	public String toLoanCheck(HttpServletRequest request, Model model) {
		String loanId = request.getParameter("loanId");
		model.addAttribute("loanId", loanId);
		return "loan/phaseOne/loanCheckAll";
	}
	
	@RequestMapping("/loanCheck")
	public String loanCheck(HttpServletRequest request, Model model) {
		try {
			String loanId = request.getParameter("loanId");
			if (!StringUtils.isEmpty(loanId)) {
				Loan loan = loanServiceImpl.selectByPrimaryKey(loanId);
				model.addAttribute("loan", loan);
				Map<String, Object> map=new HashMap<>();
				map.put("loanId", loanId);
				map.put("type", "3");
				List<Map<String, Object>> fileList=commonFileuploadService.selFileByLoanId(map);
				model.addAttribute("fileList", fileList);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "loan/phaseFive/loanCheck";
	}
}
