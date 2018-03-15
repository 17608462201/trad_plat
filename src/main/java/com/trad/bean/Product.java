package com.trad.bean;

import java.util.Date;

public class Product {
    private Integer id;

    private String name;

    private String decription;

    private String payName;

    private Integer payTimes;

    private Double trad;

    private String paytype;

    private String punishtype;

    private Double punishtrad;

    private Integer mostmon;

    private String payobj;

    private String remark;

    private Date createTime;

    private Date updateTime;

    private String createPer;

    private String updatePer;

    private String recordStatus="1";
    
    private  CommonGgdm ggdm1;
    
    private CommonGgdm ggdm2;
    
    private CommonGgdm ggdm3;
    
    public String getRecordStatus() {
		return recordStatus;
	}

	public void setRecordStatus(String recordStatus) {
		this.recordStatus = recordStatus;
	}
	
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public String getDecription() {
        return decription;
    }

    public void setDecription(String decription) {
        this.decription = decription == null ? null : decription.trim();
    }

    public String getPayName() {
        return payName;
    }

    public void setPayName(String payName) {
        this.payName = payName == null ? null : payName.trim();
    }

    public Integer getPayTimes() {
        return payTimes;
    }

    public void setPayTimes(Integer payTimes) {
        this.payTimes = payTimes;
    }

    public Double getTrad() {
        return trad;
    }

    public void setTrad(Double trad) {
        this.trad = trad;
    }

    public String getPaytype() {
        return paytype;
    }

    public void setPaytype(String paytype) {
        this.paytype = paytype == null ? null : paytype.trim();
    }

    public String getPunishtype() {
        return punishtype;
    }

    public void setPunishtype(String punishtype) {
        this.punishtype = punishtype == null ? null : punishtype.trim();
    }

    public Double getPunishtrad() {
        return punishtrad;
    }

    public void setPunishtrad(Double punishtrad) {
        this.punishtrad = punishtrad;
    }

    public Integer getMostmon() {
        return mostmon;
    }

    public void setMostmon(Integer mostmon) {
        this.mostmon = mostmon;
    }

    public String getPayobj() {
        return payobj;
    }

    public void setPayobj(String payobj) {
        this.payobj = payobj == null ? null : payobj.trim();
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark == null ? null : remark.trim();
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

	public CommonGgdm getGgdm1() {
		return ggdm1;
	}

	public void setGgdm1(CommonGgdm ggdm1) {
		this.ggdm1 = ggdm1;
	}

	public CommonGgdm getGgdm2() {
		return ggdm2;
	}

	public void setGgdm2(CommonGgdm ggdm2) {
		this.ggdm2 = ggdm2;
	}

	public CommonGgdm getGgdm3() {
		return ggdm3;
	}

	public void setGgdm3(CommonGgdm ggdm3) {
		this.ggdm3 = ggdm3;
	}

}