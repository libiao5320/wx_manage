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
 					<strong>添加分类</strong>
  				</div>
   			</div>
   			
   			
   			<div class="row">
			      <div class="col-xs-5">
			      
			        	<div class="form-group">
							<label class="col-sm-6 control-label">分类名称:</label>
							<div class="col-sm-6">
								<input id="fristClassName" class="input-sm form-control w160 " required>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-6 control-label">排序
							<br/>
							<small>优先级小排序靠前</small></label>
							<div class="col-sm-6">
								<input  id="sort" class="input-sm form-control w160 " required>
							</div>
			     		</div>
			     		<!--
						<div class="form-group">
							<label class="col-sm-6 control-label">图标</label>
							<div class="col-sm-6">
								<input type="file" class="w250 fl" name="fileinfo" path="" id="fileinfo">
					     		<a class='btn btn-xs btn-primary' id="uploadImg">上传</a>
							</div>
							<div class="cb">
                            	<img width="50" height="50" id="lowerImg">
                            </div>
						    <input type="hidden" id="imagePath"/>
			     		</div>			     		
			     		-->
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

	var isUpload = false;
	$("#closeBtn").click(function(){
    	$("#addFristClass1 div", window.parent.document).remove();
    });
    
     $("#saveBtn").click(function(){
		
//		if(!isUpload){
//		    alert("请上传文件");
//		    return false;
//		}			
		
	  var params = {
	  	className: $("#fristClassName").val(),
	  	sort: $("#sort").val(),
	  	classParentId:4,
	  	deep:2,
	  	classImg:$("#imagePath").val()
	  };
	  $.ajax({
			url: '/storeClass/saveClass.ajax' ,
			type: 'GET',
			data: {map: JSON.stringify(params)} ,
			dataType: 'json',
			async:false,
			success: function(json){
				if(json.state == 1){
					alert("创建成功！");
					window.location.reload();
				}else{
					alert(json.message);
				}
			} ,
			error: function(){
				alert("网络忙，请稍后重试！");
			}
		 });
     });
     $("#uploadImg").click(function(){
		var fileId = "fileinfo";
		var divId = $(this).attr("id");
		if(divId == "uploadDetailImg"){
			fileId = "detailimg";
		}
		$.ajaxFileUpload({
		    url:"/storeClass/uploadImage.ajax",//需要链接到服务器地址
	        secureuri:false,
	        fileElementId:fileId,//文件选择框的id属性
	        dataType: 'json',   //json
	        success: function (data) {
	        	isUpload = true;
	        	if(divId == "uploadImg"){
	                $("#lowerImg").attr("src",data[0].url + data[0].imagePath);
	                 $("#imagePath").val(data[0].imagePath);
	            }
	        },error:function(XMLHttpRequest, textStatus, errorThrown){
	            bootbox.alert('上传失败！'+errorThrown);
	        }
	    });
	});
});
</script>
