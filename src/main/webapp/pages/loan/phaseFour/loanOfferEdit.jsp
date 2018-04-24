<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	//页面标题设置
	request.setAttribute("pageTitle", "新增产品");
	//如果不需要公用的css,请使用下面代码 (默认是为true)
	//request.setAttribute("INCLUDE_SKIN",false);
	//如果不需要公用的js,请使用下面代码 (默认是为true)
	//request.setAttribute("INCLUDE_COMMON",false);
	//如果不需要公用的css,请使用下面代码 (默认是为true)
	//request.setAttribute("INCLUDE_CSS",false);
%>
<%@ include file="/pages/common/header.jsp"%>
	<hr>
	<input type="hidden" id="id" name="id" value="${loanOffer.id }">
	<input type="hidden" id="loanId" name="loanId" value="${loanOffer.loadId }">
	<div class="layui-row">
		<div class="layui-col-xs6">
			<div class="grid-demo grid-demo-bg1">
				<div class="layui-inline">
					<label class="layui-form-label">类型：</label>
					<div class="layui-input-inline">
						<input type="hidden" name="loadTypeId" id="loadTypeId" value="${loanOffer.loadType }">
						<select name="loadType" id="loadType" lay-verify="required" lay-search="">
						</select>
					</div>
				</div>
			</div>
		</div>
		<div class="layui-col-xs6">
			<div class="grid-demo">
				<div class="layui-form-item">
					<label class="layui-form-label">产品：</label>
					<div class="layui-input-block">
						${loanOffer.productName }
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="layui-row">
		<div class="layui-col-xs6">
			<div class="grid-demo grid-demo-bg1">
				<div class="layui-form-item">
					<label class="layui-form-label">还款人姓名：</label>
					<div class="layui-input-block">
						<input type="text" name="paymentName" id="paymentName" placeholder="" value="${loanOffer.paymentName }"
							autocomplete="off" class="layui-input">
					</div>
				</div>
			</div>
		</div>
		<div class="layui-col-xs6">
			<div class="grid-demo">
				<div class="layui-form-item">
					<label class="layui-form-label">还款人联系方式：</label>
					<div class="layui-input-block">
						<input type="text" name="paymentContract" id="paymentContract" value="${mobile }" placeholder=""
							autocomplete="off" class="layui-input">
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="layui-row">
		<div class="layui-col-xs6">
			<div class="grid-demo grid-demo-bg1">
				<div class="layui-form-item">
					<label class="layui-form-label">保证金比例：</label>
					<div class="layui-input-block">
						<input type="text" name="bailScale" id="bailScale" value="${loanOffer.bailScale }" placeholder=""
							autocomplete="off" class="layui-input">
					</div>
				</div>
			</div>
		</div>
		<div class="layui-col-xs6">
			<div class="grid-demo">
				<div class="layui-form-item">
					<label class="layui-form-label">保证金金额：</label>
					<div class="layui-input-block">
						<input type="text" name="bailMoney" id="bailMoney" value="${loanOffer.bailMoney }" placeholder=""
							autocomplete="off" class="layui-input">
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="layui-row">
		<div class="layui-col-xs6">
			<div class="grid-demo grid-demo-bg1">
				<div class="layui-form-item">
					<label class="layui-form-label">评估费：</label>
					<div class="layui-input-block">
						<input type="text" name="evalueMoney" id="evalueMoney" value="${loanOffer.evalueMoney }" placeholder=""
							autocomplete="off" class="layui-input">
					</div>
				</div>
			</div>
		</div>
		<div class="layui-col-xs6">
			<div class="grid-demo">
				<div class="layui-form-item">
					<label class="layui-form-label">放款手续费：</label>
					<div class="layui-input-block">
						<input type="text" name="offerPound" id="offerPound" value="${loanOffer.offerPound }" placeholder=""
							autocomplete="off" class="layui-input">
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="layui-row">
		<div class="layui-col-xs6">
			<div class="grid-demo grid-demo-bg1">
				<div class="layui-form-item">
					<label class="layui-form-label">综合收费：</label>
					<div class="layui-input-block">
						<input type="text" name="zhMoney" id="zhMoney" value="${loanOffer.zhMoney }" placeholder=""
							autocomplete="off" class="layui-input">
					</div>
				</div>
			</div>
		</div>
		<div class="layui-col-xs6">
			<div class="grid-demo">
				<div class="layui-form-item">
					<label class="layui-form-label">平台服务费：</label>
					<div class="layui-input-block">
						<input type="text" name="platMoney" id="platMoney" value="${loanOffer.platMoney }" placeholder=""
							autocomplete="off" class="layui-input">
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="layui-row">
		<div class="layui-col-xs6">
			<div class="grid-demo grid-demo-bg1">
				<div class="layui-form-item">
					<label class="layui-form-label">放款日：</label>
					<div class="layui-input-block">
						<input type="text" name="offerDay" id="offerDay" lay-verify="date" value="${loanOffer.offerDay }" placeholder="yyyy-MM-dd" autocomplete="off" class="layui-input">
					</div>
				</div>
			</div>
		</div>
		<div class="layui-col-xs6">
			<div class="grid-demo">
				<div class="layui-form-item">
					<label class="layui-form-label">放款金额：</label>
					<div class="layui-input-block">
						<input type="text" name="offerMoney" id="offerMoney" value="${loanOffer.offerMoney }" placeholder=""
							autocomplete="off" class="layui-input">
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="layui-row">
		<div class="layui-col-xs6">
			<div class="grid-demo grid-demo-bg1">
				<div class="layui-form-item">
					<label class="layui-form-label">借款利率%（月）：</label>
					<div class="layui-input-block">
						<input type="text" name="monthScale" id="monthScale" value="${loanOffer.monthScale }" placeholder=""
							autocomplete="off" class="layui-input">
					</div>
				</div>
			</div>
		</div>
		<div class="layui-col-xs6">
			<div class="grid-demo">
				<div class="layui-form-item">
					<label class="layui-form-label">首个还款日：</label>
					<div class="layui-input-block">
						<input type="text" name="firstPayment" id="firstPayment" lay-verify="date" value="${loanOffer.firstPayment }"
							placeholder="yyyy-MM-dd" autocomplete="off" class="layui-input">
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="layui-row">
		<div class="layui-col-xs6">
			<div class="grid-demo grid-demo-bg1">
				<div class="layui-form-item">
					<label class="layui-form-label">放款期限（期）：</label>
					<div class="layui-input-block">
						<input type="text" name="offerLimit" id="offerLimit" value="${loanOffer.offerLimit }" placeholder=""
							autocomplete="off" class="layui-input">
					</div>
				</div>
			</div>
		</div>
		<div class="layui-col-xs6">
			<div class="grid-demo">
				
				<div class="layui-form-item">
					<label class="layui-form-label">月应缴担保费（元）：</label>
					<div class="layui-input-block">
						<input type="text" name="monthSerc" id="monthSerc" value="${loanOffer.monthSerc }" placeholder=""
							autocomplete="off" class="layui-input">
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="layui-row">
		<div class="layui-col-xs6">
			<div class="grid-demo grid-demo-bg1">
				
			</div>
		</div>
	</div>
	
	<button class="layui-btn layui-btn-normal" id="userSelect">生成还款计划书</button>
	<table class="layui-hide" id="test" lay-filter="test"></table>
<script>
	layui.use(['form','laydate','table'], function() {
		var laydate = layui.laydate;
		//日期
		laydate.render({
		  elem: '#offerDay'
		});
		laydate.render({
		  elem: '#firstPayment'
		});
		laydate.render({
		  elem: '#lastPayment'
		});
		
		var form = layui.form;
		initGroupSelect(form);
		//planAll(form);
		
		var table = layui.table;
		  table.render({
		    elem: '#test'
		    ,url:'${ctx}/loanPhaseFour/getPlanAll?loanId='+$('#loanId').val()
		    ,cols: [[
		      {field:'planId', width:80, title: 'id'}
		      ,{field:'stageNumber', width:80, title: '期数'}
		      ,{field:'paymentTime', width:120, title: '还款日', edit: 'text'}
		      ,{field:'principal', width:100, title: '本金（元）'}
		      ,{field:'interest', title: '利息（元）', width: 120} //minWidth：局部定义当前单元格的最小宽度，layui 2.2.1 新增
		      ,{field:'guarantee', title: '担保费（元）', width: 120}
		      ,{field:'service', title: '服务费（元）', width: 120}
		    ]]
		});
		//监听单元格编辑
		  table.on('edit(test)', function(obj){
		    var value = obj.value //得到修改后的值
		    ,data = obj.data //得到所在行所有键值
		    ,field = obj.field; //得到字段
		    alert('[ID: '+ data.planId +'] ' + field + ' 字段更改为：'+ value)
		    
		    $.post("${ctx}/loanPhaseFour/upPlan",{"planId":data.planId,"paymentTime":value},function(obj){
		   		 if(obj == "200"){
		   			 layer.msg("数据更新成功！");
		   		 }else{
		   			 layer.msg("数据更新失败！");
		   		 }
		     });
		  });
		
		$("#userSelect").on("click", function() {
			var existence=$('#demoList').attr('data-existence');
			if(existence==1){
				alert("已有还款计划不能再生成了！");
			}else{
				var loanId=$('#loanId').val();
				var offerDay=$('#offerDay').val();
				var offerMoney=$('#offerMoney').val();
				var monthScale=$('#monthScale').val();
				var firstPayment=$('#firstPayment').val();
				var lastPayment=$('#lastPayment').val();
				var offerLimit=$('#offerLimit').val();
				
				var jsonObj = {"loanId":loanId,"offerDay":offerDay,"offerMoney":offerMoney,"monthScale":monthScale,"firstPayment":firstPayment
						,"lastPayment":lastPayment,"offerLimit":offerLimit}
				$.post("${ctx}/loanPhaseFour/insPlan",jsonObj,function(text){
		    		  if(text=='200'){
		    			layer.closeAll();
		    			table.reload('test', {
	    				  url: '${ctx}/loanPhaseFour/getPlanAll?loanId='+$('#loanId').val()
	    				});
		    		  }else{
		    			  layer.msg("保存借款信息出错！");
		    		  }
		 	    });
			}
			
		})
	});
	
	
	
	function planAll(form){
		var loanId=$('#loanId').val();
		$.ajax({
			url : "${ctx}/loanPhaseFour/getPlanAll?loanId="+loanId,
			dataType : "json",
			success : function(data) {
				var html = '';
				console.log(data.length);
				if(data.length>0){
					$('#demoList').attr('data-existence',1);
				}else{
					$('#demoList').attr('data-existence',0);
				}
				$.each(data, function(index, val) {
					html+='<tr>';
					html+='<th>'+val.stageNumber+'</th>';
					html+='<th>'+val.paymentTime+'</th>';
					if(val.principal!=undefined){
						html+='<th>'+val.principal+'</th>';
					}else{
						html+='<th></th>';
					}
					html+='<th>'+val.interest+'</th>';
					html+='<th>'+val.guarantee+'</th>';
					html+='<th>'+val.service+'</th>';
					html+='</tr>';
				})
				$('#demoList').append(html);
			}
		})
	}
	
	function initGroupSelect(form){
		$.ajax({
		     url: "${ctx}/common/getGGdmj?dmjbhs=type", 
		     dataType: "json", 
		     success: function(data){
		   		 var jsonData  = eval(data);
		   		 $.each(jsonData['type'],function(index,val){
		   			 $("#loadType").append('<option value="'+val.dm+'">'+val.dmnr+'</option>');
		   		 });
		     }
		 });
	}

</script>
<%@ include file="/pages/common/footer.jsp"%>