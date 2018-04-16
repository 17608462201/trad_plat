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

<div class="layui-form-item">
	<input type="hidden" id="loanId" name="loanId" value="${loanId }">
</div>
  
<table class="layui-table" lay-data="{height:478,url:'${ctx }/paymentOvre/getList?loanId=${loanId }', page:true, limit:10, id:'tables'}" lay-filter="tree_filter">
  <thead>
    <tr>
      <th lay-data="{field:'pay_num', width:160,sort: true}">期数</th>
      <th lay-data="{field:'pay_day', width:100,sort: true}">应还款日</th>
      <th lay-data="{field:'orgin_day', width:120,sort: true}">实际还款日</th>
      <th lay-data="{field:'overdue', width:100, sort: true}">逾期天数</th>
      <th lay-data="{field:'origin_pay', width:120, sort: true}">本期应还</th>
      <th lay-data="{field:'default_inter', width:100, sort: true}">罚息（元）</th>
      <th lay-data="{field:'sum_money', width:150, sort: true}">合计（元）</th>
      <th lay-data="{field:'remark', width:150, sort: true}">备注</th>
      <th lay-data="{field:'recordStatus', width:100,templet: '#checkboxTpl', unresize: true}">操作</th>
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
		  url: '${ctx }paymentOvre/getList?loanId='+$('#loanId').val()
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
		              ,area: ['400px', '400px']
		              ,shade: 0
		              ,maxmin: true
		              ,offset: [
		                   10
		              ] 
		              ,content: '${ctx}/paymentOvre/getPaymentByLoanId?id='+ids
		              ,btn: ['提交','关闭']
		              ,yes: function(){
		            	  var body = layer.getChildFrame('body', 0);
		            	  var id=body.find('input[name="id"]').val();
		            	  var remark=body.find('textarea[name="remark"]').val();
		            	  var json={"paymentOverId":id, "remark":remark}
		            	  $.post("${ctx}/paymentOvre/upPayment",json,function(text){
			             		 if(text=='200'){
			             			layer.closeAll();
			  		          		window.location.href ='${ctx }/paymentOvre/init?loanId='+data.loan_id;
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