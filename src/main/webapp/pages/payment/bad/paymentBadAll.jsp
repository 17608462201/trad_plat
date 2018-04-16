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

<table class="layui-table" lay-data="{height:478,url:'${ctx }/paymentBad/getListAll', page:true, limit:10, id:'tables'}" lay-filter="tree_filter">
  <thead>
    <tr>
      <th lay-data="{field:'loan_contract_no', width:160,sort: true}">合同编号</th>
      <th lay-data="{field:'customer_name', width:100,sort: true}">借款人</th>
      <th lay-data="{field:'loan_mobile', width:120,sort: true}">借款人手机号</th>
      <th lay-data="{field:'payment_name', width:100, sort: true}">还款人</th>
      <th lay-data="{field:'payment_contract', width:120, sort: true}">还款人手机号</th>
      <th lay-data="{field:'offer_money', width:120, sort: true}">放款金额（元）</th>
      <th lay-data="{field:'product_name', width:120, sort: true}">产品</th>
      <th lay-data="{field:'pay_time', width:120, sort: true}">还款日</th>
      <th lay-data="{field:'offer_limit', width:120, sort: true}">已还/借款期限</th>
      <th lay-data="{field:'status', width:120, sort: true}">坏账状态</th>
      <th lay-data="{field:'', width:100,templet: '#checkboxTpl', unresize: true}">操作</th>
    </tr>
  </thead>
</table>
 <script type="text/html" id="checkboxTpl">
	<a class="layui-btn layui-btn-xs" lay-event="examine">修改状态</a>
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
		  url: '${ctx }/paymentBad/getListAll'
		});
	});
  
  table.on('tool(tree_filter)', function(obj){
	    var data = obj.data;
	    if(obj.event === 'examine'){
	    	if(data.length>1){
		    	  layer.alert("不支持同时查看多行，请只选中一行！");
		      }else{
		    	  var ids = data.id;
		    	  layer.open({
		              type: 2 //此处以iframe举例
		              ,title: '查看借款单'
		              ,area: ['500px', '400px']
		              ,shade: 0
		              ,maxmin: true
		              ,offset: [
		                   10
		              ] 
		              ,content: '${ctx}/paymentBad/toUpdate?id='+ids+'&status='+data.bad_debt_status+'&isSettle='+data.is_settle
		              ,btn: ['保存','关闭']
			    	  ,yes: function(){
		            	  	var body = layer.getChildFrame('body', 0);
		            	  	var id=body.find('input[name="id"]').val();
		            	  	var badDebtStatus=body.find('input[name="bad_debt_status"]:checked').val();
		            	  	var isSettle=body.find('input[name="is_settle"]:checked').val();
		            	  	var remark=body.find('textarea[name="remark"]').val();
		            	  	
			          		var json={"id":id,"badDebtStatus":badDebtStatus,"isSettle":isSettle,"remark":remark};
			          		$.post("${ctx}/paymentBad/upLoanStatus",json,function(text){
			             		  if(text=='200'){
			             			 layer.closeAll();
			  		          		 window.location.href ='${ctx }/paymentBad/init?loanId='+$('#loanId').val();
			             		  }else{
			             			  layer.msg("保存借款信息出错！");
			             		  }
			          	    });
		              }
			    	  ,zIndex: layer.zIndex //重点1
			          ,success: function(layero){
			            layer.setTop(layero); //重点2
			          }
		    	  })
		      }
	    }
	})
});
</script>
<%@ include file="/pages/common/footer.jsp"%>