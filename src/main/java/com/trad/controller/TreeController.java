package com.trad.controller;

import java.lang.reflect.InvocationTargetException;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.trad.bean.RolePermission;
import com.trad.bean.Tree;
import com.trad.bean.TreeVo;
import com.trad.service.TreeService;
import com.trad.util.ReplyCode;
import com.trad.util.TreeUtil;
@Controller
@RequestMapping("/tree")
public class TreeController {
	
	@Resource
	private TreeService treeService;
	
	@RequestMapping("/getMenuList")
	@ResponseBody
	public String getMenuList(HttpServletRequest request,Model model){
		List<TreeVo> treeVoList = null;
		try {
				String parentId = request.getParameter("parentId");
				if(!StringUtils.isEmpty(parentId)){
					int parentIdInt = Integer.parseInt(parentId);
					List<Tree> treeList = treeService.getTreeListById(parentIdInt);
					treeVoList = TreeUtil.getChild(parentIdInt,treeList,true);
				}
			} catch (IllegalAccessException | InvocationTargetException e) {
				e.printStackTrace();
			}
		return JSONObject.toJSONString(treeVoList);
	}
	
	
	@RequestMapping("/saveTreePer")
	@ResponseBody
	 public String saveRoleUser(HttpServletRequest request,Model model){
	  String roleId = request.getParameter("roleId");
	  String treeIdsCheck = request.getParameter("treeIdsCheck");
	  String treeIdsUnCheck = request.getParameter("treeIdsUnCheck");
	  try{
		  if(!StringUtils.isEmpty(roleId)){
			  //更新选中结果
			  if(!StringUtils.isEmpty(treeIdsCheck)){
				  String [] ids = treeIdsCheck.split(",");
				  for(String id : ids){
					  if(!StringUtils.isEmpty(id)){
						  RolePermission rp = new RolePermission();
						  rp.setCreateTime(new Date());
						  rp.setUpdateTime(new Date());
						  rp.setRoleId(Integer.parseInt(roleId));
						  rp.setTreeId(Integer.parseInt(id));
						  //保存数据库数据
						  treeService.insertRolePermission(rp);
					  }
				  }
			  }
			  //更新未选中结果
			  if(!StringUtils.isEmpty(treeIdsUnCheck)){
				  String [] uids = treeIdsUnCheck.split(",");
				  for(String id : uids){
					  if(!StringUtils.isEmpty(id)){
						  RolePermission rp = new RolePermission();
						  rp.setRoleId(Integer.parseInt(roleId));
						  rp.setTreeId(Integer.parseInt(id));
						  //保存数据库数据
						  treeService.deleteRolePermission(rp);
					  }
				  }
			  }
		  }
		  return ReplyCode.SUCCESS;
	  }catch(Exception e){
		  e.printStackTrace();
		  return ReplyCode.INSIDEERROR;
	  }
	}
	
}
