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

<input type="hidden" name="id" id="id" value="${loanId }">

<div class="grid-demo grid-demo-bg1">
	<div class="layui-form-item">
		<label class="layui-form-label">退回接收：</label>
		<div class="layui-input-inline">
			<c:forEach items="${listGgdms }" var="listGgdms">
				<input type="radio" name="status" id="status" value="${listGgdms.dm }" title="${listGgdms.dmnr }">${listGgdms.dmnr }
			</c:forEach>
		</div>
	</div>
</div>

<div class="grid-demo grid-demo-bg1">
	<div class="layui-form-item">
		<label class="layui-form-label">借款单编号：</label>
		<div class="layui-input-inline">
			<textarea name="loan_opinion" id="loan_opinion" placeholder="请输入内容" class="layui-textarea"></textarea>
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