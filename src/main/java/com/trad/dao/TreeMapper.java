package com.trad.dao;

import java.util.List;
import com.trad.bean.Tree;

public interface TreeMapper {
    int deleteByPrimaryKey(Integer treeId);

    int insert(Tree record);

    int insertSelective(Tree record);

    Tree selectByPrimaryKey(Integer treeId);

    int updateByPrimaryKeySelective(Tree record);

    int updateByPrimaryKey(Tree record);
    
    List<Tree> getTreeListById(int parentId); 
    
    List<Tree> getTreeList();
}