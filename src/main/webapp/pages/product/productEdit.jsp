<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%  
//页面标题设置
	request.setAttribute("pageTitle","新增产品");  
	//如果不需要公用的css,请使用下面代码 (默认是为true)
	//request.setAttribute("INCLUDE_SKIN",false);
	//如果不需要公用的js,请使用下面代码 (默认是为true)
	//request.setAttribute("INCLUDE_COMMON",false);
	//如果不需要公用的css,请使用下面代码 (默认是为true)
	//request.setAttribute("INCLUDE_CSS",false);
%>
<%@ include file="/pages/common/header.jsp" %>
<form class="layui-form" action="#" method="post">
           <div class="layui-row" style="padding-top: 10px;padding-bottom: 5px;">
          <div class="layui-col-xs6">
		      <div class="grid-demo grid-demo-bg1">&nbsp;</div>
		    </div>
		    <div class="layui-col-xs3">
		      <div class="grid-demo grid-demo-bg1">&nbsp;</div>
		    </div>
		    <div class="layui-col-xs3">
		      <div class="grid-demo grid-demo-bg1">
		       <button class="layui-btn" lay-submit lay-filter="*"><i class="layui-icon">&#xe61a;</i>保存</button>
		      <c:if test="${not empty pro.id}">
				      <a class="layui-btn" id="edit"><i class="layui-icon">&#xe642;</i>编辑</a>
			  </c:if>
		      </div>
		    </div>
         </div>
        <hr>
     <div class="layui-form-item">
          <label class="layui-form-label">产品名称：</label>
          <div class="layui-input-inline">
               <input type="text" name="name"  value="${pro.name }"  required placeholder="请输入产品名称" autocomplete="off" class="layui-input">
          </div>
     </div>
     <div class="layui-form-item">
          <label class="layui-form-label">产品描述：</label>
          <div class="layui-input-block">
               <input type="text" name="decription" value="${pro.name }"    placeholder="请输入产品描述" autocomplete="off" class="layui-input">
          </div>
     </div>
      <div class="layui-form-item">
          <label class="layui-form-label">还款方式：</label>
          <div class="layui-input-inline">
               <select name="payName" id="payName" lay-verify="required" >
               <option value="">${pro.payName ==null ? '请选择还款方式':pro.payName } </option>
		      </select>
          </div>
     </div>
      <div class="layui-form-item">
	    <label class="layui-form-label">还款期数：</label>
	    <div class="layui-input-inline">
	      <input type="text" name="payTimes"  value="${pro.payTimes }"  lay-verify="required" placeholder="请输入还款期数" autocomplete="off" class="layui-input">
	    </div>
	    <div class="layui-form-mid layui-word-aux">期</div>
	  </div>
	  <div class="layui-form-item">
	    <label class="layui-form-label">还款利率：</label>
	    <div class="layui-input-inline">
	      <input type="text" name="trad" value="${pro.trad }" required lay-verify="required" placeholder="请输入还款利率" autocomplete="off" class="layui-input">
	    </div>
	    <div class="layui-form-mid layui-word-aux">%（日）</div>
	  </div>
	  <div class="layui-form-item">
	    <label class="layui-form-label">付款对象：</label>
	      <div class="layui-input-inline">
	       <select name="payobj" id="payobj" lay-verify="required" >
	            <option value="">${pro.payobj ==null ? '请选择付款对象':pro.payobj } </option>
		      </select>
	    </div>
	  </div>
	  <div class="layui-form-item">
	    <label class="layui-form-label">罚息方式：</label>
	    <div class="layui-input-inline">
	     <select name="punishtype"   id="punishtype">
	     <option value="">${pro.punishtype ==null ? '请选择罚息方式':pro.punishtype } </option>
	      </select>
	      </div>
	  </div>
	  <div class="layui-form-item">
	    <label class="layui-form-label">罚息额：</label>
	    <div class="layui-input-inline">
	      <input type="text" name="punishtrad" value="${pro.punishtrad }"  required lay-verify="required" placeholder="请输入罚息额" autocomplete="off" class="layui-input">
	    </div>
	    <div class="layui-form-mid layui-word-aux">%</div>
	  </div>
	   <div class="layui-form-item">
          <label class="layui-form-label">最高放贷：</label>
          <div class="layui-input-inline">
               <input type="text" name="mostmon" value="${pro.mostmon }"   placeholder="请输入最高放贷金额" autocomplete="off" class="layui-input">
          </div>
          <div class="layui-form-mid layui-word-aux">元</div>
     </div>
</form>
 
<script>
	layui.use('form', function(){
		  var form = layui.form;
		  initGroupSelect(form);
	
		var hasData = '${pro.id }';
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
		     url: "${ctx}/common/getGGdmj?dmjbhs=payType,fxfs,payobj", 
		     dataType: "json", 
		     success: function(data){
	   		 var jsonData  = eval(data); 
	   		 $.each(jsonData['payType'],function(index,val){
	   			 $("#payName").append('<option value="'+val.dm+'">'+val.dmnr+'</option>');
	   		 });
	   		$.each(jsonData['fxfs'],function(index,val){
	  			 $("#punishtype").append('<option value="'+val.dm+'">'+val.dmnr+'</option>');
	  		 });
	   		$.each(jsonData['payobj'],function(index,val){
	  			 $("#payobj").append('<option value="'+val.dm+'">'+val.dmnr+'</option>');
	  		 });
	   		
	   		form.render('select');
		     }
		 });
	}

</script>
<%@ include file="/pages/common/footer.jsp"%>