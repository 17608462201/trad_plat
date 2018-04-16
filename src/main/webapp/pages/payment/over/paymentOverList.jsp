<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%  
     //页面标题设置
	request.setAttribute("pageTitle","还款列表");  
	//设置查询标题
	request.setAttribute("QUERY_TILE","还款人手机搜索内容");  
	//如果不需要公用的css,请使用下面代码 (默认是为true)
	request.setAttribute("SHOW_EDIT",true);  
	//request.setAttribute("INCLUDE_SKIN",false);
	//如果不需要公用的js,请使用下面代码 (默认是为true)
	//request.setAttribute("INCLUDE_COMMON",false);
	//如果不需要公用的css,请使用下面代码 (默认是为true)
	//request.setAttribute("INCLUDE_CSS",false);
%>
<%@ include file="/pages/common/header.jsp" %>
<div class="layui-form">
	<div class="layui-form-item">
		<label class="layui-form-label">产品</label>
		<div class="layui-input-inline">
			<select name="productName" id="productName" lay-verify="required">
			</select>
		</div>
		<div class="layui-input-inline">
			<button class="layui-btn" id="search" name="search"><i class="layui-icon">&#xe615;</i>搜索 </button>
		</div>
	</div>
</div>

<table class="layui-table" lay-data="{height:478,url:'${ctx }/paymentOvre/getPaymentOverList', page:true, limit:10, id:'tables'}" lay-filter="tree_filter">
  <thead>
    <tr>
      <th lay-data="{field:'loan_contract_no', width:160,sort: true}">合同编号</th>
      <th lay-data="{field:'customer_name', width:100,sort: true}">借款人</th>
      <th lay-data="{field:'loan_mobile', width:120,sort: true}">借款人手机号</th>
      <th lay-data="{field:'payment_name', width:100,sort: true}">还款人</th>
      <th lay-data="{field:'payment_contract', width:120,sort: true}">还款人手机号</th>
      <th lay-data="{field:'offer_money', width:100,sort: true}">放款金额（元）</th>
      <th lay-data="{field:'product_name', width:150,sort: true}">产品</th>
      <th lay-data="{field:'day', width:150,sort: true}">本期逾期（天）</th>
      <th lay-data="{field:'origin_pay', width:150,sort: true}">应还（元）</th>
      <th lay-data="{field:'money', width:150,sort: true}">罚息（元）</th>
      <th lay-data="{field:'sumMoney', width:150,sort: true}">合计（元）</th>
      <th lay-data="{field:'orgin_day', width:150,sort: true}">还款日</th>
      <th lay-data="{field:'manager_name', width:150,sort: true}">客户经理</th>
    </tr>
  </thead>
</table>
<script type="text/html" id="payDayTpl">
	
</script>
<script>
layui.use('table', function(){
  var table = layui.table
  ,form = layui.form;
  
  	getProductAll(form);
	$("#search").on("click",function() {
		var val = $("#filter").val();
		console.log($('#productName').val())
		//刷新表格
		  table.reload('tables', {
			  //encodeURI加密
			  url: '${ctx }/paymentOvre/getPaymentOverList?productId='+$('#productName').val()
		  });
	 });
});

</script>
<%@ include file="/pages/common/footer.jsp"%>