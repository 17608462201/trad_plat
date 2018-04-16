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

<table class="layui-table" lay-data="{height:478,url:'${ctx }/paymentAdvance/list', page:true, limit:10, id:'tables'}" lay-filter="tree_filter">
  <thead>
    <tr>
      <th lay-data="{field:'loan_contract_no', width:160,sort: true}">合同编号</th>
      <th lay-data="{field:'customer_name', width:100,sort: true}">借款人</th>
      <th lay-data="{field:'loan_mobile', width:120,sort: true}">借款人手机号</th>
      <th lay-data="{field:'payment_name', width:100, sort: true}">还款人</th>
      <th lay-data="{field:'payment_contract', width:120, sort: true}">还款人手机号</th>
      <th lay-data="{field:'offer_pound', width:120, sort: true}">放款金额（元）</th>
      <th lay-data="{field:'principals', width:120, sort: true}">累计还款（元）</th>
      <th lay-data="{field:'offer_limit', width:120, sort: true}">借款期限</th>
      <th lay-data="{field:'product_name', width:120, sort: true}">产品</th>
      <th lay-data="{field:'settle_time', width:120, sort: true}">结清时间</th>
      <th lay-data="{field:'remark', width:120, sort: true}">备注</th>
    </tr>
  </thead>
</table>
 <script type="text/html" id="checkboxTpl">
	<a class="layui-btn layui-btn-xs" lay-event="examine">修改备注</a>
</script>
<script type="text/html" id="payDayTpl">
	
</script>
<script>
layui.use('table', function(){
  var table = layui.table
  ,form = layui.form;
  $("#refresh").on("click",function(){
	  var val = $("#filter").val();
	  //刷新表格
	  table.reload('tables', {
		  url: '${ctx }/paymentAdvance/list?loanId='+$('#loanId').val()
		});
	});
});
</script>
<%@ include file="/pages/common/footer.jsp"%>