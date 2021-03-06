<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	//页面标题设置
	request.setAttribute("pageTitle", "新增产品");
	//如果不需要公用的css,请使用下面代码 (默认是为true)
	request.setAttribute("INCLUDE_UPLOAD",true);
	//如果不需要公用的js,请使用下面代码 (默认是为true)
	//request.setAttribute("INCLUDE_COMMON",false);
	//如果不需要公用的css,请使用下面代码 (默认是为true)
	//request.setAttribute("INCLUDE_CSS",false);
%>
<%@ include file="/pages/common/header.jsp"%>
<form class="layui-form" action="#" method="post">
	<hr>
	<input type="hidden" name="type" id="type" value="${type }">
	<input type="hidden" name="id" id="id" value="${loan.id }">
	<div class="layui-form-item">
		<label class="layui-form-label">产品：</label>
		<div class="layui-input-block">
			<input type="hidden" name="productId" id="productId" value="${loan.productId }">
			<select name="productName" id="productName" lay-verify="required">
			</select>
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">借款人手机：</label>
		<div class="layui-input-block">
			<input type="text" name="loanMobile" id="loanMobile" value="${loan.loanMobile }"
				placeholder="" autocomplete="off" class="layui-input">
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">借款金额：</label>
		<div class="layui-input-block">
			<input type="text" name="loanMoney" id="loanMoney" value="${loan.loanMoney }" placeholder=""
				autocomplete="off" class="layui-input">
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">借款期限：</label>
		<div class="layui-input-block">
			<input type="text" name="loanLimit" id="loanLimit" value="${loan.loanLimit }" placeholder=""
				autocomplete="off" class="layui-input">
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">客户名称：</label>
		<div class="layui-input-block">
			<input type="hidden" name="customerId" id="customerId" value="${loan.customerId }">
			<select lay-verify="required" lay-search="" name="customerName" id="customerName">
				<option value="">直接选择或搜索选择</option>
			</select>
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">客户经理名称：</label>
		<div class="layui-input-block">
			<input type="hidden" name="managerId" id="managerId" value="${loan.managerId }">
			<input type="hidden" name="managerNames" id="managerNames" value="${loan.managerName }">
			<input type="text" name="managerName" lay-verify="required" disabled="disabled" id="managerName" value="${loan.managerName }" autocomplete="off"	class="layui-input">
		</div>
		<div>
			<button class="layui-btn layui-btn-normal" id="userSelect">...</button>
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">抵押物地址：</label>
		<div class="layui-input-block">
			<input type="text" name="pawnAdd" id="pawnAdd" value="${loan.pawnAdd }" placeholder=""
				autocomplete="off" class="layui-input">
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">备注：</label>
		<div class="layui-input-block">
			<input type="text" name="remark" id="remark" value="${loan.remark }" placeholder=""
				autocomplete="off" class="layui-input">
		</div>
	</div>
</form>

<script>
	layui.use('form', function() {
		
		var form = layui.form;
		getProductAll(form);
		getCustomerAll(form);
	});
	
	$('#delImage').on('click', function(){
		if (confirm("确定要删除吗？")==true){
			$.ajax({
	    	     url: "${ctx}/loan/delImage?loanId="+$('#id').val()+"&type=1",
	    	     dataType: "text",
	    	     success: function(data){
	    	    	 if(data =='200'){
	    	    		layer.closeAll();
	    	    		$('#demoList tr').remove();
	    	    	 }else{
	    	    		 layer.msg("删除产品信息失败，请重试！");
	    	    	 }
	    	     }
	    	 });
			return true;
		}else{
			return false;
		}
	})
	
	$('#loanImg').on('click', function(){
		layer.open({
            type: 2 //此处以iframe举例
            ,title: '查看借款单'
            ,area: ['620px', '300px']
            ,shade: 0
            ,maxmin: true
            ,offset: [
                 10
            ] 
            ,content: '${ctx}/loan/loanImg?loanId='+$('#id').val()+"&type=1"
            ,btn: ['关闭']
  	    })
	})
	
	function getCustomerAll(form){
		$.ajax({
		     url: "${ctx}/loan/getCustomerAll", 
		     dataType: "json", 
		     success: function(data){
		    	 var customerId=$('#customerId').val();
		   		 $.each(data,function(index,val){
		   			 if(val.id==customerId){
		   				$("#customerName").append('<option value="'+val.id+'" selected="selected">'+val.name+'</option>');
		   			 }else{
		   				$("#customerName").append('<option value="'+val.id+'">'+val.name+'</option>');
		   			 }
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
				var productId=$('#productId').val();
				$.each(data, function(index, val) {
					if(val.id==productId){
						html += '<option value="'+val.id+'" selected="selected">' + val.name + '</option>';
					}else{
						html += '<option value="'+val.id+'">' + val.name + '</option>';
					}
					
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