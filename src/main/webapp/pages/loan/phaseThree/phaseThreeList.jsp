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
			<button class="layui-btn" id="refresh"><i class="layui-icon">&#x1002;</i>刷新</button>
			<button class="layui-btn" id="check"><i class="layui-icon">&#xe615;</i>查看</button>
      </div>
    </div>
  </div>
  </div>
<table class="layui-table" lay-data="{height:550,url:'${ctx }/loanPhaseThree/getList', page:true, limit:10, id:'tables'}" lay-filter="tree_filter">
  <thead>
    <tr>
      <th lay-data="{checkbox:true, fixed: true}"></th>
      <th lay-data="{field:'id', width:130}">借款ID</th>
      <th lay-data="{field:'productName', width:150}">产品名称</th>
      <th lay-data="{field:'customerName', width:100}">客户名称</th>
      <th lay-data="{field:'loanMobile', width:120}">借款人手机</th>
      <th lay-data="{field:'loanMoney', width:110}">借款金额</th>
      <th lay-data="{field:'loanLimit', width:90}">借款期限</th>
      <th lay-data="{field:'loanStatus', width:90}">借款状态</th>
      <th lay-data="{field:'managerName', width:120}">客户经理名称</th>
      <th lay-data="{field:'pawnAdd', width:100}">抵押物地址</th>
      <th lay-data="{field:'applyTime', width:110}">申请时间</th>
      <th lay-data="{fixed: 'right', width:180, toolbar: '#barDemo'}">操作</th>
    </tr>
  </thead>
</table>
<script type="text/html" id="barDemo">
	{{ d.status == 3 ? '<a class="layui-btn layui-btn-xs" lay-event="examine">提交审核</a>' : '' }}
    {{ d.status == 3 ? '<a class="layui-btn layui-btn-xs" lay-event="fallback">退回</a>' : '' }}
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
});
  
  $("#refresh").on("click",function(){
	  var val = $("#filter").val();
	  //刷新表格
	  table.reload('tables', {
		  url: '${ctx }/loanPhaseThree/getList?filter='+encodeURI(encodeURI(val))
		});
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
    	  })
      }
  })

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
		    	layer.open({
		            type: 2 //此处以iframe举例
		            ,title: '审核页面'
		            ,area: ['450px', '400px']
		            ,shade: 0
		            ,maxmin: true
		            ,offset: [
		               10
		            ] 
		            ,content: '${ctx}/loanPhaseThree/loanExamine?loanId='+data.id
		            ,btn: ['确认', '关闭']
		            ,yes: function(){
		            	 var body = layer.getChildFrame('body', 0);
		            	 var examineMoney = body.find('input[name="examineMoney"]').val();
		            	 var examineLimit = body.find('input[name="examineLimit"]').val();
		            	 var isStatus = body.find('input[name="isStatus"]:checked').val();
		            	 var loanId = body.find('input[name="loanId"]').val();
		            	 console.log(examineMoney)
		            	 $.post("${ctx}/loanPhaseThree/upLoanStatus?loanId="+loanId+"&examineMoney="+examineMoney+"&examineLimit="+examineLimit+"&isStatus="+isStatus,function(text){
			          		  if(text=='200'){
			          			layer.closeAll();
				          		  window.location.href ='${ctx }/loanPhaseThree/init';
			          		  }else{
			          			  layer.msg("保存借款信息出错！");
			          		  }
			       	     });
		            }
		            ,btn2: function(){
		              layer.closeAll();
		            }
		            ,zIndex: layer.zIndex //重点1
		            ,success: function(layero){
		              layer.setTop(layero); //重点2
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
		  		          		  window.location.href ='${ctx }/loanPhaseThree/init';
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