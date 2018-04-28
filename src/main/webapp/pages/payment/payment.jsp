<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%  
     //页面标题设置
	request.setAttribute("pageTitle","还款列表");  
	//设置查询标题
	request.setAttribute("QUERY_TILE","还款人手机搜索内容");  
	//如果不需要公用的css,请使用下面代码 (默认是为true)
	request.setAttribute("SHOW_EDIT",true);  
	//request.setAttribute("INCLUDE_SKIN",false);
	//如果不需要公用的js,请使用下面代码 (默认是为true)
	//request.setAttribute("INCLUDE_COMMON",false);
	//如果不需要公用的css,请使用下面代码 (默认是为true)
	//request.setAttribute("INCLUDE_CSS",false);
%>
<%@ include file="/pages/common/header.jsp" %>

<div class="layui-form-item">
	<label class="layui-form-label">还款人手机</label>
	<div class="layui-input-inline" style="width: 150px;padding-left: 5px;">
		<input type="text" id="filter" name="filter" value="" lay-verify="" placeholder="${requestScope.QUERY_TILE }" autocomplete="off" class="layui-input">
	</div>
	<label class="layui-form-label">月份</label>
	<div class="layui-input-inline" style="width: 80px;padding-left: 5px;">
		<select id="paymentDay" name="paymentDay" autocomplete="off" class="layui-input">
			<option>请选择</option>
			<option value="1">1月</option>
			<option value="2">2月</option>
			<option value="3">3月</option>
			<option value="4">4月</option>
			<option value="5">5月</option>
			<option value="6">6月</option>
			<option value="7">7月</option>
			<option value="8">8月</option>
			<option value="9">9月</option>
			<option value="10">10月</option>
			<option value="11">11月</option>
			<option value="12">12月</option>
		</select>
	</div>
	<label class="layui-form-label">还款状态</label>
	<div class="layui-input-inline" style="width: 85px;padding-left: 5px;">
		<select id="paymentStatus" name="paymentStatus" autocomplete="off" class="layui-input">
			<option>请选择</option>
			<option value="0">待还款</option>
			<option value="1">正常还款</option>
			<option value="2">逾期还款</option>
			<option value="3">坏账</option>
			<option value="4">提前结清</option>
		</select>
	</div>
	<div class="layui-input-inline">
		<button class="layui-btn" id="search" name="search"><i class="layui-icon">&#xe615;</i>搜索 </button>
	</div>
</div>
<button class="layui-btn" id="refresh"><i class="layui-icon">&#x1002;</i>刷新</button>
<button class="layui-btn" id="check"><i class="layui-icon">&#xe615;</i>查看还款详情</button>
  
<table class="layui-table" lay-data="{height:478,url:'${ctx }/payment/list', page:true, limit:10, id:'tables'}" lay-filter="tree_filter">
  <thead>
    <tr>
      <th lay-data="{checkbox:true, fixed: true}"></th>
      <th lay-data="{field:'contractId', width:160,sort: true}">合同编号</th>
      <th lay-data="{field:'loanPer', width:100,sort: true}">借款人</th>
      <th lay-data="{field:'paymentName', width:100, sort: true}">还款人</th>
      <th lay-data="{field:'paymentPhone', width:120, sort: true}">手机</th>
      <th lay-data="{field:'offerMoney', width:100, sort: true}">放款金额</th>
      <th lay-data="{field:'productName', width:150, sort: true}">贷款产品</th>
      <th lay-data="{field:'paymentMoney', width:150, sort: true}">应还金额</th>
      <th lay-data="{field:'defaultInter', width:100, sort: true}">罚息</th>
      <th lay-data="{field:'reallyPayment', width:100, sort: true}">实际还款金额</th>
      <th lay-data="{field:'paymentDayStr', width:150, sort: true}">还款日</th>
      <th lay-data="{field:'precentStr', width:150, sort: true}">已还/借款期数</th>
      <th lay-data="{field:'managerName', width:100, sort: true}">客户经理</th>
      <th lay-data="{field:'recordStatus', width:100,templet: '#checkboxTpl', unresize: true}">操作</th>
    </tr>
  </thead>
</table>
 <script type="text/html" id="checkboxTpl">
	{{ d.paymentStatus == 0 ? '<a class="layui-btn layui-btn-xs" lay-event="examine">确认还款</a>' : '' }}
</script>
<script type="text/html" id="payDayTpl">
	
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
		  url: '${ctx }/payment/list?filter='+encodeURI(encodeURI(val))
		});
	});
  
   $("#search").on("click",function() {
		var val = $("#filter").val();
		//刷新表格
		  table.reload('tables', {
			  //encodeURI加密
			  url: '${ctx }/payment/list?filter='+encodeURI(encodeURI(val))+'&paymentDay='+$('#paymentDay').val()+'&paymentStatus='+$('#paymentStatus').val()
		  });
	 });
   
   $("#check").on("click",function(){
		  var datas = table.checkStatus('tables').data;
		  if(datas.length>1){
	    	  layer.alert("不支持同时查看多行，请只选中一行！");
	      }else{
	    	  var paymentId = datas[0].id;
	    	  var loanId = datas[0].loanId;
	    	  layer.open({
	              type: 2 //此处以iframe举例
	              ,title: '查看借款单'
	              ,area: ['1000px', '610px']
	              ,shade: 0
	              ,maxmin: true
	              ,offset: [
	                   10
	              ] 
	              ,content: '${ctx}/payment/PaymentCheck?paymentId='+paymentId+"&loanId="+loanId
	              ,btn: ['关闭']
		    	  ,zIndex: layer.zIndex //重点1
		          ,success: function(layero){
		            layer.setTop(layero); //重点2
		          }
	    	  })
	      }
	  })
   
     table.on('tool(tree_filter)', function(obj){
	    var data = obj.data;
	    if(obj.event === 'examine'){
	    	if(data.length>1){
		    	  layer.alert("不支持同时查看多行，请只选中一行！");
		      }else{
		    	  var ids = data.loanId;
		    	  layer.open({
		              type: 2 //此处以iframe举例
		              ,title: '查看借款单'
		              ,area: ['1000px', '650px']
		              ,shade: 0
		              ,maxmin: true
		              ,offset: [
		                   10
		              ] 
		              ,content: '${ctx}/payment/getPaymentByLoanId?loanId='+ids+"&type=EDIT"
		              ,btn: ['关闭']
			    	  ,zIndex: layer.zIndex //重点1
			          ,success: function(layero){
			            layer.setTop(layero); //重点2
			          }
		    	  })
		      }
	    }
	})
});
</script>
<%@ include file="/pages/common/footer.jsp"%>