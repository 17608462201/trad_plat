<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%  
//页面标题设置
	request.setAttribute("pageTitle","工作信息");  
	//如果不需要公用的css,请使用下面代码 (默认是为true)
	//request.setAttribute("INCLUDE_SKIN",false);
	//如果不需要公用的js,请使用下面代码 (默认是为true)
	//request.setAttribute("INCLUDE_COMMON",false);
	//如果不需要公用的css,请使用下面代码 (默认是为true)
	//request.setAttribute("INCLUDE_CSS",false);
%>
<%@ include file="/pages/common/header.jsp" %>
 <form class="layui-form" action="${ctx }/customer/saveCustomerWork?customerId=${customerId}" method="post">
          <div class="layui-row" style="padding-top: 2px;padding-bottom: 5px;">
          <div class="layui-col-xs6">
		      <div class="grid-demo grid-demo-bg1">&nbsp;</div>
		    </div>
		    <div class="layui-col-xs3">
		      <div class="grid-demo grid-demo-bg1">&nbsp;</div>
		    </div>
		    <div class="layui-col-xs3">
		      <div class="grid-demo grid-demo-bg1">
		            <button class="layui-btn" lay-submit lay-filter="*"><i class="layui-icon">&#xe61a;</i>保存</button>
			        <button class="layui-btn layui-btn-danger" type="reset"><i class="layui-icon">&#x1002;</i>重置</button>
			      <c:if test="${not empty customerWork.id}">
				      <a class="layui-btn" id="edit"><i class="layui-icon">&#xe642;</i>编辑</a>
				    </c:if>
		      </div>
		    </div>
         </div>
        <hr>
         <input type="hidden" id="customerId" name="customerId" value="${customerWork.customerId }">
         <input type="hidden" id="id" name="id" value="${customerWork.id }">
	      <div class="layui-row">
		    <div class="layui-col-xs6">
		      <div class="layui-form-item">
	           <label class="layui-form-label">公司名称：</label>
	           <div class="layui-input-block">
                     <input type="text" name="companyName" value="${customerWork.companyName }" id="companyName" lay-verify="required" placeholder="请输入公司名称" autocomplete="off" class="layui-input">
	           </div>
		      </div>
		    </div>
		    <div class="layui-col-xs6">
		         <div class="layui-form-item">
				    <label class="layui-form-label">公司类别：</label>
				    <div class="layui-input-inline">
				      <select name="companyType"  id="companyType" >
				        <option value="">${customerWork.companyType ==null ? '请选择公司类别':customerWork.companyType} </option>
				      </select>
				    </div>
				 </div>
		    </div>
		 </div>
		 <div class="layui-row">
		    <div class="layui-col-xs6">
		      <div class="grid-demo grid-demo-bg1">
		          <div class="layui-form-item">
				    <label class="layui-form-label">部门：</label>
				    <div class="layui-input-inline">
			                <input type="text" name="department" value="${customerWork.department }" placeholder="请输入部门"   autocomplete="off" class="layui-input">
			           </div>
				    </div>
		      </div>
		    </div>
		    <div class="layui-col-xs6">
		      <div class="grid-demo">
		          <div class="layui-form-item">
			           <label class="layui-form-label">职务：</label>
			           <div class="layui-input-inline">
			                <input type="text" name="job" value="${customerWork.job }" lay-verify="required" placeholder="请输入职务" autocomplete="off" class="layui-input">
			           </div>
			      </div>
				 </div>
		      </div>
		    </div>
		 </div>
		 <div class="layui-row">
		    <div class="layui-col-xs6">
		      <div class="grid-demo grid-demo-bg1">
		          <div class="layui-form-item">
				    <label class="layui-form-label">入职时间：</label>
				    <fmt:formatDate var="startTime" value="${customerWork.startTime }" pattern="yyyy-MM-dd"/>
				    <div class="layui-input-inline">
				        <input type="text" name="startTime" value="${startTime }" id="startTime" placeholder="yyyy-MM-dd" autocomplete="off" class="layui-input">
				      </div>
				 </div>
		      </div>
		    </div>
		    <div class="layui-col-xs6">
		      <div class="grid-demo">
		          <div class="layui-form-item">
			           <label class="layui-form-label">平均工资：</label>
			           <div class="layui-input-inline">
			                <input type="text" name="payMonth" id="payMonth" value="${customerWork.payMonth }" lay-verify="required|number"  placeholder="请输入月平均工资" autocomplete="off" class="layui-input">
			           </div>
			      </div>
		      </div>
		    </div>
		 </div>
		   <div class="layui-row">
		    <div class="layui-col-xs6">
		      <div class="grid-demo grid-demo-bg1">
		        <div class="layui-inline">
				      <label class="layui-form-label">发薪日期：</label>
				      <fmt:formatDate var="payTime" value="${customerWork.payTime }" pattern="yyyy-MM-dd"/>
				       <div class="layui-input-inline">
				        <input type="text" name="payTime" value="${payTime }" lay-verify="date" id="payTime" placeholder="yyyy-MM-dd" autocomplete="off" class="layui-input">
				      </div>
				  </div>
		      </div>
		    </div>
		    <div class="layui-col-xs6">
		      <div class="grid-demo">
		         <div class="layui-form-item">
				    <label class="layui-form-label">发放形式：</label>
				      <div class="layui-input-inline">
				      <select name="payType"  id="payType" >
				        <option value="">${customerWork.payType ==null ? '请选择月工资发放形式':customerWork.payType} </option>
				      </select>
				    </div>
			   </div>
		      </div>
		    </div>
		 </div>
		  <div class="layui-row">
		    <div class="layui-col-xs6">
		      <div class="grid-demo grid-demo-bg1">
		         <div class="layui-form-item">
				      <label class="layui-form-label">家庭收入（元）：</label>
				      <div class="layui-input-inline">
			               <input type="text" name="homePayMonth" id="homePayMonth" value="${homePayMonth.address }" lay-verify="required\number" placeholder="请输入家庭月收入" autocomplete="off" class="layui-input">
				      </div>
				  </div>
		      </div>
		    </div>
		    <div class="layui-col-xs6">
		      <div class="grid-demo grid-demo-bg1">
		         <div class="layui-form-item">
		           <label class="layui-form-label">公司地址：</label>
		           <div class="layui-input-block">
		                <input type="text" name="address" value="${customerWork.address }" id="address" lay-verify="required" placeholder="请输入公司地址" autocomplete="off" class="layui-input">
		           </div>
			      </div>
		      </div>
		    </div>
		 </div>
	</div>
</form>

<script>
layui.use(['form','laydate'], function(){
	  var form = layui.form
	  ,laydate = layui.laydate;
	  
	  laydate.render({
	    elem: '#startTime'
	  });
	  
	  laydate.render({
		    elem: '#payTime'
		  });
	  
	  initGroupSelect(form);
	  var hasData = '${customerWork.id }';
	  if(hasData != ''){
		  $("input").attr("disabled", true);
		  $("select").attr("disabled", true);
		  $("button").hide();
		  $("#edit").show();
	  }
	  
	  
	  $("#edit").on("click",function(){
		  //js方法解除禁用
		 $("input").removeAttr("disabled");
		 $("select").removeAttr("disabled");
		 $("button").show();
		 $("#edit").hide();
		 form.render('select');
	});
});

function initGroupSelect(form){
	$.ajax({
	     url: "${ctx}/common/getGGdmj?dmjbhs=gslb,gzffxs", 
	     dataType: "json", 
	     success: function(data){
   		 var jsonData  = eval(data); 
   		 $.each(jsonData['gslb'],function(index,val){
   			 $("#companyType").append('<option value="'+val.dmnr+'">'+val.dmnr+'</option>');
   		 });
   		$.each(jsonData['gzffxs'],function(index,val){
  			 $("#payType").append('<option value="'+val.dmnr+'">'+val.dmnr+'</option>');
  		 });
   		form.render('select');
	     }
	 });
}

</script>
<%@ include file="/pages/common/footer.jsp"%>