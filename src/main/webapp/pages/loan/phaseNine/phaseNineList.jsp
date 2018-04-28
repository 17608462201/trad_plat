<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	//页面标题设置
	request.setAttribute("pageTitle", "菜单列表");
	//设置查询标题
	request.setAttribute("QUERY_TILE", "支持菜单名称/描述搜索内容");
	//如果不需要公用的css,请使用下面代码 (默认是为true)
	request.setAttribute("SHOW_EDIT", true);
	//request.setAttribute("INCLUDE_SKIN",false);
	//如果不需要公用的js,请使用下面代码 (默认是为true)
	//request.setAttribute("INCLUDE_COMMON",false);
	//如果不需要公用的css,请使用下面代码 (默认是为true)
	//request.setAttribute("INCLUDE_CSS",false);
%>
<%@ include file="/pages/common/header.jsp"%>
<div class="layui-row">
	<div class="layui-col-xs6">
		<div class="grid-demo grid-demo-bg1">
			<div class="layui-form-item">
				<div class="layui-input-inline"
					style="width: 250px; padding-left: 5px;">
					<input type="text" id="filter" name="filter" value="" lay-verify=""
						placeholder="${requestScope.QUERY_TILE }" autocomplete="off"
						class="layui-input">
				</div>
				<div class="layui-input-inline">
					<button class="layui-btn" id="search" name="search">
						<i class="layui-icon">&#xe615;</i>搜索
					</button>
				</div>
			</div>
		</div>
	</div>
	<div class="layui-col-xs6">
		<div class="grid-demo">
			<div class="layui-form-item">
				<c:if test="${requestScope.SHOW_EDIT eq true}">
					<button class="layui-btn" id="edit">
						<i class="layui-icon">&#xe642;</i>编辑
					</button>
				</c:if>
				<button class="layui-btn" id="refresh">
					<i class="layui-icon">&#x1002;</i>刷新
				</button>
				<button class="layui-btn" id="check">
					<i class="layui-icon">&#xe615;</i>查看
				</button>
			</div>
		</div>
	</div>
</div>
<table class="layui-table"
	lay-data="{height:550,url:'${ctx }/loanPhaseNine/getList', page:true, limit:10, id:'tables'}"
	lay-filter="tree_filter">
	<thead>
		<tr>
			<th lay-data="{checkbox:true, fixed: true}"></th>
			<th lay-data="{field:'receiptsLoadId', width:75}">借款ID</th>
			<th lay-data="{field:'customerName', width:100}">借款人姓名</th>
			<th lay-data="{field:'loanStatus', width:90}">借款状态</th>
			<th lay-data="{field:'receiptsBailScale', width:160}">放款实收保证金比例</th>
			<th lay-data="{field:'receiptsBailMoney', width:160}">放款实收保证金金额</th>
			<th lay-data="{field:'receiptsEvalueMoney', width:130}">放款实收评估费</th>
			<th lay-data="{field:'receiptsOfferPound', width:160}">放款实收放款手续费</th>
			<th lay-data="{field:'receiptsZhMoney', width:150}">放款实收杂费</th>
			<th lay-data="{field:'receiptsPlatMoney', width:160}">放款实收平台服务费</th>
			<th lay-data="{field:'receiptsOfferMoney', width:100}">放款金额</th>
			<th lay-data="{field:'receiptsMonthScale', width:155}">借款利率%（月）</th>
			<th lay-data="{field:'receiptsOfferLimit', width:100}">放款期限</th>
			<th lay-data="{field:'applyTime', width:110}">申请时间</th>
			<th lay-data="{width:170, toolbar: '#barDemo'}">操作</th>
		</tr>
	</thead>
</table>

<script type="text/html" id="barDemo">
  {{ d.loanStatus == 9 ? '<a class="layui-btn layui-btn-xs" lay-event="examine">提交确认放款</a>' : '' }}
  {{ d.loanStatus == 9 ? '<a class="layui-btn layui-btn-xs" lay-event="fallback">退回</a>' : '' }}
</script>
<script>
	layui.use('table', function() {
		var table = layui.table, form = layui.form;
		//监听表格复选框选择
		table.on('checkbox(tree_filter)', function(obj) {
		});

		//监听是否有效操作
		form.on('switch(validFilter)', function(obj) {
			var tds = $(obj.elem).parent().parent().parent().children();
			var id = tds[1].innerText.replace(/[\r\n]/g, "");
			var dataVal = '';
			if (this.checked) {
				dataVal = '1';
			} else {
				dataVal = '0';
			}

			$.post("${ctx}/loanPhaseNine/getList", {"proID" : id, "proFiled" : this.name, "proValue" : dataVal}, function(obj) {
				if (obj == "200") {
					layer.msg("设置产品是否有效成功！");
				} else {
					layer.msg("设置产品是否有效失败！");
				}
			});
		});

		$("#refresh").on("click", function() {
			var val = $("#filter").val();
			//刷新表格
			table.reload('tables', {url : '${ctx }/loanPhaseNine/getList?filter=' + encodeURI(encodeURI(val))});
		});

		$("#check").on("click", function() {
			var datas = table.checkStatus('tables').data;
			if (datas.length > 1) {
				layer.alert("不支持同时查看多行，请只选中一行！");
			} else {
				var ids = datas[0].receiptsLoadId;
				layer.open({
					type : 2, //此处以iframe举例
					title : '查看借款单',
					area : [ '750px', '600px' ],
					shade : 0,
					maxmin : true,
					offset : [ 10 ],
					content : '${ctx}/loan/toLoanCheck?loanId=' + ids + "&type=EDIT",
					btn : [ '关闭' ]
				})
			}
		})

		$("#edit").on("click",function() {
			//删除表格
			var datas = table.checkStatus('tables').data;
			if (datas.length > 1) {
				layer.alert("不支持同时编辑多行，请只选中一行！");
			} else if (datas.length == 0) {
				layer.alert("请选中一行！");
			} else {
				var ids = datas[0].receiptsId;
				var loanStatus = datas[0].loanStatus;
				var loanId=datas[0].loanId
				if (loanStatus == 9) {
					//新增
					layer.open({
						type : 2, //此处以iframe举例
						title : '修改借款',
						area : ['850px','600px' ],
						shade : 0,
						maxmin : true,
						offset : [ 10 ],
						content : '${ctx}/loanPhaseNine/upReceiptsLoanOffer?receiptsId='+ ids+ "&type=EDIT&loanId="+loanId,
						btn : [ '保存','关闭' ],
						yes : function() {
							var body = layer.getChildFrame('body', 0);
							var receiptsId = body.find('input[name="receiptsId"]').val();
							var bailScale = body.find('input[name="bailScale"]').val();
							var bailMoney = body.find('input[name="bailMoney"]').val();
							var evalueMoney = body.find('input[name="evalueMoney"]').val();
							var offerPound = body.find('input[name="offerPound"]').val();
							var zhMoney = body.find('input[name="zhMoney"]').val();
							var platMoney = body.find('input[name="platMoney"]').val();
							var loanExpenses = body.find('input[name="loanExpenses"]').val();
							var loanCollection = body.find('input[name="loanCollection"]').val();
							var loanId = body.find('input[name="loanId"]').val();
							if(bailScale!=''){
		          				  if(isNaN(bailScale)){
		          					  layer.msg("保证金比例必须为数字不包含小数点！");
		          					  return false;
		          				  }
		          			}
							
							if(bailMoney!=''){
		          				  if(isNaN(bailMoney)){
		          					  layer.msg("保证金金额必须为数字不包含小数点！");
		          					  return false;
		          				  }
		          			  }
							
							if(evalueMoney!=''){
		          				  if(isNaN(evalueMoney)){
		          					  layer.msg("评估费必须为数字不包含小数点！");
		          					  return false;
		          				  }
		          			  }
							
							if(offerPound!=''){
		          				  if(isNaN(offerPound)){
		          					  layer.msg("放款手续费必须为数字不包含小数点！");
		          					  return false;
		          				  }
		          			  }
							
							if(zhMoney!=''){
		          				  if(isNaN(zhMoney)){
		          					  layer.msg("杂费必须为数字不包含小数点！");
		          					  return false;
		          				  }
		          			  }
							
							if(platMoney!=''){
		          				  if(isNaN(platMoney)){
		          					  layer.msg("平台服务费必须为数字不包含小数点！");
		          					  return false;
		          				  }
		          			  }
							
							var jsonObj = {"receiptsId":receiptsId,"receiptsLoadId":loanId,"receiptsBailScale":bailScale,"receiptsBailMoney":bailMoney,
									"receiptsEvalueMoney":evalueMoney,"receiptsOfferPound":offerPound,"receiptsZhMoney":zhMoney,
									"receiptsPlatMoney":platMoney,"loanExpenses":loanExpenses,"loanCollection":loanCollection};
							$.post("${ctx}/loanPhaseNine/upLoan", jsonObj, function(text) {
									if (text == '200') {
										layer.closeAll();
										window.location.href = '${ctx }/loanPhaseNine/init';
									} else {
										layer.msg("保存借款信息出错！");
									}
							});
						}
					});
				} else {
					layer.alert("数据已提交，不支持修改！");
				}
			}
		});
		
		table.on('tool(tree_filter)', function(obj){
		    var data = obj.data;
		    if(obj.event === 'examine'){
		    	$.post("${ctx}/loanPhaseNine/upLoanStatus?loanId="+data.loanId,function(text){
	          		  if(text=='200'){
	          			  layer.closeAll();
		          		  window.location.href ='${ctx }/loanPhaseNine/init';
	          		  }else{
	          			  layer.msg("保存借款信息出错！");
	          		  }
	       	     });
		     }else{
		    	 layer.open({
						type : 2, //此处以iframe举例
						title : '修改借款',
						area : ['850px','600px' ],
						shade : 0,
						maxmin : true,
						offset : [ 10 ],
						content : '${ctx}/loanPhaseNine/upReceiptsLoanOffer?receiptsId='+ ids+ "&type=EDIT",
						btn : [ '保存','关闭' ],
						yes : function() {
							var body = layer.getChildFrame('body', 0);
							var receiptsId = body.find('input[name="receiptsId"]').val();
							var bailScale = body.find('input[name="bailScale"]').val();
							var bailMoney = body.find('input[name="bailMoney"]').val();
							var evalueMoney = body.find('input[name="evalueMoney"]').val();
							var offerPound = body.find('input[name="offerPound"]').val();
							var zhMoney = body.find('input[name="zhMoney"]').val();
							var platMoney = body.find('input[name="platMoney"]').val();
							console.log(zhMoney)
							var jsonObj = {"receiptsId":receiptsId,"receiptsBailScale":bailScale,"receiptsBailMoney":bailMoney,
									"receiptsEvalueMoney":evalueMoney,"receiptsOfferPound":offerPound,"receiptsZhMoney":zhMoney,
									"receiptsPlatMoney":platMoney};
							$.post("${ctx}/loanPhaseNine/upLoan", jsonObj, function(text) {
									if (text == '200') {
										layer.closeAll();
										window.location.href = '${ctx }/loanPhaseNine/init';
									} else {
										layer.msg("保存借款信息出错！");
									}
							});
						}
					});
		     }
	     })
	});
</script>
<%@ include file="/pages/common/footer.jsp"%>