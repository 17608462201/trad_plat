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
<div class="layui-carousel" id="test1" lay-filter="test1">
  <div carousel-item="">
  	<c:forEach items="${fileList }" var="fileList">
  		<div><img src="${ctx}${fileList.address }"></div>
	</c:forEach>
  </div>
</div> 

<script>
layui.use('carousel', function(){
  var carousel = layui.carousel;
  carousel.render({
    elem: '#test1'
    ,arrow: 'always'
  });
});	
</script>
<%@ include file="/pages/common/footer.jsp"%>