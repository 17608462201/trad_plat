package com.trad.bean;

import java.util.Date;

public class RolePermission {
    private Integer roleId;

    private Integer treeId;

    private Date createTime;

    private Date updateTime;
    
    private Roles roles;
    
    private Tree tree;

    private String createPer;
    
    private String updatePer;
    
    public String getCreatePer() {
        return createPer;
    }

    public void setCreatePer(String createPer) {
        this.createPer = createPer == null ? null : createPer.trim();
    }
	
	public String getUpdatePer() {
        return updatePer;
    }

    public void setUpdatePer(String updatePer) {
        this.updatePer = updatePer == null ? null : updatePer.trim();
    }
    public Integer getRoleId() {
        return roleId;
    }

    public void setRoleId(Integer roleId) {
        this.roleId = roleId;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

	public Roles getRoles() {
		return roles;
	}

	public void setRoles(Roles roles) {
		this.roles = roles;
	}

	public Tree getTree() {
		return tree;
	}

	public void setTree(Tree tree) {
		this.tree = tree;
	}

	public Integer getTreeId() {
		return treeId;
	}

	public void setTreeId(Integer treeId) {
		this.treeId = treeId;
	}
	
}