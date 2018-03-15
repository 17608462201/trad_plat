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
		  <fieldset class="layui-elem-field" style="width: 700px;height: 100px;">
	        <legend><i class="layui-icon" style="font-size: 28px;">&#xe613;${tree.groupName }</i> </legend>
	                <table>
	                       <c:forEach items="${tree.users }" var="user" varStatus="index">
		                     <c:if test="${index.count%7 ==0 or index.count ==1}"><tr></c:if>
		                        <c:choose> 
			                        <c:when test="${onlySelect ne 'yes' }">
			                        	 <td><input type="checkbox" title="${user.realName }" name='userId' value="${user.userId }@${user.realName }" <c:if test="${user.checked eq true }">checked</c:if>  lay-skin="primary"  lay-filter="checkboxFilter"></td>
			                        </c:when>
			                        <c:otherwise>
			                        	  <td><input type="radio" title="${user.realName }" name='userId' value="${user.userId }@${user.realName }"  <c:if test="${user.checked eq true }">checked</c:if> lay-filter="radioFilter"></td>
			                        </c:otherwise>
		                        </c:choose>
		                     <c:if test="${index.count%6 ==0 }"></tr></c:if>
	                     </c:forEach>
	                </table>
		  </fieldset>
	  </c:forEach>
	  <input type="hidden" name="userIdsCheck"  id="userIdsCheck">
	  <input type="hidden" name="userIdsUnCheck"  id="userIdsUnCheck">
	  <input type="hidden" name="userIdsCheckName"  id="userIdsCheckName">
	  <input type="hidden" name="userIdsUnCheckName"  id="userIdsUnCheckName">
</form>
<script type="text/javascript">
layui.use('form', function(){
	    var form = layui.form;
	    //监听checkbox选中取值
	    form.on('checkbox(checkboxFilter)', function(data){
		var userIdsCheck =  $("#userIdsCheck").val();
		var userIdsCheckName =  $("#userIdsCheckName").val();
		var userIdsUnCheck =  $("#userIdsUnCheck").val();
		var userIdsUnCheckName =  $("#userIdsUnCheckName").val();
		var values = data.value.split('@');
		 if(data.elem.checked){
			 //给新选择赋值
			  if(userIdsUnCheck.indexOf(values[0]) != -1){
				  var uncheckArrays = userIdsUnCheck.split(",");
				  var arraysUnCheckName = userIdsUnCheckName.split(",");
				  for(i=0;i<uncheckArrays.length;i++){
					 if(uncheckArrays[i] == values[0]){
						 uncheckArrays.splice(i,1);
						 arraysUnCheckName.splice(i,1);
					 }
				  }
				  userIdsUnCheck = uncheckArrays.join(",");
				  arraysUnCheckName = arraysUnCheckName.join(",");
			  }else{
				  userIdsCheck += values[0]+",";
				  userIdsCheckName += values[1]+",";
			  }
		 }else{
			 //给取消选择赋值userIdsCheck = arrays.join(",");
			 if(userIdsCheck.indexOf(values[0]) != -1){
				 var arrays = userIdsCheck.split(",");
				 var arraysName = userIdsCheckName.split(",");
				 for(i=0;i<arrays.length;i++){
					 if(arrays[i] == values[0]){
						 arrays.splice(i,1);
						 arraysName.splice(i,1);
					 }
				 }
				 userIdsCheck = arrays.join(",");
				 userIdsCheckName = arraysName.join(",");
			 }else{
				 userIdsUnCheck += values[0]+",";
				 userIdsUnCheckName += values[1]+",";
			 }
		}
		 
		 //给隐藏域赋值
		 if(userIdsCheck.length > 0){
			 $("#userIdsCheck").val(userIdsCheck.substring(0,userIdsCheck.length-1));
		 }
		 
		 if(userIdsUnCheck.length > 0){
			 $("#userIdsUnCheck").val(userIdsUnCheck.substring(0,userIdsUnCheck.length-1));
		 }
		 
		 if(userIdsCheckName.length > 0){
			 $("#userIdsCheckName").val(userIdsCheckName.substring(0,userIdsCheckName.length-1));
		 }
		 
		 if(userIdsUnCheckName.length > 0){
			 $("#userIdsUnCheckName").val(userIdsUnCheckName.substring(0,userIdsUnCheckName.length-1));
		 }
	});
	    
	    form.on('radio(radioFilter)', function(data){
	    	var arrays = data.value.split('@');
	    	 $("#userIdsCheck").val(arrays[0]);
	    	 $("#userIdsCheckName").val(arrays[1]);
	    });
	
/* 	$(document).ready(function(){
		var onlySelect = '${onlySelect}';
		if(onlySelect !='yes'){
			//checkbox赋值，并渲染选中选项
			//$('input[alt="checkAlt"]').attr("checked", "checked");
			//$('input[alt="checkAlt"]').next('.layui-form-checkbox').addClass('layui-form-checked');
		}else{
			//单选项赋值，并渲染选中选项
			//$('input[alt="checkAlt"]').attr("checked", "checked");
			//$('input[alt="checkAlt"]').next('.layui-unselect.layui-form-radio').addClass('layui-form-radioed');
			//$('input[alt="checkAlt"]').next('.layui-unselect.layui-form-radio').children('i.layui-anim.layui-icon').addClass('layui-anim-scaleSpring');
		}
    }); */
	
}); 
 
</script>
<%@ include file="/pages/common/footer.jsp"%>