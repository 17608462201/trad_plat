<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%  
//页面标题设置
	request.setAttribute("pageTitle","汉融贷金服");  
	//如果不需要公用的css,请使用下面代码 (默认是为true)
	//request.setAttribute("INCLUDE_SKIN",false);
	//如果不需要公用的js,请使用下面代码 (默认是为true)
	//request.setAttribute("INCLUDE_COMMON",false);
	//如果不需要公用的css,请使用下面代码 (默认是为true)
	//request.setAttribute("INCLUDE_CSS",false);
%>
<%@ include file="/pages/common/header.jsp" %>
<div class="layui-layout layui-layout-admin">
  <div class="layui-header">
    <div class="layui-logo">汉融贷金服</div>
    <!-- 头部区域（可配合layui已有的水平导航） -->
    <ul class="layui-nav layui-layout-left">
    <c:forEach items="${treeListVo }" var="tree" varStatus="status">
         <li class="layui-nav-item"><a   href="#" onclick="changeLeftMenu('${tree.id}')">${tree.name }</a></li>
    </c:forEach>
      <!-- <li class="layui-nav-item">
        <a href="javascript:;">其它系统</a>
        <dl class="layui-nav-child">
          <dd><a href=""></a></dd>
          <dd><a href=""></a></dd>
          <dd><a href=""></a></dd>
        </dl>
      </li> -->
    </ul>
    <ul class="layui-nav layui-layout-right">
      <li class="layui-nav-item">
        <a href="javascript:;">
          <img src="http://t.cn/RCzsdCq" class="layui-nav-img">
          ${loginUser.userName}
        </a>
        <dl class="layui-nav-child">
          <dd><a >基本资料</a></dd>
          <dd><a >安全设置</a></dd>
        </dl>
      </li>
      <li class="layui-nav-item"><a href="${ctx }/login/loginOut">退了</a></li>
    </ul>
  </div>
  
  <div class="layui-side layui-bg-black" >
    <div class="layui-side-scroll">
      <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
      <ul class="layui-nav layui-nav-tree"  lay-filter="test">
        <li class="layui-nav-item layui-nav-itemed">
          <!-- <a class="" href="javascript:;">所有商品</a> -->
          <dl class="layui-nav-child"  id="leftMena">
          <c:if test="${not empty treeListVo[0].children}">
                <c:forEach items="${treeListVo[0].children}"  var="item">
                  <dd><a  href="#" onclick="changeFrameUrl(this,'${item.href }');">${item.name }</a></dd>
                </c:forEach>
          </c:if>
          </dl>
        </li>
        <!-- <li class="layui-nav-item"><a href="">test</a></li> -->
      </ul>
    </div>
  </div>
  
  <div class="layui-body">
    <!-- 内容主体区域 -->
    <div style="padding: 15px;"><iframe src="" id="myBody" height="100%" width="100%" frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes"></iframe></div>
  </div>
  <div class="layui-footer">
    © 汉融贷金服
  </div>
</div>
<script>
//JavaScript代码区域
layui.use('element', function(){
  var element = layui.element;
});

function changeLeftMenu(id){
	var content ='';
	 $.ajax({
	     url: "${ctx}/tree/getMenuList?parentId="+id, 
	     dataType: "json", 
	     success: function(data){
    		 if(data != '' && data[0].parentId == id){
    			 $.each(data, function(index,val) {
    				 var url = val.href;
    				 if(url.indexOf("http:")  == -1){
    					 url ='${ctx}'+url; 
    				 }
    				 content += '<dd><a  href="#" onclick="changeFrameUrl(this,\''+url+'\');">'+val.name+'</a></dd>';
    			    });
    			 $("#leftMena").html(content);
    		 }
	     }
	 });
}

function changeFrameUrl(obj,url){
	document.getElementById("myBody").src = url;
	$(obj).css({"background-color": "#009688","color": "#fff"});
	$(".layui-nav-child a").not(obj).css({"background-color": ""});
}
//iframe 嵌套html出现双滚动条
function ajustFrame(){
	var ht = $(window).height();//获取浏览器窗口的整体高度；
	var topHeader = $(".warp_header").height();//获取头部高度，定义一个变量名为topHeader
	$(".sidebar").height(ht);
	$("#rightFrame").height(ht);
	$(".sidebar").height(ht-topHeader);//计算左边高度：窗口高度-头部高度
	$("#rightFrame").height(ht-topHeader);//计算右边高度：窗口高度-头部高度
  }
	

</script>
<%@ include file="/pages/common/footer.jsp"%>