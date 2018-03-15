<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%  
    //页面标题设置
	request.setAttribute("pageTitle","客户联系人列表");
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
<table class="layui-table" lay-data="{height:478,url:'${ctx }/customer/contractList?customerId=${customerId}',id:'tables'}" lay-filter="role_filter">
  <thead>
    <tr>
      <th lay-data="{field:'',checkbox:true, fixed: true}"></th>
       <th lay-data="{field:'id', width:80,sort: true}">ID</th>
      <th lay-data="{field:'name', width:100,sort: true,edit: 'text'}">姓名</th>
      <th lay-data="{field:'relation', width:100, sort: true,edit: 'text'}">关系</th>
      <th lay-data="{field:'mobile', width:150, sort: true,edit: 'text'}">电话号码</th>
      <th lay-data="{field:'companyName', width:250, sort: true,edit: 'text'}">公司名称</th>
      <th lay-data="{field:'companyAddress', width:250, sort: true,edit: 'text'}">公司地址</th>
      <th lay-data="{field:'address', width:250, sort: true,edit: 'text'}">住址</th>
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
    $.post("${ctx}/customer/contractModify",{"nId":data.id,"nFiled":obj.field,"nValue":obj.value},function(obj){
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
		  url: '${ctx }/customer/contractList?customerId=${customerId}'
		});
	});
  
  $("#delete").on("click",function(){
		  var datas = table.checkStatus('tables').data;
	      var customerIds = '';
	      for(i=0;i<datas.length;i++){
	    	  customerIds += datas[i].id+',';
	      }
	 	 if(customerIds!=''){
					 layer.confirm('确认删除联系人信息吗？', function(index){
						 $.ajax({
	   	         	     url: "${ctx}/customer/deleteContract?customerIds="+customerIds, 
	   	         	     dataType: "text", 
	   	         	     success: function(data){
	   	         	    	 if(data =='200'){
	   	         	    		layer.closeAll();
	   	         	    		window.location.href ='${ctx }/customer/contractEdit?customerId=${customerId}';
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
          ,title: '客户联系人信息'
          ,area: ['600px', '500px']
          ,shade: 0
          ,maxmin: true
          ,offset: [
            10
          ] 
          ,content: '${ctx}/customer/addContract?customerId=${customerId}'
          ,btn: ['保存', '关闭']
          ,yes: function(){
          	 var body = layer.getChildFrame('body', 0);
          	 var customerId = body.find('input[name="customerId"]').val();
          	 var name = body.find('input[name="name"]').val();
          	 var relation = body.find('select[name="relation"]').val();
          	 var mobile = body.find('input[name="mobile"]').val();
          	 var companyName = body.find('input[name="companyName"]').val();
          	var companyAddress = body.find('input[name="companyAddress"]').val();
          	var address = body.find('input[name="address"]').val();
          	  $.post("${ctx}/customer/saveCustomerContract",{"customerId":customerId,"name":name,"relation":relation,"mobile":mobile,"companyName":companyName,"companyAddress":companyAddress,"address":address},function(obj){
          		  layer.closeAll();
          		  window.location.href ='${ctx }/customer/contractEdit?customerId=${customerId}';
       	     });
          }
      });
	});
});
</script>
<%@ include file="/pages/common/footer.jsp"%>