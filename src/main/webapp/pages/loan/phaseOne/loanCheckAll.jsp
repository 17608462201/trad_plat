<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	//页面标题设置
	request.setAttribute("pageTitle", "新增产品");
	//如果不需要公用的css,请使用下面代码 (默认是为true)
	request.setAttribute("INCLUDE_UPLOAD",true);
	//如果不需要公用的js,请使用下面代码 (默认是为true)
	//request.setAttribute("INCLUDE_COMMON",false);
	//如果不需要公用的css,请使用下面代码 (默认是为true)
	//request.setAttribute("INCLUDE_CSS",false);
%>
<%@ include file="/pages/common/header.jsp"%>
<div class="layui-tab" lay-filter="customerTab">
  <ul class="layui-tab-title">
   <li class="layui-this" lay-id="11">借款基本信息</li>
    <li lay-id="22">下户信息</li>
    <li lay-id="33">核算信息</li>
    <li lay-id="44">签约信息</li>
  </ul>
  <div class="layui-tab-content">
  <div class="layui-tab-item layui-show">
       <iframe  id="tabFrame11" src="${ctx }/loan/loanCheck?loanId=${loanId}"  width="100%" height="100%" frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes"></iframe>
  </div>
  </div>
</div>

<script>
	
</script>
<%@ include file="/pages/common/footer.jsp"%>