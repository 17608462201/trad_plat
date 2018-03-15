<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%  
//页面标题设置
	request.setAttribute("pageTitle","角色管理");  
	//如果不需要公用的css,请使用下面代码 (默认是为true)
	//request.setAttribute("INCLUDE_SKIN",false);
	//如果不需要公用的js,请使用下面代码 (默认是为true)
	//request.setAttribute("INCLUDE_COMMON",false);
	//如果不需要公用的css,请使用下面代码 (默认是为true)
	//request.setAttribute("INCLUDE_CSS",false);
%>
<%@ include file="/pages/common/header.jsp" %>
<form class="layui-form" action="#" method="post">
     <div  style="padding-top: 20px;"/>
     <div class="layui-form-item">
          <label class="layui-form-label">角色名：</label>
          <div class="layui-input-inline">
               <input type="text" name="roleName"   required placeholder="请输入角色名" autocomplete="off" class="layui-input">
          </div>
     </div>
     <div class="layui-form-item">
          <label class="layui-form-label">角色描述：</label>
          <div class="layui-input-inline">
               <input type="text" name="roleDesc"  placeholder="请输入角色描述" autocomplete="off" class="layui-input">
          </div>
     </div>
      <div class="layui-form-item">
          <label class="layui-form-label">角色用户：</label>
          <div class="layui-input-inline">
               <input type="text" name="roleUsersName"  id="roleUsersName"   disabled="disabled"  class="layui-input">
                <input type="hidden" name="roleUsers"  id="roleUsers">
          </div>
          <div><button class="layui-btn layui-btn-normal"  id="userSelect" >...</button></div>
     </div>
      <div class="layui-form-item">
          <label class="layui-form-label">角色菜单：</label>
          <div class="layui-input-inline">
               <input type="text" name="roleMenus"   disabled="disabled"  class="layui-input">
          </div>
           <div><button class="layui-btn layui-btn-normal"  id="menuSelect" >...</button></div>
     </div>
      <div class="layui-form-item">
	    <label class="layui-form-label">是否有效：</label>
	    <div class="layui-input-inline">
	      <input type="checkbox" checked="" name="recordStatus" lay-skin="switch" lay-filter="switchTest" lay-text="是|否">
	    </div>
  </div>
</form>
 
<script>
	layui.use('form', function(){
		  var form = layui.form;
	});

	$("#userSelect").on("click",function(){
		layer.open({
            type: 2
            ,title: '用户选择'
            ,area: ['800px', '400px']
            ,shade: 0
            ,maxmin: true
            ,offset: [
               5
            ] 
            ,content: '${ctx}/common/getUserTree'
            ,btn: ['确认', '关闭']
            ,yes: function(){
            	  var body = layer.getChildFrame('body', 0);
            	  var userIdsCheck = body.find('input[name="userIdsCheck"]').val();
            	  var userIdsCheckName = body.find('input[name="userIdsCheckName"]').val();
            	  $("input[name='roleUsers']").val(userIdsCheck);
            	  $("input[name='roleUsersName']").val(userIdsCheckName);
            	  layer.closeAll();
            },btn2: function(){
              layer.closeAll();
            }
            ,zIndex: layer.zIndex //重点1
            ,success: function(layero){
              layer.setTop(layero); //重点2
            }
	   });
		return false;
	})
	
   $("#menuSelect").on("click",function(){
		layer.open({
            type: 2
            ,title: '用户选择'
            ,area: ['600px', '400px']
            ,shade: 0
            ,maxmin: true
            ,offset: [
				5
            ] 
            ,content: '${ctx}/common/getMenuTree'
            ,btn: ['确认', '关闭']
            ,yes: function(){
            	var body = layer.getChildFrame('body', 0);
           	    var treeIdsCheck = body.find('input[name="treeIdsCheck"]').val();
           	   $("input[name='roleMenus']").val(treeIdsCheck);
               layer.closeAll();
            },btn2: function(){
              layer.closeAll();
            }
            ,zIndex: layer.zIndex //重点1
            ,success: function(layero){
              layer.setTop(layero); //重点2
            }
	   });
		return false;
	});
	
</script>
<%@ include file="/pages/common/footer.jsp"%>