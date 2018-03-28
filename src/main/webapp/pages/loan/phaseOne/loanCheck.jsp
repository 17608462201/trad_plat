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
<div class="layui-row">
	<div class="layui-col-xs6">
		<div class="grid-demo grid-demo-bg1">
			<div class="layui-form-item">
				<label class="layui-form-label">借款单编号：</label>
				<div class="layui-input-inline">
					${loan.id }
				</div>
			</div>
		</div>
	</div>
	<div class="layui-col-xs6">
		<div class="grid-demo grid-demo-bg1">
			<div class="layui-form-item">
				<label class="layui-form-label">产品：</label>
				<div class="layui-input-inline">
					${loan.productName }
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
				<div class="layui-input-inline">
					${loan.customerName }
				</div>
			</div>
		</div>
	</div>
	<div class="layui-col-xs6">
		<div class="grid-demo grid-demo-bg1">
			<div class="layui-form-item">
				<label class="layui-form-label">借款人手机号：</label>
				<div class="layui-input-inline">
					${loan.loanMobile }
				</div>
			</div>
		</div>
	</div>
</div>

<div class="layui-row">
	<div class="layui-col-xs6">
		<div class="grid-demo grid-demo-bg1">
			<div class="layui-form-item">
				<label class="layui-form-label">借款金额：</label>
				<div class="layui-input-inline">
					${loan.loanMoney }
				</div>
			</div>
		</div>
	</div>
	<div class="layui-col-xs6">
		<div class="grid-demo grid-demo-bg1">
			<div class="layui-form-item">
				<label class="layui-form-label">借款期限：</label>
				<div class="layui-input-inline">
					${loan.loanLimit }
				</div>
			</div>
		</div>
	</div>
</div>

<div class="layui-row">
	<div class="layui-col-xs6">
		<div class="grid-demo grid-demo-bg1">
			<div class="layui-form-item">
				<label class="layui-form-label">借款状态：</label>
				<div class="layui-input-inline">
					${loan.loanStatus }
				</div>
			</div>
		</div>
	</div>
	<div class="layui-col-xs6">
		<div class="grid-demo grid-demo-bg1">
			<div class="layui-form-item">
				<label class="layui-form-label">客户经理名称：</label>
				<div class="layui-input-inline">
					${loan.managerName }
				</div>
			</div>
		</div>
	</div>
</div>

<div class="layui-row">
	<div class="layui-col-xs6">
		<div class="grid-demo grid-demo-bg1">
			<div class="layui-form-item">
				<label class="layui-form-label">借款抵押物：</label>
				<div class="layui-input-inline">
					
				</div>
			</div>
		</div>
	</div>
</div>

<div class="layui-row">
	<div class="layui-col-xs6">
		<div class="grid-demo grid-demo-bg1">
			<div class="layui-form-item">
				<label class="layui-form-label">申请时间：</label>
				<div class="layui-input-inline">
					${loan.applyTime }
				</div>
			</div>
		</div>
	</div>
	<div class="layui-col-xs6">
		<div class="grid-demo grid-demo-bg1">
			<div class="layui-form-item">
				<label class="layui-form-label">借款抵押物地址：</label>
				<div class="layui-input-inline">
					${loan.pawnAdd }
				</div>
			</div>
		</div>
	</div>
</div>

<script>
layui.use('element', function(){
  var element = layui.element; //Tab的切换功能，切换事件监听等，需要依赖element模块
  var $ = layui.jquery
  var layid = location.hash.replace(/^#customerTab=/, '');
  element.tabChange('customerTab', layid);
  element.on('tab(customerTab)', function(data){
	  location.hash = 'customerTab='+ $(this).attr('lay-id');
	  var iframe=$(data.elem).find("iframe").eq(data.index);
	 if(data.index == 2 || data.index ==3){
		  var iframeSrc=$(iframe[0]).attr("src");
		  console.log(iframeSrc);
          $(iframe[0]).attr("src",iframeSrc);
	  }
	});
});	
</script>
<%@ include file="/pages/common/footer.jsp"%>