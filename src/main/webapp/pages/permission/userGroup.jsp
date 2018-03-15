<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%  
	//页面标题设置
	request.setAttribute("pageTitle","小组列表");  
	//设置查询标题
	request.setAttribute("QUERY_TILE","支持组名称/职员名称搜索内容");  
	//如果不需要公用的css,请使用下面代码 (默认是为true)
	//request.setAttribute("INCLUDE_SKIN",false);
	//如果不需要公用的js,请使用下面代码 (默认是为true)
	//request.setAttribute("INCLUDE_COMMON",false);
	//如果不需要公用的css,请使用下面代码 (默认是为true)
	//request.setAttribute("INCLUDE_CSS",false);
%>
<%@ include file="/pages/common/header.jsp" %>
<%@ include file="/pages/common/listHeader.jsp" %>
<table class="layui-table" lay-data="{height:478,url:'${ctx }/userGroup/list', page:true, limit:10, id:'tables'}" lay-filter="role_filter">
  <thead>
    <tr>
      <th lay-data="{checkbox:true, fixed: true}"></th>
      <th lay-data="{field:'id', width:80,sort: true}">小组ID</th>
      <th lay-data="{field:'groupName', width:150,sort: true,edit: 'text'}">小组名称</th>
      <th lay-data="{field:'masterId', width:150,sort: true}">小组组长ID</th>
      <th lay-data="{field:'masterName', width:150,sort: true}">小组组长</th>
      <th lay-data="{field:'userNames', width:200, sort: true}">小组用户</th>
      <th lay-data="{field:'recordStatus', width:100,templet: '#checkboxTpl', unresize: true}">是否有效</th>
     <th lay-data="{fixed: 'right', width:200, align:'center', toolbar: '#barDemo'}"></th>
    </tr>
  </thead>
</table>
<script type="text/html" id="barDemo">
  <a class="layui-btn layui-btn-xs" lay-event="groupMaster">小组组长</a>
  <a class="layui-btn  layui-btn-xs layui-btn-normal" lay-event="userGroup">小组用户</a>
</script>
 <script type="text/html" id="checkboxTpl">
  <input type="checkbox" {{ d.recordStatus == 1 ? 'checked' : '' }} name="recordStatus" lay-skin="switch" lay-filter="validFilter" lay-text="是|否">
</script>
<script>
layui.use('table', function(){
  var table = layui.table
  ,form = layui.form;
  //监听表格复选框选择
  table.on('checkbox(role_filter)', function(obj){
    console.log(obj)
  });
  
  
//监听是否有效操作
  form.on('switch(validFilter)', function(obj){
    var tds = $(obj.elem).parent().parent().parent().children();
    var userId = tds[1].innerText.replace(/[\r\n]/g, "");
    var dataVal = '';
   	if(this.checked){
   		dataVal = '1';
   	}else{
   	    dataVal = '0';
   	}
   	
   	$.post("${ctx}/userGroup/modify",{"nUserID":userId,"nUserFiled":this.name,"nUserValue":dataVal},function(obj){
  		 if(obj == "200"){
  			 layer.msg("设置用户组是否有效成功！");
  		 }else{
  			 layer.msg("设置用户组是否有效失败！");
  		 }
   });
   	
});
  //监听工具条
  table.on('tool(role_filter)', function(obj){
    var data = obj.data;
    if(obj.event === 'userGroup'){
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
            ,content: '${ctx}/common/getUserTree?groupId='+data.id
            ,btn: ['确认', '关闭']
            ,yes: function(){
            	 var body = layer.getChildFrame('body', 0);
            	 var userIdsCheck = body.find('input[name="userIdsCheck"]').val();
            	 var userIdsUnCheck = body.find('input[name="userIdsUnCheck"]').val();
            	$.ajax({
              	     url: "${ctx}/user/updateUserGroup?groupId="+data.id+"&userIdsCheck="+userIdsCheck+"&userIdsUnCheck="+userIdsUnCheck, 
              	     dataType: "text", 
              	     success: function(data){
              	    	 if(data =='200'){
              	    		layer.closeAll();
              	    		window.location.href ='${ctx }/userGroup/init';
              	    	 }else{
              	    		 layer.msg("更新小组所属用户失败，请重试！");
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
    }else if(obj.event === 'groupMaster'){
    	//如果是iframe层
    	layer.open({
            type: 2 //此处以iframe举例
            ,title: '组长选择'
            ,area: ['800px', '500px']
            ,shade: 0
            ,maxmin: true
            ,offset: [
               10
            ] 
            ,content: '${ctx}/common/getUserTree?masterId='+data.masterId+"&onlySelect=yes"
            ,btn: ['确认', '关闭']
            ,yes: function(){
            	 var body = layer.getChildFrame('body', 0);
            	 var userIdsCheck = body.find('input[name="userIdsCheck"]').val();
            	 var userIdsCheckName = body.find('input[name="userIdsCheckName"]').val();
            	$.ajax({
              	     url: "${ctx}/userGroup/updateMaster?groupId="+data.id+"&ids="+userIdsCheck+"&names="+encodeURI(encodeURI(userIdsCheckName)), 
              	     dataType: "text", 
              	     success: function(data){
              	    	 if(data =='200'){
              	    		layer.closeAll();
              	    		window.location.href ='${ctx }/userGroup/init';
              	    	 }else{
              	    		 layer.msg("更新小组所属用户失败，请重试！");
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
  
//监听单元格编辑
  table.on('edit(role_filter)', function(obj){
	  data = obj.data; //得到所在行所有键值
	    $.post("${ctx}/userGroup/modify",{"nUserID":data.id,"nUserFiled":obj.field,"nUserValue":obj.value},function(obj){
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
		  url: '${ctx }/userGroup/list?filter='+encodeURI(encodeURI(val))
		});
	});
  
  $("#delete").on("click",function(){
	  var datas = table.checkStatus('tables').data;
      var ids = '';
       for(i=0;i<datas.length;i++){
    	   ids += datas[i].id+',';
       }
	 	 if(ids!=''){
					 layer.confirm('确认删除么？请慎重！', function(index){
						 $.ajax({
	   	         	     url: "${ctx}/userGroup/deleteGroups?ids="+ids, 
	   	         	     dataType: "text", 
	   	         	     success: function(data){
	   	         	    	 if(data =='200'){
	   	         	    		layer.closeAll();
	   	         	    		window.location.href ='${ctx }/userGroup/init';
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
          ,title: '管理'
          ,area: ['600px', '500px']
          ,shade: 0
          ,maxmin: true
          ,offset: [
            10
          ] ,content: '${ctx}/userGroup/editGroup'
          ,btn: ['保存', '关闭']
          ,yes: function(){
          	 var body = layer.getChildFrame('body', 0);
          	 var groupName = body.find('input[name="groupName"]').val();
          	 var groupMaster = body.find('input[name="groupMaster"]').val();
          	var groupMasterName = body.find('input[name="groupMasterName"]').val();
          	 var roleUsers = body.find('input[name="roleUsers"]').val();
          	var recordStatus = body.find('input[name="recordStatus"]').val();
         	 if(recordStatus != undefined && recordStatus =='on'){
         		recordStatus = '1';
         	 }else{
         		recordStatus = '0'
         	 }
          	 var jsonObj = {"groupName":groupName,"groupMaster":groupMaster,"roleUsers":roleUsers,"groupMasterName":groupMasterName,"recordStatus":recordStatus};
          	  $.post("${ctx}/userGroup/saveGroup",jsonObj,function(obj){
          		  layer.closeAll();
          		  window.location.href ='${ctx }/userGroup/init';
       	     });
          }
      });
	});

   $("#search").on("click",function() {
		var val = $("#filter").val();
		//刷新表格
		  table.reload('tables', {
			  //encodeURI加密
			  url: '${ctx }/userGroup/list?filter='+encodeURI(encodeURI(val))
		  });
	 });
});
</script>
<%@ include file="/pages/common/footer.jsp"%>