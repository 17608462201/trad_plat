<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%  
//页面标题设置
	request.setAttribute("pageTitle","菜单管理");  
	//如果不需要公用的css,请使用下面代码 (默认是为true)
	//request.setAttribute("INCLUDE_SKIN",false);
	//如果不需要公用的js,请使用下面代码 (默认是为true)
	//request.setAttribute("INCLUDE_COMMON",false);
%>
<%@ include file="/pages/common/header.jsp" %>
<form class="layui-form" action="#" method="post">
     <div  style="padding-top: 20px;"/>
     <div class="layui-form-item">
          <label class="layui-form-label">菜单名：</label>
          <div class="layui-input-inline">
               <input type="text" name="treeName"   required placeholder="请输入角色名" autocomplete="off" class="layui-input">
          </div>
     </div>
     <div class="layui-form-item">
          <label class="layui-form-label">菜单描述：</label>
          <div class="layui-input-block">
               <input type="text" name="treeDesc"  placeholder="请输入角色描述" autocomplete="off" class="layui-input">
          </div>
     </div>
      <div class="layui-form-item">
          <label class="layui-form-label">父菜单ID：</label>
          <div class="layui-input-inline">
               <input type="text" name="parentId"   class="layui-input">
          </div>
     </div>
      <div class="layui-form-item">
          <label class="layui-form-label">访问地址：</label>
          <div class="layui-input-block">
               <input type="text" name="url"  class="layui-input">
          </div>
     </div>
</form>
 
<script>
	layui.use('form', function(){
		  var form = layui.form;
	});

</script>
<%@ include file="/pages/common/footer.jsp"%>