<#include "../head.ftl"/>
<script src="../../js/bootbox/bootbox.min.js"></script>
<script src="../../js/jquery-ui-1.10.3/jquery-ui-1.10.3.min.js"></script>
<link rel="stylesheet" type="text/css" href="/css/wangedit/wangEditor.min.css">
<style>.imglist{margin-right:5px;}body{margin-top:0 !important;}</style>
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
                        <h4>编辑主题活动</h4>
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
							<h4 class="panel-title">编辑活动信息</h4>
						</div>
                    </div><!-- panel-heading -->
                    <div class="panel-body">
                        <form class="form-horizontal form-bordered" id="form">
                            <div class="form-group">
                                <label class="col-sm-3 control-label">*活动名称：</label>
                                <div class="col-sm-7">
                                    <input type="text" id="name" name="name" value="${event.name !''}" class="form-control input-sm" required>
                                </div>
                            </div><!-- form-group -->
    
    						<div class="form-group">
                                <label class="col-sm-3 control-label" for="readonlyinput">活动缩略图：(672*250px)</label>
                                <div class="col-sm-7">
                                    <input type="file" class="w250 fl" name="img" path="${event.img !''}" id="img"><a class='btn btn-xs btn-primary' id="uploadImg">上传</a>
                                    <div class="cb">
                                    	<img width="50" src="/imgView/readGoodImage.htm?imagePath=${event.img !''}" height="50" id="lowerImg">
                                    </div>
                                </div>
                            </div><!-- form-group -->
                            
                            <div class="form-group">
                                <label class="col-sm-3 control-label" for="readonlyinput">活动详情图：(720*354px)</label>
                                <div class="col-sm-7">
                                	<input type="hidden" name="imgPaths" value="" id="imgPaths">
                                    <input type="file" class="w250 fl" name="img"  multiple="multiple" id="detailimg"><a class='btn btn-xs btn-primary' id="uploadDetailImg">上传</a>
                                    <div class="cb" id="imgList">
                                    <#if event?? && (event.imageList??) && (event.imageList?size >0)>
                                    <#list event.imageList as eve>
                                    <img class='imglist' src="/imgView/readGoodImage.htm?imagePath=${eve.imgPath}">
                                    </#list>
                                    </#if>
                                    </div>
                                </div>
                            </div><!-- form-group -->
    
                            <div class="form-group">
                                <label class="col-sm-3 control-label" for="disabledinput">*活动简介：</label>
                                <div class="col-sm-7">
                                    <textarea id="profile" class="form-control" rows="5" name="profile" required>${event.profile !''}</textarea>
                                </div>
                            </div><!-- form-group -->
    
                            <div class="form-group">
                                <label class="col-sm-3 control-label" for="readonlyinput">* 活动参与限额：</label>
                                <div class="col-sm-7">
                                    <input type="number" id="quota" value="${event.quota !''}" class="input-sm form-control w160 fl" name="quota" required><span class="lh30">人</span>
                                </div>
                            </div><!-- form-group -->
                            <div class="form-group">
                                <label class="col-sm-3 control-label" for="readonlyinput">* 报名开始时间：</label>
                                <div class="col-sm-7">
                                    <input type="text" id="enroll_start_time" value="" class="datepicker input-sm form-control w160" name="enroll_start_time" required>
                                </div>
                            </div><!-- form-group -->
                            
                            <div class="form-group">
                                <label class="col-sm-3 control-label" for="readonlyinput">* 报名结束时间：</label>
                                <div class="col-sm-7">
                                    <input type="text" id="enroll_end_time" value="" class="datepicker input-sm form-control w160" name="enroll_end_time" required>
                                </div>
                            </div><!-- form-group -->
                            
                            <div class="form-group">
                                <label class="col-sm-3 control-label" for="readonlyinput">* 自动下架时间：</label>
                                <div class="col-sm-7">
                                    <input type="text" id="enroll_off_time" value="" class="datepicker input-sm form-control w160" name="enroll_off_time" required>
                                </div>
                            </div><!-- form-group -->
                            
                            <div class="form-group">
                                <label class="col-sm-3 control-label" for="readonlyinput">* 活动时间：</label>
                                <div class="col-sm-7">
                                    <input type="text" id="event_time" value="" class="datepicker input-sm form-control w160" name="event_time" required>
                                </div>
                            </div><!-- form-group -->
                            
                            <div class="form-group">
                                <label class="col-sm-3 control-label" for="readonlyinput">*活动地点：</label>
                                <div class="col-sm-7">
                                    <textarea class="form-control" id="address" rows="5" name="address" required>${event.address !''}</textarea>
                                </div>
                            </div><!-- form-group -->
                            
                            <div class="form-group">
                                <label class="col-sm-3 control-label" for="readonlyinput">*活动地图地点：</label>
                                <div class="col-sm-7">
                                	<input type="text" id="location" value="${event.longitude !''},${event.latitude !''}" class="input-sm form-control w160 fl" name="location" required>
                                	<span class="lh30 ml10 crp"><a id="locationMap">活动地图地点</a></span>
                                </div>
                            </div><!-- form-group -->
                            
                            <div class="form-group">
                                <label class="col-sm-3 control-label">*活动承办方：</label>
                                <div class="col-sm-7">
                                    <input type="text" id="store_name" name="store_name" store_id="${event.store.storeId !''}" value="${event.store.storeName !''}" class="form-control input-sm" required remote="../validateStore.htm">
                                </div>
                            </div><!-- form-group -->
                            
                            <div class="form-group">
                                <label class="col-sm-3 control-label">*活动发起人：</label>
                                <div class="col-sm-7">
                                    <input type="text" id="organizer_by" name="organizer_by" value="${event.organizerBy !''}" class="form-control input-sm" required>
                                </div>
                            </div><!-- form-group -->
                            
                            <div class="form-group">
                                <label class="col-sm-3 control-label" for="readonlyinput">*活动介绍：</label>
                                <div class="col-sm-7">
                                    <textarea id="ckeditor" class="form-control" rows="15" name="ckeditor" required></textarea>
                                    <div id="introduceDiv" style="display:none;">${event.introduce}</div>
                                </div>
                            </div>
                            
                            <div class="form-group">
                                <label class="col-sm-3 control-label">*活动主要安排：</label>
                                <div class="col-sm-7">
                                    <textarea id="text" class="form-control" name="text" rows="10" required>${event.text.text}</textarea>
                                </div>
                            </div>
                            
                            <div class="form-group">
                                <label class="col-sm-3 control-label" for="readonlyinput">*活动状态：</label>
                                <div class="col-sm-7">
                                    <select id="status" class="select2 w160 fl" name="status" required>
									  <option value="on">已上架</option>
									  <option value="off">已下架</option>
									  <option value="stock">库存</option>
									</select>
                                </div>
                            </div><!-- form-group -->
                            
                            <div class="form-group">
                                <label class="col-sm-3 control-label" for="readonlyinput">*报名费：</label>
                                <div class="col-sm-7">
                                    <input type="number" id="entryfee" value="${event.entryfee !''}" name="entryfee" class="input-sm form-control w160 fl" required><span class="lh30">元</span>
                                </div>
                            </div>
                            
                            <div class="form-group">
                                <label class="col-sm-3 control-label" for="readonlyinput">*排序：</label>
                                <div class="col-sm-7">
                                    <input type="number" id="order_by" value="${event.orderBy !''}" class="input-sm form-control w160 fl" name="order_by" required><span class="lh30">排序数字越小排序越靠前</span>
                                </div>
                            </div>
                            
                            <div class="form-group">
                                <label class="col-sm-3 control-label" for="readonlyinput">自定义活动页：</label>
                                <div class="col-sm-7">
                                    <input type="text" id="url" value="${event.url !''}" name="url" class="input-sm form-control" />
                                </div>
                                <div class="col-sm-2">
                                    
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
                                    <input type="text" id="event_key" value="${event.eventKey}" name="event_key" class="input-sm form-control w100" required />
                                </div>
                            </div><!-- form-group -->
                            
                            
                            <hr>
                     		<div class="row center"><a id="saveBtn" type="submit" class="btn btn-primary">保存</a></div>
                     </form>
                    </div><!-- panel-body -->
                </div>
                
                <script src="/js/wangedit/wangEditor.js"></script>
                <script src="/js/ajaxfileupload/ajaxfileupload.js"></script>
                <script src="/js/jquery-validate/jquery.validate.min.js"></script>
                <script src="/js/jquery-validate/message_cn.js"></script>
       			<script>
       				var editor = new wangEditor('ckeditor');
			        editor.config.uploadImgUrl = '/goods/uploadTmpImg.htm';
					editor.create();
					editor.$txt.html($("#introduceDiv").html());
					
					$("#entryfee").val(${event.entryfee !'0'}/100);
       				
       				var imgPaths = [];
       				$(".imglist").each(function(index,dom){
       					var path = $(dom).attr("src");
       					imgPaths.push({imagePath: path.split("=")[1]});
       				});
       				$("#imgPaths").val(JSON.stringify(imgPaths));
       				
       				$('#locationMap').click(function(){
       					bootbox.dialog({
							message: "<iframe width='100%' id='mapIframe' style='margin: -10px 0px;' height='370' frameborder='no' border='0' src='../map.htm'></iframe>",
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
				            fileElementId:fileId,//文件选择框的id属性
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
       				
       				var stringToDate = function(value){
       					if(isNaN(value)){
       						value = value.substring(0,value.indexOf(" "));
							return value;
						}
       					var date = new Date(parseInt(value));
       					var year=date.getFullYear();     
              			var month=date.getMonth()+1;     
              			if(month < 10){
              				month = "0" + month;
              			}   
              			var date=date.getDate();
              			if(date < 10){
              				date = "0" + date;
              			}   
		              	return year + "-" + month + "-" + date
		            };
       				
		            jQuery(document).ready(function(){
		              jQuery("#form").validate({
	                    highlight: function(element) {
	                        jQuery(element).closest('.form-group').removeClass('has-success').addClass('has-error');
	                    },
	                    success: function(element) {
	                        jQuery(element).closest('.form-group').removeClass('has-error');
	                    }
	                  });
		            	
		              $("#status").val('${event.status !''}');
		              $("#status").select2({minimumResultsForSearch: -1});
		              $("#enroll_start_time").val(stringToDate('${event.enrollStartTime !''}'));
		              $("#enroll_end_time").val(stringToDate('${event.enrollEndTime !''}'));
		              $("#enroll_off_time").val(stringToDate('${event.enrollOffTime !''}'));
		              $("#event_time").val(stringToDate('${event.eventTime !''}'));
		              
		              $("#is_pt_red").val('${event.isPtRed !'Y'}');
		              $("#is_pt_red").select2({minimumResultsForSearch: -1});
		              $("#is_diy_text").val('${event.isDiyText !'N'}');
		              $("#is_diy_text").select2({minimumResultsForSearch: -1});
		              
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
			                delay: 200 
		              });
		              
		              $("#saveBtn").click(function(){
		                  if(!$("#form").valid()){
		              	  	return;
		              	  }
		              	  var params = {
			              	id: '${event.id !'-1'}',
			              	name: $("#name").val(),
			              	img: $("#img").attr("path"),
			              	imgPaths: $("#imgPaths").val(),
			              	profile: $("#profile").val(),
			              	quota: $("#quota").val(), 
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
			              $.ajax({
								url: '/event/updateEventById.ajax' ,
								type: 'POST',
								data: {map: JSON.stringify(params)} ,
								dataType: 'json',
								success: function(json){
									if(json.state == 1){
										bootbox.alert("更新成功！");
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