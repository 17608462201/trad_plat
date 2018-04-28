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
<div class="layui-row">
	<div class="layui-col-xs6">
		<div class="grid-demo grid-demo-bg1">
			<div class="layui-form-item">
				<label class="layui-form-label" style="width: 120px;">产品：</label>
				<div class="layui-input-inline" style="margin-top: 10px;">
					${map.product_name }
				</div>
			</div>
		</div>
	</div>
	<div class="layui-col-xs6">
		<div class="grid-demo grid-demo-bg1">
			<div class="layui-form-item">
				<label class="layui-form-label" style="width: 120px;">客户经理：</label>
				<div class="layui-input-inline" style="margin-top: 10px;">
					${map.manager_name }
				</div>
			</div>
		</div>
	</div>
</div>
<div class="layui-row">
	<div class="layui-col-xs6">
		<div class="grid-demo grid-demo-bg1">
			<div class="layui-form-item">
				<label class="layui-form-label" style="width: 120px;">类型：</label>
				<div class="layui-input-inline" style="margin-top: 10px;">
					${map.load_type }
				</div>
			</div>
		</div>
	</div>
</div>

<div class="layui-row">
	<div class="layui-col-xs6">
		<div class="grid-demo grid-demo-bg1">
			<div class="layui-form-item">
				<label class="layui-form-label" style="width: 120px;">借款单编号：</label>
				<div class="layui-input-inline" style="margin-top: 10px;">
					${map.load_id }
				</div>
			</div>
		</div>
	</div>
	<div class="layui-col-xs6">
		<div class="grid-demo grid-demo-bg1">
			<div class="layui-form-item">
				<label class="layui-form-label" style="width: 120px;">还款人姓名：</label>
				<div class="layui-input-inline" style="margin-top: 10px;">
					${map.payment_name }
				</div>
			</div>
		</div>
	</div>
</div>

<div class="layui-row">
	<div class="layui-col-xs6">
		<div class="grid-demo grid-demo-bg1">
			<div class="layui-form-item">
				<label class="layui-form-label" style="width: 120px;">还款人联系方式：</label>
				<div class="layui-input-inline" style="margin-top: 10px;">
					${map.payment_contract }
				</div>
			</div>
		</div>
	</div>
	<div class="layui-col-xs6">
		<div class="grid-demo grid-demo-bg1">
			<div class="layui-form-item">
				<label class="layui-form-label" style="width: 120px;">保证金比例：</label>
				<div class="layui-input-inline" style="margin-top: 10px;">
					${map.bail_scale }
				</div>
			</div>
		</div>
	</div>
</div>

<div class="layui-row">
	<div class="layui-col-xs6">
		<div class="grid-demo grid-demo-bg1">
			<div class="layui-form-item">
				<label class="layui-form-label" style="width: 120px;">保证金金额：</label>
				<div class="layui-input-inline" style="margin-top: 10px;">
					${map.bail_money }
				</div>
			</div>
		</div>
	</div>
	<div class="layui-col-xs6">
		<div class="grid-demo grid-demo-bg1">
			<div class="layui-form-item">
				<label class="layui-form-label" style="width: 120px;">评估费：</label>
				<div class="layui-input-inline" style="margin-top: 10px;">
					${map.evalue_money }
				</div>
			</div>
		</div>
	</div>
</div>

<div class="layui-row">
	<div class="layui-col-xs6">
		<div class="grid-demo grid-demo-bg1">
			<div class="layui-form-item">
				<label class="layui-form-label" style="width: 120px;">放款手续费：</label>
				<div class="layui-input-inline" style="margin-top: 10px;">
					${map.offer_pound }
				</div>
			</div>
		</div>
	</div>
	<div class="layui-col-xs6">
		<div class="grid-demo grid-demo-bg1">
			<div class="layui-form-item">
				<label class="layui-form-label" style="width: 120px;">综合收费：</label>
				<div class="layui-input-inline" style="margin-top: 10px;">
					${map.zh_money }
				</div>
			</div>
		</div>
	</div>
</div>

<div class="layui-row">
	<div class="layui-col-xs6">
		<div class="grid-demo grid-demo-bg1">
			<div class="layui-form-item">
				<label class="layui-form-label" style="width: 120px;">平台服务费：</label>
				<div class="layui-input-inline" style="margin-top: 10px;">
					${map.plat_money }
				</div>
			</div>
		</div>
	</div>
	<div class="layui-col-xs6">
		<div class="grid-demo grid-demo-bg1">
			<div class="layui-form-item">
				<label class="layui-form-label" style="width: 120px;">放款日：</label>
				<div class="layui-input-inline" style="margin-top: 10px;">
					${map.offer_day }
				</div>
			</div>
		</div>
	</div>
</div>

<div class="layui-row">
	<div class="layui-col-xs6">
		<div class="grid-demo grid-demo-bg1">
			<div class="layui-form-item">
				<label class="layui-form-label" style="width: 120px;">放款金额：</label>
				<div class="layui-input-inline" style="margin-top: 10px;">
					${map.offer_money }
				</div>
			</div>
		</div>
	</div>
	<div class="layui-col-xs6">
		<div class="grid-demo grid-demo-bg1">
			<div class="layui-form-item">
				<label class="layui-form-label" style="width: 120px;">借款利率%（月）：</label>
				<div class="layui-input-inline" style="margin-top: 10px;">
					${map.month_scale }
				</div>
			</div>
		</div>
	</div>
</div>

<div class="layui-row">
	<div class="layui-col-xs6">
		<div class="grid-demo grid-demo-bg1">
			<div class="layui-form-item">
				<label class="layui-form-label" style="width: 120px;">首个还款日：</label>
				<div class="layui-input-inline" style="margin-top: 10px;">
					${map.first_payment }
				</div>
			</div>
		</div>
	</div>
	<div class="layui-col-xs6">
		<div class="grid-demo grid-demo-bg1">
			<div class="layui-form-item">
				<label class="layui-form-label" style="width: 120px;">放款期限（期）：</label>
				<div class="layui-input-inline" style="margin-top: 10px;">
					${map.offer_limit }
				</div>
			</div>
		</div>
	</div>
</div>

<div class="layui-row">
	<div class="layui-col-xs6">
		<div class="grid-demo grid-demo-bg1">
			<div class="layui-form-item">
				<label class="layui-form-label" style="width: 120px;">月应缴担保费（元）：</label>
				<div class="layui-input-inline" style="margin-top: 10px;">
					${map.month_serc }
				</div>
			</div>
		</div>
	</div>
</div>
<input type="hidden" value="${map.load_id }" name="loanId" id="loanId">

<div class="layui-row">
	<div class="layui-col-xs6">
		<div class="grid-demo grid-demo-bg1">
			<div class="layui-form-item">
				
			</div>
		</div>
	</div>
</div>
<script>
layui.use(['element','table'], function(){
  var element = layui.element; //Tab的切换功能，切换事件监听等，需要依赖element模块
  var $ = layui.jquery
  var layid = location.hash.replace(/^#customerTab=/, '');
  element.tabChange('customerTab', layid);
  element.on('tab(customerTab)', function(data){
	  location.hash = 'customerTab='+ $(this).attr('lay-id');
	  var iframe=$(data.elem).find("iframe").eq(data.index);
	});
});	
</script>
<%@ include file="/pages/common/footer.jsp"%>