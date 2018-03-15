<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%  
	//页面标题设置
	request.setAttribute("pageTitle","用户列表");  
	//设置查询标题
	request.setAttribute("QUERY_TILE","支持用户名/真实姓名/联系电话/地址搜索内容");  
	//如果不需要公用的css,请使用下面代码 (默认是为true)
	//request.setAttribute("INCLUDE_SKIN",false);
	//如果不需要公用的js,请使用下面代码 (默认是为true)
	//request.setAttribute("INCLUDE_COMMON",false);
	//如果不需要公用的css,请使用下面代码 (默认是为true)
	//request.setAttribute("INCLUDE_CSS",false);
%>
<%@ include file="/pages/common/header.jsp" %>
<%@ include file="/pages/common/listHeader.jsp" %>
<table class="layui-table" lay-data="{height:478,url:'${ctx }/user/list', page:true, limit:10, id:'tables'}" lay-filter="role_filter">
  <thead>
    <tr>
      <th lay-data="{checkbox:true, fixed: true}"></th>
      <th lay-data="{field:'userId', width:100,sort: true}">用户ID</th>
      <th lay-data="{field:'realName', width:80, sort: true,edit: 'text'}">用户名</th>
      <th lay-data="{field:'email', width:170, sort: true,edit: 'text'}">邮箱</th>
      <th lay-data="{field:'phone', width:100, sort: true,edit: 'text'}">联系电话</th>
      <th lay-data="{field:'sex', width:80, sort: true}">性别</th>
      <th lay-data="{field:'job', width:100, sort: true,edit: 'text'}">职业</th>
      <th lay-data="{field:'roleNames', width:150, sort: true}">用户角色</th>
      <th lay-data="{field:'liveAddress', width:180, sort: true,edit: 'text'}">联系地址</th>
      <th lay-data="{field:'recordStatus', width:100,templet: '#checkboxTpl', unresize: true}">是否有效</th>
     <!-- <th lay-data="{fixed: 'right', width:100, align:'center', toolbar: '#barDemo'}"></th> -->
    </tr>
  </thead>
</table>
<script type="text/html" id="barDemo">
  <a class="layui-btn layui-btn-xs" lay-event="roleUser">角色用户</a>
  <a class="layui-btn layui-btn-xs layui-btn-normal" lay-event="roleTree">角色菜单</a>
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
   	
    $.post("${ctx}/user/modify",{"nUserID":userId,"nUserFiled":this.name,"nUserValue":dataVal},function(obj){
  		 if(obj == "200"){
  			 layer.msg("设置用户是否有效成功！");
  		 }else{
  			 layer.msg("设置用户是否有效失败！");
  		 }
    });
});
  
//监听单元格编辑
  table.on('edit(role_filter)', function(obj){
	  data = obj.data; //得到所在行所有键值
	    $.post("${ctx}/user/modify",{"nUserID":data.userId,"nUserFiled":obj.field,"nUserValue":obj.value},function(obj){
	    	if(obj == "200"){
	  			 layer.msg("设置用户是否有效成功！");
	  		 }else{
	  			 layer.msg("设置用户是否有效失败！");
	  		 }
		  });
  });
  
  $("#refresh").on("click",function(){
	  //刷新表格
	  var val = $("#filter").val();
	  table.reload('tables', {
		  url: '${ctx }/user/list?filter='+encodeURI(encodeURI(val))
		});
	});
  
  $("#delete").on("click",function(){
	  var datas = table.checkStatus('tables').data;
      var userIds = '';
       for(i=0;i<datas.length;i++){
     	 userIds += datas[i].userId+',';
       }
	 	 if(userIds!=''){
					 layer.confirm('确认删除么？点击确认后该用户角色也会被删除，请慎重！', function(index){
						 $.ajax({
	   	         	     url: "${ctx}/user/deleteUsers?userIds="+userIds, 
	   	         	     dataType: "text", 
	   	         	     success: function(data){
	   	         	    	 if(data =='200'){
	   	         	    		layer.closeAll();
	   	         	    		window.location.href ='${ctx }/user/init';
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
          ,area: ['600px', '500px']
          ,shade: 0
          ,maxmin: true
          ,offset: [
            10
          ] ,content: '${ctx}/register/init?showPic=N'
          ,btn: ['保存', '关闭']
          ,yes: function(){
          	 var body = layer.getChildFrame('body', 0);
          	 var userName = body.find('input[name="userName"]').val();
          	 var realName = body.find('input[name="realName"]').val();
          	 var password = body.find('input[name="password"]').val();
          	 var groupId = body.find('input[name="groupId"]').val();
          	 var phone = body.find('input[name="phone"]').val();
          	 var email = body.find('input[name="email"]').val();
          	 var sex = body.find('input[name="sex"]').val();
          	 var job = body.find('input[name="job"]').val();
          	 var liveAddress = body.find('input[name="liveAddress"]').val();
          	var recordStatus = body.find('input[name="recordStatus"]').val();
        	 if(recordStatus != undefined && recordStatus =='on'){
        		recordStatus = '1';
        	 }else{
        		recordStatus = '0'
        	 }
          	 var jsonObj = {"userName":userName,"realName":realName,"password":password,"groupId":groupId,"phone":phone,"email":email,"sex":sex,"job":job,"liveAddress":liveAddress,"recordStatus":recordStatus};
          	  $.post("${ctx}/register/doReg",jsonObj,function(obj){
          		  layer.closeAll();
          		  window.location.href ='${ctx }/user/init';
       	     });
          }
      });
	});

   $("#search").on("click",function() {
		var val = $("#filter").val();
		//刷新表格
		  table.reload('tables', {
			  //encodeURI加密
			  url: '${ctx }/user/list?filter='+encodeURI(encodeURI(val))
		  });
	 });
});
</script>
<%@ include file="/pages/common/footer.jsp"%>