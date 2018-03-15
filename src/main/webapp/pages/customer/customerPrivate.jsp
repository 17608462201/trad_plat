<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%  
    //页面标题设置
	request.setAttribute("pageTitle","客户私营业主列表");
    //设置查询标题
    //request.setAttribute("QUERY_TILE","支持角色名搜索内容");  
	//如果不需要公用的css,请使用下面代码 (默认是为true)
	//request.setAttribute("INCLUDE_SKIN",false);
	//如果不需要公用的js,请使用下面代码 (默认是为true)
	//request.setAttribute("INCLUDE_COMMON",false);
	//如果不需要公用的css,请使用下面代码 (默认是为true)
	//request.setAttribute("INCLUDE_CSS",false);
%>
<%@ include file="/pages/common/header.jsp" %>
<%@ include file="/pages/common/listHeaderNoSearch.jsp" %>
<table class="layui-table" lay-data="{height:478,url:'${ctx }/customer/privateList?customerId=${customerId}',id:'tables'}" lay-filter="role_filter">
  <thead>
    <tr>
      <th lay-data="{field:'',checkbox:true, fixed: true}"></th>
       <th lay-data="{field:'id', width:50,sort: true}">ID</th>
      <th lay-data="{field:'companyName', width:200,sort: true,edit: 'text'}">企业名称</th>
      <th lay-data="{field:'persionHold', width:150, sort: true,edit: 'text'}">个人持股比</th>
      <th lay-data="{field:'registerTimeStr', width:100, sort: true,edit: 'text'}">注册时间</th>
      <th lay-data="{field:'companyType', width:100, sort: true,edit: 'text'}">企业性质</th>
      <th lay-data="{field:'address', width:200, sort: true,edit: 'text'}">经营场所</th>
      <th lay-data="{field:'staffNum', width:100, sort: true,edit: 'text'}">员工数量</th>
      <th lay-data="{field:'companyAddress', width:200, sort: true,edit: 'text'}">企业地址</th>
    </tr>
  </thead>
</table>
<script>
layui.use('table', function(){
  var table = layui.table;
  //监听表格复选框选择
  table.on('checkbox(role_filter)', function(obj){
  });
  
//监听单元格编辑
  table.on('edit(role_filter)', function(obj){
	data = obj.data; //得到所在行所有键值
    $.post("${ctx}/customer/privateModify",{"nId":data.id,"nFiled":obj.field,"nValue":obj.value},function(obj){
	   		 if(obj == "200"){
	   			 layer.msg("数据更新成功！");
	   		 }else{
	   			 layer.msg("数据更新失败！");
	   		 }
	     });
  });
  
  
  $("#refresh").on("click",function(){
	  //刷新表格
	  table.reload('tables', {
		  url: '${ctx }/customer/privateList?customerId=${customerId}'
		});
	});
  
  $("#delete").on("click",function(){
		  var datas = table.checkStatus('tables').data;
	      var customerIds = '';
	      for(i=0;i<datas.length;i++){
	    	  customerIds += datas[i].id+',';
	      }
	 	 if(customerIds!=''){
					 layer.confirm('确认删除么私营业主信息吗？', function(index){
						 $.ajax({
	   	         	     url: "${ctx}/customer/deletePrivate?customerIds="+customerIds, 
	   	         	     dataType: "text", 
	   	         	     success: function(data){
	   	         	    	 if(data =='200'){
	   	         	    		layer.closeAll();
	   	         	    		window.location.href ='${ctx }/customer/privateEdit?customerId=${customerId}';
	   	         	    	 }else{
	   	         	    		 layer.msg("删除角色信息失败，请重试！");
	   	         	    	 }
	   	         	     }
	   	         	 });
					 });
	 	 }else{
	 		 layer.alert("你未选中任何行！");
	 	 }
   });
  
  $("#add").on("click",function(){
		  //新增
	  layer.open({
          type: 2 //此处以iframe举例
          ,title: '客户私营业主信息'
          ,area: ['600px', '500px']
          ,shade: 0
          ,maxmin: true
          ,offset: [
            10
          ] 
          ,content: '${ctx}/customer/addPrivate?customerId=${customerId}'
          ,btn: ['保存', '关闭']
          ,yes: function(){
          	 var body = layer.getChildFrame('body', 0);
          	 var customerId = body.find('input[name="customerId"]').val();
          	 var companyName = body.find('input[name="companyName"]').val();
          	 var persionHold = body.find('input[name="persionHold"]').val();
          	 var registerTime = body.find('input[name="registerTime"]').val();
          	 var companyType = body.find('select[name="companyType"]').val();
          	var address = body.find('input[name="address"]').val();
          	var staffNum = body.find('input[name="staffNum"]').val();
          	var companyAddress = body.find('input[name="companyAddress"]').val();
          	  $.post("${ctx}/customer/saveCustomerPrivate",{"customerId":customerId,"companyName":companyName,"persionHold":persionHold,"registerTime":registerTime,"companyType":companyType,"companyAddress":companyAddress,"address":address,"staffNum":staffNum},function(obj){
          		  layer.closeAll();
          		  window.location.href ='${ctx }/customer/privateEdit?customerId=${customerId}';
       	     });
          }
      });
	});
   
});
</script>
<%@ include file="/pages/common/footer.jsp"%>