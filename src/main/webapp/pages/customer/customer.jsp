<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%  
     //页面标题设置
	request.setAttribute("pageTitle","客户管理");  
	//设置查询标题
	request.setAttribute("QUERY_TILE","支持客户名称/手机/省份/市区搜索内容");  
	request.setAttribute("NEED_ADD_BUT",false);
	//如果不需要公用的css,请使用下面代码 (默认是为true)
	//request.setAttribute("INCLUDE_SKIN",false);
	//如果不需要公用的js,请使用下面代码 (默认是为true)
	//request.setAttribute("INCLUDE_COMMON",false);
	//如果不需要公用的css,请使用下面代码 (默认是为true)
	//request.setAttribute("INCLUDE_CSS",false);
%>
<%@ include file="/pages/common/header.jsp" %>
<style type="text/css">
  .layui-table-cell .layui-form-checkbox[lay-skin=primary]{
        top: 5px;
    }
</style>
  <div class="layui-row">
    <div class="layui-col-xs6">
		      <div class="grid-demo grid-demo-bg1">
		      <div class="layui-form-item">
		    <div class="layui-input-inline"style="width: 250px;padding-left: 5px;">
		        <input type="text" id="filter" name="filter" value="" lay-verify="" placeholder="${requestScope.QUERY_TILE }" autocomplete="off" class="layui-input">
		    </div>
		    <div class="layui-input-inline">
		        <button class="layui-btn" id="search" name="search"><i class="layui-icon">&#xe615;</i>搜索 </button>
		    </div>
     </div>
    </div>
    </div>
    <div class="layui-col-xs6">
      <div class="grid-demo">
       <div class="layui-form-item">
  	 		<button class="layui-btn layui-btn-danger" id="add"><i class="layui-icon">&#xe654;</i>添加</button>
  	 		<button class="layui-btn" id="edit"><i class="layui-icon">&#xe642;</i>编辑</button>
			<button class="layui-btn layui-btn-danger" id="delete"><i class="layui-icon">&#xe640;</i>删除 </button>
			<button class="layui-btn" id="refresh"><i class="layui-icon">&#x1002;</i>刷新</button>
      </div>
    </div>
  </div>
  </div>
<table class="layui-table" lay-data="{height:478,url:'${ctx }/customer/list', page:true, limit:10, id:'tables'}" lay-filter="customer_filter">
  <thead>
    <tr>
      <th lay-data="{checkbox:true, fixed: true}"></th>
      <th lay-data="{field:'id', width:100,sort: true}">客户ID</th>
      <th lay-data="{field:'name', width:100,sort: true,edit: 'text'}">客户名称</th>
      <th lay-data="{field:'mobile', width:150,sort: true,edit: 'text'}">客户手机</th>
      <th lay-data="{field:'province', width:100, sort: true,edit: 'text'}">省份</th>
      <th lay-data="{field:'city', width:130, sort: true,edit: 'text'}">市/区</th>
      <th lay-data="{field:'manager', width:100, sort: true,edit: 'text'}">客户经理</th>
      <th lay-data="{field:'record', width:110, sort: true,edit: 'text'}">最高学历</th>
      <th lay-data="{field:'marry', width:110, sort: true,edit: 'text'}">婚姻状态</th>
      <th lay-data="{field:'liveAddress', width:300, sort: true,edit: 'text'}">住宅地址</th>
      <th lay-data="{field:'recordStatus', width:100,templet: '#checkboxTpl', unresize: true}">是否有效</th>
     <!-- <th lay-data="{fixed: 'right', width:100, align:'center', toolbar: '#barDemo'}"></th> -->
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
  table.on('checkbox(customer_filter)', function(obj){
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
   	
    $.post("${ctx}/customer/modify",{"nID":id,"nFiled":this.name,"nValue":dataVal},function(obj){
  		 if(obj == "200"){
  			 layer.msg("设置菜单树是否有效成功！");
  		 }else{
  			 layer.msg("设置菜单树是否有效失败！");
  		 }
    });
});
  
//监听单元格编辑
  table.on('edit(customer_filter)', function(obj){
    data = obj.data; //得到所在行所有键值
   $.post("${ctx}/customer/modify",{"nID":data.id,"nFiled":obj.field,"nValue":obj.value},function(obj){
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
		  url: '${ctx }/customer/list?filter='+encodeURI(encodeURI(val))
		});
	});
  
  $("#delete").on("click",function(){
		  //删除表格
		  var datas = table.checkStatus('tables').data;
	      var ids = '';
	      for(i=0;i<datas.length;i++){
	    	  ids += datas[i].id+',';
	      }
	 	 if(ids!=''){
					 layer.confirm('确认删除么？确认后用户工作信息，联系人信息，私营信息也会被删除！', function(index){
						 $.ajax({
	   	         	     url: "${ctx}/customer/deleteCustomer?ids="+ids, 
	   	         	     dataType: "text", 
	   	         	     success: function(data){
	   	         	    	 if(data =='200'){
	   	         	    		layer.closeAll();
	   	         	    		window.location.href ='${ctx }/customer/init';
	   	         	    	 }else{
	   	         	    		 layer.msg("删除客户信息失败，请重试！");
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
	          ,title: '新增用户'
	          ,area: ['1000px', '600px']
	          ,shade: 0
	          ,maxmin: true
	          ,offset: [
	               10
	          ] 
	          ,content: '${ctx}/customer/add'
	          ,btn: ['确定', '关闭']
	          ,yes: function(){
         		  layer.closeAll();
         		  window.location.href ='${ctx }/customer/init';
	         }
	   });
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
              ,title: '新增用户'
              ,area: ['1000px', '600px']
              ,shade: 0
              ,maxmin: true
              ,offset: [
                   10
              ] 
              ,content: '${ctx}/customer/add?customerId='+ids
       });
      }
});

   $("#search").on("click",function() {
		var val = $("#filter").val();
		//刷新表格
		  table.reload('tables', {
			  //encodeURI加密
			  url: '${ctx }/customer/list?filter='+encodeURI(encodeURI(val))
		  });
	 });
   
});
</script>
<%@ include file="/pages/common/footer.jsp"%>