package com.trad.bean;

public class CommonGgdmKey {
    private String dmjbh;

    private String dm;

    public String getDmjbh() {
        return dmjbh;
    }

    public void setDmjbh(String dmjbh) {
        this.dmjbh = dmjbh == null ? null : dmjbh.trim();
    }

    public String getDm() {
        return dm;
    }

    public void setDm(String dm) {
        this.dm = dm == null ? null : dm.trim();
    }
}