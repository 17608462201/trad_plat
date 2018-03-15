<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%  
//页面标题设置
	request.setAttribute("pageTitle","客户私营业主信息");  
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
			           <label class="layui-form-label">企业名称：</label>
			           <div class="layui-input-block">
			                <input type="text" name="companyName" id="companyName"  lay-verify="required"  placeholder="请输入企业名称" autocomplete="off" class="layui-input">
			           </div>
			      </div>
		          <div class="layui-form-item">
				    <label class="layui-form-label">个人持股比：</label>
				    <div class="layui-input-inline">
				         <input type="text" name="persionHold" id="persionHold"lay-verify="required"  lay-verify="number"  placeholder="请输入个人持股比" autocomplete="off" class="layui-input">	
				    </div>
				 </div>
		         <div class="layui-form-item">
		           <label class="layui-form-label">注册时间：</label>
		           <div class="layui-input-inline">
		                <input type="text" name="registerTime" id="registerTime" lay-verify="required"  lay-verify="date"  placeholder="请输入注册时间" autocomplete="off" class="layui-input">
		           </div>
		        </div> 
		        <div class="layui-form-item">
			      <label class="layui-form-label">企业性质：</label>
			     <div class="layui-input-inline">
			             <select name="companyType" id="companyType">
				        <option value="">${customerPrivate.companyType ==null ? '请选择企业性质':customerPrivate.companyType} </option>
				      </select>
		           </div>
			  </div>
		      <div class="layui-form-item">
	           <label class="layui-form-label">经营场所：</label>
	           <div class="layui-input-block">
	                <input type="text" name="address" id="address" placeholder="请输入经营场所" autocomplete="off" class="layui-input">
	           </div>
		      </div>
		        <div class="layui-form-item">
	           <label class="layui-form-label">员工数量：</label>
	           <div class="layui-input-inline">
	                <input type="text" name="staffNum" id="staffNum" lay-verify="number"  placeholder="请输入员工数量" autocomplete="off" class="layui-input">
	           </div>
		      </div>
		      <div class="layui-form-item">
	           <label class="layui-form-label">企业地址：</label>
	           <div class="layui-input-block">
	                <input type="text" name="companyAddress" id="companyAddress" lay-verify="required" placeholder="请输入企业地址" autocomplete="off" class="layui-input">
	           </div>
		      </div>
</form>
 
<script>
layui.use(['form','laydate'], function(){
	  var form = layui.form
	  ,laydate = layui.laydate;
	  
	  laydate.render({
	    elem: '#registerTime'
	  });
	  
	  form.verify({
		  
	  });  
	  initGroupSelect(form);
	  
});

function initGroupSelect(form){
	$.ajax({
	     url: "${ctx}/common/getGGdmj?dmjbhs=gslb", 
	     dataType: "json", 
	     success: function(data){
   		 var jsonData  = eval(data); 
   		$.each(jsonData['gslb'],function(index,val){
			 $("#companyType").append('<option value="'+val.dmnr+'">'+val.dmnr+'</option>');
		 });
   		form.render('select');
	     }
	 });
}

</script>
<%@ include file="/pages/common/footer.jsp"%>