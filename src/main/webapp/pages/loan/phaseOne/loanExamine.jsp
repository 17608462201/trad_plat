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
		<label class="layui-form-label">审核状态：</label>
		<div class="layui-input-inline">
			<select name="loanStatus" id="loanStatus" lay-verify="required">
				<option>请选择审核状态</option>
				<option value="1">待审核</option>
				<option value="2">待放款</option>
				<option value="3">取消贷款申请</option>
				<option value="4">拒绝贷款申请</option>
			</select>
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">审核意见：</label>
		<div class="layui-input-block">
			<input type="text" name="loanOpinion" lay-verify="required" id="loanOpinion" autocomplete="off"	class="layui-input">
		</div>
	</div>
</form>

<script>
	layui.use(['form','laydate'], function() {
		var form = layui.form;
	});
</script>
<%@ include file="/pages/common/footer.jsp"%>