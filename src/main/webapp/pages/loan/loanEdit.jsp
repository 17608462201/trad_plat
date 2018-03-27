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
<form class="layui-form" action="#" method="post">
	<div class="layui-row" style="padding-top: 10px; padding-bottom: 5px;">
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
	</div>
	<hr>
	<input type="hidden" name="id" id="id" value="${loan.id }">
	<div class="layui-form-item">
		<label class="layui-form-label">产品：</label>
		<div class="layui-input-inline">
			<input type="hidden" name="productId" id="productId" value="${loan.productId }">
			<select name="productName" id="productName" lay-verify="required">
			</select>
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">借款人：</label>
		<div class="layui-input-block">
			<input type="text" name="loanPer" id="loanPer" value="${loan.loanPer }" placeholder=""
				autocomplete="off" class="layui-input">
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">借款人手机：</label>
		<div class="layui-input-block">
			<input type="text" name="loanMobile" id="loanMobile" value="${loan.loanMobile }"
				placeholder="" autocomplete="off" class="layui-input">
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">借款金额：</label>
		<div class="layui-input-block">
			<input type="text" name="loanMoney" id="loanMoney" value="${loan.loanMoney }" placeholder=""
				autocomplete="off" class="layui-input">
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">借款期限：</label>
		<div class="layui-input-block">
			<input type="text" name="loanLimit" id="loanLimit" value="${loan.loanLimit }" placeholder=""
				autocomplete="off" class="layui-input">
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">借款状态：</label>
		<div class="layui-input-block">
			<select name="loanStatus" id="loanStatus" value="${loan.loanStatus }" lay-verify="required">
			</select>
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">申请时间：</label>
		<div class="layui-input-block">
			<input type="text" name="applyTime" id="applyTime" value="${loan.applyTime }" placeholder=""
				autocomplete="off" class="layui-input">
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">客户名称：</label>
		<div class="layui-input-block">
			<input type="hidden" name="customerId" id="customerId" value="${loan.customerId }">
			<select name="customerName" id="customerName" lay-verify="required">
			</select>
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">客户经理名称：</label>
		<div class="layui-input-block">
			<input type="hidden" name="managerId" id="managerId" value="${loan.managerId }">
			<select name="managerName" id="managerName" lay-verify="required">
			</select>
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">借款抵押物：</label>
		<div class="layui-input-block">
			<input type="text" name="loanPawn" id="loanPawn" value="${loan.loanPawn }" placeholder=""
				autocomplete="off" class="layui-input">
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">抵押物地址：</label>
		<div class="layui-input-block">
			<input type="text" name="pawnAdd" id="pawnAdd" value="${loan.pawnAdd }" placeholder=""
				autocomplete="off" class="layui-input">
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">备注：</label>
		<div class="layui-input-block">
			<input type="text" name="remark" id="remark" value="${loan.remark }" placeholder=""
				autocomplete="off" class="layui-input">
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">申请时间：</label>
		<div class="layui-input-block">
			<input type="text" name="createTime" id="createTime" value="${loan.createTime }"
				placeholder="" autocomplete="off" class="layui-input">
		</div>
	</div>
</form>

<script>
	layui.use('form', function() {
		var form = layui.form;
		//initGroupSelect(form);

		var hasData = '${pro.id }';
		if (hasData != '') {
			$("input").attr("disabled", true);
			$("select").attr("disabled", true);
			$("button").hide();
			$("#edit").show();
		}

		$("#edit").on("click", function() {
			//js方法解除禁用
			$("input").removeAttr("disabled");
			$("select").removeAttr("disabled");
			$("button").show();
			$("#edit").hide();
			form.render('select');
		});
	});
	
	

	function initGroupSelect(form) {
		$.ajax({
			url : "${ctx}/common/getGGdmj?dmjbhs=payType,fxfs,payobj",
			dataType : "json",
			success : function(data) {
				var jsonData = eval(data);
				$.each(jsonData['payType'], function(index, val) {
					$("#payName").append(
							'<option value="'+val.dm+'">' + val.dmnr
									+ '</option>');
				});
				$.each(jsonData['fxfs'], function(index, val) {
					$("#punishtype").append(
							'<option value="'+val.dm+'">' + val.dmnr
									+ '</option>');
				});
				$.each(jsonData['payobj'], function(index, val) {
					$("#payobj").append(
							'<option value="'+val.dm+'">' + val.dmnr
									+ '</option>');
				});

				form.render('select');
			}
		});
	}
</script>
<%@ include file="/pages/common/footer.jsp"%>