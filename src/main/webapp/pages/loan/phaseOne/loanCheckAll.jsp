<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	//页面标题设置
	request.setAttribute("pageTitle", "新增产品");
	//如果不需要公用的css,请使用下面代码 (默认是为true)
	request.setAttribute("INCLUDE_UPLOAD",true);
	//如果不需要公用的js,请使用下面代码 (默认是为true)
	//request.setAttribute("INCLUDE_COMMON",false);
	//如果不需要公用的css,请使用下面代码 (默认是为true)
	//request.setAttribute("INCLUDE_CSS",false);
%>
<%@ include file="/pages/common/header.jsp"%>
<div class="layui-tab" lay-filter="customerTab">
  <ul class="layui-tab-title">
   <li class="layui-this" lay-id="11">借款基本信息</li>
    <li lay-id="22">下户信息</li>
    <li lay-id="33">复核信息</li>
    <li lay-id="44">费用核算</li>
    <li lay-id="55">签约合同信息</li>
  </ul>
  <div class="layui-tab-content">
	  <div class="layui-tab-item layui-show">
	       <iframe  id="tabFrame11" src="${ctx }/loan/loanCheck?loanId=${loanId}"  width="100%" height="100%" frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes"></iframe>
	  </div>
	  <div class="layui-tab-item">
           <iframe  id="tabFrame22" src="${ctx }/loanPhaseTow/loanCheck?loanId=${loanId}"  width="100%" height="100%" frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes"></iframe>
      </div>
      <div class="layui-tab-item">
           <iframe  id="tabFrame33"  src="${ctx }/loanPhaseThree/loanCheck?loanId=${loanId}" width="100%" height="100%" frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes"></iframe>
      </div>
      <div class="layui-tab-item">
           <iframe  id="tabFrame44"  src="${ctx }/loanPhaseFour/loanCheck?loanId=${loanId}" width="100%" height="1300" frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes"></iframe>
      </div>
      <div class="layui-tab-item">
           <iframe  id="tabFrame55"  src="${ctx }/loanPhaseFive/loanCheck?loanId=${loanId}" width="100%" height="100%" frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes"></iframe>
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
// 		 if(data.index == 2 || data.index ==3){
// 			  var iframeSrc=$(iframe[0]).attr("src");
// 	          $(iframe[0]).attr("src",iframeSrc);
// 		  }
		});
	});	
</script>
<%@ include file="/pages/common/footer.jsp"%>