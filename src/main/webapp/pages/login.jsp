<%@page import="com.trad.util.DataConvertUtil"%>
<%@page import="com.trad.util.SercurityUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%  
//页面标题设置
	 request.setAttribute("pageTitle","用户登录");  
	//如果不需要公用的css,请使用下面代码 (默认是为true)
	//request.setAttribute("INCLUDE_SKIN",false);
	//如果不需要公用的js,请使用下面代码 (默认是为true)
	//request.setAttribute("INCLUDE_COMMON",false);
	//如果用户未登录，则检测cookie是否存在，如果存在将cookie推送到登录界面
 	   Cookie[] cookies=request.getCookies();
 	   int num = 0;
 	   for(Cookie cookie: cookies)
 		{
 			//如果能找到用户名和密码，设置到request中
 			if(!StringUtils.isEmpty(cookie.getName()) &&Constant.COOKIE_NAME.equals(cookie.getName())){
 				request.setAttribute(Constant.COOKIE_NAME, new String(new BASE64Decoder().decodeBuffer(cookie.getValue())));
 				num++;
 			}
 			if(!StringUtils.isEmpty(cookie.getName()) &&Constant.COOKIE_PASS.equals(cookie.getName())){
 				request.setAttribute(Constant.COOKIE_PASS, new String(SercurityUtils.decryptDES(DataConvertUtil.hexStringToBytes(cookie.getValue()))));
 				num++;
 			}
 			if(num == 2){
 				break;
 			}
 		} 
%>
<%@ include file="/pages/common/header.jsp" %>
 <c:if test="${viewer eq 'success'}">
    <i class="layui-icon" style="font-size: 30px; color: #CD919E;text-align: center;padding-left: 400px;">&#xe6af;恭喜您注册成功，请登录！</i>  
</c:if>
 <c:if test="${relogin eq '1'}">
    <i class="layui-icon" style="font-size: 30px; color: #CD919E;text-align: center;padding-left: 400px;">&#xe69c;登陆失效，请重新登录！</i>  
 </c:if>
 <form class="layui-form" action="${ctx }/login/submit" method="post">
      <div style="padding-top: 50px;"><input type="hidden" value="${failedText }" id="failedText" ></div>
      <div class="layui-col-xs6" align="right">
		      <div class="grid-demo grid-demo-bg1">
		            <img title="logo"   src="${ctx }/res/images/login/xct.jpg" >
		      </div>
		    </div>
		    <div class="layui-col-xs6" align="left">
		      <fieldset class="layui-elem-field" style="width: 400px;height: 450px;">
						  <legend><i class="layui-icon" style="font-size: 30px;">&#xe613;用户登录</i> </legend>
						  <div style="height: 50px;" id="showText" ></div>
						  <div class="layui-form-item">
				           <div class="layui-input-inline" style="width: 250px;text-align: center;">
				                <input type="text" name="userName" id="userNameId" required  lay-verify="userName" placeholder="请输入用户名" onchange="tipsValid('1','userNameId')"  value="${requestScope.plat_name_0001_test_123456 }" autocomplete="off" class="layui-input">
				           </div>
					      </div>
						  <div class="layui-form-item">
						    <div class="layui-input-inline" style="width: 250px;">
						      <input type="password" name="password" id="passwordId" required lay-verify="password" placeholder="请输入密码"  onchange="tipsValid('2','passwordId')"  value="${requestScope.plat_word_0001_test_123456 }" autocomplete="off" class="layui-input">
						    </div>
						    </div>
						      <div class="layui-row" style="width: 250px;">
								    <div class="layui-col-xs6">
								      <div class="grid-demo grid-demo-bg1"><input type="text" id="imageId" name="imageCode" class="layui-input" required onchange="imageValid(this)" placeholder="请输入验证码" maxlength="4" /></div>
								    </div>
								    <div class="layui-col-xs6">
								      <div class="grid-demo"><img src="${ctx}/login/getImage" onclick="reloadcode(this)" title="单击刷新验证码" id="img_rand_code" ></div>
								    </div>
								<div class="layui-row">
									    <div class="layui-col-md5">
									          <label class="layui-form-label"  style="text-align: center;">记住一周</label>
									    </div>
									    <div class="layui-col-md5">
									          <input type="checkbox" style="text-align: left;" name="remeberPass" lay-skin="switch" lay-text="是|否" <c:if test="${requestScope.plat_word_0001 ne ''}">checked</c:if>>
									    </div>
							  </div>
							  <div style="height: 10px;"></div>
						    <div class="layui-form-item">
					                  <button lay-submit  class="layui-btn layui-btn-big" lay-filter="formSub" style="width: 250px;">登陆</button>
						    </div>
				          <div class="layui-row" style="width: 250px;">
						      <div class="layui-col-xs6"><a href="${ctx}/register/init" class="fl">&nbsp;&nbsp;&nbsp;&nbsp;立即注册</a></div>
						      <div class="layui-col-xs6"><a href="${ctx}/login/forgetPassword" class="fr">忘记密码？</a></div>
						  </div>
			  </fieldset>
		    </div>
</form>
<script type="text/javascript">
layui.use('form', function(){
	  var myForm = layui.form;
	//监听提交
	  myForm.on('submit(formSub)', function(data){
   		  if(tipsValid('1','userNameId') &&  tipsValid('2','passwordId')){
   				return true;
   		   }
   	      return false;
	  });
});


$(document).ready(function(){
	  var failedText  = $("#failedText").val();
	  if(failedText != '' && failedText !='undefined'){
	  	 $("#showText").html('<font color="red" >'+failedText+'</font>');
	  }
});

	
function tipsValid(type,id){
	var tipStr ='';
	var value = $("#"+id).val();
	if(type == "1"){
		    if(!(/^[a-zA-Z]{1}([a-zA-Z0-9]|[._]){4,19}$/.test(value))){
		    	tipStr = '用户名必须5-20个以字母开头、可带数字、“_”、“.”的字串';
		    }
	}else{
		if(!(/^(\w){6,20}$/.test(value))){
			tipStr = '密码必须6到20个字母、数字、下划线';
		}
	}
	if(tipStr != ''){
		layer.tips(tipStr, '#'+id,{
				  tips: 2,
				  tipsMore: true
			 });
		return false
	}
	return true;
}
    

//验证验证码
function imageValid(obj){
	 $.ajax({
		     url: "${ctx}/login/validateImage?imageCode="+obj.value, 
		     dataType: "text", 
		     success: function(data){
	    		 if(data != "success"){
	    			 layer.tips('验证码输入错误', '#imageId',{
	    				  tips: 2,
	    				  tipsMore: true
	    			 });
	    		 }
		     }
  	 });
}
    

//刷新验证码
   function reloadcode(obj){    
     var rand=new Date().getTime(); 
     obj.src="${ctx}/login/getImage?abc="+rand;
   }
 
</script>
<%@ include file="/pages/common/footer.jsp"%>