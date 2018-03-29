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
	<input type="hidden" name="type" id="type" value="${type }">
	<input type="hidden" name="id" id="id" value="${loan.id }">
	<div class="layui-form-item">
		<label class="layui-form-label">产品：</label>
		<div class="layui-input-inline">
			<input type="hidden" name="productId" id="productId" value="${loan.productId }">
			<select name="productName" id="productName" lay-verify="required">
			</select>
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">借款人：</label>
		<div class="layui-input-block">
			<input type="text" name="loanPer" id="loanPer" value="${loan.loanPer }" placeholder=""
				autocomplete="off" class="layui-input">
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
	<!-- <div class="layui-form-item">
		<label class="layui-form-label">借款状态：</label>
		<div class="layui-input-block">
			<select name="loanStatus" id="loanStatus" value="${loan.loanStatus }" lay-verify="required">
			</select>
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">申请时间：</label>
		<div class="layui-input-block">
			<input type="text" name="applyTime" id="applyTime" value="${loan.applyTime }" placeholder=""
				autocomplete="off" class="layui-input">
		</div>
	</div> -->
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
		<label class="layui-form-label">借款抵押物：</label>
		<div class="layui-input-block">
			<div class="layui-upload">
			  <button type="button" class="layui-btn layui-btn-normal" id="testList">选择多文件</button> 
			  <div class="layui-upload-list">
			    <table class="layui-table">
			      <thead>
			        <tr><th>文件名</th>
			        <th>大小</th>
			        <th>状态</th>
			        <th>操作</th>
			      </tr></thead>
			      <tbody id="demoList">
			      	<c:forEach items="${fileList }" var="fileList">
			      		<tr id="upload-1522293012844-0">
					      	<td>${ctx}${fileList.address }</td>
					      	<td></td>
					      	<td><span style="color: #5FB878;">已经上传</span></td>
					      	<td>
						      	<button class="layui-btn layui-btn-mini layui-btn-danger demo-delete" id="delImage">删除</button>
					      	</td>
				      	</tr>
			      	</c:forEach>
			      	
			      </tbody>
			    </table>
			  </div>
			  <button type="button" class="layui-btn" id="testListAction">开始上传</button>
			  <button type="button" class="layui-btn" id="loanImg">查看</button>
			</div>
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
		var upload = layui.upload;
		//多文件列表示例
		  var demoListView = $('#demoList')
		  ,uploadListIns = upload.render({
		    elem: '#testList'
		    ,url: '${ctx}/upload/uploadFile/'
			,data:{id:$('#id').val(),type:1}
		    ,accept: 'file'
		    ,multiple: true
		    ,auto: false
		    ,bindAction: '#testListAction'
		    ,choose: function(obj){   
		      var files = this.files = obj.pushFile(); //将每次选择的文件追加到文件队列
		      //读取本地文件
		      obj.preview(function(index, file, result){
		        var tr = $(['<tr id="upload-'+ index +'">'
		          ,'<td>'+ file.name +'</td>'
		          ,'<td>'+ (file.size/1014).toFixed(1) +'kb</td>'
		          ,'<td>等待上传</td>'
		          ,'<td>'
		            ,'<button class="layui-btn layui-btn-mini demo-reload layui-hide">重传</button>'
		            ,'<button class="layui-btn layui-btn-mini layui-btn-danger demo-delete">删除</button>'
		          ,'</td>'
		        ,'</tr>'].join(''));
		        
		        //单个重传
		        tr.find('.demo-reload').on('click', function(){
		          obj.upload(index, file);
		        });
		        
		        //删除
		        tr.find('.demo-delete').on('click', function(){
		          delete files[index]; //删除对应的文件
		          tr.remove();
		          uploadListIns.config.elem.next()[0].value = ''; //清空 input file 值，以免删除后出现同名文件不可选
		        });
		        
		        demoListView.append(tr);
		      });
		    }
		    ,done: function(res, index, upload){
		      if(res.code == 1){ //上传成功
		        var tr = demoListView.find('tr#upload-'+ index)
		        ,tds = tr.children();
		        tds.eq(2).html('<span style="color: #5FB878;">上传成功</span>');
		        tds.eq(3).html(''); //清空操作
		        return delete this.files[index]; //删除文件队列已经上传成功的文件
		      }
		      this.error(index, upload);
		    }
		    ,error: function(index, upload){
		      var tr = demoListView.find('tr#upload-'+ index)
		      ,tds = tr.children();
		      tds.eq(2).html('<span style="color: #FF5722;">上传失败</span>');
		      tds.eq(3).find('.demo-reload').removeClass('layui-hide'); //显示重传
		    }
		  });
		
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
            ,content: '${ctx}/loan/loanImg?loanId='+$('#id').val()
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