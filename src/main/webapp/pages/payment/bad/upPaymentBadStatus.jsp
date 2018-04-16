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
	    <label class="layui-form-label">*坏账状态</label>
	    <div class="layui-input-block">
	      <input type="radio" name="bad_debt_status" value="0" title="失联" <c:if test="${status==0 }">checked</c:if>>
	      <input type="radio" name="bad_debt_status" value="1" title="司法程序" <c:if test="${status==1 }">checked</c:if>>
	      <input type="radio" name="bad_debt_status" value="2" title="变卖资产" <c:if test="${status==2 }">checked</c:if>>
	      <input type="radio" name="bad_debt_status" value="3" title="自垫" <c:if test="${status==3 }">checked</c:if>>
	      <input type="radio" name="bad_debt_status" value="4" title="正常" <c:if test="${status==4 }">checked</c:if>>
	    </div>
	</div>
	
	<div class="layui-form-item">
	    <label class="layui-form-label">是否结清</label>
	    <div class="layui-input-block">
	      <input type="radio" name="is_settle" value="0" title="已结清" <c:if test="${isSettle==0 }">checked</c:if>>
	      <input type="radio" name="is_settle" value="1" title="未结清" <c:if test="${isSettle==1 }">checked</c:if>>
	    </div>
	</div>
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