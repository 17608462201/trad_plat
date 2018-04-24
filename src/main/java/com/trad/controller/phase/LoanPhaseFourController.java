package com.trad.controller.phase;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
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
		Map<String, Object> map = new HashMap<>();
		map.put("page", page-1);
		map.put("pageSize", limit);
		map.put("loanStatus", 4);
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
		Map<String, Object> loanOffer = loanOfferService.selectByPrimaryKey(loanOfferId);
		String mobile=loanOfferService.selMobile(loanOfferId);
		model.addAttribute("mobile", mobile);
		model.addAttribute("loanOffer", loanOffer);
		model.addAttribute("loanOfferId", loanOfferId);
		return "loan/phaseFour/loanOfferEdit";
	}

	@RequestMapping("/upLoan")
	@ResponseBody
	public String upLoan(HttpServletRequest request, Model model) {
		try {
			LoanOffer loanOffer = new LoanOffer();
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
	public String insPlan(HttpServletRequest request, Model model) {
		try {
			String loanId = request.getParameter("loanId");
			String offerDay = request.getParameter("offerDay");
			String offerMoney = request.getParameter("offerMoney");
			String monthScale = request.getParameter("monthScale");
			String firstPayment = request.getParameter("firstPayment");
			String lastPayment = request.getParameter("lastPayment");
			String offerLimit = request.getParameter("offerLimit");

			LoanPlan loanPlan = new LoanPlan();
			loanPlan.setLoanId(loanId);

			loanPlan.setGuarantee("");
			loanPlan.setService("");

			if (offerDay.equals(firstPayment)) {
				for (int i = 1; i < Integer.parseInt(offerLimit) + 2; i++) {
					Date date = date = DateUtil.parse(firstPayment);
					if (i == 1) { // 第一个月时间
						loanPlan.setPrincipal("0");
						loanPlan.setInterest(
								String.valueOf(Integer.parseInt(offerMoney) * (Double.valueOf(monthScale) / 100)));
					} else if (i == Integer.parseInt(offerLimit) + 1) {
						date = DateUtil.addMonths(date, i - 1); // 获取最后一个月时间
						date = DateUtil.addDays(date, -1); // 最后一个月减一天
						loanPlan.setInterest("0");
						loanPlan.setPrincipal(offerMoney);
					} else { // 中间月份的时间
						date = DateUtil.addMonths(date, i - 1);
						loanPlan.setPrincipal("0");
						loanPlan.setInterest(
								String.valueOf(Integer.parseInt(offerMoney) * (Double.valueOf(monthScale) / 100)));
					}
					loanPlan.setPaymentTime(DateUtil.format(date));
					loanPlan.setStageNumber(i);
					loanPlanService.insert(loanPlan);
					System.out.println(DateUtil.format(date));
				}
			} else {
				for (int i = 1; i < Integer.parseInt(offerLimit) + 1; i++) {
					Date date = date = DateUtil.parse(firstPayment);
					if (i == 1) { // 第一个月时间
						loanPlan.setInterest(
								String.valueOf(Integer.parseInt(offerMoney) * (Double.valueOf(monthScale) / 100)));
						loanPlan.setPrincipal("0");
					} else if (i == Integer.parseInt(offerLimit)) {
						date = DateUtil.addMonths(date, i); // 获取最后一个月时间
						loanPlan.setPrincipal(offerMoney);
						loanPlan.setInterest(
								String.valueOf(Integer.parseInt(offerMoney) * (Double.valueOf(monthScale) / 100)));
					} else { // 中间月份的时间
						date = DateUtil.addMonths(date, i);
						loanPlan.setPrincipal("0");
						loanPlan.setInterest(
								String.valueOf(Integer.parseInt(offerMoney) * (Double.valueOf(monthScale) / 100)));
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
		String loanId = request.getParameter("loanId");
		List<Map<String, Object>> planList = loanPlanService.selPlanByLoanId(loanId);
		LayuiTable returnMsg = new LayuiTable();
		returnMsg.setData(planList);
		return JSONObject.toJSONString(returnMsg);
	}

	@RequestMapping("/upPlan")
	@ResponseBody
	public String upPlan(HttpServletRequest request, Model model) {
		try {
			LoanPlan plan = new LoanPlan();
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
				Map<String, Object> map = loanOfferService.selloanOfferByloanId(loanId);
				model.addAttribute("map", map);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "loan/phaseFour/loanCheck";
	}

	@RequestMapping("/upLoanStatus")
	@ResponseBody
	public String upLoanStatus(HttpServletRequest request, Model model) {
		try {
			String loanId = request.getParameter("loanId");
			Map<String, Object> map = new HashMap<>();
			map.put("loanId", loanId);
			map.put("loanStatus", 5);

			User user = new SessionHelper(request).getLoginUser();
			LoanStatus loanStatus = new LoanStatus();
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

	@RequestMapping("/downExcel")
	public String download(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String loanId=request.getParameter("loanId");
		List<Map<String, Object>> planList = loanPlanService.selPlanByLoanId(loanId);
		
		String columnNames[] = { "ID", "期数", "还款日期", "本金", "利息", "担保费" , "服务费"};// 列名
		// 生成一个Excel文件
		// 创建excel工作簿
		Workbook wb = new HSSFWorkbook();
		// 创建第一个sheet（页），并命名
		Sheet sheet = wb.createSheet("sheet");
		// 手动设置列宽。第一个参数表示要为第几列设；，第二个参数表示列的宽度，n为列高的像素数。
		for (int i = 0; i < 1; i++) {
			sheet.setColumnWidth((short) i, (short) (35.7 * 150));
		}
		// 创建第一行
		Row row = sheet.createRow((short) 0);
		// 设置列名
		for (int i = 0; i < columnNames.length; i++) {
			Cell cell = row.createCell(i);
			cell.setCellValue(columnNames[i]);
		}
		
		for (int i = 0; i < planList.size(); i++) {
			Map<String, Object> map=planList.get(i);
			Row rows = sheet.createRow(i+1);
			Cell cell = rows.createCell(0);
			cell.setCellValue(map.get("planId").toString());
			
			Cell cell1 = rows.createCell(1);
			cell1.setCellValue(map.get("stageNumber").toString());
			
			Cell cell2 = rows.createCell(2);
			cell2.setCellValue(map.get("paymentTime").toString());
			
			Cell cell3 = rows.createCell(3);
			cell3.setCellValue(map.get("principal").toString());
			
			Cell cell4 = rows.createCell(4);
			cell4.setCellValue(map.get("interest").toString());
			
			Cell cell5 = rows.createCell(5);
			cell5.setCellValue(map.get("guarantee").toString());
			
			Cell cell6 = rows.createCell(6);
			cell6.setCellValue(map.get("service").toString());
		}
		
		
		// 同理可以设置数据行
		ByteArrayOutputStream os = new ByteArrayOutputStream();
		try {
			wb.write(os);
		} catch (IOException e) {
			e.printStackTrace();
		}
		byte[] content = os.toByteArray();
		InputStream is = new ByteArrayInputStream(content);
		// 设置response参数，可以打开下载页面
		response.reset();
		response.setContentType("application/vnd.ms-excel;charset=utf-8");
		response.setHeader("Content-Disposition", "attachment;filename=" + new String(("plan.xls").getBytes(), "iso-8859-1"));
		ServletOutputStream out = response.getOutputStream();
		BufferedInputStream bis = null;
		BufferedOutputStream bos = null;
		try {
			bis = new BufferedInputStream(is);
			bos = new BufferedOutputStream(out);
			byte[] buff = new byte[2048];
			int bytesRead;
			while (-1 != (bytesRead = bis.read(buff, 0, buff.length))) {
				bos.write(buff, 0, bytesRead);
			}
		} catch (final IOException e) {
			throw e;
		} finally {
			if (bis != null)
				bis.close();
			if (bos != null)
				bos.close();
		}
		return null;
	}
}
