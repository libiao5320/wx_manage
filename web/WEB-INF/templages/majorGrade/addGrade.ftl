<link rel="stylesheet" type="text/css" href="/css/wangedit/ajaxFileUpload-1.4.0.css">

<script src="/js/jquery-validate/jquery.validate.min.js"></script>
<script src="/js/jquery-validate/message_cn.js"></script>
<form class="form-horizontal form-bordered" id="form">
<div class="locked  center-block ">
	<div class="lockedpanel" style="width:535px;">
		
		<div class="container" >
			<div class="row">
  				<div class="col-xs-5" 
 					style="line-height:50px;height:50px;">
 					<strong>添加等级</strong>
  				</div>
   			</div>
   			
   			<div class="row">
			      <div class="col-xs-5">
			        			<div class="form-group">
									<label class="col-sm-6 control-label">*等级：</label>
									<div class="col-sm-6">
										<input id="grade" class="input-sm form-control w160 " required>
									</div>
								</div>
								
								
								<div class="form-group">
									<label class="col-sm-6 control-label">*所属专业：</label>
									<div class="col-sm-6">
										<div id="u52" class="ax_下拉列表框">
											<select id="major"  class="form-control" onchange="changeMajor(this)" >
				        				        <#if  result.major?? && result.major?size gt 0 >  
										        	<#list result.major as a ><option  value="${a.classId}">${a.className}</option></#list>
										        </#if>
			                                 </select>
										</div>
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-sm-6 control-label">*排序：
										<br/>
										<small>优先级小排序靠前</small></label>
									<div class="col-sm-6">
										<input  id="sort" class="input-sm form-control w160 " required>
									</div>
								</div>

								<a class="btn btn-danger" id="closeBtn">取消</a>
								<button class="btn btn-success" id="saveBtn">保存</button>
								
							</div>
		    </div>
		</div>
	</div>
</div>
</form>
<script src="/js/ajaxfileupload/ajaxfileupload.js"></script>
<script>
	var getMaxSort = function(id){
  	  	$.ajax({
				url: '/GroupbuyClassCtrl/queryMaxGoodsClass.ajax?classParentId=' + id ,
				type: 'GET',
				dataType: 'json',
				async:false,
				success: function(json){
					if(json.maxSort > 0){
						$("#sort").val(json.maxSort);
					}
				}
		 });
  	  };
	function changeMajor(o){
		getMaxSort($(o).val());
	}
	$(function(){
		getMaxSort($("#major").val());
		
		$("#closeBtn").click(function(){
	    	$("#addGradePage div", window.parent.document).remove();
	    });
	    $("#saveBtn").click(function(){
					   	
		  	  var params = {
		      	className: $("#grade").val(),
		      	classParentId: $("#major").val(),
		      	sort: $("#sort").val(),
		      	deep:3,
		      };
		      $.ajax({
					url: '/majorGrade/saveMajorGrade.ajax' ,
					type: 'GET',
					data: {map: JSON.stringify(params)} ,
					dataType: 'json',
					async:false,
					success: function(json){
						if(json.state == 1){
							alert("创建成功！");
							window.location.href="/majorGrade/index.htm";
						}else{
							alert(json.message);
						}
					} ,
					error: function(){
						alert("网络忙，请稍后重试！");
					}
			 });
		  });
	  
});
</script>
