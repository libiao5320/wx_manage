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
 					<strong>添加专业</strong>
  				</div>
   			</div>
   			
   			
   			<div class="row">
			      <div class="col-xs-5">
			      
			        	<div class="form-group">
							<label class="col-sm-6 control-label">*专业：</label>
							<div class="col-sm-6">
								<input id="major" class="input-sm form-control w160 " required>
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
			     		
			     		
			     		<button class="btn btn-danger" id="closeBtn">取消</button>
						<button class="btn btn-success" id="saveBtn"> 保存</button>
			     </div>
		    </div>
		</div>
	</div>
</div>
</form>
<script src="/js/ajaxfileupload/ajaxfileupload.js"></script>
<script>
$(function(){
	$.ajax({
				url: '/GroupbuyClassCtrl/queryMaxGoodsClass.ajax?classParentId=2' ,
				type: 'GET',
				dataType: 'json',
				async:false,
				success: function(json){
					if(json.maxSort > 0){
						$("#sort").val(json.maxSort);
					}
				}
		 });
	
	$("#closeBtn").click(function(){
    	$("#addMajorPage div", window.parent.document).remove();
    });
    
     $("#saveBtn").click(function(){
		
      	  var params = {
          	className: $("#major").val(),
          	sort: $("#sort").val(),
          	classParentId:2,
          	deep:2,
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
