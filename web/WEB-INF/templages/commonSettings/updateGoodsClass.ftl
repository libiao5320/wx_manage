<script src="/js/ajaxfileupload/ajaxfileupload.js"></script>
<div class="locked  center-block " style="overflow-y:auto;">
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
								
								 <#if  goodsClass.dgroupbuyClass.classParentId!=1 >  
									<div class="form-group">
									<div>
										<label class="col-sm-6 control-label"> * 所属分类：
											</label>
									</div>
									<div class="col-sm-6">
										<div id="u52" class="ax_下拉列表框">
									<select id="firstClass"  class="form-control">
		        				        <#if  goodsClass.firstClass?? && goodsClass.firstClass?size gt 0 >  
								        	<#list goodsClass.firstClass as a ><option  value="${a.classId}">${a.className}</option></#list>
								        </#if>
                                    </select>
										</div>
									</div>
								</div>
								 </#if>
								<div class="form-group">
									<label class="col-sm-6 control-label">排序
										<br/>
										<small>优先级小排序靠前</small></label>
									<div class="col-sm-6">
										<input class="form-control" id="sort" value="${goodsClass.dgroupbuyClass.sort !'null'}">
									</div>
								</div>

								<div class="form-group">
									<label class="col-sm-6 control-label">图标</label>
									<div class="col-sm-6">
										<input type="file" id="fileinfo" name="fileinfo"/>
							     		<button id="upload">上传</button>
									</div>
								    <input type="hidden" id="imagePath" value="${goodsClass.dgroupbuyClass.classImg !''}"/>
					     		</div>		
								
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
              	classParentId: classParentId,
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
		        $.ajaxFileUpload({
		            url: '/GroupbuyClassCtrl/uploadImg.ajax', 
		            type: 'post',
		            secureuri: false, //一般设置为false
		            fileElementId: 'fileinfo', // 上传文件的id、name属性名
		            dataType: 'json', //返回值类型，一般设置为json、application/json
		            success: function(data){  
		                $("#imagePath").val(data.imagePath);
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
