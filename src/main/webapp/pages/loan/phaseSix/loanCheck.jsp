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
				<label class="layui-form-label" style="width: 120px;">公证抵押信息：</label>
				<div class="layui-input-inline">
					<div class="layui-upload-list" style="width: 600px;">
						<input type="hidden" name="id" id="id" value="${loan.id }">
						<table class="layui-table">
							<thead>
								<tr>
									<th>文件名</th>
									<th>大小</th>
									<th>状态</th>
								</tr>
							</thead>
							<tbody id="demoList">
								<c:forEach items="${fileList }" var="fileList">
						      		<tr id="upload-1522293012844-0">
								      	<td><a href="javascript:void(0)" data-url="${ctx}${fileList.address }" id="downloadFile">${fileList.fileName }</a></td>
								      	<td>${fileList.fileSize }</td>
								      	<td><span style="color: #5FB878;">已经上传</span></td>
							      	</tr>
						      	</c:forEach>
							</tbody>
						</table>
					</div>
					<button type="button" class="layui-btn" id="loanImg">查看</button>
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

$('#downloadFile').on('click', function(){
	console.log($(this).attr('data-url'))
	var $form = $('<form method="GET"></form>');
    $form.attr('action', $(this).attr('data-url'));
    $form.appendTo($('body'));
    $form.submit();
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
        ,content: '${ctx}/loan/loanImg?loanId='+$('#id').val()+"&type=4"
        ,btn: ['关闭']
	})
})
</script>
<%@ include file="/pages/common/footer.jsp"%>