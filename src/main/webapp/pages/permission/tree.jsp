<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%  
//页面标题设置
	request.setAttribute("pageTitle","菜单列表");  
	//如果不需要公用的css,请使用下面代码 (默认是为true)
	//request.setAttribute("INCLUDE_SKIN",false);
	//如果不需要公用的js,请使用下面代码 (默认是为true)
	//request.setAttribute("INCLUDE_COMMON",false);
%>
<%@ include file="/pages/common/header.jsp" %>
<div style="margin-top: 10px;"></div>
 <div class="layui-row">
    <div class="layui-col-xs6">
		      <div class="grid-demo grid-demo-bg1">
		      <div class="layui-form-item">
		    <div class="layui-input-inline"style="width: 250px;padding-left: 5px;">
		        <input type="text" id="filter" name="filter" value="" lay-verify="" placeholder="支持菜单名称/描述搜索内容" autocomplete="off" class="layui-input">
		    </div>
		    <div class="layui-input-inline">
		        <button class="layui-btn" id="search" name="search">
		            <i class="layui-icon"></i>搜索
		        </button>
		    </div>
     </div>
    </div>
    </div>
    <div class="layui-col-xs6">
      <div class="grid-demo">
       <div class="layui-form-item">
  	 		<button class="layui-btn" id="add">
			  <i class="layui-icon"></i>添加
			</button>
			<button class="layui-btn layui-btn-danger" id="delete">
			  <i class="layui-icon"></i>删除
			</button>
			<button class="layui-btn" id="refresh">
			  <i class="layui-icon">ဂ</i>刷新
			</button>
      </div>
    </div>
  </div>
  </div>
  
<table class="layui-table" lay-data="{width: 1110, height:500,url:'${ctx }/tree/list', page:true, limit:10, id:'tables'}" lay-filter="tree_filter">
  <thead>
    <tr>
      <th lay-data="{checkbox:true, fixed: true}"></th>
      <th lay-data="{field:'treeId', width:100,sort: true}">菜单ID</th>
      <th lay-data="{field:'treeName', width:150,sort: true,edit: 'text'}">菜单名称</th>
      <th lay-data="{field:'treeDesc', width:200, sort: true,edit: 'text'}">菜单描述</th>
      <th lay-data="{field:'parentId', width:100, sort: true,edit: 'text'}">父菜单ID</th>
      <th lay-data="{field:'url', width:300, sort: true,edit: 'text'}">菜单地址</th>
      <th lay-data="{field:'roleNames', width:200, sort: true}">菜单角色</th>
     <!-- <th lay-data="{fixed: 'right', width:100, align:'center', toolbar: '#barDemo'}"></th> -->
    </tr>
  </thead>
</table>
 <!--  
<script type="text/html" id="barDemo">
  <a class="layui-btn layui-btn-mini" lay-event="userRoles">用户角色</a>
</script>
-->
<script>
layui.use('table', function(){
  var table = layui.table;
  //监听表格复选框选择
  table.on('checkbox(tree_filter)', function(obj){
  });
  
//监听单元格编辑
  table.on('edit(tree_filter)', function(obj){
    data = obj.data; //得到所在行所有键值
   $.post("${ctx}/tree/modify",{"nTreeID":data.treeId,"nTreeFiled":obj.field,"nTreeValue":obj.value},function(obj){
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
		  url: '${ctx }/tree/list?filter='+encodeURI(encodeURI(val))
		});
	});
  
  $("#delete").on("click",function(){
		  //删除表格
		  var datas = table.checkStatus('tables').data;
	      var treeIds = '';
	      for(i=0;i<datas.length;i++){
	    	  treeIds += datas[i].treeId+',';
	      }
	 	 if(treeIds!=''){
					 layer.confirm('确认删除么？', function(index){
						 $.ajax({
	   	         	     url: "${ctx}/tree/deleteTrees?treeIds="+treeIds, 
	   	         	     dataType: "text", 
	   	         	     success: function(data){
	   	         	    	 if(data =='200'){
	   	         	    		layer.closeAll();
	   	         	    		window.location.href ='${ctx }/tree/init';
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
	          ,title: '新增用户'
	          ,area: ['600px', '500px']
	          ,shade: 0
	          ,maxmin: true
	          ,offset: [
	               80
	          ] 
	          ,content: '${ctx}/tree/add'
	          ,btn: ['保存', '关闭']
	          ,yes: function(){
	          	 var body = layer.getChildFrame('body', 0);
	          	 var treeName = body.find('input[name="treeName"]').val();
	          	 var treeDesc = body.find('input[name="treeDesc"]').val();
	          	 var parentId = body.find('input[name="parentId"]').val();
	          	 var url = body.find('input[name="url"]').val();
	          	 var jsonObj = {"treeName":treeName,"treeDesc":treeDesc,"parentId":parentId,"url":url};
	          	  $.post("${ctx}/tree/saveTree",jsonObj,function(text){
	          		  if(text=='200'){
	          			layer.closeAll();
		          		  window.location.href ='${ctx }/tree/init';
	          		  }else{
	          			  layer.msg("保存菜单树出错！");
	          		  }
	       	     });
	          }
	   });
	});

   $("#search").on("click",function() {
		var val = $("#filter").val();
		//刷新表格
		  table.reload('tables', {
			  //encodeURI加密
			  url: '${ctx }/tree/list?filter='+encodeURI(encodeURI(val))
		  });
	 });
   
});
</script>
<%@ include file="/pages/common/footer.jsp"%>