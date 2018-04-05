package com.trad.controller.common;

import java.io.File;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.alibaba.fastjson.JSONObject;
import com.trad.bean.CommonFileupload;
import com.trad.bean.User;
import com.trad.service.CommonFileuploadService;
import com.trad.util.SessionHelper;

@Controller
@RequestMapping("upload")
public class UploadController {
	
	//阶段一 包括身份证 征信报告 抵押物等
	private final static String PHASEONE="1";
	
	//阶段二 下户照片
	private final static String PHASETWO="2";
	
	//阶段三 合同附件 
	private final static String PHASETHREE="3";
	
	//阶段四 公证附件
	private final static String PHASEFOUR="4";
	
	@Autowired
	private CommonFileuploadService commonFileuploadService;
	
	@RequestMapping("uploadFile")
	@ResponseBody
	public String uploadFile(HttpServletRequest request) {
		String loanId=request.getParameter("id");
		String type=request.getParameter("type");
		User user = new SessionHelper(request).getLoginUser();
		String path="";
		try {
			MultipartHttpServletRequest murequest = (MultipartHttpServletRequest) request;
			List<MultipartFile> files = murequest.getFiles("file");
			
			for (int i = 0; i < files.size(); i++) {
				if (!files.get(i).isEmpty()) {
					String upfileName=files.get(i).getOriginalFilename();
					String suffix=upfileName.substring(upfileName.lastIndexOf("."), upfileName.length());
					String fileName=UUID.randomUUID().toString().replaceAll("-", "")+suffix;
					saveFile(files.get(i), request, fileName);
					path=fileName+",";
					
					CommonFileupload commonFileupload=new CommonFileupload();
					commonFileupload.setBusnissId(loanId);
					if(type.equals("1")) {
						commonFileupload.setBusnissType(PHASEONE);
					}else if(type.equals("2")) {
						commonFileupload.setBusnissType(PHASETWO);
					}else if(type.equals("3")) {
						commonFileupload.setBusnissType(PHASETHREE);
					}else {
						commonFileupload.setBusnissType(PHASEFOUR);
					}
					commonFileupload.setCreatePer(String.valueOf(user.getUserId()));
					commonFileupload.setAddress("/res/upload/"+fileName);
					commonFileupload.setFileName(upfileName.substring(0, upfileName.lastIndexOf(".")));
					commonFileupload.setFileSize(String.valueOf(files.get(i).getSize()));
					commonFileupload.setUpdatePer(String.valueOf(user.getUserId()));
					if(".BMP.JPG.JPEG.PNG.GIF.bmp.jpg.jpeg.png.gif".indexOf(suffix)!=-1) {
						commonFileupload.setFileType("1");
					}else if(".xls.xlsx.doc.docx.pdf".indexOf(suffix)!=-1) {
						commonFileupload.setFileType("2");
					}
					commonFileuploadService.insert(commonFileupload);
				} else {
					System.out.println("文件为空出现错误");
				}
			}
			JSONObject json=new JSONObject();
			json.put("code", 1);
			json.put("msg", "上传成功");
			json.put("data", path);
			return json.toString();
		} catch (Exception e) {
			JSONObject json=new JSONObject();
			json.put("code", 0);
			json.put("msg", "上传成功");
			return json.toString();
		}
	}

	/***
	 * 保存文件
	 * 
	 * @param file
	 * @return
	 */
	private boolean saveFile(MultipartFile file, HttpServletRequest request,String fileName) {
		// 判断文件是否为空
		if (!file.isEmpty()) {
			try {
				// 文件保存路径
				String filePath = request.getSession().getServletContext().getRealPath("/") + "resources/upload/"
						+ fileName;
				// 转存文件
				file.transferTo(new File(filePath));
				return true;
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return false;
	}
}
