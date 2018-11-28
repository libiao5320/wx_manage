<script src="/js/ajaxfileupload/ajaxfileupload.js"></script>
<div class="locked  center-block ">
	<div class="lockedpanel" style="width:535px;">
		
		<div class="container" >
			<div class="row">
  				<div class="col-xs-5" 
 					style="line-height:50px;height:50px;">
 					<strong>编辑产品分类</strong>
  				</div>
   			</div>
   			
   			<div class="row">
			      <div class="col-xs-5">
			        	<div class="form-group">
									<label class="col-sm-6 control-label">产品分类名称:</label>
									<div class="col-sm-6">
										<input class="form-control" id="className" value="${goodsClass.dgroupbuyClass.className !'null'}" >
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-6 control-label">排序
										<br/>
										<small>优先级小排序靠前</small></label>
									<div class="col-sm-6">
										<input class="form-control" id="sort" value="${goodsClass.dgroupbuyClass.sort !'null'}">
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
		                            	<img width="50" height="50" id="lowerImg" src="${img_url !''}${goodsClass.dgroupbuyClass.classImg !''}">
		                            </div>
								    <input type="hidden" id="imagePath" value="${goodsClass.dgroupbuyClass.classImg !''}"/>
					     		</div>		
								-->
								<button class="btn btn-danger" id="closeBtn">取消</button>
								<button class="btn btn-success" id="saveBtn">保存</button>

								
							</div>
		    </div>
		</div>
	</div>
</div>
<script>
  jQuery(document).ready(function(){
		$("#closeBtn").click(function(){
			$("#updateGoodClass div", window.parent.document).remove();
    	});
    	
	 $("#firstClass").val("${goodsClass.groupbuyClass.classId}");
	 $("#saveBtn").click(function(){
			<!--判断是修改一级分类还是二级分类，如是一级分类，则父级id为1-->
			var ParentId=$("#firstClass").val();
			if(ParentId!=undefined){
				classParentId=ParentId;
			}else{
				classParentId=1;
			}
          	  var params = {
              	classId: '${goodsClass.dgroupbuyClass.classId !'null'}',
              	className: $("#className").val(),
              	classParentId: 4,
              	sort: $("#sort").val(),
              	deep:'${goodsClass.dgroupbuyClass.deep !'null'}',
              	classImg:$("#imagePath").val()
              };
              $.ajax({
					url: '/GroupbuyClassCtrl/updateGoodsClass.ajax' ,
					type: 'POST',
					data: {map: JSON.stringify(params)} ,
					dataType: 'json',
					success: function(json){
						if(json.state == 1){
							alert("更新成功！");
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
