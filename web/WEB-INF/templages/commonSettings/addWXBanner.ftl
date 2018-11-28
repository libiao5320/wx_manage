<script src="/js/jquery-ui-1.10.3/jquery-ui-1.10.3.min.js"></script>
<script src="/js/jquery-ui-1.10.3/jquery.ui.datepicker-zh-CN.js"></script>
<script src="/js/jquery-validate/jquery.validate.min.js"></script>
<script src="/js/jquery-validate/message_cn.js"></script>
	         
<form id="form">   
<div class="locked  center-block " style="overflow-y:auto;">
	<div class="lockedpanel" style="width:535px;margin-top: 30px">
		
	
		
			<!---<div class="">
				<div class="container" >
  				<div class="col-xs-6" style="line-height:50px;height:50px;">
 					<strong>添加banner</strong>
  				</div>
   			</div>--->
   			
   			<div class="">
   			
			      <div class="">
			      
			     <div class="col-xs-12" style="line-height:50px;height:50px;">
 					<strong>添加banner</strong>
  				</div>
			      
			        	<div class="form-group">
									<label class="col-sm-6 control-label">*品牌活动名称:</label>
									<div class="col-sm-6">
										<input class="form-control" id="name" >
									</div>
								</div>
		
								<div class="form-group">
									<div>
										<label class="col-sm-6 control-label">* 活动图片：
											<br />
											<small>分辨率？*？</small></label>
									</div>
									<div class="col-sm-6">
										<input type="file" class="form-control" id="image" name="image">
										<input type="hidden"  id="imagePath" >
									 </div>
								</div>
								
                                 <div class="form-group">
                                    <div >		
                                    <label class="col-sm-6 control-label">*排序:
                                    	<br />
									<small>优先级小排序靠前</small></label>
									</div>
	
									<div class="col-sm-6">
										<input class="form-control" id="orderBy" >
									</div>
								</div>
								<div class="form-group">
                                    <div >		
                                   		<label class="col-sm-6 control-label">*活动类型：</label>
                                    	
									</div>
	
										<label><input name="event" type="radio" value="" id="commonEvent" checked onclick="check()"/>普通活动 </label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<label><input  name="event" type="radio" value="" id="redPakageEvent" onclick="check()"/>红包活动 </label>
								</div>	
								<div class="form-group">
									<div>
										<label class="col-sm-6 control-label"> *红包名称：</label>
									</div>
									<div class="col-sm-6">
										<div id="u52" class="ax_下拉列表框">
											<select   class="form-control" id="redPackageName">
				        				        <#if  oneClassArea.dredpackets?? && oneClassArea.dredpackets?size gt 0 >  
										        	<#list oneClassArea.dredpackets as a ><option  value="${a.id !''}">${a.name !''}</option></#list>
										        </#if>
			                                </select>
										</div>
									</div>
								</div>
								<div class="form-group">
									<div>
										<label class="col-sm-6 control-label"> * 超链接：</label>
									</div>
									<div class="col-sm-6">
										<input class="form-control" id="url" required>
									</div>
								</div>

								<div class="form-group">
									<div>
										<label class="col-sm-6 control-label"> * 显示时间：
											<br />
											<small></small></label>
									</div>
									<div class="col-sm-6">
										<div class="col-sm-12">开始时间
											 <input  placeholder="" class="datepicker input-sm form-control w160 fl ml10" id="begin" required>
										</div>
                                       <br />
										<div  class="col-sm-12">结束时间
										 <input type="text" placeholder="" class="datepicker input-sm form-control w160 fl ml10" id="end" required>
										</div>
									</div>
									
								</div>
								
									<div class="form-group">
									<div>
										<label class="col-sm-6 control-label"> * 是否显示：
											</label>
									</div>
									<div class="col-sm-6">
										<div id="u52" class="ax_下拉列表框">
													<select id="isShow" class="form-control" >
														<option value="Y">是</option>
														<option value="N">否</option>
													</select>
												</div>
									</div>
								</div>
								<div class="form-group">
									<div>
										<label class="col-sm-6 control-label"> * 显示区域：
											</label>
									</div>
									<div class="col-sm-6">
										<div id="u52" class="ax_下拉列表框">
									<select   class="form-control" id="area">
										<option value="0">全国</option>
		        				        <#if  oneClassArea.proviceList?? && oneClassArea.proviceList?size gt 0 >  
								        	<#list oneClassArea.proviceList as a ><option  value="${a.areaId}">${a.areaName}</option></#list>
								        </#if>
	                                </select>
												</div>
									</div>
								</div>
										<button class="btn btn-danger" id="closeBtn">取消</button>
								<a class="btn btn-success"  id="saveBtn">保存</a>

								
							</div>
		    </div>
		</div>
	</div>
</div>
</form>
<script src="/js/ajaxfileupload/ajaxfileupload.js"></script>
<script>
        function check(){
	        var radios = document.getElementsByName("event");  
		    //根据 name集合长度 遍历name集合  
		    for(var i=0;i<radios.length;i++)  
		    {    
		        //判断那个单选按钮为选中状态  
		        if(radios[0].checked)  
		        {  
		            <!--选择普通活动,红包名称下拉列表框禁用-->
        			$('#redPackageName').attr('disabled',true);
        			$('#url').attr('disabled',false);
		        }else{
		          	<!--选择红包活动，输入超链接的文本框禁用-->
        			$('#url').attr('disabled',true);
        			$("#url").val("");
        			$('#redPackageName').attr('disabled',false);
		        }     
		    }   
        }
        
        var uploadImg = function() {
	        $.ajaxFileUpload({
	            url: '/WXBannerCtrl/uploadImg.ajax', 
	            type: 'post',
	            secureuri: false, //一般设置为false
	            fileElementId: 'image', // 上传文件的id、name属性名
	            dataType: 'json', //返回值类型，一般设置为json、application/json
	            success: function(data){  
	            	alert('上传成功！');
	                $("#imagePath").val(data.imagePath);
	            },
	            error: function(){ 
	                alert('上传失败！');
	            }
	        });
       }
jQuery(document).ready(function(){
		check();
		
        $('#area').val("18");//地区默认选择湖南
        $('#begin').datepicker();
        $('#end').datepicker();
        
	$("#image").change(function(){
		uploadImg();
	});
	    
	$("#closeBtn").click(function(){
    	$("#addBanner div", window.parent.document).remove();
    });
    $("#saveBtn").click(function(){
		              	if(!$("#form").valid()){
			    	 	  	return;
		      	  		};
     					if(document.getElementById("commonEvent").checked){
     						$("#redPackageName").val("");
     					}
		              	  var params = {
			              	name: $("#name").val(),
			              	img:$("#imagePath").val(),
			              	orderBy: $("#orderBy").val(),
			              	redpacketsId: $("#redPackageName").val(),
			              	url: $("#url").val(),
			              	startTime: $("#begin").val(),
			              	endTime: $("#end").val(),
			              	isShow: $("#isShow").val(),
			              	areaId: $("#area").val(),
			              	areaName:$("#area").find("option:selected").text()
			              };
			              $.ajax({
								url: '/WXBannerCtrl/saveWXBanner.ajax' ,
								type: 'POST',
								data: {map: JSON.stringify(params)} ,
								dataType: 'json',
								success: function(json){
									if(json.state == 1){
										alert("创建成功！");
										setTimeout(function(){
											window.location.href="/WXBannerCtrl/wxBannerPage.htm";
										},800);
									}else{
										alert(json.message);
									}
								} ,
								error: function(xhr, desc, err){
								console.log(xhr);
                console.log("Details: " + desc + "\nError:" + err);
                alert()
									bootbox.alert("网络忙，请稍后重试！");
								}
						 });
		              });
});
</script>
