package com.trad.controller.phase;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.trad.bean.Loan;
import com.trad.bean.LoanOffer;
import com.trad.util.DateUtil;
import com.trad.util.ReplyCode;

public class LoanOfferController {
	
	/*@RequestMapping("/editLoan")
	public String editPro(HttpServletRequest request, Model model) {
		try {
			String loanId = request.getParameter("loanId");
			if (!StringUtils.isEmpty(loanId)) {
				Integer idInt = Integer.parseInt(loanId);
				Loan loan = loanServiceImpl.selectByPrimaryKey(idInt);
				model.addAttribute("loan", loan);
				model.addAttribute("type", "EDIT");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "loan/loanEdit";
	}
	
	@RequestMapping("/saveLoanOffer")
	@ResponseBody
	public String saveLoan(HttpServletRequest request,Model model) {
		try {
			Loan loan=new Loan();
			LoanOffer loanOffer=new LoanOffer();
			
			ServletRequestDataBinder binder = new ServletRequestDataBinder(loan);
			binder.bind(request);
			
			ServletRequestDataBinder binderTwo = new ServletRequestDataBinder(loanOffer);
			binderTwo.bind(request);
			
			loan.setApplyTime(DateUtil.format(new Date()));
			
			loanServiceImpl.insert(loan);
			loanOfferService.insert(loanOffer);
			return ReplyCode.SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ReplyCode.INSIDEERROR;
		}
	}*/
	
	@RequestMapping("/addLoanOffer")
	public String addLoan(HttpServletRequest request, Model model) {
		return "loan/loanOfferAdd";
	}
}
