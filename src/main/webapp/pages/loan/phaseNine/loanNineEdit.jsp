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
	<hr>
	<input type="hidden" id="receiptsId" name="receiptsId" value="${receiptsLoanOffer.receiptsId }">
	<div class="layui-row">
		<div class="layui-col-xs6">
			<div class="grid-demo grid-demo-bg1">
				<div class="layui-form-item">
					<label class="layui-form-label">保证金比例：</label>
					<div class="layui-input-block">
						<input type="text" name="bailScale" id="bailScale" value="${receiptsLoanOffer.receiptsBailScale }" placeholder=""
							autocomplete="off" class="layui-input">
					</div>
				</div>
			</div>
		</div>
		<div class="layui-col-xs6">
			<div class="grid-demo">
				<div class="layui-form-item">
					<label class="layui-form-label">保证金金额：</label>
					<div class="layui-input-block">
						<input type="text" name="bailMoney" id="bailMoney" value="${receiptsLoanOffer.receiptsBailMoney }" placeholder=""
							autocomplete="off" class="layui-input">
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="layui-row">
		<div class="layui-col-xs6">
			<div class="grid-demo grid-demo-bg1">
				<div class="layui-form-item">
					<label class="layui-form-label">评估费：</label>
					<div class="layui-input-block">
						<input type="text" name="evalueMoney" id="evalueMoney" value="${receiptsLoanOffer.receiptsEvalueMoney }" placeholder=""
							autocomplete="off" class="layui-input">
					</div>
				</div>
			</div>
		</div>
		<div class="layui-col-xs6">
			<div class="grid-demo">
				<div class="layui-form-item">
					<label class="layui-form-label">放款手续费：</label>
					<div class="layui-input-block">
						<input type="text" name="offerPound" id="offerPound" value="${receiptsLoanOffer.receiptsOfferPound }" placeholder=""
							autocomplete="off" class="layui-input">
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="layui-row">
		<div class="layui-col-xs6">
			<div class="grid-demo grid-demo-bg1">
				<div class="layui-form-item">
					<label class="layui-form-label">综合收费：</label>
					<div class="layui-input-block">
						<input type="text" name="zhMoney" id="zhMoney" value="${receiptsLoanOffer.receiptsZhMoney }" placeholder="" autocomplete="off" class="layui-input">
					</div>
				</div>
			</div>
		</div>
		<div class="layui-col-xs6">
			<div class="grid-demo">
				<div class="layui-form-item">
					<label class="layui-form-label">平台服务费：</label>
					<div class="layui-input-block">
						<input type="text" name="platMoney" id="platMoney" value="${receiptsLoanOffer.receiptsPlatMoney }" placeholder=""
							autocomplete="off" class="layui-input">
					</div>
				</div>
			</div>
		</div>
	</div>
<script>
	layui.use(['form','table'], function() {
		var form = layui.form;
	});
</script>
<%@ include file="/pages/common/footer.jsp"%>