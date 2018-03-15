<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%  
    //页面标题设置
	request.setAttribute("pageTitle","角色列表");
    //设置查询标题
    request.setAttribute("QUERY_TILE","支持角色名搜索内容");  
	//如果不需要公用的css,请使用下面代码 (默认是为true)
	//request.setAttribute("INCLUDE_SKIN",false);
	//如果不需要公用的js,请使用下面代码 (默认是为true)
	//request.setAttribute("INCLUDE_COMMON",false);
	//如果不需要公用的css,请使用下面代码 (默认是为true)
	//request.setAttribute("INCLUDE_CSS",false);
%>
<%@ include file="/pages/common/header.jsp" %>
<%@ include file="/pages/common/listHeader.jsp" %>
<table class="layui-table" lay-data="{height:478,url:'${ctx }/roles/list', page:true, limit:10, id:'tables'}" lay-filter="role_filter">
  <thead>
    <tr>
      <th lay-data="{checkbox:true, fixed: true}"></th>
      <th lay-data="{field:'roleId', width:80,sort: true}">角色ID</th>
      <th lay-data="{field:'roleDesc', width:100, sort: true,edit: 'text'}">角色名</th>
      <th lay-data="{field:'userNames', width:200, sort: true}">角色用户</th>
      <th lay-data="{field:'treeNames', width:400, sort: true}">角色菜单</th>
      <th lay-data="{field:'recordStatus', width:100,templet: '#checkboxTpl', unresize: true}">是否有效</th>
     <th lay-data="{fixed: 'right', width:160, align:'center', toolbar: '#barDemo'}"></th>
    </tr>
  </thead>
</table>
 <script type="text/html" id="checkboxTpl">
  <input type="checkbox" {{ d.recordStatus == 1 ? 'checked' : '' }} name="recordStatus" lay-skin="switch" lay-filter="validFilter" lay-text="是|否">
</script>
<script type="text/html" id="barDemo">
  <a class="layui-btn layui-btn-xs" lay-event="roleUser">角色用户</a>
  <a class="layui-btn layui-btn-xs layui-btn-normal" lay-event="roleTree">角色菜单</a>
</script>
<script>
layui.use('table', function(){
  var table = layui.table
  ,form = layui.form;
  //监听表格复选框选择
  table.on('checkbox(role_filter)', function(obj){
  });
  
  //监听是否有效操作
  form.on('switch(validFilter)', function(obj){
    var tds = $(obj.elem).parent().parent().parent().children();
    var roleId = tds[1].innerText.replace(/[\r\n]/g, "");
    var dataVal = '';
   	if(this.checked){
   		dataVal = '1';
   	}else{
   	    dataVal = '0';
   	}
   	
    $.post("${ctx}/roles/modify",{"nRoleID":roleId,"nRoleFiled":this.name,"nRoleValue":dataVal},function(obj){
  		 if(obj == "200"){
  			 layer.msg("设置角色是否有效成功！");
  		 }else{
  			 layer.msg("设置角色是否有效失败！");
  		 }
    });
});
//监听单元格编辑
  table.on('edit(role_filter)', function(obj){
	data = obj.data; //得到所在行所有键值
    $.post("${ctx}/roles/modify",{"nRoleID":data.roleId,"nRoleFiled":obj.field,"nRoleValue":obj.value},function(obj){
	   		 if(obj == "200"){
	   			 layer.msg("数据更新成功！");
	   		 }else{
	   			 layer.msg("数据更新失败！");
	   		 }
	     });
  });
  
  
  $("#refresh").on("click",function(){
	  //刷新表格
	  var val = $("#filter").val();
	  table.reload('tables', {
		  url: '${ctx }/roles/list?filter='+encodeURI(encodeURI(val))
		});
	});
  
  $("#delete").on("click",function(){
		  var datas = table.checkStatus('tables').data;
	      var roleIds = '';
	      for(i=0;i<datas.length;i++){
	     	 roleIds += datas[i].roleId+',';
	      }
	 	 if(roleIds!=''){
					 layer.confirm('确认删除么？点击确认后该角色包含角色用户和角色菜单也会被删除，请慎重！', function(index){
						 $.ajax({
	   	         	     url: "${ctx}/roles/deleteRoles?roleIds="+roleIds, 
	   	         	     dataType: "text", 
	   	         	     success: function(data){
	   	         	    	 if(data =='200'){
	   	         	    		layer.closeAll();
	   	         	    		window.location.href ='${ctx }/roles/init';
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
          ,title: '角色管理'
          ,area: ['890px', '500px']
          ,shade: 0
          ,maxmin: true
          ,offset: [
            10
          ] 
          ,content: '${ctx}/roles/add'
          ,btn: ['保存', '关闭']
          ,yes: function(){
          	 var body = layer.getChildFrame('body', 0);
          	 var roleDesc = body.find('input[name="roleDesc"]').val();
          	 var roleName = body.find('input[name="roleName"]').val();
          	 var roleUsers = body.find('input[name="roleUsers"]').val();
          	 var roleMenus = body.find('input[name="roleMenus"]').val();
          	var recordStatus = body.find('input[name="recordStatus"]').val();
          	 if(recordStatus != undefined && recordStatus =='on'){
          		recordStatus = '1';
          	 }else{
          		recordStatus = '0'
          	 }
          	  $.post("${ctx}/roles/saveNewRole",{"roleName":roleName,"roleDesc":roleDesc,"roleUsers":roleUsers,"roleMenus":roleMenus,"recordStatus":recordStatus},function(obj){
          		  layer.closeAll();
          		  window.location.href ='${ctx }/roles/init';
       	     });
          }
      });
	});

   $("#search").on("click",function() {
		var val = $("#filter").val();
		//刷新表格
		  table.reload('tables', {
			  //encodeURI加密
			  url: '${ctx }/roles/list?filter='+encodeURI(encodeURI(val))
		  });
	 });
   
  
  //监听工具条
  table.on('tool(role_filter)', function(obj){
    var data = obj.data;
    if(obj.event === 'roleUser'){
    	//如果是iframe层
    	layer.open({
            type: 2 //此处以iframe举例
            ,title: '用户选择'
            ,area: ['800px', '500px']
            ,shade: 0
            ,maxmin: true
            ,offset: [
               10
            ] 
            ,content: '${ctx}/common/getUserTree?roleId='+data.roleId
            ,btn: ['确认', '关闭']
            ,yes: function(){
            	 var body = layer.getChildFrame('body', 0);
            	 var userIdsCheck = body.find('input[name="userIdsCheck"]').val();
            	 var userIdsUnCheck = body.find('input[name="userIdsUnCheck"]').val();
            	$.ajax({
              	     url: "${ctx}/roles/saveRoleUser?roleId="+data.roleId+"&userIdsCheck="+userIdsCheck+"&userIdsUnCheck="+userIdsUnCheck, 
              	     dataType: "text", 
              	     success: function(data){
              	    	 if(data =='200'){
              	    		layer.closeAll();
              	    		window.location.href ='${ctx }/roles/init';
              	    	 }else{
              	    		 layer.msg("更新角色所属用户失败，请重试！");
              	    	 }
              	    	 
              	     }
              	 });
            }
            ,btn2: function(){
              layer.closeAll();
            }
            ,zIndex: layer.zIndex //重点1
            ,success: function(layero){
              layer.setTop(layero); //重点2
            }
          });
    } else if(obj.event === 'roleTree'){
    	//如果是iframe层
    	layer.open({
            type: 2 //此处以iframe举例
            ,title: '用户菜单选择'
            ,area: ['600px', '500px']
            ,shade: 0
            ,maxmin: true
            ,offset: [
               10
            ] 
            ,content: '${ctx}/common/getMenuTree?roleId='+data.roleId
            ,btn: ['确认', '关闭']
            ,yes: function(){
            	 var body = layer.getChildFrame('body', 0);
            	 var treeIdsCheck = body.find('input[name="treeIdsCheck"]').val();
            	 var treeIdsUnCheck = body.find('input[name="treeIdsUnCheck"]').val();
            	$.ajax({
              	     url: "${ctx}/tree/saveTreePer?roleId="+data.roleId+"&treeIdsCheck="+treeIdsCheck+"&treeIdsUnCheck="+treeIdsUnCheck, 
              	     dataType: "text", 
              	     success: function(data){
              	    	 if(data =='200'){
              	    		layer.closeAll();
              	    		window.location.href ='${ctx }/roles/init';
              	    	 }else{
              	    		 layer.msg("更新角色所属用户失败，请重试！");
              	    	 }
              	     }
              	 });
            }
            ,btn2: function(){
              layer.closeAll();
            }
            ,zIndex: layer.zIndex //重点1
            ,success: function(layero){
              layer.setTop(layero); //重点2
            }
          });
    }
  });
  
});
</script>
<%@ include file="/pages/common/footer.jsp"%>