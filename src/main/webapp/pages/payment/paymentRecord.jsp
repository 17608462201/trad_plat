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
	<div class="layui-input-inline">
		<button class="layui-btn" id="refresh"><i class="layui-icon">&#x1002;</i>刷新</button>
	</div>
</div>

  
<table class="layui-table" lay-data="{height:478,url:'${ctx }/payment/paymentRecord?loanId=${loanId }', page:true, limit:10, id:'tables'}" lay-filter="tree_filter">
  <thead>
    <tr>
      <th lay-data="{checkbox:true, fixed: true}"></th>
      <th lay-data="{field:'contractId', width:160,sort: true}">合同编号</th>
      <th lay-data="{field:'loanPer', width:100,sort: true}">借款人</th>
      <th lay-data="{field:'loanPhone', width:120,sort: true}">手机</th>
      <th lay-data="{field:'paymentName', width:100, sort: true}">还款人</th>
      <th lay-data="{field:'paymentPhone', width:120, sort: true}">手机</th>
      <th lay-data="{field:'offerMoney', width:100, sort: true}">放款金额</th>
      <th lay-data="{field:'productName', width:150, sort: true}">贷款产品</th>
      <th lay-data="{field:'paymentMoney', width:150, sort: true}">应还金额</th>
      <th lay-data="{field:'defaultInter', width:100, sort: true}">罚息</th>
      <th lay-data="{field:'reallyPayment', width:100, sort: true}">实际还款金额</th>
      <th lay-data="{field:'paymentDayStr', width:150, sort: true}">还款日</th>
      <th lay-data="{field:'precentStr', width:150, sort: true}">已还/借款期数</th>
      <th lay-data="{field:'managerName', width:100, sort: true}">客户经理</th>
      <th lay-data="{field:'recordStatus', width:100,templet: '#checkboxTpl', unresize: true}">操作</th>
    </tr>
  </thead>
</table>
 <script type="text/html" id="checkboxTpl">
	{{ d.paymentStatus == 0 ? '<a class="layui-btn layui-btn-xs" lay-event="examine">确认还款</a>' : '' }}
</script>
<script type="text/html" id="payDayTpl">
	
</script>
<script>
layui.use('table', function(){
  var table = layui.table
  ,form = layui.form;
  //监听表格复选框选择
  table.on('checkbox(tree_filter)', function(obj){
  });
  
  //监听是否有效操作
  	form.on('switch(validFilter)', function(obj){
	    var tds = $(obj.elem).parent().parent().parent().children();
	    var id = tds[1].innerText.replace(/[\r\n]/g, "");
	    var dataVal = '';
	   	if(this.checked){
	   		dataVal = '1';
	   	}else{
	   	    dataVal = '0';
	   	}
	});
  
  $("#refresh").on("click",function(){
	  var val = $("#filter").val();
	  //刷新表格
	  table.reload('tables', {
		  url: '${ctx }/payment/paymentRecord?loandId='+$('#loanId').val()
		});
	});
   
   $("#check").on("click",function(){
		  var datas = table.checkStatus('tables').data;
		  if(datas.length>1){
	    	  layer.alert("不支持同时查看多行，请只选中一行！");
	      }else{
	    	  var ids = datas[0].id;
	    	  layer.open({
	              type: 2 //此处以iframe举例
	              ,title: '查看借款单'
	              ,area: ['800px', '650px']
	              ,shade: 0
	              ,maxmin: true
	              ,offset: [
	                   10
	              ] 
	              ,content: '${ctx}/payment/PaymentCheck?paymentId='+ids+"&type=EDIT"
	              ,btn: ['关闭']
		    	  ,zIndex: layer.zIndex //重点1
		          ,success: function(layero){
		            layer.setTop(layero); //重点2
		          }
	    	  })
	      }
	  })
   
     table.on('tool(tree_filter)', function(obj){
	    var data = obj.data;
	    if(obj.event === 'examine'){
	    	if(data.length>1){
		    	  layer.alert("不支持同时查看多行，请只选中一行！");
		      }else{
		    	  var ids = data.id;
		    	  layer.open({
		              type: 2 //此处以iframe举例
		              ,title: '查看还款信息'
		              ,area: ['800px', '500px']
		              ,shade: 0
		              ,maxmin: true
		              ,offset: [
		                   10
		              ] 
		              ,content: '${ctx}/payment/toUpPayment?paymentId='+ids+"&type=EDIT"
		              ,btn: ['提交','关闭']
		              ,yes: function(){
		            	  	var body = layer.getChildFrame('body', 0);
		            	  	var id=body.find('input[name="id"]').val();
			          		var reallyPayment=body.find('input[name="reallyPayment"]').val();
			          		var paymentTime=body.find('input[name="paymentTime"]').val();
			          		var paymentStatus=body.find('select[name="paymentStatus"]').find("option:selected").val();
			          		var paymentAdvance=body.find('input[name="paymentAdvance"]').val();
			          		var paymentWay=body.find('select[name="paymentWay"]').find("option:selected").text();
			          		var remark=body.find('input[name="remark"]').val();
			          		
			          		if(paymentTime==''){
			          			layer.msg("实际还款时间不能为空！");
			          			return false;
			          		}
			          		
			          		if(reallyPayment!=''){
			      				  if(isNaN(reallyPayment)){
			      					  layer.msg("实际还款金额必须为数字不包含小数点！");
			      					  return false;
			      				  }
			      			  }else{
			      				layer.msg("实际还款金额不能为空！");
			      				return false;
			      			  }
			          		
			          		if(paymentStatus=='请选择'){
			      				layer.msg("还款状态必须选择一项！");
			      				return false;
			      			  }
			          		
			          		
			          		if(paymentAdvance!=''){
			      				  if(isNaN(paymentAdvance)){
			      					  layer.msg("过桥垫资金额必须为数字不包含小数点！");
			      					  return false;
			      				  }
			      			  }
			          		
			          		if(paymentWay=='请选择'){
			      				layer.msg("还款方式必须选择一项！");
			      				return false;
			      			  }
			          		
			          		var json={"id":id,"reallyPayment":reallyPayment,"paymentTime":paymentTime,"paymentStatus":paymentStatus,"paymentAdvance":paymentAdvance,"paymentWay":paymentWay,"remark":remark};
			          		$.post("${ctx}/payment/upPayment?paymentTime="+paymentTime,json,function(text){
			             		  if(text=='200'){
			             			 layer.closeAll();
			  		          		 window.location.href ='${ctx }/payment/getPaymentByLoanId?loanId='+data.loanId;
			             		  }else{
			             			  layer.msg("确认还款信息出错！");
			             		  }
			          	    });
		              }
		    	  })
		      }
	    }
	})
});
</script>
<%@ include file="/pages/common/footer.jsp"%>