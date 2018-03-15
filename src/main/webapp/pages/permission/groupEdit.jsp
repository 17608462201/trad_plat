<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%  
//页面标题设置
	request.setAttribute("pageTitle","用户组管理");  
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
          <label class="layui-form-label">小组名称：</label>
          <div class="layui-input-inline">
               <input type="text" name="groupName"   required placeholder="请输入用户组名称" autocomplete="off" class="layui-input">
          </div>
     </div>
     <div class="layui-form-item">
          <label class="layui-form-label">小组组长：</label>
          <div class="layui-input-inline">
               <input type="text" name="groupMasterName"  disabled="disabled" autocomplete="off" class="layui-input">
               <input type="hidden" name="groupMaster"  id="groupMaster">
          </div>
          <div><button class="layui-btn layui-btn-normal"  id="userSelectMaster" >...</button></div>
     </div>
     <div class="layui-form-item">
          <label class="layui-form-label">小组用户：</label>
          <div class="layui-input-inline">
                <input type="text" name="roleUsersName"  id="roleUsersName"   disabled="disabled"  class="layui-input">
                <input type="hidden" name="roleUsers"  id="roleUsers">
          </div>
          <div><button class="layui-btn layui-btn-normal"  id="userSelect" >...</button></div>
     </div>
</form>
 
<script>
	layui.use('form', function(){
		  var form = layui.form;
	});
	
	$("#userSelectMaster").on("click",function(){
		layer.open({
            type: 2
            ,title: '用户选择'
            ,area: ['800px', '400px']
            ,shade: 0
            ,maxmin: true
            ,offset: [
               5
            ] 
            ,content: '${ctx}/common/getUserTree?onlySelect=yes'
            ,btn: ['确认', '关闭']
            ,yes: function(){
            	  var body = layer.getChildFrame('body', 0);
            	  var userIdsCheck = body.find('input[name="userIdsCheck"]').val();
            	  var userIdsCheckName = body.find('input[name="userIdsCheckName"]').val();
            	  $("input[name='groupMaster']").val(userIdsCheck);
            	  $("input[name='groupMasterName']").val(userIdsCheckName);
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

</script>
<%@ include file="/pages/common/footer.jsp"%>