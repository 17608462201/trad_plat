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

<table class="layui-hide" id="test" lay-filter="test"></table>
<input type="hidden" id="loanId" name="loanId" value="${loanId }">
 <script type="text/html" id="checkboxTpl">
	{{ d.paymentStatus == 0 ? '<a class="layui-btn layui-btn-xs" lay-event="examine">确认还款</a>' : '' }}
</script>
<script type="text/html" id="payDayTpl">
	
</script>
<script>
layui.use('table', function(){
	var table = layui.table;
	  table.render({
	    elem: '#test'
	    ,url:'${ctx}/payment/getPaymentPlan?loanId='+$('#loanId').val()
	    ,cols: [[
	      {field:'plan_id', width:80, title: 'id'}
	      ,{field:'stage_number', width:80, title: '期数'}
	      ,{field:'paymentStatus', width:80, title: '还款状态'}
	      ,{field:'payment_time', width:120, title: '还款日', edit: 'text'}
	      ,{field:'principal', width:100, title: '本金（元）'}
	      ,{field:'interest', title: '利息（元）', width: 120} //minWidth：局部定义当前单元格的最小宽度，layui 2.2.1 新增
	      ,{field:'guarantee', title: '担保费（元）', width: 120}
	      ,{field:'service', title: '服务费（元）', width: 120}
	    ]]
	});
});
</script>
<%@ include file="/pages/common/footer.jsp"%>