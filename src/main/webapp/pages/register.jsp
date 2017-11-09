<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%  
//页面标题设置
	request.setAttribute("pageTitle","用户注册");  
	//如果不需要公用的css,请使用下面代码 (默认是为true)
	//request.setAttribute("INCLUDE_SKIN",false);
	//如果不需要公用的js,请使用下面代码 (默认是为true)
	//request.setAttribute("INCLUDE_COMMON",false);
%>
<%@ include file="/pages/common/header.jsp" %>
<form class="layui-form" action="${ctx }/register/doReg" method="post">
 <div style="padding-top: 50px;"></div>
      <div class="layui-col-xs6" align="right">
		      <div class="grid-demo grid-demo-bg1">
		          <img title="logo"   src="${ctx }/res/images/login/xct.jpg" >
		      </div>
		    </div>
		    <div class="layui-col-xs6" align="left">
		      <fieldset class="layui-elem-field" style="width: 500px;height: 650px;">
					 <legend><i class="layui-icon" style="font-size: 30px;">&#xe613;用户注册</i> </legend>
					  <div style="height: 50px;" id="showText" ></div>
				      <div class="layui-form-item">
				           <label class="layui-form-label">用户名：</label>
				           <div class="layui-input-inline">
				                <input type="text" name="userName" id="userNameId" required  lay-verify="userName" onchange="checkUserName(this)" placeholder="请输入用户名" autocomplete="off" class="layui-input">
				           </div>
				      </div>
				      <div class="layui-form-item">
				           <label class="layui-form-label">真实姓名：</label>
				           <div class="layui-input-inline">
				                <input type="text" name="realName" required  lay-verify="realName" placeholder="请输入真实姓名" autocomplete="off" class="layui-input">
				           </div>
				      </div>
					  <div class="layui-form-item">
					    <label class="layui-form-label">密码：</label>
					    <div class="layui-input-inline">
					      <input type="password" name="password" required lay-verify="password" placeholder="请输入密码" autocomplete="off" class="layui-input">
					    </div>
					    <div class="layui-form-item">
					    <label class="layui-form-label">确认密码：</label>
					    <div class="layui-input-inline">
					      <input type="password" name="password2" required lay-verify="required" id="password2" onchange="validatePass();" placeholder="请确认密码" autocomplete="off" class="layui-input">
					    </div>
					    <div class="layui-form-mid layui-word-aux">两次密码必须一致！</div>
					  </div>
					  <div class="layui-form-item">
						    <label class="layui-form-label">所属小组</label>
						    <div class="layui-input-inline">
						      <select name="groupId" required lay-verify="required"  id="groupId">
						        <option value="">请选择小组</option>
						      </select>
						    </div>
					  </div>
					   <div class="layui-row">
						    <div class="layui-col-md6">
						         <div class="layui-form-item">
						           <label class="layui-form-label">手机：</label>
						          <div class="layui-input-block">
						                <input type="text" name="phone" required  lay-verify="phone" placeholder="请输入手机号" autocomplete="off" class="layui-input">
						           </div>
						         </div>
						    </div>
						    <div class="layui-col-md6">
						         <div class="layui-form-item">
						           <label class="layui-form-label">Email：</label>
						           <div class="layui-input-block">
						                <input type="text" name="email" required   lay-verify="email" placeholder="请输入Email" autocomplete="off" class="layui-input">
						           </div> 
						      </div>
						    </div>
					    </div>
				      <div class="layui-row">
					    <div class="layui-col-md6">
					            <div class="layui-form-item">
							    <label class="layui-form-label">性别：</label>
							    <div class="layui-input-block">
							      <input type="radio" name="sex" value="男" title="男">
							      <input type="radio" name="sex" value="女" title="女" checked>
							    </div>
							  </div>
					    </div>
					    <div class="layui-col-md6">
					            <div class="layui-form-item">
							    <label class="layui-form-label">职业：</label>
							    <div class="layui-input-block">
						              <input type="text" name="job" lay-verify="job" placeholder="请输入职业" autocomplete="off" class="layui-input">
							    </div>
							  </div>
					    </div>
				      </div>
				      <div class="layui-form-item">
					    <label class="layui-form-label">住址：</label>
					    <div class="layui-input-block">
				              <input type="text" name="liveAddress" required  lay-verify="liveAddress" placeholder="请输入住址" autocomplete="off" class="layui-input">
					    </div>
					  </div>
					  <div class="layui-form-item">
					    <div class="layui-input-block">
					      <button class="layui-btn" lay-submit lay-filter="myForm">立即提交</button>
					      <button type="reset" class="layui-btn layui-btn-primary">重置</button>
					    </div>
					  </div>
             </div>
		</fieldset>
   </div>
</form>
 
<script>
//Demo
layui.use('form', function(){
  var form = layui.form;
  form.verify({
		//value：表单的值、item：表单的DOM对象
		       userName: function(value, item){ 
	    	     if(!(/^[a-zA-Z]{1}([a-zA-Z0-9]|[._]){4,19}$/.test(value))){
			    	return  '用户名必须5-20个以字母开头、可带数字、“_”、“.”的字串';
			      }
			  },
			  realName: function(value, item){ 
		    	     if(!(/^[\u4E00-\u9FA5]{2,8}$/.test(value))){
				    	return  '真实姓名必须2-8个汉字';
				      }
				  },
			  //我们既支持上述函数式的方式，也支持下述数组的形式
			  //数组的两个值分别代表：[正则匹配、匹配不符时的提示文字]
		      password: [
                /^(\w){6,20}$/
			    ,'密码必须6到20个字母、数字、下划线'
			  ],
			  phone: [/^1[3|4|5|7|8]\d{9}$/, '手机必须11位，只能是数字！'] ,
		      email: [/^[a-z0-9._%-]+@([a-z0-9-]+\.)+[a-z]{2,4}$|^1[3|4|5|7|8]\d{9}$/, '邮箱格式不对']  
	  });
    initGroupSelect(form);
});

//校验用户名是否已存在
function checkUserName(obj){
	 $.ajax({
		     url: "${ctx}/register/checkUserName?sName="+obj.value, 
		     dataType: "text", 
		     success: function(data){
	    		 if(data== "success"){
	    			 layer.tips('恭喜，该用户可以注册!', '#userNameId',{
	    				  tips: 2,
	    				  tipsMore: true
	    			 });
	    		 }
		     }
  	 });
}

function initGroupSelect(form){
	$.ajax({
	     url: "${ctx}/register/getGroup", 
	     dataType: "json", 
	     success: function(data){
   		 var jsonData  = eval(data); 
   		 $.each(jsonData,function(index,val){
   			 $("#groupId").append('<option value="'+val.id+'">'+val.groupName+'</option>');
   		 });
   		form.render('select');
	     }
	 });
}

function validatePass(){
	var password = $("input[name='password']");
	var password2 = $("input[name='password2']");
	if(password.val() != password2.val()){
		layer.msg("两次密码输入不一致,请重新输入！");
		password.val("");
		password2.val("");
	}else{
	   layer.tips('恭喜，两次密码输入一致!', '#password2',{
 				  tips: 2,
 				  tipsMore: true
 			 });
	}
}
    
</script>
<%@ include file="/pages/common/footer.jsp"%>