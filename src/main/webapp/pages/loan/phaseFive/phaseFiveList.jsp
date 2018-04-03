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
  	 		<!-- <button class="layui-btn" id="add"><i class="layui-icon">&#xe654;</i>添加</button> -->
  	 		<button class="layui-btn" id="edit"><i class="layui-icon">&#xe642;</i>编辑</button>
			<!-- <button class="layui-btn layui-btn-danger" id="delete"><i class="layui-icon">&#xe640;</i>删除 </button> -->
			<button class="layui-btn" id="refresh"><i class="layui-icon">&#x1002;</i>刷新</button>
			<button class="layui-btn" id="check"><i class="layui-icon">&#xe615;</i>查看</button>
      </div>
    </div>
  </div>
  </div>
<table class="layui-table" lay-data="{height:550,url:'${ctx }/loanPhaseFive/getList', page:true, limit:10, id:'tables'}" lay-filter="tree_filter">
  <thead>
    <tr>
      <th lay-data="{checkbox:true, fixed: true}"></th>
      <th lay-data="{field:'id', width:75}">借款ID</th>
      <th lay-data="{field:'customerName', width:85}">客户名称</th>
      <th lay-data="{field:'productName', width:90}">产品名称</th>
      <th lay-data="{field:'loanMoney', width:90}">借款金额</th>
      <th lay-data="{field:'paymentName', width:100}">还款人姓名</th>
      <th lay-data="{field:'paymentContract', width:90}">还款人手机</th>
      <th lay-data="{field:'bailScale', width:90}">保证金比例</th>
      <th lay-data="{field:'bailMoney', width:100}">保证金金额</th>
      <th lay-data="{field:'evalueMoney', width:100}">评估费</th>
      <th lay-data="{field:'offerPound', width:110}">放款手续费</th>
      <th lay-data="{field:'zhMoney', width:110}">综合收费</th>
      <th lay-data="{field:'platMoney', width:110}">平台服务费</th>
      <th lay-data="{field:'offerDay', width:110}">放款日</th>
      <th lay-data="{field:'offerMoney', width:110}">放款金额</th>
      <th lay-data="{field:'monthScale', width:110}">借款利率%(月)</th>
      <th lay-data="{field:'firstPayment', width:110}">首个还款日</th>
      <th lay-data="{field:'offerLimit', width:110}">放款期限</th>
      <th lay-data="{field:'monthPayMoney', width:110}">月应缴金额</th>
      <th lay-data="{field:'monthSerc', width:110}">月应缴担保费</th>
      <th lay-data="{width:120, toolbar: '#barDemo'}">操作</th>
    </tr>
  </thead>
</table>

<script type="text/html" id="barDemo">
  {{ d.loanStatus == 5 ? '<a class="layui-btn layui-btn-xs" lay-event="examine">提交公证</a>' : '' }}
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
		  url: '${ctx }/loanPhaseFive/getList'
		});
	});
  
  $("#check").on("click",function(){
	  var datas = table.checkStatus('tables').data;
	  if(datas.length>1){
    	  layer.alert("不支持同时查看多行，请只选中一行！");
      }else{
    	  var ids = datas[0].loadId;
    	  layer.open({
              type: 2 //此处以iframe举例
              ,title: '查看借款单'
              ,area: ['750px', '600px']
              ,shade: 0
              ,maxmin: true
              ,offset: [
                   10
              ] 
              ,content: '${ctx}/loanPhaseFive/toLoanCheck?loanId='+ids+"&type=EDIT"
              ,btn: ['关闭']
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
    	  var loanStatus = datas[0].loanStatus;
    	  if(loanStatus == 5){
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
                  ,content: '${ctx}/loanPhaseFive/editLoanOffer?loanOfferId='+ids
                  ,btn: ['保存', '关闭']
           });
    	  }else{
    		  layer.alert("数据已提交，不支持修改！");
    	  }
 	 }
	});
  
	 table.on('tool(tree_filter)', function(obj){
		    var data = obj.data;
		    if(obj.event === 'examine'){
		    	$.post("${ctx}/loanPhaseFive/upLoanStatus?loanId="+data.loadId,function(text){
	          		  if(text=='200'){
	          			  layer.closeAll();
		          		  window.location.href ='${ctx }/loanPhaseFive/init';
	          		  }else{
	          			  layer.msg("保存借款信息出错！");
	          		  }
	       	     });
		    }
	 })
});

</script>
<%@ include file="/pages/common/footer.jsp"%>