package com.trad.util;

import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.util.StringUtils;

import com.trad.bean.Tree;
import com.trad.bean.TreeVo;

public class TreeUtil {

	/**
	 * 根据菜单表数据加载生产所有菜单
	 * @param queryList
	 * @return
	 * @throws InvocationTargetException 
	 * @throws IllegalAccessException 
	 */
	public static List<TreeVo> queryTreeVoList(List<Tree> rootTree,boolean needUrl) throws IllegalAccessException, InvocationTargetException {
		if(rootTree == null || rootTree.size()==0){
			return null;
		}
	    List<TreeVo> treeVoList = new ArrayList<TreeVo>();
	    // 先找到所有的一级菜单
	    for (int i = 0; i < rootTree.size(); i++) {
	        // 一级菜单没有parentId
	        if (StringUtils.isEmpty(rootTree.get(i).getParentId())) {
	        	TreeVo treeVo = convertTree(rootTree.get(i),needUrl);
	        	treeVo.setSpread(true);
	        	treeVoList.add(treeVo);
	        }
	    }
	    // 为一级菜单设置子菜单，getChild是递归调用的
	    for (TreeVo TreeVo : treeVoList) {
	        TreeVo.setChildren(getChild(TreeVo.getId(), rootTree,needUrl));
	    }

	    return treeVoList;
	}
	

	/**
	 * 递归查找子菜单
	 * 
	 * @param id
	 *            当前菜单id
	 * @param rootTreeVo
	 *            要查找的列表
	 * @return
	 * @throws InvocationTargetException 
	 * @throws IllegalAccessException 
	 */
	public static List<TreeVo> getChild(int id, List<Tree> rootTreeVo,boolean needUrl) throws IllegalAccessException, InvocationTargetException {
	    // 子菜单
	    List<TreeVo> childList = new ArrayList<>();
	    for (Tree tree: rootTreeVo) {
	        // 遍历所有节点，将父菜单id与传过来的id比较
	        if (!StringUtils.isEmpty(tree.getParentId())) {
	            if (tree.getParentId().equals(id)) {
	                childList.add(convertTree(tree,needUrl));
	            }
	        }
	    }
	    // 把子菜单的子菜单再循环一遍
	    for (TreeVo TreeVo : childList) {// 没有url子菜单还有子菜单
	        if (!StringUtils.isEmpty(TreeVo.getHref())) {
	            // 递归
	            TreeVo.setChildren(getChild(TreeVo.getId(), rootTreeVo,needUrl));
	        }
	    } // 递归退出条件
	    if (childList.size() == 0) {
	        return null;
	    }
	    return childList;
	}
	
	
	public static TreeVo convertTree(Tree tree,boolean needUrl) throws IllegalAccessException, InvocationTargetException{
		TreeVo vo  = new TreeVo();
		vo.setId(tree.getTreeId());
		vo.setName(tree.getTreeName());
		vo.setIcon(tree.getIcon());
		vo.setOrdernum(tree.getOrdernum());
		vo.setParentId(tree.getParentId());
		vo.setChecked(tree.isChecked());
		if(needUrl){
			vo.setHref(tree.getUrl());
		}
		return vo;
	}
}
