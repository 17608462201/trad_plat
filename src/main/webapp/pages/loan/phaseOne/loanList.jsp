<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%  
     //页面标题设置
	request.setAttribute("pageTitle","菜单列表");  
	//设置查询标题
	request.setAttribute("QUERY_TILE","支持菜单名称/描述搜索内容");  
	//如果不需要公用的css,请使用下面代码 (默认是为true)
	request.setAttribute("SHOW_EDIT",true);  
	//request.setAttribute("INCLUDE_SKIN",false);
	//如果不需要公用的js,请使用下面代码 (默认是为true)
	//request.setAttribute("INCLUDE_COMMON",false);
	//如果不需要公用的css,请使用下面代码 (默认是为true)
	//request.setAttribute("INCLUDE_CSS",false);
%>
<%@ include file="/pages/common/header.jsp" %>
<div class="layui-row">
    <div class="layui-col-xs6">
		      <div class="grid-demo grid-demo-bg1">
		      <div class="layui-form-item">
		    <div class="layui-input-inline"style="width: 250px;padding-left: 5px;">
		        <input type="text" id="filter" name="filter" value="" lay-verify="" placeholder="${requestScope.QUERY_TILE }" autocomplete="off" class="layui-input">
		    </div>
		    <div class="layui-input-inline">
		        <button class="layui-btn" id="search" name="search"><i class="layui-icon">&#xe615;</i>搜索 </button>
		    </div>
     </div>
    </div>
    </div>
    <div class="layui-col-xs6">
      <div class="grid-demo">
       <div class="layui-form-item">
  	 		<button class="layui-btn" id="add"><i class="layui-icon">&#xe654;</i>添加</button>
  	 		<c:if test="${requestScope.SHOW_EDIT eq true}">
  	 		<button class="layui-btn" id="edit"><i class="layui-icon">&#xe642;</i>编辑</button>
  	 		</c:if>
			<button class="layui-btn layui-btn-danger" id="delete"><i class="layui-icon">&#xe640;</i>删除 </button>
			<button class="layui-btn" id="refresh"><i class="layui-icon">&#x1002;</i>刷新</button>
			<button class="layui-btn" id="check"><i class="layui-icon">&#xe615;</i>查看</button>
      </div>
    </div>
  </div>
  </div>
<table class="layui-table" lay-data="{height:550,url:'${ctx }/loan/getList', page:true, limit:10, id:'tables'}" lay-filter="tree_filter">
  <thead>
    <tr>
      <th lay-data="{checkbox:true, fixed: true}"></th>
      <th lay-data="{field:'id', width:75}">借款ID</th>
      <th lay-data="{field:'productName', width:90}">产品名称</th>
      <th lay-data="{field:'customerName', width:85}">客户名称</th>
      <th lay-data="{field:'loanMobile', width:100}">借款人手机</th>
      <th lay-data="{field:'loanMoney', width:90}">借款金额</th>
      <th lay-data="{field:'loanLimit', width:90}">借款期限</th>
      <th lay-data="{field:'loanStatus', width:90}">借款状态</th>
      <th lay-data="{field:'managerName', width:100}">客户经理名称</th>
      <th lay-data="{field:'pawnAdd', width:100}">抵押物地址</th>
      <th lay-data="{field:'applyTime', width:110}">申请时间</th>
      <th lay-data="{fixed: 'right', width:180, toolbar: '#barDemo'}"></th>
    </tr>
  </thead>
</table>

<script type="text/html" id="barDemo">
  {{ d.status == 1 ? '<a class="layui-btn layui-btn-xs" lay-event="examine">提交待下户</a>' : '' }}
  {{ d.status == 1 ? '<a class="layui-btn layui-btn-xs" lay-event="fallback">退回</a>' : '' }}
</script>
<script>
layui.use('table', function(){
  var table = layui.table
  ,form = layui.form;
  //监听表格复选框选择
  table.on('checkbox(tree_filter)', function(obj){
  });
  
  //监听是否有效操作
  form.on('switch(validFilter)', function(obj){
    var tds = $(obj.elem).parent().parent().parent().children();
    var id = tds[1].innerText.replace(/[\r\n]/g, "");
    var dataVal = '';
   	if(this.checked){
   		dataVal = '1';
   	}else{
   	    dataVal = '0';
   	}
   	
    $.post("${ctx}/loan/getList",{"proID":id,"proFiled":this.name,"proValue":dataVal},function(obj){
  		 if(obj == "200"){
  			 layer.msg("设置产品是否有效成功！");
  		 }else{
  			 layer.msg("设置产品是否有效失败！");
  		 }
    });
});
  
//监听单元格编辑
  table.on('edit(tree_filter)', function(obj){
    data = obj.data; //得到所在行所有键值
   $.post("${ctx}/product/modify",{"proID":data.id,"proFiled":obj.field,"proValue":obj.value},function(obj){
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
		  url: '${ctx }/loan/getList?filter='+encodeURI(encodeURI(val))
		});
	});
  
  $("#delete").on("click",function(){
		  //删除表格
		  var datas = table.checkStatus('tables').data;
	      var loanId = '';
	      for(i=0;i<datas.length;i++){
	    	  loanId += datas[i].id+',';
	      }
	 	 if(loanId!=''){
				 layer.confirm('确认删除么？', function(index){
					 $.ajax({
	   	         	     url: "${ctx}/loan/delLoan?loanId="+loanId, 
	   	         	     dataType: "text", 
	   	         	     success: function(data){
	   	         	    	 if(data =='200'){
	   	         	    		layer.closeAll();
	   	         	    		window.location.href ='${ctx }/loan/init';
	   	         	    	 }else{
	   	         	    		 layer.msg("删除产品信息失败，请重试！");
	   	         	    	 }
	   	         	     }
	   	         	 });
				  });
	 	 }else{
	 		 layer.alert("你未选中任何行！");
	 	 }
	});
  
  $("#check").on("click",function(){
	  var datas = table.checkStatus('tables').data;
	  if(datas.length>1){
    	  layer.alert("不支持同时查看多行，请只选中一行！");
      }else{
    	  var ids = datas[0].id;
    	  layer.open({
              type: 2 //此处以iframe举例
              ,title: '查看借款单'
              ,area: ['750px', '600px']
              ,shade: 0
              ,maxmin: true
              ,offset: [
                   10
              ] 
              ,content: '${ctx}/loan/toLoanCheck?loanId='+ids+"&type=EDIT"
              ,btn: ['关闭']
	    	  ,zIndex: layer.zIndex //重点1
	          ,success: function(layero){
	            layer.setTop(layero); //重点2
	          }
    	  })
      }
  })
  
  $("#edit").on("click",function(){
	  //删除表格
	  var datas = table.checkStatus('tables').data;
	  if(datas.length>1){
    	  layer.alert("不支持同时编辑多行，请只选中一行！");
      }else if(datas.length == 0) {
    	  layer.alert("请选中一行！");
      }else {
    	  var ids = datas[0].id;
    	  var loanStatus = datas[0].status;
    	  if(loanStatus == 1){
    		//新增
        	  layer.open({
                  type: 2 //此处以iframe举例
                  ,title: '修改借款'
                  ,area: ['850px', '600px']
                  ,shade: 0
                  ,maxmin: true
                  ,offset: [
                       10
                  ] 
                  ,content: '${ctx}/loan/editLoan?loanId='+ids+"&type=EDIT"
                  ,btn: ['保存', '关闭']
    	    	  ,yes: function(){
    	    		  var body = layer.getChildFrame('body', 0);
    	    		  var id=body.find('input[name="id"]').val();
            		  var productId=body.find('select[name="productName"]').val();
            		  var productName=body.find('select[name="productName"]').find("option:selected").text();
          			  var managerId=body.find('input[name="managerId"]').val();
          			  var managerName=body.find('input[name="managerNames"]').val();
          			  var loanMobile=body.find('input[name="loanMobile"]').val();
          			  var loanMoney=body.find('input[name="loanMoney"]').val();
          			  var loanLimit=body.find('input[name="loanLimit"]').val();
          			  var customerId=body.find('select[name="customerName"]').val();
          			  var customerName=body.find('select[name="customerName"]').find("option:selected").text();
          			  var pawnAdd=body.find('input[name="pawnAdd"]').val();
          			  var remark=body.find('input[name="remark"]').val();
          			  
          			  var jsonObj = {"id":id,"productId":productId,"productName":productName,"managerId":managerId,"managerName":managerName,
    		      			  "loanMobile":loanMobile,"loanMoney":loanMoney,"loanLimit":loanLimit,"customerId":customerId,"customerName":customerName,
    		      			  "pawnAdd":pawnAdd,"remark":remark};
    	    		  $.post("${ctx}/loan/upLoan",jsonObj,function(text){
    	          		  if(text=='200'){
    	          			layer.closeAll();
    		          		  window.location.href ='${ctx }/loan/init';
    	          		  }else{
    	          			  layer.msg("保存借款信息出错！");
    	          		  }
    	       	     });
    	    	  }
           });
    	  }else{
    		  layer.alert("数据已提交，不支持修改！");
    	  }
 	 }
});
  
  $("#add").on("click",function(){
		//新增
		layer.open({
              type: 2 //此处以iframe举例
              ,title: '修改借款'
              ,area: ['850px', '600px']
              ,shade: 0
              ,maxmin: true
              ,offset: [
                   10
              ] 
              ,content: '${ctx}/loan/addLoan'
              ,btn: ['保存', '关闭']
        	  ,yes: function(){
        		  var body = layer.getChildFrame('body', 0);
        		  var id=body.find('input[name="id"]').val();
        		  var productId=body.find('select[name="productName"]').val();
        		  var productName=body.find('select[name="productName"]').find("option:selected").text();
      			  var managerId=body.find('input[name="managerId"]').val();
      			  var managerName=body.find('input[name="managerNames"]').val();
      			  var loanMobile=body.find('input[name="loanMobile"]').val();
      			  var loanMoney=body.find('input[name="loanMoney"]').val();
      			  var loanLimit=body.find('input[name="loanLimit"]').val();
      			  var customerId=body.find('select[name="customerName"]').val();
      			  var customerName=body.find('select[name="customerName"]').find("option:selected").text();
      			  var pawnAdd=body.find('input[name="pawnAdd"]').val();
      			  var remark=body.find('input[name="remark"]').val();
      			  
				  var jsonObj = {"id":id,"productId":productId,"productName":productName,"managerId":managerId,"managerName":managerName,
		      			  "loanMobile":loanMobile,"loanMoney":loanMoney,"loanLimit":loanLimit,"customerId":customerId,"customerName":customerName,
		      			  "pawnAdd":pawnAdd,"remark":remark};
        		  $.post("${ctx}/loan/saveLoan",jsonObj,function(text){
	          		  if(text=='200'){
	          			layer.closeAll();
		          		  window.location.href ='${ctx }/loan/init';
	          		  }else{
	          			  layer.msg("保存借款信息出错！");
	          		  }
	       	     });
        	  }
       	});
	});

  /*$("#search").on("click",function() {
		var val = $("#filter").val();
		//刷新表格
		  table.reload('tables', {
			  //encodeURI加密
			  url: '${ctx }/product/list?filter='+encodeURI(encodeURI(val))
		  });
	 });*/
	 table.on('tool(tree_filter)', function(obj){
		    var data = obj.data;
		    if(obj.event === 'examine'){
		    	$.post("${ctx}/loan/upLoanStatus?loanId="+data.id,function(text){
	          		  if(text=='200'){
	          			  layer.closeAll();
		          		  window.location.href ='${ctx }/loan/init';
	          		  }else{
	          			  layer.msg("保存借款信息出错！");
	          		  }
	       	     });
		    }else if(obj.event === 'fallback'){
		    	layer.open({
		              type: 2 //此处以iframe举例
		              ,title: '查看借款单'
		              ,area: ['300px', '300px']
		              ,shade: 0
		              ,maxmin: true
		              ,offset: [
		                   10
		              ] 
		              ,content: '${ctx}/loan/loanFallbackById?loanId='+data.id
		              ,btn: ['保存','关闭']
		              ,yes: function(){
		            	  var body = layer.getChildFrame('body', 0);
		        		  var id=body.find('input[name="id"]').val();
		        		  var status=body.find('input[name="status"]:checked').val();
		        		  var loanOpinion=body.find('textarea[name="loan_opinion"]').val();
		        		  
		            	  var jsonObj = {"id":id,"status":status,"loanOpinion":loanOpinion};
		            	 $.post("${ctx}/loan/fallBack",jsonObj,function(text){
		            		  if(text=='200'){
		  	          			layer.closeAll();
		  		          		  window.location.href ='${ctx }/loan/init';
		  	          		  }else{
		  	          			  layer.msg("保存借款信息出错！");
		  	          		  }
			       	     });
		              }
		    	})
		    }
	 })
});

</script>
<%@ include file="/pages/common/footer.jsp"%>