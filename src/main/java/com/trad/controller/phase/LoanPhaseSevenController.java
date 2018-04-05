package com.trad.controller.phase;

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
import com.trad.bean.LoanStatus;
import com.trad.bean.User;
import com.trad.bean.common.LayuiTable;
import com.trad.service.CommonFileuploadService;
import com.trad.service.CommonGgdmService;
import com.trad.service.LoanService;
import com.trad.service.LoanStatusService;
import com.trad.util.EntityToMap;
import com.trad.util.ReplyCode;
import com.trad.util.SessionHelper;

@Controller
@RequestMapping("/loanPhaseSeven")
public class LoanPhaseSevenController {
	
	@Autowired
	private LoanService loanServiceImpl;
	@Autowired
	private LoanStatusService loanStatusService;
	@Autowired
	private CommonGgdmService ggdmService;
	
	@RequestMapping("/init")
	public String init(HttpServletRequest request, Model model) {
		return "loan/phaseSeven/phaseSevenList";
	}

	@RequestMapping("/getList")
	@ResponseBody
	public String getList(@RequestParam(value = "page", defaultValue = "1") int page,
			@RequestParam(value = "limit", defaultValue = "4") int limit, HttpServletRequest request, Model model) {
		Map<String, Object> map=new HashMap<>();
		map.put("page", page);
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
	
	@RequestMapping("/upLoan")
	@ResponseBody
	public String upLoan(HttpServletRequest request,Model model) {
		try {
			Loan loan=new Loan();
			
			ServletRequestDataBinder binder = new ServletRequestDataBinder(loan);
			binder.bind(request);
			
			Map<String, Object> map=EntityToMap.ConvertObjToMap(loan);
			loanServiceImpl.updateByPrimaryKeySelective(map);
			return ReplyCode.SUCCESS;
		}catch (Exception e) {
			e.printStackTrace();
			return ReplyCode.INSIDEERROR;
		}
	}
	
	@RequestMapping("/upLoanStatus")
	@ResponseBody
	public String upLoanStatus(HttpServletRequest request,Model model) {
		try {
			String loanId=request.getParameter("loanId");
			Map<String, Object> map=new HashMap<>();
			map.put("loanId", loanId);
			map.put("loanStatus", 8);
			map.put("loanExamine", 1);
			
			User user = new SessionHelper(request).getLoginUser();
			LoanStatus loanStatus=new LoanStatus();
			loanStatus.setLoanId(loanId);
			loanStatus.setLoanStatus(8);
			loanStatus.setCreateUserId(user.getUserId());
			
			loanStatusService.insert(loanStatus);
			loanServiceImpl.upLoanStatus(map);
			return ReplyCode.SUCCESS;
		} catch (Exception e) {
			return ReplyCode.INSIDEERROR;
		}
	}
}
