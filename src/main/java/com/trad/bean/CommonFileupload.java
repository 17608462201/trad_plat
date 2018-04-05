package com.trad.bean;

import java.util.Date;

public class CommonFileupload {
    private Integer id;

    private String busnissId;

    private String busnissType;

    private String address;

    private String uploadPer;
    
    private String fileName;
    
    private String fileSize;

    private Date uploadTime;

    private Date createTime;

    private Date updateTime;

    private String createPer;

    private String updatePer;
    
    private String fileType;

    public String getFileType() {
		return fileType;
	}

	public void setFileType(String fileType) {
		this.fileType = fileType;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getFileSize() {
		return fileSize;
	}

	public void setFileSize(String fileSize) {
		this.fileSize = fileSize;
	}

	public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getBusnissId() {
        return busnissId;
    }

    public void setBusnissId(String busnissId) {
        this.busnissId = busnissId == null ? null : busnissId.trim();
    }

    public String getBusnissType() {
        return busnissType;
    }

    public void setBusnissType(String busnissType) {
        this.busnissType = busnissType == null ? null : busnissType.trim();
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address == null ? null : address.trim();
    }

    public String getUploadPer() {
        return uploadPer;
    }

    public void setUploadPer(String uploadPer) {
        this.uploadPer = uploadPer == null ? null : uploadPer.trim();
    }

    public Date getUploadTime() {
        return uploadTime;
    }

    public void setUploadTime(Date uploadTime) {
        this.uploadTime = uploadTime;
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
}