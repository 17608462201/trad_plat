<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%  
//页面标题设置
	request.setAttribute("pageTitle","新增产品");  
	//如果不需要公用的css,请使用下面代码 (默认是为true)
	//request.setAttribute("INCLUDE_SKIN",false);
	//如果不需要公用的js,请使用下面代码 (默认是为true)
	//request.setAttribute("INCLUDE_COMMON",false);
	//如果不需要公用的css,请使用下面代码 (默认是为true)
	//request.setAttribute("INCLUDE_CSS",false);
%>
<%@ include file="/pages/common/header.jsp" %>
	<input type="hidden" id="paymentId" name="paymentId" value="${paymentId }">
	<input type="hidden" id="loanId" name="loanId" value="${loanId }">
	<input type="hidden" id="payMoney" name="payMoney" value="${paymentMoney}">
     <div class="layui-form-item">
          <label class="layui-form-label">应缴纳金额：</label>
          <div class="layui-input-inline">
               ${paymentMoney}
          </div>
     </div>
     <div class="layui-form-item">
          <label class="layui-form-label">实际缴纳金额：</label>
          <div class="layui-input-inline">
          	   <input type="text" name="real_pay_money" id="real_pay_money" lay-verify="required" placeholder="" autocomplete="off" class="layui-input">
          </div>
     </div>
      <div class="layui-form-item">
          <label class="layui-form-label">备注：</label>
          <div class="layui-input-block">
	      	<textarea placeholder="请输入内容" id="remark" name="remark" class="layui-textarea"></textarea>
	      </div>
     </div>
     <button class="layui-btn" id="refresh">保存</button>

 
<script>
	layui.use(['form','laydate'], function(){
		var form = layui.form;
		var laydate = layui.laydate;
		//日期
		laydate.render({
		  elem: '#paymentTime'
		});
		$('.layui-btn').on('click', function(){
			var json={"paymentId":$('#paymentId').val(),"loanId":$('#loanId').val(),"realPayMoney":$('#real_pay_money').val(),"remark":$('#remark').val(),"payMoney":$('#payMoney').val()}
			$.post("${ctx}/paymentAdvance/insPaymentAdvance",json,function(text){
				console.log(text)
		   		  if(text=='200'){
		   			  layer.msg("结清成功！");
		   		  }else{
		   			  layer.msg("保存借款信息出错！");
		   		  }
			});
		})
	});
</script>
<%@ include file="/pages/common/footer.jsp"%>