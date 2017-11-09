<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%  
//页面标题设置
	request.setAttribute("pageTitle","showUser测试");  
	//如果不需要公用的css,请使用下面代码 (默认是为true)
	//request.setAttribute("INCLUDE_SKIN",false);
	//如果不需要公用的js,请使用下面代码 (默认是为true)
	//request.setAttribute("INCLUDE_COMMON",false);
%>
<%@ include file="/pages/common/header.jsp" %>
<script type="text/javascript">
layui.use('table', function(){
  var table = layui.table;
  //table 数据渲染
   /* table.render({ 
	  elem: '#demo', //指定原始表格元素选择器（推荐id选择器
	  height: 315, //容器高度
	  //data: {"code":0,"msg":"","count":1000,"data":[{"id":10000,"username":"user-0","password":"123412","password":"12"},{"id":20000,"username":"user-1","password":"123412","password":"15"}]}, //赋值数据
	  cols:  [[ //标题栏
	      {field:'id', width:80,title: 'ID', sort: true},
	      {field:'username',title: '用户名', width:80},
	      {field:'sex', width:80,title: '性别', sort: true},
	      {field:'city',title: '城市', width:80},
	      {field:'sign', title: '签名',width:177},
	      {field:'experience',title: '积分', width:80, sort: true},
	      {field:'score', width:80, title: '评分',sort: true},
	      {field:'classify',title: '职业', width:80},
	      {field:'wealth',title: '财富', width:135, sort: true}
        ]],//设置表头
	  url:'http://www.layui.com/demo/table/user',
	  loading: true,
	  page: true //开启分页
	}); */
});

//一般直接写在一个js文件中
layui.use(['layer', 'form'], function(){
  var layer = layui.layer,
  form = layui.form;
  layer.msg('Hello World');s
});
</script>
<table class="layui-table" lay-data="{height:315, url:'http://www.layui.com/demo/table/user', page:true, id:'test'}" lay-filter="test">
  <thead>
    <tr>
      <th lay-data="{field:'id', width:80, sort: true}">ID</th>
      <th lay-data="{field:'username', width:80}">用户名</th>
      <th lay-data="{field:'sex', width:80, sort: true}">性别</th>
      <th lay-data="{field:'city', width:80}">城市</th>
      <th lay-data="{field:'sign', width:177}">签名</th>
      <th lay-data="{field:'experience', width:80, sort: true}">积分</th>
      <th lay-data="{field:'score', width:80, sort: true}">评分</th>
      <th lay-data="{field:'classify', width:80}">职业</th>
      <th lay-data="{field:'wealth', width:135, sort: true}">财富</th>
    </tr>
  </thead>
</table>

<%@ include file="/pages/common/footer.jsp"%>