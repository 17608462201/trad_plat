<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%  
//页面标题设置
	request.setAttribute("pageTitle","客户联系人信息");  
	//如果不需要公用的css,请使用下面代码 (默认是为true)
	//request.setAttribute("INCLUDE_SKIN",false);
	//如果不需要公用的js,请使用下面代码 (默认是为true)
	//request.setAttribute("INCLUDE_COMMON",false);
	//如果不需要公用的css,请使用下面代码 (默认是为true)
	//request.setAttribute("INCLUDE_CSS",false);
%>
<%@ include file="/pages/common/header.jsp" %>
 <form class="layui-form" action="#" method="post">
      <input type="hidden" name="customerId" value="${customerId }">
              <div style="padding-top: 2px;padding-bottom: 5px;"></div>
		         <div class="layui-form-item">
			           <label class="layui-form-label">姓名：</label>
			           <div class="layui-input-inline">
			                <input type="text" name="name" id="name" value="${customerContract.name }" lay-verify="required"  placeholder="请输入姓名" autocomplete="off" class="layui-input">
			           </div>
			      </div>
		          <div class="layui-form-item">
				    <label class="layui-form-label">关系：</label>
				    <div class="layui-input-inline">
				      <select name="relation" lay-verify="required" id="relation">
				        <option value="">${customerContract.relation ==null ? '请选择客户来源':customerContract.relation} </option>
				      </select>
				    </div>
				 </div>
		         <div class="layui-form-item">
		           <label class="layui-form-label">电话号码：</label>
		           <div class="layui-input-inline">
		                <input type="text" name="mobile" id="mobile" value="${customerContract.mobile }"  lay-verify="required|phone"  placeholder="请输入电话号码" autocomplete="off" class="layui-input">
		           </div>
		        </div> 
		        <div class="layui-form-item">
			      <label class="layui-form-label">公司名称：</label>
			     <div class="layui-input-block">
		                <input type="text" name="companyName" id="companyName" value="${customerContract.companyName }"  lay-verify="required"  placeholder="请输入公司名称" autocomplete="off" class="layui-input">
		           </div>
			  </div>
		      <div class="layui-form-item">
	           <label class="layui-form-label">公司地址：</label>
	           <div class="layui-input-block">
	                <input type="text" name="companyAddress" value="${customerContract.companyAddress }" id="companyAddress" lay-verify="required"  lay-verify="companyAddress"  placeholder="请输入公司地址" autocomplete="off" class="layui-input">
	           </div>
		      </div>
		        <div class="layui-form-item">
	           <label class="layui-form-label">家庭地址：</label>
	           <div class="layui-input-block">
	                <input type="text" name="address" value="${customerContract.address }" id="address"  placeholder="请输入家庭地址" autocomplete="off" class="layui-input">
	           </div>
		      </div>
</form>
 
<script>
layui.use(['form'], function(){
	  var form = layui.form
	  ,laydate = layui.laydate;
	  
	  initGroupSelect(form);
	  
});

function initGroupSelect(form){
	$.ajax({
	     url: "${ctx}/common/getGGdmj?dmjbhs=relation", 
	     dataType: "json", 
	     success: function(data){
   		 var jsonData  = eval(data); 
   		$.each(jsonData['relation'],function(index,val){
			 $("#relation").append('<option value="'+val.dmnr+'">'+val.dmnr+'</option>');
		 });
   		form.render('select');
	     }
	 });
}

</script>
<%@ include file="/pages/common/footer.jsp"%>