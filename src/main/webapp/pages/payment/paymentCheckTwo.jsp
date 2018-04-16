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
<form class="layui-form" action="#" method="post">
	<div class="layui-form-item">
          <label class="layui-form-label">还款期数：</label>
          <div class="layui-input-inline">
               ${payment.paymentNum} 期
          </div>
     </div>
     <div class="layui-form-item">
          <label class="layui-form-label">实际还款时间：</label>
          <div class="layui-input-inline">
          	${payment.paymentTime }
          </div>
     </div>
      <div class="layui-form-item">
          <label class="layui-form-label">本期应还（元）：</label>
          <div class="layui-input-inline">
          		${payment.paymentMoney }
          </div>
     </div>
      <div class="layui-form-item">
	    <label class="layui-form-label">实际还款金额（元）：</label>
	    <div class="layui-input-inline">
	    	${payment.reallyPayment }
	    </div>
	  </div>
	  <div class="layui-form-item">
	    <label class="layui-form-label">还款状态：</label>
	    <div class="layui-input-inline">
	    	${payment.paymentStatus }
	    </div>
	  </div>
	  <div class="layui-form-item">
	    <label class="layui-form-label">过桥垫资金额：</label>
	      <div class="layui-input-inline">
	          ${payment.paymentAdvance }
	    </div>
	  </div>
	  <div class="layui-form-item">
	    <label class="layui-form-label">还款方式：</label>
	    <div class="layui-input-inline">
	    	${payment.paymentWay }
	      </div>
	  </div>
	  <div class="layui-form-item">
	    <label class="layui-form-label">借款利率（月）：</label>
	    <div class="layui-input-inline">
	    	${payment.loanPrecent }
	    </div>
	  </div>
	   <div class="layui-form-item">
          <label class="layui-form-label">借款期限：</label>
          <div class="layui-input-inline">
               ${payment.paymentNum }
          </div>
     </div>
     <div class="layui-form-item">
          <label class="layui-form-label">备注：</label>
          <div class="layui-input-block">
          		${payment.remark }
          </div>
     </div>
</form>
 
<script>
	layui.use(['form','laydate'], function(){
		var form = layui.form;
		var laydate = layui.laydate;
		//日期
		laydate.render({
		  elem: '#paymentTime'
		});
	});

</script>
<%@ include file="/pages/common/footer.jsp"%>