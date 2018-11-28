<link rel="stylesheet" type="text/css" href="/css/wangedit/ajaxFileUpload-1.4.0.css">
<script src="/js/jquery-validate/jquery.validate.min.js"></script>
<script src="/js/jquery-validate/message_cn.js"></script>
<form class="form-horizontal form-bordered" id="form">
<div class="locked  center-block " style="overflow-y:auto;">
	<div class="lockedpanel" style="width:535px;">
		
		<div class="container" >
			<div class="row">
  				<div class="col-xs-5" 
 					style="line-height:50px;height:50px;">
 					<strong>添加一级分类</strong>
  				</div>
   			</div>
   			
   			
   			<div class="row">
			      <div class="col-xs-5">
			      
			        	<div class="form-group">
							<label class="col-sm-6 control-label">产品分类名称:</label>
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
			     		
						<div class="form-group">
							<label class="col-sm-6 control-label">图标</br>(88*88px)</label>
							<div class="col-sm-6">
								<input type="file" id="fileinfo" name="fileinfo"/>
					     		<button id="upload">上传</button>
							</div>
						    <input type="hidden" id="imagePath"/>
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
//		              jQuery("#form").validate({
//	                    highlight: function(element) {
//	                        jQuery(element).closest('.form-group').removeClass('has-success').addClass('has-error');
//	                    },
//	                    success: function(element) {
//	                        jQuery(element).closest('.form-group').removeClass('has-error');
//	                    }
//	                  });
	$.ajax({
				url: '/GroupbuyClassCtrl/queryMaxGoodsClass.ajax?classParentId=1' ,
				type: 'GET',
				dataType: 'json',
				async:false,
				success: function(json){
					if(json.maxSort > 0){
						$("#sort").val(json.maxSort);
					}
				}
		 });
	

	var isUpload = false;
	$("#closeBtn").click(function(){
    	$("#addFristClass1 div", window.parent.document).remove();
    });
    
     $("#saveBtn").click(function(){
//          if(!$("#form").valid()){
//     	  		return;
//      	  };
			if($("#fristClassName").val() == ''){
				alert("请填写产品分类名称!");
				return;
			}
			if($("#sort").val() == ''){
				alert("请填写排序!");
				return;
			}
			    if(!isUpload){
			        alert("请上传文件");
			        return false;
			    }			
		
      	  var params = {
          	className: $("#fristClassName").val(),
          	sort: $("#sort").val(),
          	classParentId:1,
          	deep:2,
          	classImg:$("#imagePath").val()
          };
          $.ajax({
				url: '/GroupbuyClassCtrl/saveGoodsClass.ajax' ,
				type: 'GET',
				data: {map: JSON.stringify(params)} ,
				dataType: 'json',
				async:false,
				success: function(json){
					if(json.state == 1){
						alert("创建成功！");
						window.location.href="/GroupbuyClassCtrl/goodsClassPage.htm";
					}else{
						alert(json.message);
					}
				} ,
				error: function(){
					alert("网络忙，请稍后重试！");
				}
		 });
     });
     
         $("#upload").click(function() {
		    if($("#fileinfo").val().length==0){
		        alert("请选择上传文件");
		        return false;
		    }
	        $.ajaxFileUpload({
	            url: '/GroupbuyClassCtrl/uploadImg.ajax', 
	            type: 'post',
	            secureuri: false, //一般设置为false
	            fileElementId: 'fileinfo', // 上传文件的id、name属性名
	            dataType: 'json', //返回值类型，一般设置为json、application/json
	            success: function(data){  
	                $("#imagePath").val(data.imagePath);
	                isUpload = true;
	            	alert('上传成功！');
	            },
	            error: function(){ 
	                alert('上传失败！');
	            }
	        });
	        return false;
  	  });
});
</script>
