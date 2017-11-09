<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%  
//页面标题设置
	request.setAttribute("pageTitle","角色列表");  
	//如果不需要公用的css,请使用下面代码 (默认是为true)
	//request.setAttribute("INCLUDE_SKIN",false);
	//如果不需要公用的js,请使用下面代码 (默认是为true)
	//request.setAttribute("INCLUDE_COMMON",false);
%>
<%@ include file="/pages/common/header.jsp" %>

<div style="margin-bottom: 5px;">          
 
<!-- 距离顶部距离 -->
<!-- <ins class="adsbygoogle" style="display:inline-block;width:970px;height:90px" data-ad-client="ca-pub-6111334333458862" data-ad-slot="3820120620"></ins>
 --> 
</div>
 
<table class="layui-table" lay-data="{width: 900, height:500,url:'${ctx }/roles/list', page:true, id:'idTest'}" lay-filter="role_filter">
  <thead>
    <tr>
      <th lay-data="{checkbox:true, fixed: true}"></th>
      <th lay-data="{field:'roleId', width:80}">角色ID</th>
      <th lay-data="{field:'roleDesc', width:200, sort: true,edit: 'text'}">角色名</th>
      <th lay-data="{field:'userNames', width:300, sort: true}">角色用户</th>
     <th lay-data="{fixed: 'right', width:260, align:'center', toolbar: '#barDemo'}"></th>
    </tr>
  </thead>
</table>
 
<script type="text/html" id="barDemo">
  <a class="layui-btn layui-btn-danger layui-btn-mini" lay-event="del">删除</a>
  <a class="layui-btn layui-btn-mini" lay-event="roleUser">角色用户</a>
  <a class="layui-btn layui-btn-primary layui-btn-mini" lay-event="roleTree">角色菜单</a>
</script>
<script>
layui.use('table', function(){
  var table = layui.table;
  //监听表格复选框选择
  table.on('checkbox(role_filter)', function(obj){
    console.log(obj)
  });
  
//监听单元格编辑
  table.on('edit(role_filter)', function(obj){
    var value = obj.value //得到修改后的值
    ,data = obj.data; //得到所在行所有键值
    $.post("${ctx}/roles/modify",{"nRoleID":data.roleId,"nRoleName":value},function(obj){
	   		 if(obj == "200"){
	   			 layer.msg("数据更新成功！");
	   		 }else{
	   			 layer.msg("数据更新失败！");
	   		 }
	     });
  });
  
  
  //监听工具条
  table.on('tool(role_filter)', function(obj){
    var data = obj.data;
    if(obj.event === 'del'){
      layer.confirm('真的删除行么', function(index){
        $.ajax({
     	     url: "${ctx}/roles/deleteRoles?roleId="+data.roleId, 
     	     dataType: "text", 
     	     success: function(data){
     	    	 if(data =='200'){
     	    	   obj.del();
     	           layer.close(index);
     	    	 }else{
     	    		 layer.msg("删除角色信息失败，请重试！");
     	    	 }
     	    	 
     	     }
     	 });
        
      });
    }else if(obj.event === 'roleUser'){
    	//如果是iframe层
    	layer.open({
            type: 2 //此处以iframe举例
            ,title: '用户选择界面'
            ,area: ['800px', '550px']
            ,shade: 0
            ,maxmin: true
            ,offset: [
              Math.random()*($(window).height()-600)
              ,Math.random()*($(window).width()-890)
            ] 
            ,content: '${ctx}/base/getUserTree?roleId='+data.roleId
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
            ,title: '用户选择界面'
            ,area: ['600px', '620px']
            ,shade: 0
            ,maxmin: true
            ,offset: [
              Math.random()*($(window).height()-640)
              ,Math.random()*($(window).width()-780)
            ] 
            ,content: '${ctx}/base/getMenuTree?roleId='+data.roleId
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
  
  var $ = layui.$, active = {
    getCheckData: function(){ //获取选中数据
      var checkStatus = table.checkStatus('idTest')
      ,data = checkStatus.data;
      layer.alert(JSON.stringify(data));
    }
    ,getCheckLength: function(){ //获取选中数目
      var checkStatus = table.checkStatus('idTest')
      ,data = checkStatus.data;
      layer.msg('选中了：'+ data.length + ' 个');
    }
    ,isAll: function(){ //验证是否全选
      var checkStatus = table.checkStatus('idTest');
      layer.msg(checkStatus.isAll ? '全选': '未全选')
    }
  };
  
  $('.demoTable .layui-btn').on('click', function(){
    var type = $(this).data('type');
    active[type] ? active[type].call(this) : '';
  });
  
});
</script>
<%@ include file="/pages/common/footer.jsp"%>