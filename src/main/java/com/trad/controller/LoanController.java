package com.trad.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
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
import com.trad.bean.Customer;
import com.trad.bean.Loan;
import com.trad.bean.LoanOffer;
import com.trad.bean.Product;
import com.trad.bean.common.LayuiTable;
import com.trad.service.CustomerService;
import com.trad.service.LoanOfferService;
import com.trad.service.LoanService;
import com.trad.service.ProductService;
import com.trad.util.DateUtil;
import com.trad.util.ReplyCode;

@Controller
@RequestMapping("/loan")
public class LoanController {

	@Autowired
	private LoanService loanServiceImpl;
	
	@Autowired
	private LoanOfferService loanOfferService;
	
	@Autowired
	private CustomerService customerServiceImpl;
	
	@Autowired
	private ProductService productServiceImpl;
	Logger logger = LoggerFactory.getLogger(LoanController.class);

	@RequestMapping("/init")
	public String init(HttpServletRequest request, Model model) {
		return "loan/loanList";
	}

	@RequestMapping("/getList")
	@ResponseBody
	public String getList(@RequestParam(value = "page", defaultValue = "1") int page,
			@RequestParam(value = "limit", defaultValue = "4") int limit, HttpServletRequest request, Model model) {
		List<Loan> list = loanServiceImpl.getLoanAll();
		int count = loanServiceImpl.getCount();
		LayuiTable returnMsg = new LayuiTable();
		returnMsg.setData(list);
		returnMsg.setCount(count);
		return JSONObject.toJSONString(returnMsg);
	}

	@RequestMapping("/delLoan")
	@ResponseBody
	public String delLoan(HttpServletRequest request, Model model) {
		String loanId = request.getParameter("loanId");
		try {
			if (!StringUtils.isEmpty(loanId)) {
				String[] idStr = loanId.split(",");
				// 鎵归噺鍒犻櫎鑿滃崟淇℃伅
				for (String id : idStr) {
					Integer idInt = Integer.parseInt(id);
					// 鍒犻櫎鑿滃崟琛�
					loanServiceImpl.deleteByPrimaryKey(idInt);
				}
			}
			return ReplyCode.SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ReplyCode.INSIDEERROR;
		}
	}

	@RequestMapping("/editLoan")
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
	
	@RequestMapping("/addLoan")
	public String addLoan(HttpServletRequest request, Model model) {
		return "loan/loanAdd";
	}
	
	@RequestMapping("/getProductAll")
	@ResponseBody
	public String getProductAll(HttpServletRequest request, Model model) {
		List<Map<String, Object>> productList=productServiceImpl.getProductAll();
		return JSONObject.toJSONString(productList);
	}
	
	@RequestMapping("/getCustomerAll")
	@ResponseBody
	public String getCustomerAll(HttpServletRequest request, Model model) {
		List<Customer> customerList=customerServiceImpl.getCustomerAll();
		return JSONObject.toJSONString(customerList);
	}
	
	@RequestMapping("/saveLoan")
	@ResponseBody
	public String saveLoan(HttpServletRequest request,Model model) {
		try {
			String productId=request.getParameter("productId");
			String managerId=request.getParameter("managerId");
			String loadType=request.getParameter("loadType");
			String customerName=request.getParameter("customerName");
			String loanMobile=request.getParameter("loanMobile");
			String paymentName=request.getParameter("paymentName");
			String paymentContract=request.getParameter("paymentContract");
			String bailScale=request.getParameter("bailScale");
			String bailMoney=request.getParameter("bailMoney");
			String evalueMoney=request.getParameter("evalueMoney");
			String offerPound=request.getParameter("offerPound");
			String zhMoney=request.getParameter("zhMoney");
			String platMoney=request.getParameter("platMoney");
			String offerDay=request.getParameter("offerDay");
			String offerMoney=request.getParameter("offerMoney");
			String monthScale=request.getParameter("monthScale");
			String firstPayment=request.getParameter("firstPayment");
			String lastPayment=request.getParameter("lastPayment");
			String offerLimit=request.getParameter("offerLimit");
			String monthSerc=request.getParameter("monthSerc");
//			String remark=request.getParameter("remark");
//
			Loan loan=new Loan();
			LoanOffer loanOffer=new LoanOffer();
			
			ServletRequestDataBinder binder = new ServletRequestDataBinder(loan);
			binder.bind(request);
			
			ServletRequestDataBinder binderTwo = new ServletRequestDataBinder(loanOffer);
			binderTwo.bind(request);
			
//			loan.setProductId(productId);
//			loan.setLoanPer(customerName);
//			loan.setLoanMobile(loanMobile);
//			loan.setManagerId(managerId);
//			loan.setRemark(remark);
//			
//			loanOffer.setLoadType(loadType);
//			loanOffer.setPaymentName(paymentName);
//			loanOffer.setPaymentContract(paymentContract);
//			loanOffer.setBailScale(bailScale);
//			loanOffer.setBailMoney(bailMoney);
//			loanOffer.setEvalueMoney(evalueMoney);
//			loanOffer.setOfferPound(offerPound);
//			loanOffer.setZhMoney(zhMoney);
//			loanOffer.setPlatMoney(platMoney);
//			loanOffer.setOfferDay(DateUtil.parse(offerDay));
//			loanOffer.setOfferMoney(offerMoney);
//			loanOffer.setMonthScale(monthScale);
//			loanOffer.setFirstPayment(DateUtil.parse(firstPayment));
//			loanOffer.setOfferLimit(Integer.parseInt(offerLimit));
//			loanOffer.setLastPayment(DateUtil.parse(lastPayment));
//			loanOffer.setMonthSerc(monthSerc);
			
			loanServiceImpl.insert(loan);
			loanOfferService.insert(loanOffer);
			return ReplyCode.SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ReplyCode.INSIDEERROR;
		}
	}
}
