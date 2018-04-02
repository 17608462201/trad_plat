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
				<label class="layui-form-label">借款单编号：</label>
				<div class="layui-input-inline">
					${map.load_id }
				</div>
			</div>
		</div>
	</div>
	<div class="layui-col-xs6">
		<div class="grid-demo grid-demo-bg1">
			<div class="layui-form-item">
				<label class="layui-form-label">还款人姓名：</label>
				<div class="layui-input-inline">
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
				<label class="layui-form-label">还款人联系方式：</label>
				<div class="layui-input-inline">
					${map.payment_contract }
				</div>
			</div>
		</div>
	</div>
	<div class="layui-col-xs6">
		<div class="grid-demo grid-demo-bg1">
			<div class="layui-form-item">
				<label class="layui-form-label">保证金比例：</label>
				<div class="layui-input-inline">
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
				<label class="layui-form-label">保证金金额：</label>
				<div class="layui-input-inline">
					${map.bail_money }
				</div>
			</div>
		</div>
	</div>
	<div class="layui-col-xs6">
		<div class="grid-demo grid-demo-bg1">
			<div class="layui-form-item">
				<label class="layui-form-label">评估费：</label>
				<div class="layui-input-inline">
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
				<label class="layui-form-label">放款手续费：</label>
				<div class="layui-input-inline">
					${map.offer_pound }
				</div>
			</div>
		</div>
	</div>
	<div class="layui-col-xs6">
		<div class="grid-demo grid-demo-bg1">
			<div class="layui-form-item">
				<label class="layui-form-label">综合收费：</label>
				<div class="layui-input-inline">
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
				<label class="layui-form-label">平台服务费：</label>
				<div class="layui-input-inline">
					${map.plat_money }
				</div>
			</div>
		</div>
	</div>
	<div class="layui-col-xs6">
		<div class="grid-demo grid-demo-bg1">
			<div class="layui-form-item">
				<label class="layui-form-label">放款日：</label>
				<div class="layui-input-inline">
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
				<label class="layui-form-label">放款金额：</label>
				<div class="layui-input-inline">
					${map.offer_money }
				</div>
			</div>
		</div>
	</div>
	<div class="layui-col-xs6">
		<div class="grid-demo grid-demo-bg1">
			<div class="layui-form-item">
				<label class="layui-form-label">借款利率%（月）：</label>
				<div class="layui-input-inline">
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
				<label class="layui-form-label">首个还款日：</label>
				<div class="layui-input-inline">
					${map.first_payment }
				</div>
			</div>
		</div>
	</div>
	<div class="layui-col-xs6">
		<div class="grid-demo grid-demo-bg1">
			<div class="layui-form-item">
				<label class="layui-form-label">放款期限（期）：</label>
				<div class="layui-input-inline">
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
				<label class="layui-form-label">月应缴担保费（元）：</label>
				<div class="layui-input-inline">
					${map.month_serc }
				</div>
			</div>
		</div>
	</div>
</div>
<input type="hidden" value="${map.load_id }" name="loanId" id="loanId">
<table class="layui-hide" id="test" lay-filter="test"></table>

<script>
layui.use(['element','table'], function(){
  var element = layui.element; //Tab的切换功能，切换事件监听等，需要依赖element模块
  var $ = layui.jquery
  var layid = location.hash.replace(/^#customerTab=/, '');
  element.tabChange('customerTab', layid);
  element.on('tab(customerTab)', function(data){
	  location.hash = 'customerTab='+ $(this).attr('lay-id');
	  var iframe=$(data.elem).find("iframe").eq(data.index);
// 	 if(data.index == 2 || data.index ==3){
// 		  var iframeSrc=$(iframe[0]).attr("src");
// 		  console.log(iframeSrc);
//           $(iframe[0]).attr("src",iframeSrc);
// 	  }
	});
  
  var table = layui.table;
  table.render({
	    elem: '#test'
	    ,url:'${ctx}/loanPhaseFour/getPlanAll?loanId='+$('#loanId').val()
	    ,cols: [[
	      {field:'planId', width:80, title: 'id'}
	      ,{field:'stageNumber', width:80, title: '期数'}
	      ,{field:'paymentTime', width:120, title: '还款日', edit: 'text'}
	      ,{field:'principal', width:100, title: '本金（元）'}
	      ,{field:'interest', title: '利息（元）', width: 120} //minWidth：局部定义当前单元格的最小宽度，layui 2.2.1 新增
	      ,{field:'guarantee', title: '担保费（元）', width: 120}
	      ,{field:'service', title: '服务费（元）', width: 120}
	    ]]
	});
});	
</script>
<%@ include file="/pages/common/footer.jsp"%>