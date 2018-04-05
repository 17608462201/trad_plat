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
import com.trad.bean.CommonGgdm;
import com.trad.bean.Loan;
import com.trad.bean.LoanOffer;
import com.trad.bean.LoanStatus;
import com.trad.bean.User;
import com.trad.bean.common.LayuiTable;
import com.trad.service.CommonFileuploadService;
import com.trad.service.CommonGgdmService;
import com.trad.service.LoanOfferService;
import com.trad.service.LoanService;
import com.trad.service.LoanStatusService;
import com.trad.util.DateUtil;
import com.trad.util.ReplyCode;
import com.trad.util.SessionHelper;

@Controller
@RequestMapping("loanPhaseThree")
public class LoanPhaseThreeController {
	
	@Autowired
	private LoanService loanServiceImpl;
	
	@Autowired
	private CommonFileuploadService commonFileuploadService;
	
	@Autowired
	private LoanStatusService loanStatusService;
	
	@Autowired
	private CommonGgdmService ggdmService;
	
	@RequestMapping("/init")
	public String init(HttpServletRequest request, Model model) {
		return "loan/phaseThree/phaseThreeList";
	}

	@RequestMapping("/getList")
	@ResponseBody
	public String getList(@RequestParam(value = "page", defaultValue = "0") int page,
			@RequestParam(value = "limit", defaultValue = "4") int limit, HttpServletRequest request, Model model) {
		Map<String, Object> map=new HashMap<>();
		map.put("page", page-1);
		map.put("pageSize", limit);
		List<Loan> list = loanServiceImpl.getLoanAll(map);
		String [] dmjbhArr = new String[] {"status"};
		List<CommonGgdm> listGgdms = ggdmService.queryByDmjbh(dmjbhArr);
		for (int i = 0; i < list.size(); i++) {
			Loan loan=list.get(i);
			loan.setStatus(loan.getLoanStatus());
			for (int j = 0; j < listGgdms.size(); j++) {
				CommonGgdm commonGgdm=listGgdms.get(j);
				if(loan.getLoanStatus().equals(commonGgdm.getDm())) {
					loan.setLoanStatus(commonGgdm.getDmnr());
				}
			}
		}
		int count = loanServiceImpl.getCount();
		LayuiTable returnMsg = new LayuiTable();
		returnMsg.setData(list);
		returnMsg.setCount(count);
		return JSONObject.toJSONString(returnMsg);
	}
	
	@RequestMapping("/loanExamine")
	public String loanExamine(HttpServletRequest request, Model model) {
		String loanId = request.getParameter("loanId");
		model.addAttribute("loanId", loanId);
		return "loan/phaseThree/loanExamine";
	}
	
	@RequestMapping("/upLoanStatus")
	@ResponseBody
	public String upLoanStatus(HttpServletRequest request,Model model) {
		try {
			String loanId=request.getParameter("loanId");
			String examineMoney=request.getParameter("examineMoney");
			String examineLimit=request.getParameter("examineLimit");
			String isStatus=request.getParameter("isStatus");
			Map<String, Object> map=new HashMap<>();
			map.put("id", loanId);
			
			map.put("examineMoney", examineMoney);
			map.put("examineLimit", examineLimit);
			
			User user = new SessionHelper(request).getLoginUser();
			LoanStatus loanStatus=new LoanStatus();
			loanStatus.setLoanId(loanId);
			if(isStatus.equals("1")) {
				map.put("loanStatus", 4);
				loanStatus.setLoanStatus(4);
			}else {
				map.put("loanStatus", 1);
				loanStatus.setLoanStatus(1);
			}
			loanStatus.setCreateUserId(user.getUserId());
			
			loanStatusService.insert(loanStatus);
			loanServiceImpl.updateByPrimaryKeySelective(map);
			return ReplyCode.SUCCESS;
		} catch (Exception e) {
			return ReplyCode.INSIDEERROR;
		}
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
				map.put("type", "2");
				List<Map<String, Object>> fileList=commonFileuploadService.selFileByLoanId(map);
				model.addAttribute("fileList", fileList);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "loan/phaseThree/loanCheck";
	}
}
