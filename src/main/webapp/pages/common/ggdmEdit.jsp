<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%  
//页面标题设置
	request.setAttribute("pageTitle","菜单管理");  
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
          <label class="layui-form-label">编号：</label>
          <div class="layui-input-inline">
               <input type="text" name="dmjbh"  placeholder="请输入代码集编号" autocomplete="off" class="layui-input">
          </div>
     </div>
      <div class="layui-form-item">
          <label class="layui-form-label">代码：</label>
          <div class="layui-input-inline">
               <input type="text" name="dm"  placeholder="请输入代码"   class="layui-input">
          </div>
     </div>
      <div class="layui-form-item">
          <label class="layui-form-label">代码内容：</label>
          <div class="layui-input-inline">
               <input type="text" name="dmnr" placeholder="请输入代码内容"  class="layui-input">
          </div>
     </div>
      <div class="layui-form-item">
          <label class="layui-form-label">父代码：</label>
          <div class="layui-input-inline">
               <input type="text" name="parentId" placeholder="请输入父代码"   class="layui-input">
          </div>
     </div>
     <div class="layui-form-item layui-form-text">
    <label class="layui-form-label">备注：</label>
    <div class="layui-input-inline">
      <textarea name="remark" placeholder="请输入备注" class="layui-textarea"></textarea>
    </div>
      <div class="layui-form-item">
          <label class="layui-form-label">排序号：</label>
          <div class="layui-input-inline">
               <input type="text" name="orderNum" placeholder="请输入排序号"   class="layui-input">
          </div>
     </div>
      <div class="layui-form-item">
	    <label class="layui-form-label">是否有效</label>
	    <div class="layui-input-inline">
	      <input type="checkbox" checked="" name="isValid" lay-skin="switch" lay-filter="switchTest" lay-text="是|否">
	    </div>
  </div>
</form>
 
<script>
	layui.use('form', function(){
		  var form = layui.form;
	});

</script>
<%@ include file="/pages/common/footer.jsp"%>