<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%  
     //页面标题设置
	request.setAttribute("pageTitle","菜单列表");  
	//设置查询标题
	request.setAttribute("QUERY_TILE","支持菜单名称/描述搜索内容");  
	//如果不需要公用的css,请使用下面代码 (默认是为true)
	request.setAttribute("SHOW_EDIT",true);  
	//request.setAttribute("INCLUDE_SKIN",false);
	//如果不需要公用的js,请使用下面代码 (默认是为true)
	//request.setAttribute("INCLUDE_COMMON",false);
	//如果不需要公用的css,请使用下面代码 (默认是为true)
	//request.setAttribute("INCLUDE_CSS",false);
%>
<%@ include file="/pages/common/header.jsp" %>
<%@ include file="/pages/common/listHeader.jsp" %>
<table class="layui-table" lay-data="{height:550,url:'${ctx }/loan/getList', page:true, limit:10, id:'tables'}" lay-filter="tree_filter">
  <thead>
    <tr>
      <th lay-data="{checkbox:true, fixed: true}"></th>
      <th lay-data="{field:'id', width:80}">借款ID</th>
      <th lay-data="{field:'productName', width:90}">产品名称</th>
      <th lay-data="{field:'loanPer', width:85}">借款人</th>
      <th lay-data="{field:'loanMobile', width:100}">借款人手机</th>
      <th lay-data="{field:'loanMoney', width:90}">借款金额</th>
      <th lay-data="{field:'loanLimit', width:90}">借款期限</th>
      <th lay-data="{field:'loanStatus', width:90}">借款状态</th>
      <th lay-data="{field:'applyTime', width:130}">申请时间</th>
      <th lay-data="{field:'customerName', width:90}">客户名称</th>
      <th lay-data="{field:'managerName', width:100}">客户经理名称</th>
      <th lay-data="{field:'loanPawn', width:100}">借款抵押物</th>
      <th lay-data="{field:'pawnAdd', width:100}">抵押物地址</th>
      <th lay-data="{field:'applyTime', width:130}">申请时间</th>
    </tr>
  </thead>
</table>
 <script type="text/html" id="checkboxTpl">
  <input type="checkbox" {{ d.recordStatus == 1 ? 'checked' : '' }} name="recordStatus" lay-skin="switch" lay-filter="validFilter" lay-text="是|否">
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
   	
    $.post("${ctx}/loan/getList",{"proID":id,"proFiled":this.name,"proValue":dataVal},function(obj){
  		 if(obj == "200"){
  			 layer.msg("设置产品是否有效成功！");
  		 }else{
  			 layer.msg("设置产品是否有效失败！");
  		 }
    });
});
  
//监听单元格编辑
  table.on('edit(tree_filter)', function(obj){
    data = obj.data; //得到所在行所有键值
   $.post("${ctx}/product/modify",{"proID":data.id,"proFiled":obj.field,"proValue":obj.value},function(obj){
	   		 if(obj == "200"){
	   			 layer.msg("数据更新成功！");
	   		 }else{
	   			 layer.msg("数据更新失败！");
	   		 }
	     });
  });
  
  $("#refresh").on("click",function(){
	  var val = $("#filter").val();
	  //刷新表格
	  table.reload('tables', {
		  url: '${ctx }/loan/getList?filter='+encodeURI(encodeURI(val))
		});
	});
  
  $("#delete").on("click",function(){
		  //删除表格
		  var datas = table.checkStatus('tables').data;
	      var loanId = '';
	      for(i=0;i<datas.length;i++){
	    	  loanId += datas[i].id+',';
	      }
	 	 if(loanId!=''){
					 layer.confirm('确认删除么？', function(index){
						 $.ajax({
	   	         	     url: "${ctx}/loan/delLoan?loanId="+loanId, 
	   	         	     dataType: "text", 
	   	         	     success: function(data){
	   	         	    	 if(data =='200'){
	   	         	    		layer.closeAll();
	   	         	    		window.location.href ='${ctx }/product/init';
	   	         	    	 }else{
	   	         	    		 layer.msg("删除产品信息失败，请重试！");
	   	         	    	 }
	   	         	     }
	   	         	 });
					 });
	 	 }else{
	 		 layer.alert("你未选中任何行！");
	 	 }
	});
  
  $("#edit").on("click",function(){
	  //删除表格
	  var datas = table.checkStatus('tables').data;
	  if(datas.length>1){
    	  layer.alert("不支持同时编辑多行，请只选中一行！");
      }else{
    	  var ids = datas[0].id;
    	  //新增
    	  layer.open({
              type: 2 //此处以iframe举例
              ,title: '修改借款'
              ,area: ['650px', '600px']
              ,shade: 0
              ,maxmin: true
              ,offset: [
                   10
              ] 
              ,content: '${ctx}/loan/editLoan?loanId='+ids+"&type=EDIT"
       });
 	 }
});
  
  $("#add").on("click",function(){
		//新增
		layer.open({
              type: 2 //此处以iframe举例
              ,title: '修改借款'
              ,area: ['850px', '600px']
              ,shade: 0
              ,maxmin: true
              ,offset: [
                   10
              ] 
              ,content: '${ctx}/loan/addLoan'
              ,btn: ['保存', '关闭']
        	  ,yes: function(){
        		  var body = layer.getChildFrame('body', 0);
        		  var productId=body.find('select[name="productName"]').val();
        		  var productName=body.find('select[name="productName"]').text();
      			  var managerId=body.find('input[name="managerId"]').val();
      			  var managerName=body.find('input[name="managerName"]').val();
      			  var loadType=body.find('select[name="loadType"]').val();
      			  var customerId=body.find('select[name="customerName"]').text();
      			  var customerName=body.find('select[name="customerName"]').val();
      			  var loanMobile=body.find('input[name="loanMobile"]').val();
      			  var paymentName=body.find('input[name="paymentName"]').val();
      			  var paymentContract=body.find('input[name="paymentContract"]').val();
      			  var bailScale=body.find('input[name="bailScale"]').val();
      			  var bailMoney=body.find('input[name="bailMoney"]').val();
      			  var evalueMoney=body.find('input[name="evalueMoney"]').val();
      			  var offerPound=body.find('input[name="offerPound"]').val();
      			  var zhMoney=body.find('input[name="zhMoney"]').val();
      			  var platMoney=body.find('input[name="platMoney"]').val();
      			  var offerDay=body.find('input[name="offerDay"]').val();
      			  var offerMoney=body.find('input[name="offerMoney"]').val();
      			  var monthScale=body.find('input[name="monthScale"]').val();
      			  var firstPayment=body.find('input[name="firstPayment"]').val();
      			  var lastPayment=body.find('input[name="lastPayment"]').val();
      			  var offerLimit=body.find('input[name="offerLimit"]').val();
      			  var monthSerc=body.find('input[name="monthSerc"]').val();
				  var jsonObj = {"productId":productId,"productName":productName,"managerId":managerId,"loadType":loadType,"customerId":customerId,"customerName":customerName,"loanMobile":loanMobile,"paymentName":paymentName,
					"paymentContract":paymentContract,"bailScale":bailScale,"bailMoney":bailMoney,"evalueMoney":evalueMoney,"offerPound":offerPound,
					"zhMoney":zhMoney,"platMoney":platMoney,"offerDay":offerDay,"offerMoney":offerMoney,"monthScale":monthScale,"firstPayment":firstPayment,
					"lastPayment":lastPayment,"offerLimit":offerLimit,"monthSerc":monthSerc};
        		  $.post("${ctx}/loan/saveLoan",jsonObj,function(text){
	          		  if(text=='200'){
	          			layer.closeAll();
		          		  window.location.href ='${ctx }/loan/init';
	          		  }else{
	          			  layer.msg("保存借款信息出错！");
	          		  }
	       	     });
        	  }
       	});
	});

  /*$("#search").on("click",function() {
		var val = $("#filter").val();
		//刷新表格
		  table.reload('tables', {
			  //encodeURI加密
			  url: '${ctx }/product/list?filter='+encodeURI(encodeURI(val))
		  });
	 });*/
   
});
</script>
<%@ include file="/pages/common/footer.jsp"%>