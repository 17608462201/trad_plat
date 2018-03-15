package com.trad.bean.vo;

import java.util.List;

public class TreeVo {
	    // 菜单id
       private Integer id;
	    // 菜单名称
       private String name;
       //是否展开
       private boolean spread;
	    // 父菜单id
	    private Integer parentId;
	    // 菜单url
	    private String href;
	    // 菜单图标
	    private String icon;
	    // 菜单顺序
	    private String ordernum;
	    // 子菜单
	    private List<TreeVo> children;
	    //是否勾选
	    public boolean checked;
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
			this.name = name;
		}
		public boolean isSpread() {
			return spread;
		}
		public void setSpread(boolean spread) {
			this.spread = spread;
		}
		public Integer getParentId() {
			return parentId;
		}
		public void setParentId(Integer parentId) {
			this.parentId = parentId;
		}
		public String getHref() {
			return href;
		}
		public void setHref(String href) {
			this.href = href;
		}
		public String getIcon() {
			return icon;
		}
		public void setIcon(String icon) {
			this.icon = icon;
		}
	 
		public List<TreeVo> getChildren() {
			return children;
		}
		public void setChildren(List<TreeVo> children) {
			this.children = children;
		}
		public String getOrdernum() {
			return ordernum;
		}
		public void setOrdernum(String ordernum) {
			this.ordernum = ordernum;
		}
		public boolean isChecked() {
			return checked;
		}
		public void setChecked(boolean checked) {
			this.checked = checked;
		}
		
}
