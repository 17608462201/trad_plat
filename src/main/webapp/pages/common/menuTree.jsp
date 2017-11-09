<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%  
//页面标题设置
	request.setAttribute("pageTitle","用户菜单树");  
	//如果不需要公用的css,请使用下面代码 (默认是为true)
	//request.setAttribute("INCLUDE_SKIN",false);
	//如果不需要公用的js,请使用下面代码 (默认是为true)
	//request.setAttribute("INCLUDE_COMMON",false);
%>
<%@ include file="/pages/common/header.jsp" %>
<ul id="treeUl"></ul>
<input type="hidden" name="treeIdsCheck"  id="treeIdsCheck">
<input type="hidden" name="treeIdsUnCheck"  id="treeIdsUnCheck">
<script type="text/javascript">
var treeValue = '${treeValue}';
var jsonVal = JSON.parse(treeValue);
layui.use('tree', function(){
	var $tree =layui.tree({
		  elem: '#treeUl'
		  ,nodes: jsonVal
		  ,check: 'checkbox'
          ,click: function(node){
        	   var treeIdsCheck =  $("#treeIdsCheck").val();
      		   var treeIdsUnCheck =  $("#treeIdsUnCheck").val();
                if ($('#tree_' + node.id).parent('a').parent('li').children('i.layui-icon-checkbox').hasClass('checked')) {
                    $('#tree_' + node.id).parent('a').prev('i').remove();
                    $('#tree_' + node.id).parent('a').before('<i class="layui-icon layui-icon-checkbox"></i>');
                    
                  //给取消选择赋值treeIdsCheck = arrays.join(",");
   				 if(treeIdsCheck.indexOf(node.id) != -1){
   					 var arrays = treeIdsCheck.split(",");
   					 for(i=0;i<arrays.length;i++){
   						 if(arrays[i] == node.id){
   							 arrays.splice(i,1);
   						 }
   					 }
   					 treeIdsCheck = arrays.join(",");
   				 }else{
   					 treeIdsUnCheck += node.id+",";
   				 }
                    
                } else {
                    $('#tree_' + node.id).parent('a').prev('i').remove();
                    $('#tree_' + node.id).parent('a').before('<i class="layui-icon layui-icon-checkbox checked"></i>');
                    
                    //给新选择赋值
  	   			  if(treeIdsUnCheck.indexOf(node.id) != -1){
  	   				  var uncheckArrays = treeIdsUnCheck.split(",");
  	   				  for(i=0;i<uncheckArrays.length;i++){
  	   					 if(uncheckArrays[i] == node.id){
  	   						 uncheckArrays.splice(i,1);
  	   					 }
  	   				  }
  	   				  treeIdsUnCheck = uncheckArrays.join(",");
  	   			  }else{
  	   				  treeIdsCheck += node.id+",";
  	   			  }
                    
                }
                
                $("#treeIdsCheck").val(treeIdsCheck);
       		    $("#treeIdsUnCheck").val(treeIdsUnCheck);
           }
		});
	
	//初始化checkbox赋值，并渲染选中选项
	childCheck(jsonVal);
	
	 function childCheck(obj){
	   	 $.each(obj,function(index,val){
	   		 if(val.children == '' || val.children == undefined){
	   			 //如果需要勾选的则添加勾选样式
	   			 if(val.checked){
	   				 $('#tree_' + val.id).parent('a').prev('i').remove();
	                 $('#tree_' + val.id).parent('a').before('<i class="layui-icon layui-icon-checkbox checked"></i>');
	   			 }
	   		 }else{
	   			 if((val.parentId == '' || val.parentId == undefined) && val.checked){
	   				$('#tree_' + val.id).parent('a').prev('i').remove();
	                $('#tree_' + val.id).parent('a').before('<i class="layui-icon layui-icon-checkbox checked"></i>');
	   			 }
	   			 childCheck(val.children);
	   		 }
	   	 });
	    }
});
</script>
<%@ include file="/pages/common/footer.jsp"%>