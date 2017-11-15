package com.trad.controller;

import java.io.UnsupportedEncodingException;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.net.URLDecoder;
import java.util.ArrayList;
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
import com.trad.bean.RolePermission;
import com.trad.bean.Tree;
import com.trad.bean.TreeVo;
import com.trad.bean.common.LayuiTable;
import com.trad.bean.common.PageStatus;
import com.trad.service.TreeService;
import com.trad.util.ReplyCode;
import com.trad.util.TreeUtil;
@Controller
@RequestMapping("/tree")
public class TreeController {
	
	@Resource
	private TreeService treeService;
	Logger logger = LoggerFactory.getLogger(TreeController.class);
	
	@RequestMapping("/init")
	 public String init(HttpServletRequest request,Model model){  
		return  "permission/tree"; 
	}
	
	@RequestMapping("/add")
	 public String add(HttpServletRequest request,Model model){  
		return  "permission/treeEdit"; 
	}
	
	@RequestMapping("/saveTree")
	@ResponseBody
	 public String saveTree(HttpServletRequest request,Model model){
		try{
			String treeName = request.getParameter("treeName");
			String treeDesc = request.getParameter("treeDesc");
			String parentId = request.getParameter("parentId");
			String url = request.getParameter("url");
			 logger.info("传入的treeName={},treeDesc={},parentId={},url={}",treeName,treeDesc,parentId,url);
			if(StringUtils.isEmpty(url)){
				 return ReplyCode.INSIDEERROR;
			}
			Tree tree = new Tree();
			tree.setTreeName(treeName);
			tree.setTreeDesc(treeDesc);
			if(!StringUtils.isEmpty(parentId)){
				tree.setParentId(Integer.parseInt(parentId));
			}
			tree.setUrl(url);
			tree.setCreateTime(new Date());
			tree.setUpdateTime(new Date());
			int count = treeService.saveTree(tree);
			if(count == 1){
				  return ReplyCode.SUCCESS;
			  }else{
				  return ReplyCode.INSIDEERROR;
			  }
		}catch(Exception e){
			e.printStackTrace();
			logger.error("保存菜单树出错！");
			return ReplyCode.INSIDEERROR;
		}
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
		      int count = treeService.count(filter);
		      pageSta.setCount(count);
		      pageSta.setPage(page);
		      pageSta.setLimit(limit);
		    //mysql limit 后面是数据条数
		      List<Tree> pageTreeList = treeService.queryByPaged(filter,pageSta.getStartNum(), limit);
		      List<Tree> treeList = treeService.getAllTree();
		      List<Tree> resultList = new ArrayList<>();
		      if(pageTreeList !=null && pageTreeList.size()>0 && treeList !=null && treeList.size()>0){
		   	   for(int i=0;i<pageTreeList.size();i++){
		   		   for(Tree tree : treeList){
		   			   //当此时的roleId与遍历id相等时，则生成treeNames,userNames
		   			   if(pageTreeList.get(i).getTreeId() == tree.getTreeId()){
		   				   List<RolePermission> rolePers = tree.getRolePers();
		   	    		   StringBuffer roleNamesBuffer = new StringBuffer();
		   	    		   //生成角色组合
		   	    		   if(rolePers !=null && rolePers.size()>0){
		   	    			   for(RolePermission rp : rolePers){
		   	    				   if(rp.getRoles() != null && !StringUtils.isEmpty(rp.getRoles().getRoleName())){
		   	    					   roleNamesBuffer.append(rp.getRoles().getRoleName()+",");
		   	    				   }
		   	    			   }
		   	    		   }
		   	    		   String roleNames = roleNamesBuffer.toString();
		   	    		   if(!StringUtils.isEmpty(roleNames)){
		   	    			   tree.setRoleNames(roleNames.substring(0,roleNames.length()-1));
		   	    		   }
		   	    		   
		   	    		   resultList.add(tree);
		   			   }
		   		   }
		   	   }
		      }
		      returnMsg.setData(resultList);
		      returnMsg.setCount(count);
      }catch(UnsupportedEncodingException e){
    	  e.printStackTrace();
      }catch (Exception e) {
    	  e.printStackTrace();
	}
      return JSONObject.toJSONString(returnMsg);
	}
	
	@RequestMapping("/deleteTrees")
	@ResponseBody
	 public String deleteRoles(HttpServletRequest request,Model model){
     try{
   	  String treeIds = request.getParameter("treeIds");
   	  logger.info("传入的treeIds={}",treeIds);
   	  if(!StringUtils.isEmpty(treeIds)){
   		  String [] treeIdStr = treeIds.split(",");
   		  //批量删除菜单信息
   		  for(String treeId : treeIdStr){
   			  Integer treeIdInt = Integer.parseInt(treeId);
       		  //删除菜单表
   			  treeService.deleteByPrimaryKey(treeIdInt);
       		  //删除菜单角色表
   			  treeService.deleteTreePerm(treeIdInt);
   		  }
   	  }
		  return ReplyCode.SUCCESS;
	  }catch(Exception e){
		  e.printStackTrace();
		  logger.error("删除菜单树出错！");
		  return ReplyCode.INSIDEERROR;
	  }
	}
	
	@RequestMapping("/modify")
	@ResponseBody
	 public String detail(HttpServletRequest request, HttpServletResponse response,Model model){
		try {
		          String nTreeID =request.getParameter("nTreeID");
				  String nTreeFiled =request.getParameter("nTreeFiled");
				  String nTreeValue = request.getParameter("nTreeValue");
				  logger.info("传入的nTreeID={},nTreeFiled={}，nTreeValue={}",nTreeID,nTreeFiled,nTreeValue);
				  if(StringUtils.isEmpty(nTreeID) || StringUtils.isEmpty(nTreeFiled) || StringUtils.isEmpty(nTreeValue)){
					   return ReplyCode.INSIDEERROR;
				  }
				  Tree tree = new Tree();
				  Field treeFiled = tree.getClass().getDeclaredField(nTreeFiled);
				  treeFiled.setAccessible(true);  
				  treeFiled.set(tree,nTreeValue);
				  tree.setTreeId(Integer.parseInt(nTreeID));
				  tree.setUpdateTime(new Date());
				  int count = treeService.updateByPrimaryKeySelective(tree);
				  if(count == 1){
					  return ReplyCode.SUCCESS;
				  }
		} catch (NoSuchFieldException e) {
			logger.error("设置反射字段出错！");
			e.printStackTrace();
		} catch (SecurityException e) {
			logger.error("设置反射字段出错！");
			e.printStackTrace();
		} catch (IllegalArgumentException e) {
			logger.error("设置反射字段出错！");
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			logger.error("设置反射字段出错！");
			e.printStackTrace();
		}catch (Exception e) {
			logger.error("修改tree信息出错！");
			e.printStackTrace();
		}
		return ReplyCode.INSIDEERROR;
	}
	
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
