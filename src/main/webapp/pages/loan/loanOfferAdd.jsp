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
<form class="layui-form" action="${ctx}/loan/saveLoan" method="post">
	<!-- <div class="layui-row" style="padding-top: 10px; padding-bottom: 5px;">
		<div class="layui-col-xs6">
			<div class="grid-demo grid-demo-bg1">&nbsp;</div>
		</div>
		<div class="layui-col-xs3">
			<div class="grid-demo grid-demo-bg1">&nbsp;</div>
		</div>
		<div class="layui-col-xs3">
			<div class="grid-demo grid-demo-bg1">
				<button class="layui-btn" lay-submit lay-filter="*">
					<i class="layui-icon">&#xe61a;</i>保存
				</button>
			</div>
		</div>
	</div> -->
	<hr>
	<div class="layui-row">
		<div class="layui-col-xs6">
			<div class="grid-demo grid-demo-bg1">
				<div class="layui-form-item">
					<label class="layui-form-label">产品：</label>
					<div class="layui-input-inline">
						<input type="hidden" name="productId" id="productId">
						<select name="productName" id="productName" lay-verify="required">
						</select>
					</div>
				</div>
			</div>
		</div>
		<div class="layui-col-xs6">
			<div class="grid-demo">
				<div class="layui-form-item">
					<label class="layui-form-label">客户经理名称：</label>
					<div class="layui-input-block">
						<input type="hidden" name="managerId" id="managerId">
						<input type="hidden" name="managerNames" id="managerNames">
						<input type="text" name="managerName" lay-verify="required" disabled="disabled" id="managerName" autocomplete="off"	class="layui-input">
					</div>
					<div>
						<button class="layui-btn layui-btn-normal" id="userSelect">...</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="layui-row">
		<div class="layui-col-xs6">
			<div class="grid-demo grid-demo-bg1">
				<div class="layui-form-item">
					<label class="layui-form-label">类型：</label>
					<div class="layui-input-block">
						<select name="loadType" id="loadType" lay-verify="required">
						</select>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="layui-row">
		<div class="layui-col-xs6">
			<div class="grid-demo grid-demo-bg1">
				<div class="layui-form-item">
					<label class="layui-form-label">客户名称：</label>
					<div class="layui-input-block">
						<input type="hidden" name="customerId" id="customerId">
						<select lay-verify="required" lay-search="" name="customerName" id="customerName">
							<option value="">直接选择或搜索选择</option>
						</select>
					</div>
				</div>
			</div>
		</div>
		<div class="layui-col-xs6">
			<div class="grid-demo">
				<div class="layui-form-item">
					<label class="layui-form-label">客户联系方式：</label>
					<div class="layui-input-block">
						<input type="text" name="loanMobile" id="loanMobile"
							placeholder="" autocomplete="off" class="layui-input">
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
						<input type="text" name="paymentName" id="paymentName" placeholder=""
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
						<input type="text" name="paymentContract" id="paymentContract" value="" placeholder=""
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
						<input type="text" name="bailScale" id="bailScale" value="" placeholder=""
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
						<input type="text" name="bailMoney" id="bailMoney" value="" placeholder=""
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
						<input type="text" name="evalueMoney" id="evalueMoney" value="" placeholder=""
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
						<input type="text" name="offerPound" id="offerPound" value="" placeholder=""
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
						<input type="text" name="zhMoney" id="zhMoney" value="" placeholder=""
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
						<input type="text" name="platMoney" id="platMoney" value="" placeholder=""
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
						<input type="text" name="offerDay" id="offerDay" lay-verify="date" placeholder="yyyy-MM-dd" autocomplete="off" class="layui-input">
					</div>
				</div>
			</div>
		</div>
		<div class="layui-col-xs6">
			<div class="grid-demo">
				<div class="layui-form-item">
					<label class="layui-form-label">放款金额：</label>
					<div class="layui-input-block">
						<input type="text" name="offerMoney" id="offerMoney" value="" placeholder=""
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
						<input type="text" name="monthScale" id="monthScale" value="" placeholder=""
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
						<input type="text" name="firstPayment" id="firstPayment" lay-verify="date"
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
					<label class="layui-form-label">最后一个还款日：</label>
					<div class="layui-input-block">
						<input type="text" name="lastPayment" id="lastPayment" lay-verify="date" placeholder="yyyy-MM-dd" autocomplete="off" class="layui-input">
					</div>
				</div>
			</div>
		</div>
		<div class="layui-col-xs6">
			<div class="grid-demo">
				<div class="layui-form-item">
					<label class="layui-form-label">放款期限（期）：</label>
					<div class="layui-input-block">
						<input type="text" name="offerLimit" id="offerLimit" value="" placeholder=""
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
					<label class="layui-form-label">月应缴担保费（元）：</label>
					<div class="layui-input-block">
						<input type="text" name="monthSerc" id="monthSerc" value="" placeholder=""
							autocomplete="off" class="layui-input">
					</div>
				</div>
			</div>
		</div>
		<div class="layui-col-xs6">
			<div class="grid-demo">
				<div class="layui-form-item">
					<label class="layui-form-label">备注：</label>
					<div class="layui-input-block">
						<input type="text" name="remark" id="remark" value=""
							placeholder="" autocomplete="off" class="layui-input">
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="layui-row">
		<div class="layui-col-xs6">
			<div class="grid-demo grid-demo-bg1">
				<div class="layui-form-item">
					<button class="layui-btn layui-btn-normal" id="userSelect">生成还款计划书</button>
				</div>
			</div>
		</div>
	</div>
</form>

<script>
	layui.use(['form','laydate'], function() {
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
		getProductAll(form);
		getCustomerAll(form);
	});
	
	function getCustomerAll(form){
		$.ajax({
		     url: "${ctx}/loan/getCustomerAll", 
		     dataType: "json", 
		     success: function(data){
		   		 $.each(data,function(index,val){
		   			 $("#customerName").append('<option value="'+val.id+'">'+val.name+'</option>');
		   		 });
		   		 form.render('select');
		     }
		 });
	}
	
	function initGroupSelect(form){
		$.ajax({
		     url: "${ctx}/common/getGGdmj?dmjbhs=type", 
		     dataType: "json", 
		     success: function(data){
		   		 var jsonData  = eval(data);
		   		 $.each(jsonData['type'],function(index,val){
		   			 $("#loadType").append('<option value="'+val.dmnr+'">'+val.dmnr+'</option>');
		   		 });
		   		 form.render('select');
		     }
		 });
	}

	function getProductAll(form) {
		$.ajax({
			url : "${ctx}/loan/getProductAll",
			dataType : "json",
			success : function(data) {
				var html = '';
				$.each(data, function(index, val) {
					html += '<option value="'+val.id+'">' + val.name + '</option>';
				})
				$('#productName').append(html);
				form.render('select');
			}
		})
	}

	$("#userSelect").on("click", function() {
		var managerVal = $("#managerId").val();
		layer.open({
			type : 2,
			title : '用户选择',
			area : [ '800px', '480px' ],
			shade : 0,
			maxmin : true,
			offset : [ 5 ],
			content : '${ctx}/common/getUserTree?onlySelect=yes&masterId=' + managerVal,
			btn : [ '确认', '关闭' ],
			yes : function() {
				var body = layer.getChildFrame('body', 0);
				var userIdsCheckName = body.find('input[name="userIdsCheckName"]').val();
				var userIdsCheck = body.find('input[name="userIdsCheck"]').val();
				if (userIdsCheckName.indexOf(',') > -1) {
					userIdsCheckName = userIdsCheckName.substr(0, userIdsCheckName.length - 1)
				}
				$("#managerName").val(userIdsCheckName);
				$("#managerNames").val(userIdsCheckName);
				$("#managerId").val(userIdsCheck);
				layer.closeAll();
			},
			btn2 : function() {
				layer.closeAll();
			},
			zIndex : layer.zIndex //重点1
			,success : function(layero) {
				layer.setTop(layero); //重点2
			}
		});
		return false;
	})
</script>
<%@ include file="/pages/common/footer.jsp"%>