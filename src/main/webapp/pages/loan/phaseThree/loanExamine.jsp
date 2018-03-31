<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	//页面标题设置
	request.setAttribute("pageTitle", "新增产品");
	//如果不需要公用的css,请使用下面代码 (默认是为true)
	//request.setAttribute("INCLUDE_SKIN",false);
	//如果不需要公用的js,请使用下面代码 (默认是为true)
	//request.setAttribute("INCLUDE_COMMON",false);
	//如果不需要公用的css,请使用下面代码 (默认是为true)
	//request.setAttribute("INCLUDE_CSS",false);
%>
<%@ include file="/pages/common/header.jsp"%>
<form class="layui-form" action="${ctx}/loan/saveLoan" method="post">
	<!-- <div class="layui-row" style="padding-top: 10px; padding-bottom: 5px;">
		<div class="layui-col-xs6">
			<div class="grid-demo grid-demo-bg1">&nbsp;</div>
		</div>
		<div class="layui-col-xs3">
			<div class="grid-demo grid-demo-bg1">&nbsp;</div>
		</div>
		<div class="layui-col-xs3">
			<div class="grid-demo grid-demo-bg1">
				<button class="layui-btn" lay-submit lay-filter="*">
					<i class="layui-icon">&#xe61a;</i>保存
				</button>
			</div>
		</div>
	</div> -->
	<hr>
	<input type="hidden" name="loanId" id="loanId" value="${loanId }">
	<div class="layui-form-item">
		<div class="layui-inline">
			<label class="layui-form-label">借款金额：</label>
			<div class="layui-input-inline">
				<input type="text" name="examineMoney" lay-verify="required" id="examineMoney" autocomplete="off"	class="layui-input">
			</div>
		</div>
	</div>
	<div class="layui-form-item">
		<div class="layui-inline">
			<label class="layui-form-label">还款期限：</label>
			<div class="layui-input-block">
				<input type="text" name="examineLimit" lay-verify="required" id="examineLimit" autocomplete="off"	class="layui-input">
			</div>
		</div>
	</div>
	<div class="layui-form-item">
		<div class="layui-inline">
			<label class="layui-form-label">是否同意：</label>
			<div class="layui-input-block">
				<input type="radio" name="isStatus" value="1" title="是">
	      		<input type="radio" name="isStatus" value="2" title="否" checked>
			</div>
		</div>
	</div>
</form>

<script>
	layui.use(['form','laydate'], function() {
		var form = layui.form;
	});
</script>
<%@ include file="/pages/common/footer.jsp"%>