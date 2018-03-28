<%@page import="sun.misc.BASE64Decoder"%>
<%@page import="com.trad.util.Constant"%>
<%@page import="org.springframework.util.StringUtils"%>
<%@ page pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" 
%><%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"
%><%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" 
%><%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" 
%><%
    //清除缓存
    response.setHeader("Pragma","No-cache"); 
    response.setHeader("Cache-Control","no-cache"); 
    response.setDateHeader("Expires", 0);
    String ctx = request.getContextPath();
    if ("/".equals(ctx)) {
        ctx = "";
    }
    request.setAttribute("ctx", ctx);
%>
<html>
<head>    
    <meta http-equiv="content-type" content="text/html;charset=UTF-8" />
    <title>${requestScope.pageTitle}</title>   
    <meta http-equiv="pragma" content="no-cache" /> 
    <meta http-equiv="cache-control" content="no-cache" />
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta http-equiv="expires" content="0" />    
    <link rel="shortcut icon" type="image/x-icon" href="" media="screen" />
    <meta http-equiv="description" content="" />
    <meta http-equiv="Page-Enter" content="blendTrans(Duration=0.5)" />
    <%-- 是否需要皮肤样式--%>
    <c:if test="${requestScope.INCLUDE_SKIN ne false}">
          <link rel="stylesheet" href="${ctx }/res/layui/css/layui.css">
          <!-- 修改公共样式，解决checkbox不居中问题 -->
    </c:if>
    <%-- 是否需要引入公用的js--%>
    <c:if test="${requestScope.INCLUDE_COMMON ne false}">
        <script type="text/javascript" src="${ctx }/res/layui/layui.js"></script>
        <script type="text/javascript" src="${ctx }/res/scripts/common/jquery1.11.3.min.js"></script>
    </c:if>
    <%-- 是否需要引入公用的js--%>
    <c:if test="${requestScope.INCLUDE_UPLOAD eq true}">
        <script type="text/javascript" src="${ctx }/res/layui/lay/modules/upload.js"></script>
    </c:if>
</head>
<%-- 是否需要body --%>
<c:if test="${requestScope.SHOW_BODY_TAG ne false}">
<body>
</c:if>