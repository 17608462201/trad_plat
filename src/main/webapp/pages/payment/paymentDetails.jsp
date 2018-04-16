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
<input type="hidden" id="loanId" name="loanId" value="${loanId }">
<table class="layui-table" lay-data="{height:478,url:'${ctx }/payment/getPaymentDetails?loanId=${loanId }', page:true, limit:10, id:'tables'}" lay-filter="tree_filter">
  <thead>
    <tr>
      <th lay-data="{checkbox:true, fixed: true}"></th>
      <th lay-data="{field:'payment_num', width:160,sort: true}">期数</th>
      <th lay-data="{field:'payment_day', width:100,sort: true}">还款日</th>
      <th lay-data="{field:'payment_time', width:120,sort: true}">实际还款时间</th>
      <th lay-data="{field:'payment_money', width:100, sort: true}">应还金额（元）</th>
      <th lay-data="{field:'default_inter', width:120, sort: true}">罚息（元）</th>
      <th lay-data="{field:'really_payment', width:100, sort: true}">实际还款金额（元）</th>
      <th lay-data="{field:'payment_advance', width:150, sort: true}">垫资还款单号</th>
      <th lay-data="{field:'paymentStatus', width:150, sort: true}">还款状态</th>
      <th lay-data="{field:'handler_name', width:100, sort: true}">操作员</th>
      <th lay-data="{field:'remark', width:100, sort: true}">备注</th>
      <th lay-data="{field:'recordStatus', width:100,templet: '#checkboxTpl', unresize: true}">操作</th>
    </tr>
  </thead>
</table>
 <script type="text/html" id="checkboxTpl">
	<a class="layui-btn layui-btn-xs" lay-event="examine">修改备注</a>
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
		  url: '${ctx }/payment/getPaymentDetails?loandId='+$('#loanId').val()
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
		              ,title: '查看借款单'
		              ,area: ['800px', '500px']
		              ,shade: 0
		              ,maxmin: true
		              ,offset: [
		                   10
		              ] 
		              ,content: '${ctx}/payment/toUpRemark?paymentId='+ids+"&loanId="+$('#loanId').val()
		              ,btn: ['提交','关闭']
		              ,yes: function(){
		            	  	var body = layer.getChildFrame('body', 0);
		            	  	var id=body.find('input[name="id"]').val();
		            	  	var loanId=body.find('input[name="loanId"]').val();
			          		var remark=body.find('textarea[name="remark"]').val();
			          		
			          		var json={"id":id,"remark":remark};
			          		$.post("${ctx}/payment/upPaymentRemark",json,function(text){
			             		  if(text=='200'){
			             			 layer.closeAll();
			  		          		 window.location.href ='${ctx }/payment/paymentDetails?loanId='+loanId;
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