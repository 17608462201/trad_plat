<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%  
//页面标题设置
	request.setAttribute("pageTitle","新增产品");  
	//如果不需要公用的css,请使用下面代码 (默认是为true)
	//request.setAttribute("INCLUDE_SKIN",false);
	//如果不需要公用的js,请使用下面代码 (默认是为true)
	//request.setAttribute("INCLUDE_COMMON",false);
	//如果不需要公用的css,请使用下面代码 (默认是为true)
	//request.setAttribute("INCLUDE_CSS",false);
%>
<%@ include file="/pages/common/header.jsp" %>
<form class="layui-form" action="#" method="post">
	<input type="hidden" id="id" name="id" value="${id }">
     <div class="layui-form-item">
          <label class="layui-form-label">备注：</label>
          <div class="layui-input-inline">
          	<textarea placeholder="请输入内容" id="remark" name="remark" class="layui-textarea"></textarea>
          </div>
     </div>
</form>
 
<script>
	layui.use(['form','laydate'], function(){
		var form = layui.form;
		var laydate = layui.laydate;
		//日期
		laydate.render({
		  elem: '#paymentTime'
		});
	});

</script>
<%@ include file="/pages/common/footer.jsp"%>