<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%  
//页面标题设置
	request.setAttribute("pageTitle","用户选择");  
	//如果不需要公用的css,请使用下面代码 (默认是为true)
	//request.setAttribute("INCLUDE_SKIN",false);
	//如果不需要公用的js,请使用下面代码 (默认是为true)
	//request.setAttribute("INCLUDE_COMMON",false);
%>
<%@ include file="/pages/common/header.jsp" %>
<form class="layui-form"  method="post">  
      <c:forEach items="${userTree }" var="tree">
		  <fieldset class="layui-elem-field" style="width: 780px;height: 150px;">
	        <legend><i class="layui-icon" style="font-size: 30px;">&#xe613;${tree.groupName }</i> </legend>
	                <table>
	                       <c:forEach items="${tree.users }" var="user" varStatus="index">
		                     <c:if test="${index.count%7 ==0 or index.count ==1}"><tr></c:if>
		                        <td><label class="layui-form-label">${user.realName }</label></td>
		                        <td><input type="checkbox"  value="${user.userId }" <c:if test="${user.checked eq true }">alt="checkAlt"</c:if>  lay-skin="primary"  lay-filter="checkboxFilter"></td>
		                     <c:if test="${index.count%6 ==0 }"></tr></c:if>
	                     </c:forEach>
	                </table>
		  </fieldset>
	  </c:forEach>
	  <input type="hidden" name="userIdsCheck"  id="userIdsCheck">
	  <input type="hidden" name="userIdsUnCheck"  id="userIdsUnCheck">
</form>
<script type="text/javascript">
layui.use('form', function(){
	 var form = layui.form;
	form.on('checkbox(checkboxFilter)', function(data){
		var userIdsCheck =  $("#userIdsCheck").val();
		var userIdsUnCheck =  $("#userIdsUnCheck").val();
		 if(data.elem.checked){
			 //给新选择赋值
			  if(userIdsUnCheck.indexOf(data.value) != -1){
				  var uncheckArrays = userIdsUnCheck.split(",");
				  for(i=0;i<uncheckArrays.length;i++){
					 if(uncheckArrays[i] == data.value){
						 uncheckArrays.splice(i,1);
					 }
				  }
				  userIdsUnCheck = uncheckArrays.join(",");
			  }else{
				  userIdsCheck += data.value+",";
			  }
		 }else{
			 //给取消选择赋值userIdsCheck = arrays.join(",");
			 if(userIdsCheck.indexOf(data.value) != -1){
				 var arrays = userIdsCheck.split(",");
				 for(i=0;i<arrays.length;i++){
					 if(arrays[i] == data.value){
						 arrays.splice(i,1);
					 }
				 }
				 userIdsCheck = arrays.join(",");
			 }else{
				 userIdsUnCheck += data.value+",";
			 }
		}
		 $("#userIdsCheck").val(userIdsCheck);
		 $("#userIdsUnCheck").val(userIdsUnCheck);
	});
	
	$(document).ready(function(){
		//checkbox赋值，并渲染选中选项
		$('input[alt="checkAlt"]').attr("checked", "checked");
		$('input[alt="checkAlt"]').next('.layui-form-checkbox').addClass('layui-form-checked');
    });
	
}); 
 
</script>
<%@ include file="/pages/common/footer.jsp"%>