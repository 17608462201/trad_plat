<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%  
	//页面标题设置
	request.setAttribute("pageTitle","公共代码集列表");  
	//设置查询标题
	request.setAttribute("QUERY_TILE","支持编号/代码/内容搜索");  
	//如果不需要公用的css,请使用下面代码 (默认是为true)
	//request.setAttribute("INCLUDE_SKIN",false);
	//如果不需要公用的js,请使用下面代码 (默认是为true)
	//request.setAttribute("INCLUDE_COMMON",false);
	//如果不需要公用的css,请使用下面代码 (默认是为true)
	//request.setAttribute("INCLUDE_CSS",false);
%>
<%@ include file="/pages/common/header.jsp" %>
<%@ include file="/pages/common/listHeader.jsp" %>
<table class="layui-table" lay-data="{height:500 ,url:'${ctx }/ggdm/list', page:true, limit:10, id:'tables'}" lay-filter="ggdm_filter">
  <thead>
    <tr>
      <th lay-data="{checkbox:true, fixed: true,alt:'fit'}"></th>
      <th lay-data="{field:'dmjbh', width:120,sort: true}">编号</th>
      <th lay-data="{field:'dm', width:150,sort: true}">代码</th>
      <th lay-data="{field:'dmnr', width:300,edit: 'text'}">代码内容</th>
      <th lay-data="{field:'fdm', width:100}">父代码</th>
      <th lay-data="{field:'remark', width:300, edit: 'text'}">备注</th>
      <th lay-data="{field:'orderNum', width:100, sort: true,edit: 'text'}">排序号</th>
      <th lay-data="{field:'isValid', width:150,templet: '#checkboxTpl', unresize: true}">是否有效</th>
     <!-- <th lay-data="{fixed: 'right', width:100, align:'center', toolbar: '#barDemo'}"></th> -->
    </tr>
  </thead>
  <script type="text/html" id="checkboxTpl">
  <input type="checkbox" {{ d.isValid == 1 ? 'checked' : '' }} name="isValid" lay-skin="switch" lay-filter="validFilter" lay-text="是|否">
</script>
</table>
 <!--  
<script type="text/html" id="barDemo">
  <a class="layui-btn layui-btn-xs" lay-event="userRoles">用户角色</a>
</script>
-->
<script>
layui.use('table', function(){
  var table = layui.table
  ,form = layui.form;
  //监听表格复选框选择
  table.on('checkbox(ggdm_filter)', function(obj){
  });
  
  //监听是否有效操作
  form.on('switch(validFilter)', function(obj){
    var tds = $(obj.elem).parent().parent().parent().children();
    var dmjbh = tds[1].innerText.replace(/[\r\n]/g, "");
    var dm = tds[2].innerText.replace(/[\r\n]/g, "");
    var dataVal = '';
   	if(this.checked){
   		dataVal = '1';
   	}else{
   	    dataVal = '0';
   	}
   	 $.post("${ctx}/ggdm/modify",{"dmjbh":dmjbh,"dm":dm,"filed":this.name,"value":dataVal},function(obj){
     		 if(obj == "200"){
     			 layer.msg("设置代码集是否有效成功！");
     		 }else{
     			 layer.msg("设置代码集是否有效失败！");
     		 }
       });
  });
  
  //监听单元格编辑
  table.on('edit(ggdm_filter)', function(obj){
    data = obj.data; //得到所在行所有键值
    $.post("${ctx}/ggdm/modify",{"dmjbh":data.dmjbh,"dm":data.dm,"filed":obj.field,"value":obj.value},function(obj){
	   		 if(obj == "200"){
	   			 layer.msg("数据更新成功！");
	   		 }else{
	   			 layer.msg("数据更新失败！");
	   		 }
     });
  });
  
  $("#refresh").on("click",function(){
	  var val = $("#filter").val();
	  //刷新表格
	  table.reload('tables', {
		  url: '${ctx }/ggdm/list?filter='+encodeURI(encodeURI(val))
		});
	});
  
  $("#delete").on("click",function(){
		  //删除表格
		  var datas = table.checkStatus('tables').data;
	      var dmjbhs = '';
	      var dms = '';
	      for(i=0;i<datas.length;i++){
	    	  dmjbhs += datas[i].dmjbh+',';
	    	  dms += datas[i].dm+',';
	      }
	 	 if(dmjbhs !='' && dms!=''){
					 layer.confirm('确认删除么？', function(index){
						 $.ajax({
	   	         	     url: "${ctx}/ggdm/deleteDms?dmjbhs="+dmjbhs+"&dms="+dms, 
	   	         	     dataType: "text", 
	   	         	     success: function(data){
	   	         	    	 if(data =='200'){
	   	         	    		layer.closeAll();
	   	         	    		window.location.href ='${ctx }/ggdm/init';
	   	         	    	 }else{
	   	         	    		 layer.msg("删除公共代码集信息失败，请重试！");
	   	         	    	 }
	   	         	     }
	   	         	 });
					 });
	 	 }else{
	 		 layer.alert("你未选中任何行！");
	 	 }
	});
  
  $("#add").on("click",function(){
		  //新增
		  layer.open({
	          type: 2 //此处以iframe举例
	          ,title: '新增用户'
	          ,area: ['600px', '550px']
	          ,shade: 0
	          ,maxmin: true
	          ,offset: [
	               20
	          ] 
	          ,content: '${ctx}/ggdm/add'
	          ,btn: ['保存', '关闭']
	          ,yes: function(){
	          	 var body = layer.getChildFrame('body', 0);
	          	 var dmjbh = body.find('input[name="dmjbh"]').val();
	          	 var dm = body.find('input[name="dm"]').val();
	          	 var dmnr = body.find('input[name="dmnr"]').val();
	          	 var parentId = body.find('input[name="parentId"]').val();
	          	 var remark = body.find('input[name="remark"]').val();
	          	 var orderNum = body.find('input[name="orderNum"]').val();
	           	 var isValid = body.find('input[name="isValid"]').val();
	           	 if(isValid != undefined && isValid =='on'){
	           		isValid = '1';
	           	 }else{
	           		isValid = '0'
	           	 }
	          	 var jsonObj = {"dmjbh":dmjbh,"dm":dm,"dmnr":dmnr,"parentId":parentId,"remark":remark,"orderNum":orderNum,"isValid":isValid};
	          	  $.post("${ctx}/ggdm/saveGgdm",jsonObj,function(text){
	          		  if(text=='200'){
	          			layer.closeAll();
		          		  window.location.href ='${ctx }/ggdm/init';
	          		  }else{
	          			  layer.msg("保存公共代码集树出错！");
	          		  }
	       	     });
	          }
	   });
	});

   $("#search").on("click",function() {
		var val = $("#filter").val();
		//刷新表格
		  table.reload('tables', {
			  //encodeURI加密
			  url: '${ctx }/ggdm/list?filter='+encodeURI(encodeURI(val))
		  });
	 });
   
});
</script>
<%@ include file="/pages/common/footer.jsp"%>