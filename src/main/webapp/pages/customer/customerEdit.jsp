<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%  
//页面标题设置
	request.setAttribute("pageTitle","客户管理");  
	//如果不需要公用的css,请使用下面代码 (默认是为true)
	//request.setAttribute("INCLUDE_SKIN",false);
	//如果不需要公用的js,请使用下面代码 (默认是为true)
	//request.setAttribute("INCLUDE_COMMON",false);
	//如果不需要公用的css,请使用下面代码 (默认是为true)
	//request.setAttribute("INCLUDE_CSS",false);
%>
<%@ include file="/pages/common/header.jsp" %>
<div class="layui-tab" lay-filter="customerTab">
  <ul class="layui-tab-title">
   <li class="layui-this" lay-id="11">基本信息</li>
    <li lay-id="22">工作信息</li>
    <li lay-id="33">联系人资料</li>
    <li lay-id="44">私营业主</li>
  </ul>
  <div class="layui-tab-content">
  <!----------------------------------选项卡1---------------------------------------------->
    <div class="layui-tab-item layui-show">
         <iframe  id="tabFrame11" src="${ctx }/customer/commonEdit?customerId=${customerId}"  width="100%" height="100%" frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes"></iframe>
    </div>
    <!----------------------------------选项卡2---------------------------------------------->
    <div class="layui-tab-item">
         <iframe  id="tabFrame22" src="${ctx }/customer/workEdit?customerId=${customerId}"  width="100%" height="100%" frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes"></iframe>
    </div>
    <!----------------------------------选项卡3---------------------------------------------->
    <div class="layui-tab-item">
           <iframe  id="tabFrame33"  src="${ctx }/customer/contractEdit?customerId=${customerId}" width="100%" height="100%" frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes"></iframe>
    </div>
    <!----------------------------------选项卡4---------------------------------------------->
    <div class="layui-tab-item">
           <iframe   id="tabFrame44"  src="${ctx }/customer/privateEdit?customerId=${customerId}" width="100%" height="100%" frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes"></iframe>
    </div>
  </div>
</div> 

<script>
layui.use('element', function(){
	  var element = layui.element; //Tab的切换功能，切换事件监听等，需要依赖element模块
	  var $ = layui.jquery
	  var layid = location.hash.replace(/^#customerTab=/, '');
	  element.tabChange('customerTab', layid);
	  element.on('tab(customerTab)', function(data){
		  location.hash = 'customerTab='+ $(this).attr('lay-id');
		  var iframe=$(data.elem).find("iframe").eq(data.index);
		 if(data.index == 2 || data.index ==3){
			  var iframeSrc=$(iframe[0]).attr("src");
			  console.log(iframeSrc);
	          $(iframe[0]).attr("src",iframeSrc);
		  }
		});
	});	
</script>
<%@ include file="/pages/common/footer.jsp"%>