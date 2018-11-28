<#include "../head.ftl"/>
<script src="../../js/bootbox/bootbox.min.js"></script>
<script src="../../js/jquery-ui-1.10.3/jquery-ui-1.10.3.min.js"></script>
<link rel="stylesheet" type="text/css" href="/css/wangedit/wangEditor.min.css">
<style>.imglist{margin-right:5px;}body{margin-top:0!important;}</style>
<section>
	<div class="mainwrapper">
	<#include "../leftnav.ftl"/>
		<div class="mainpanel">
			<div class="pageheader">
                <div class="media">
                    <div class="pageicon pull-left">
                        <i class="fa fa-home"></i>
                    </div>
                    <div class="media-body">
                        <ul class="breadcrumb">
                            <li><a href=""><i class="glyphicon glyphicon-home"></i></a></li>
                            <li>营销管理</li>
                        </ul>
                        <h4>添加主题活动</h4>
                    </div>
                </div><!-- media -->
            </div><!-- pageheader -->
            
            <div class="contentpanel">
                <div class="alert alert-info">
                    <button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
                    <strong>说明：</strong>报名活动为用户或商家发起，商家组织的线下活动，报名即购买支付活动活动全款
                </div>
                 <div class="panel panel-default">
                   <div class="panel-heading">
						<div class="form-horizontal cb pt5">
							<h4 class="panel-title">添加活动信息</h4>
						</div>
                    </div><!-- panel-heading -->
                    <div class="panel-body">
                        <form class="form-horizontal form-bordered" id="form">
                            <div class="form-group">
                                <label class="col-sm-3 control-label">*活动名称：</label>
                                <div class="col-sm-7">
                                    <input type="text" id="name" name="name" value="" class="form-control input-sm" required>
                                </div>
                            </div><!-- form-group -->
    
    						<div class="form-group">
                                <label class="col-sm-3 control-label">活动缩略图：(672*250px)</label>
                                <div class="col-sm-7">
                                    <input type="file" class="w250 fl" name="img" path="" id="img"><a class='btn btn-xs btn-primary' id="uploadImg">上传</a>
                                    <div class="cb">
                                    	<img width="50" height="50" id="lowerImg">
                                    </div>
                                </div>
                            </div><!-- form-group -->
                            
                            <div class="form-group">
                                <label class="col-sm-3 control-label">活动详情图：(720*354px)</label>
                                <div class="col-sm-7">
                                	<input type="hidden" name="imgPaths" value="" id="imgPaths">
                                    <input type="file" class="w250 fl" name="img"  multiple="multiple" id="detailimg"><a class='btn btn-xs btn-primary' id="uploadDetailImg">上传</a>
                                    <div class="cb" id="imgList">
                                    
                                    </div>
                                </div>
                            </div><!-- form-group -->
    
                            <div class="form-group">
                                <label class="col-sm-3 control-label">*活动简介：</label>
                                <div class="col-sm-7">
                                    <textarea id="profile" class="form-control" name="profile" rows="5" required></textarea>
                                </div>
                            </div><!-- form-group -->
    
                            <div class="form-group">
                                <label class="col-sm-3 control-label">* 活动参与限额：</label>
                                <div class="col-sm-7">
                                    <input type="number" id="quota" value="" name="quota" class="input-sm form-control w160 fl" required><span class="lh30">人</span>
                                </div>
                            </div><!-- form-group -->
                            <div class="form-group">
                                <label class="col-sm-3 control-label">* 报名开始时间：</label>
                                <div class="col-sm-7">
                                    <input type="text" id="enroll_start_time" name="type" value="" class="datepicker input-sm form-control w160" required>
                                </div>
                            </div><!-- form-group -->
                            
                            <div class="form-group">
                                <label class="col-sm-3 control-label">* 报名结束时间：</label>
                                <div class="col-sm-7">
                                    <input type="text" id="enroll_end_time" name="enroll_end_time" value="" class="datepicker input-sm form-control w160" required>
                                </div>
                            </div><!-- form-group -->
                            
                            <div class="form-group">
                                <label class="col-sm-3 control-label">* 自动下架时间：</label>
                                <div class="col-sm-7">
                                    <input type="text" id="enroll_off_time" name="enroll_off_time" value="" class="datepicker input-sm form-control w160" required>
                                </div>
                            </div><!-- form-group -->
                            
                            <div class="form-group">
                                <label class="col-sm-3 control-label">* 活动时间：</label>
                                <div class="col-sm-7">
                                    <input type="text" id="event_time" value="" name="event_time" class="datepicker input-sm form-control w160" required>
                                </div>
                            </div><!-- form-group -->
                            
                            <div class="form-group">
                                <label class="col-sm-3 control-label">*活动地点：</label>
                                <div class="col-sm-7">
                                    <textarea class="form-control" id="address" name="address" rows="5" required></textarea>
                                </div>
                            </div><!-- form-group -->
                            
                            <div class="form-group">
                                <label class="col-sm-3 control-label">*活动地图地点：</label>
                                <div class="col-sm-7">
                                	<input type="text" id="location" value="" name="location" class="input-sm form-control w160 fl" required>
                                	<span class="lh30 ml10 crp"><a id="locationMap">活动地图地点</a></span>
                                </div>
                            </div><!-- form-group -->
                            
                            <div class="form-group">
                                <label class="col-sm-3 control-label">*活动承办方：</label>
                                <div class="col-sm-7">
                                    <input type="text" id="store_name" store_id="" name="store_name" remote="validateStore.htm" value="" class="form-control input-sm" required>
                                </div>
                            </div><!-- form-group -->
                            
                            <div class="form-group">
                                <label class="col-sm-3 control-label">*活动发起人：</label>
                                <div class="col-sm-7">
                                    <input type="text" id="organizer_by" name="organizer_by" value="" class="form-control input-sm" required>
                                </div>
                            </div><!-- form-group -->
                            
                            <div class="form-group">
                                <label class="col-sm-3 control-label">*活动介绍：</label>
                                <div class="col-sm-7">
                                    <textarea id="ckeditor" class="form-control" name="ckeditor" rows="15" required></textarea>
                                </div>
                            </div>
                            
                            <div class="form-group">
                                <label class="col-sm-3 control-label">*活动主要安排：</label>
                                <div class="col-sm-7">
                                    <textarea id="text" class="form-control" name="text" rows="10" required></textarea>
                                </div>
                            </div>
                            
                            <div class="form-group">
                                <label class="col-sm-3 control-label">*活动状态：</label>
                                <div class="col-sm-7">
                                    <select id="status" class="select2 w160 fl" name="status" required>
									  <option value="on">已上架</option>
									  <option value="off">已下架</option>
									  <option value="stock">库存</option>
									</select>
                                </div>
                            </div><!-- form-group -->
                            
                            <div class="form-group">
                                <label class="col-sm-3 control-label">*报名费：</label>
                                <div class="col-sm-7">
                                    <input type="number" id="entryfee" name="entryfee" value="" class="input-sm form-control w160 fl" required><span class="lh30">元</span>
                                </div>
                            </div>
                            
                            <div class="form-group">
                                <label class="col-sm-3 control-label">*排序：</label>
                                <div class="col-sm-7">
                                    <input type="number" id="order_by" name="number" value="" class="input-sm form-control w160 fl" required><span class="lh30">排序数字越小排序越靠前</span>
                                </div>
                            </div>
                            
                            <div class="form-group">
                                <label class="col-sm-3 control-label">自定义活动页：</label>
                                <div class="col-sm-7">
                                    <input type="text" id="url" value="" name="url" class="input-sm form-control" />
                                </div>
                                <div class="col-sm-2">
                                    
                                </div>
                            </div><!-- form-group -->
                            
                            <div class="form-group">
                                <label class="col-sm-3 control-label">*活动状态：</label>
                                <div class="col-sm-7">
                                    <select id="status" class="select2 w160 fl" name="status" required>
									  <option value="on">已上架</option>
									  <option value="off">已下架</option>
									  <option value="stock">库存</option>
									</select>
                                </div>
                            </div><!-- form-group -->
                            
                            <div class="form-group">
                                <label class="col-sm-3 control-label">*是否能使用普通红包：</label>
                                <div class="col-sm-7">
                                    <select id="is_pt_red" class="select2 w160 fl" name="is_pt_red" required>
									  <option value="Y">是</option>
									  <option value="N">否</option>
									</select>
                                </div>
                            </div><!-- form-group -->
                            
                            <div class="form-group">
                                <label class="col-sm-3 control-label">*是否需要DIV文本录入：</label>
                                <div class="col-sm-7">
                                    <select id="is_diy_text" class="select2 w160 fl" name="is_diy_text" required>
									  <option value="N">否</option>
									  <option value="Y">是</option>
									</select>
                                </div>
                            </div><!-- form-group -->
                            
                            <div class="form-group" style="display:none;">
                                <label class="col-sm-3 control-label">*用作前台显示，比如“减”,“送”：</label>
                                <div class="col-sm-7">
                                    <input type="text" id="event_key" value="送" name="event_key" class="input-sm form-control w100" required />
                                </div>
                            </div><!-- form-group -->
                            
                            <hr>
                    		<div class="row center"><a class="btn btn-primary" href="/event/index.htm">返回</a><button id="saveBtn" type="submit" class="btn btn-primary ml10">保存</button></div>
                     </form>
                    </div><!-- panel-body-->
                </div>
                
                <script src="/js/wangedit/wangEditor.js"></script>
                <script src="/js/ajaxfileupload/ajaxfileupload.js"></script>
                <script src="/js/jquery-validate/jquery.validate.min.js"></script>
                <script src="/js/jquery-validate/message_cn.js"></script>
       			<script>
       				var editor = new wangEditor('ckeditor');
			        editor.config.uploadImgUrl = '/goods/uploadTmpImg.htm';
					editor.create();
       				$('#locationMap').click(function(){
       					bootbox.dialog({
							message: "<iframe width='100%' id='mapIframe' style='margin: -10px 0px;' height='370' frameborder='no' border='0' src='map.htm'></iframe>",
							title: "地图选点",
							buttons: {
								success: {
									label: "确定",
									className: "btn-primary btn-xs",
									callback: function() {
										var pointers = $("#mapIframe").contents().find("#result_").val();
										$("#location").val(pointers);
									}
								},
								cancel: {
									label: "取消",
									className: "btn-default btn-xs",
									callback: function() {
										
									}
								}
							}
						});
       				});
       				
       				$("#uploadImg,#uploadDetailImg").click(function(){
       					var fileId = "img";
       					var divId = $(this).attr("id");
       					if(divId == "uploadDetailImg"){
       						fileId = "detailimg";
       					}
       					$.ajaxFileUpload({
				            url:"/event/uploadImg.htm",//需要链接到服务器地址
				            secureuri:false,
				            fileElementId: fileId,//文件选择框的id属性
				            dataType: 'json',   //json
				            success: function (data) {
				            	if(divId == "uploadImg"){
					                $("#lowerImg").attr("src","/imgView/readGoodImage.htm?imagePath="+data[0].imagePath);
					                $("#img").attr("path",data[0].imagePath);
					            }else{
					            	$("#imgList").empty();
					            	$("#imgPaths").val(JSON.stringify(data));
					            	for(var i=0;i<data.length;i++){
					            		var _img = $("<img class='imglist'>");
						                $("#imgList").append(_img);
						                _img.attr("src","/imgView/readGoodImage.htm?imagePath="+data[i].imagePath);
						                _img.css("width","50px");
						                _img.css("height","50px");
					            	}
					            }
				            },error:function(XMLHttpRequest, textStatus, errorThrown){
				                bootbox.alert('上传失败！');
				            }
				        });
				    });
       				
		            jQuery(document).ready(function(){
		              jQuery("#form").validate({
		              	debug:true,
	                    highlight: function(element) {
	                        jQuery(element).closest('.form-group').removeClass('has-success').addClass('has-error');
	                    },
	                    success: function(element) {
	                        jQuery(element).closest('.form-group').removeClass('has-error');
	                    }
	                  });
		              $("#store_name").autocomplete({
		              		source: function(request, response) {
		              			var params = {
		              				storeName: $("#store_name").val()
		              			};
		              			
			                    $.ajax({
			                        url: "/event/autoStoreName.ajax",
			                        data: {map: JSON.stringify(params)},
			                        success: function(result) {
			                            var result = JSON.parse(result);
			                            var data = result.data;
			                            response(
				                            $.map(data, function(item) {
				                                return { label: item.store_name, value: item.store_name, id: item.store_id }
				                            })
			                            );
			                            if(result.data && result.data.length>0){
			                            	$("#store_name").attr("store_id",result.data[0].store_id);
			                            }else{
			                            	$("#store_name").attr("store_id",-1);
			                            }
			                        }
			                    });
			                },
			                select: function (event, ui) {
			                	var data = ui.item;
			                	$("#store_name").val(data.label);
			                	$("#store_name").attr("store_id",data.id);
						    },
			                minLength: 1, 
			                autoFocus: true, 
			                mustMatch: true,
			                delay: 200 
		              });
		              
		              $("#saveBtn").click(function(){
		              	  if(!$("#form").valid()){
		              	  	return;
		              	  }
		              	  var params = {
			              	name: $("#name").val(),
			              	profile: $("#profile").val(),
			              	quota: $("#quota").val(), 
			              	img: $("#img").attr("path"),
			              	imgPaths: $("#imgPaths").val(),
			              	enrollStartTime: date2Timestamp($("#enroll_start_time").val()), 
			              	enrollEndTime: date2Timestamp($("#enroll_end_time").val()), 
			              	enrollOffTime: date2Timestamp($("#enroll_off_time").val()), 
			              	eventTime: date2Timestamp($("#event_time").val()),
			              	address: $("#address").val(), 
			              	storeId: $("#store_name").attr("store_id"),
			              	storeName: $("#store_name").val(),
			              	organizerBy: $("#organizer_by").val(),
			              	introduce: $("#ckeditor").val(),
			              	plan: $("#text").val(),
			              	status: $("#status").val(),
			              	entryfee: $("#entryfee").val()*100,
			              	orderBy: $("#order_by").val(),
			              	url: $("#url").val(),
			              	isPtRed: $("#is_pt_red").val(),
			              	isDiyText: $("#is_diy_text").val(),
			              	eventKey: $("#event_key").val()
			              };
			              var locationstr = $("#location").val();   //地图坐标
			              if(locationstr != ''){
			              	var location = locationstr.split(",");
			              	params.longitude = location[0];
			              	params.latitude = location[1];
			              }
			              
			              $.ajax({
								url: '/event/saveEvent.ajax' ,
								type: 'POST',
								data: {map: JSON.stringify(params)} ,
								dataType: 'json',
								success: function(json){
									if(json.state == 1){
										bootbox.alert("创建成功！");
										setTimeout(function(){
											window.location.href="/event/index.htm";
										},800);
									}else{
										bootbox.alert(json.message);
									}
								} ,
								error: function(){
									bootbox.alert("网络忙，请稍后重试！");
								}
						 });
		              });
		            });
		            
		            var date2Timestamp = function(date){
		            	date = date.replace(/-/g,'/');
		            	return new Date(date).getTime();
		            };
	            </script>
		</div>
	</div>
</section>
</body>
</html>