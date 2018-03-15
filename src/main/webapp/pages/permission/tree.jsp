<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%  
     //页面标题设置
	request.setAttribute("pageTitle","菜单列表");  
	//设置查询标题
	request.setAttribute("QUERY_TILE","支持菜单名称/描述搜索内容");  
	//如果不需要公用的css,请使用下面代码 (默认是为true)
	//request.setAttribute("INCLUDE_SKIN",false);
	//如果不需要公用的js,请使用下面代码 (默认是为true)
	//request.setAttribute("INCLUDE_COMMON",false);
	//如果不需要公用的css,请使用下面代码 (默认是为true)
	//request.setAttribute("INCLUDE_CSS",false);
%>
<%@ include file="/pages/common/header.jsp" %>
<%@ include file="/pages/common/listHeader.jsp" %>
<table class="layui-table" lay-data="{height:478,url:'${ctx }/tree/list', page:true, limit:10, id:'tables'}" lay-filter="tree_filter">
  <thead>
    <tr>
      <th lay-data="{checkbox:true, fixed: true}"></th>
      <th lay-data="{field:'treeId', width:100,sort: true}">菜单ID</th>
      <th lay-data="{field:'treeName', width:150,sort: true,edit: 'text'}">菜单名称</th>
      <th lay-data="{field:'treeDesc', width:200, sort: true,edit: 'text'}">菜单描述</th>
      <th lay-data="{field:'parentId', width:100, sort: true,edit: 'text'}">父菜单ID</th>
      <th lay-data="{field:'url', width:300, sort: true,edit: 'text'}">菜单地址</th>
      <th lay-data="{field:'roleNames', width:110, sort: true}">菜单角色</th>
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
  table.on('checkbox(tree_filter)', function(obj){
  });
  
  //监听是否有效操作
  form.on('switch(validFilter)', function(obj){
    var tds = $(obj.elem).parent().parent().parent().children();
    var treeId = tds[1].innerText.replace(/[\r\n]/g, "");
    var dataVal = '';
   	if(this.checked){
   		dataVal = '1';
   	}else{
   	    dataVal = '0';
   	}
   	
    $.post("${ctx}/tree/modify",{"nTreeID":treeId,"nTreeFiled":this.name,"nTreeValue":dataVal},function(obj){
  		 if(obj == "200"){
  			 layer.msg("设置菜单树是否有效成功！");
  		 }else{
  			 layer.msg("设置菜单树是否有效失败！");
  		 }
    });
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
	               10
	          ] 
	          ,content: '${ctx}/tree/add'
	          ,btn: ['保存', '关闭']
	          ,yes: function(){
	          	 var body = layer.getChildFrame('body', 0);
	          	 var treeName = body.find('input[name="treeName"]').val();
	          	 var treeDesc = body.find('input[name="treeDesc"]').val();
	          	 var parentId = body.find('input[name="parentId"]').val();
	          	 var ordernum = body.find('input[name="ordernum"]').val();
	          	 var url = body.find('input[name="url"]').val();
	          	var recordStatus = body.find('input[name="recordStatus"]').val();
	          	 if(recordStatus != undefined && recordStatus =='on'){
	          		recordStatus = '1';
	          	 }else{
	          		recordStatus = '0'
	          	 }
	          	 var jsonObj = {"treeName":treeName,"treeDesc":treeDesc,"parentId":parentId,"url":url,"ordernum":ordernum,"recordStatus":recordStatus};
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