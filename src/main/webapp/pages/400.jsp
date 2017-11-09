<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%  
//页面标题设置
	request.setAttribute("pageTitle","汉融贷金服");  
	//如果不需要公用的css,请使用下面代码 (默认是为true)
	//request.setAttribute("INCLUDE_SKIN",false);
	//如果不需要公用的js,请使用下面代码 (默认是为true)
	//request.setAttribute("INCLUDE_COMMON",false);
%>
<%@ include file="/pages/common/header.jsp" %>
<div style="padding: 50px 0; height: 600px; text-align: center;">
  <h1>
    <i class="layui-icon" style="line-height: 500px; font-size: 500px; color: #393D50;">&#xe61c;</i>
  </h1>
  <p style="font-size: 20px; font-weight: 300; color: #999;">好干净的页面啊，什么都没有的样子</p>
</div>
<%@ include file="/pages/common/footer.jsp"%>