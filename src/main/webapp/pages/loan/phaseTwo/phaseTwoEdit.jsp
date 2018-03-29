<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	//页面标题设置
	request.setAttribute("pageTitle", "新增产品");
	//如果不需要公用的css,请使用下面代码 (默认是为true)
	request.setAttribute("INCLUDE_UPLOAD", true);
	//如果不需要公用的js,请使用下面代码 (默认是为true)
	//request.setAttribute("INCLUDE_COMMON",false);
	//如果不需要公用的css,请使用下面代码 (默认是为true)
	//request.setAttribute("INCLUDE_CSS",false);
%>
<%@ include file="/pages/common/header.jsp"%>
<form class="layui-form" action="#" method="post">
	<hr>
	<input type="hidden" name="type" id="type" value="${type }"> <input
		type="hidden" name="id" id="id" value="${loan.id }">
	<div class="layui-form-item">
		<label class="layui-form-label">房屋状况：</label>
		<div class="layui-input-block">
			<input type="text" name="loanState" id="loanState" value="${loan.loanState }" placeholder=""
				autocomplete="off" class="layui-input">
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">借款用途：</label>
		<div class="layui-input-block">
			<input type="text" name="loanPurpose" id="loanPurpose" value="${loan.loanPurpose }" placeholder=""
				autocomplete="off" class="layui-input">
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">还款来源：</label>
		<div class="layui-input-block">
			<input type="text" name="loanSource" id="loanSource" value="${loan.loanSource }" placeholder=""
				autocomplete="off" class="layui-input">
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">经营状况：</label>
		<div class="layui-input-block">
			<input type="text" name="loanOperate" id="loanOperate" value="${loan.loanOperate }" placeholder=""
				autocomplete="off" class="layui-input">
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">下戶图上传：</label>
		<div class="layui-upload">
			<button type="button" class="layui-btn layui-btn-normal" id="testList">选择多文件</button>
			<div class="layui-upload-list">
				<table class="layui-table">
					<thead>
						<tr>
							<th>文件名</th>
							<th>大小</th>
							<th>状态</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody id="demoList">
						<c:forEach items="${fileList }" var="fileList">
							<tr id="upload-1522293012844-0">
								<td>${ctx}${fileList.address }</td>
								<td></td>
								<td><span style="color: #5FB878;">已经上传</span></td>
								<td>
									<button
										class="layui-btn layui-btn-mini layui-btn-danger demo-delete"
										id="delImage">删除</button>
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
</form>

<script>
	layui.use('form', function() {
		var upload = layui.upload;
		var demoListView = $('#demoList')
		  ,uploadListIns = upload.render({
		    elem: '#testList'
		    ,url: '${ctx}/upload/uploadFile/'
			,data:{id:$('#id').val(),type:2}
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
	});
	$('#delImage').on('click', function(){
		if (confirm("确定要删除吗？")==true){
			$.ajax({
	    	     url: "${ctx}/loan/delImage?loanId="+$('#id').val()+"&type=2",
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
</script>
<%@ include file="/pages/common/footer.jsp"%>