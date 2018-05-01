<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%  
//页面标题设置
	request.setAttribute("pageTitle","基本信息");  
	//如果不需要公用的css,请使用下面代码 (默认是为true)
	//request.setAttribute("INCLUDE_SKIN",false);
	//如果不需要公用的js,请使用下面代码 (默认是为true)
	//request.setAttribute("INCLUDE_COMMON",false);
	//如果不需要公用的css,请使用下面代码 (默认是为true)
	//request.setAttribute("INCLUDE_CSS",false);
%>
<%@ include file="/pages/common/header.jsp" %>
 <form class="layui-form" action="${ctx }/customer/saveCustomer" method="post">
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
			       <c:if test="${not empty customer.id}">
				      <a class="layui-btn" id="edit"><i class="layui-icon">&#xe642;</i>编辑</a>
				    </c:if>
		      </div>
		    </div>
         </div>
        <hr>
         <input type="hidden" id="id" name="id" value="${customer.id }">
		 <div class="layui-row">
		    <div class="layui-col-xs6">
		      <div class="grid-demo grid-demo-bg1">
		          <div class="layui-form-item">
				    <label class="layui-form-label">客户来源：</label>
				    <div class="layui-input-inline">
				      <select name="source"  id="source" >
				        <option value="">${customer.source ==null ? '请选择客户来源':customer.source} </option>
				      </select>
				    </div>
				 </div>
		      </div>
		    </div>
		    <div class="layui-col-xs6">
		      <div class="grid-demo">
		          <div class="layui-form-item">
				    <label class="layui-form-label">客户经理：</label>
				    <div class="layui-input-inline">
			                <input type="text" name="managerName" lay-verify="required" value="${customer.manager }" disabled="disabled"  id="managerName" autocomplete="off" class="layui-input">
			                <input type="hidden" id="manager" name="manager">
			           </div>
			           <div><button class="layui-btn layui-btn-normal"  id="userSelect" >...</button></div>
				    </div>
				 </div>
		      </div>
		    </div>
		 </div>
		 <div class="layui-row">
		    <div class="layui-col-xs6">
		      <div class="grid-demo grid-demo-bg1">
		         <div class="layui-form-item">
			           <label class="layui-form-label">客户姓名：</label>
			           <div class="layui-input-inline">
			                <input type="text" name="name" id="name" value="${customer.name }" lay-verify="required" placeholder="请输入客户姓名" autocomplete="off" class="layui-input">
			           </div>
			      </div>
		      </div>
		    </div>
		    <div class="layui-col-xs6">
		      <div class="grid-demo">
		          <div class="layui-inline">
				      <label class="layui-form-label">出生日期：</label>
				      <fmt:formatDate var="birth" value="${customer.birthday }" pattern="yyyy-MM-dd"/>
				      <div class="layui-input-inline">
				        <input type="text" name="birthdayName" value="${birth }" id="birthdayName" lay-verify="date" placeholder="yyyy-MM-dd" autocomplete="off" class="layui-input">
				        <input type="hidden" id="birthday" name="birthday" value=""/>
				      </div>
				  </div>
		      </div>
		    </div>
		 </div>
		  <div class="layui-row">
		    <div class="layui-col-xs6">
		      <div class="grid-demo grid-demo-bg1">
		          <div class="layui-form-item">
				    <label class="layui-form-label">省份：</label>
				    <div class="layui-input-inline">
				      <select name="province" id="province" >
				        <option value="">${customer.province ==null ? '请选择客户省份':customer.province} </option>
				      </select>
				    </div>
				 </div>
		      </div>
		    </div>
		    <div class="layui-col-xs6">
		      <div class="grid-demo">
		          <div class="layui-form-item">
				     <label class="layui-form-label">市/区：</label>
				    <div class="layui-input-inline">
				      <select name="city"  id="city" >
				        <option value="">${customer.city ==null ? '请选择客户城市':customer.city} </option>
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
				    <label class="layui-form-label">证件类型：</label>
				    <div class="layui-input-inline">
				      <select name="credentials" id="credentials">
				        <option value="">${customer.credentials ==null ? '请选择客户来源':customer.credentials} </option>
				      </select>
				    </div>
				 </div>
		    </div>
		    </div>
		    <div class="layui-col-xs6">
		      <div class="grid-demo">
				  <div class="layui-form-item">
			           <label class="layui-form-label">证件号：</label>
			           <div class="layui-input-inline">
			                <input type="text" name="credentialsNum" id="credentialsNum" value="${customer.credentialsNum }"  lay-verify="required|identity"  placeholder="请输入证件号" autocomplete="off" class="layui-input">
			           </div>
			      </div>
		      </div>
		      </div>
		 </div>
		  <div class="layui-row">
		    <div class="layui-col-xs6">
		      <div class="grid-demo grid-demo-bg1">
		         <div class="layui-form-item">
				    <label class="layui-form-label">性别：</label>
				    <div class="layui-input-inline">
				      <input type="radio" name="sex" value="男" title="男" <c:if test="${customer.sex eq '男' }">checked=""</c:if>>
				      <input type="radio" name="sex" value="女" title="女" <c:if test="${customer.sex eq '女' }">checked=""</c:if>>
				    </div>
				  </div>
		      </div>
		    </div>
		    <div class="layui-col-xs6">
		      <div class="grid-demo grid-demo-bg1">
		         <div class="layui-form-item">
			           <label class="layui-form-label">手机号：</label>
			           <div class="layui-input-inline">
			                <input type="text" name="mobile" id="mobile" value="${customer.mobile }"  lay-verify="required|phone"  placeholder="请输入手机号" autocomplete="off" class="layui-input">
			           </div>
			      </div>
		      </div>
		    </div>
		 </div>
		 <div class="layui-row">
		    <div class="layui-col-xs6">
		      <div class="grid-demo grid-demo-bg1">
		         <div class="layui-form-item">
				    <label class="layui-form-label">婚姻状况：</label>
				    <div class="layui-input-inline">
				       <select name="marry"   id="marry">
				          <option value="">${customer.marry ==null ? '请选择婚姻状况':customer.marry}</option>
				          <option value="未婚">未婚</option>
				          <option value="已婚">已婚</option>
				      </select>
				    </div>
				  </div>
		      </div>
		    </div>
		    <div class="layui-col-xs6">
		      <div class="grid-demo">
		         <div class="layui-inline">
				       <label class="layui-form-label">最高学历：</label>
					    <div class="layui-input-inline">
					    <select name="record"  id="record">
				        <option value="">${customer.record ==null ? '请选择最高学历':customer.record}</option>
				      </select>
				  </div>
		      </div>
		    </div>
		 </div>
		 <div class="layui-row">
		    <div class="layui-col-xs6">
		      <div class="grid-demo grid-demo-bg1">
		         <div class="layui-form-item">
				    <label class="layui-form-label">住宅类别：</label>
				    <div class="layui-input-inline">
				     <select name="houseType"   id="houseType">
				        <option value="">${customer.houseType ==null ? '请选择住宅类型':customer.houseType}</option>
				      </select>
				    </div>
				  </div>
		      </div>
		    </div>
		    <div class="layui-col-xs6">
		      <div class="grid-demo">
		         <div class="layui-inline" >
				      <label class="layui-form-label">共同居住：</label>
					    <div class="layui-input-block">
					      <input type="radio" name="liveType" value="是" title="是" <c:if test="${customer.liveType eq '是' }">checked=""</c:if> >
					      <input type="radio" name="liveType" value="否" title="否" <c:if test="${customer.liveType eq '否' }">checked=""</c:if>>
					    </div>
				  </div>
		      </div>
		    </div>
		 </div>
		  <div class="layui-row">
		    <div class="layui-col-xs6">
		      <div class="layui-form-item">
	           <label class="layui-form-label">住宅地址：</label>
	           <div class="layui-input-block">
	                <input type="text" name="liveAddress" value="${customer.liveAddress }" id="liveAddress" placeholder="请输入住宅地址" autocomplete="off" class="layui-input">
	           </div>
		      </div>
		    </div>
		    <div class="layui-col-xs6">
		       <div class="layui-form-item">
				      <label class="layui-form-label">户口所在地：</label>
				      <div class="layui-input-block">
			               <input type="text" name="address" id="address" value="${customer.address }" placeholder="请输入用户名" autocomplete="off" class="layui-input">
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
	    elem: '#birthdayName'
   	    ,done: function(value, date){
   	    	var birValue = $("#birthdayName").val();
	   		$("#birthday").val(birValue);
   	    }
	  });
	  
	  initGroupSelect(form);
	  
	  var hasData = '${customer.id }';
	  if(hasData != ''){
		  $("input").attr("disabled", true);
		  $("select").attr("disabled", true);
		  $("button").hide();
		  $("#edit").show();
		  form.render('select');
	  }
	  
	  
	  $("#edit").on("click",function(){
		  //js方法解除禁用
		 $("input").removeAttr("disabled");
		 $("select").removeAttr("disabled");
		 $("button").show();
		 $("#edit").hide();
		 form.render('select');
		 form.render();
	});
});

function initGroupSelect(form){
	$.ajax({
	     url: "${ctx}/common/getGGdmj?dmjbhs=khly,zjlx,xl,fclx,province,city", 
	     dataType: "json", 
	     success: function(data){
   		 var jsonData  = eval(data); 
   		 $.each(jsonData['khly'],function(index,val){
   			 $("#source").append('<option value="'+val.dmnr+'">'+val.dmnr+'</option>');
   		 });
   		$.each(jsonData['zjlx'],function(index,val){
  			 $("#credentials").append('<option value="'+val.dmnr+'">'+val.dmnr+'</option>');
  		 });
   		$.each(jsonData['xl'],function(index,val){
 			 $("#record").append('<option value="'+val.dmnr+'">'+val.dmnr+'</option>');
 		 });
   		$.each(jsonData['fclx'],function(index,val){
			 $("#houseType").append('<option value="'+val.dmnr+'">'+val.dmnr+'</option>');
		 });
   		$.each(jsonData['province'],function(index,val){
			 $("#province").append('<option value="'+val.dmnr+'">'+val.dmnr+'</option>');
		 });
   		$.each(jsonData['city'],function(index,val){
			 $("#city").append('<option value="'+val.dmnr+'">'+val.dmnr+'</option>');
		 });
   		form.render('select');
	     }
	 });
}

$("#userSelect").on("click",function(){
	var managerVal = $("#manager").val();
	layer.open({
        type: 2
        ,title: '用户选择'
        ,area: ['800px', '480px']
        ,shade: 0
        ,maxmin: true
        ,offset: [
           5
        ] 
        ,content: '${ctx}/common/getUserTree?onlySelect=yes&masterId='+managerVal
        ,btn: ['确认', '关闭']
        ,yes: function(){
        	  var body = layer.getChildFrame('body', 0);
        	  var userIdsCheckName = body.find('input[name="userIdsCheckName"]').val();
        	  if(userIdsCheckName.indexOf(',')>-1){
        		  userIdsCheckName = userIdsCheckName.substr(0,userIdsCheckName.length-1)
        	  }
        	  $("#managerName").val(userIdsCheckName);
        	  $("#manager").val(userIdsCheckName);
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