<#include "../head.ftl"/>
<script src="../../js/bootbox/bootbox.min.js"></script>
<script src="../../js/jquery-ui-1.10.3/jquery-ui-1.10.3.min.js"></script>
<link rel="stylesheet" type="text/css" href="/css/wangedit/wangEditor.min.css">
<style>.imglist{margin-right:5px;}body{margin-top:0!important;}</style>
<link href="/css/fileinput.css" rel="stylesheet">
<script src="/js/fileinput/fileinput.js"></script>
<script src="/js/fileinput/fileinput_locale_zh.js"></script>
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
                            <li>私人健康师管理</li>
                        </ul>
                        <h4>私人健康师</h4>
                    </div>
                </div><!-- media -->
            </div><!-- pageheader -->
            
            <div class="contentpanel">
                <div class="alert alert-info">
                    <button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
                    <strong>说明：</strong>健康师资料
                </div>
                 <div class="panel panel-default">
                   <div class="panel-heading">
						<div class="form-horizontal cb pt5">
							<h4 class="panel-title"健康师信息</h4>
						</div>
                    </div><!-- panel-heading -->
                    <div class="panel-body">
                        <form class="form-horizontal form-bordered" id="form">
                            <div class="form-group">
                                <label class="col-sm-3 control-label">*姓名：</label>
                                <div class="col-sm-7">
                                    <input type="text" id="trueName" name="trueName" value="${result.techie.trueName !''}" class="form-control input-sm" required>
                                </div>
                            </div><!-- form-group -->
                            
                            <div class="form-group">
                                <label class="col-sm-3 control-label">*性别：</label>
                                <div class="col-sm-7">
                                    <select id="sex" class="select2 w160 fl" name="sex" required>
									  <option value="m">男</option>
									  <option value="w">女</option>
									  <option value="c">保密</option>
									</select>
                                </div>
                            </div><!-- form-group -->
                            
                            <div class="form-group">
                                <label class="col-sm-3 control-label">*年龄：</label>
                                <div class="col-sm-7">
                                    <input type="text" id="age" name="age" value="${result.techie.age !''}" class="form-control input-sm" required>
                                </div>
                            </div><!-- form-group -->
                            
                            <div class="form-group">
                                <label class="col-sm-3 control-label" for="readonlyinput">*地区：</label>

                                <div class="col-sm-7">
                                    <div class="form-horizontal cb pt5">
                                        <div class="form-line">
                                            <select name="map[areaid1]" id="province" class="select2 w100 fl ml10">
                                            <option value="">请选择</option>
                                            <#if result.proviceList?? && result.proviceList?size gt 0>

                                                <#list result.proviceList as province >

                                                    <option value="${province.areaId}">${province.areaName}</option>

                                                </#list>

                                            </#if>

                                            </select>
                                            <select name="map[areaid2]" id="city" class="select2 w100 fl ml10">
                                            <option value="">请选择</option>
                                            <#if result.cityList?? && result.cityList?size gt 0>

                                                <#list result.cityList as city >

                                                    <option province="${city.areaParentId}"
                                                            value="${city.areaId}">${city.areaName}</option>

                                                </#list>

                                            </#if>
                                            </select>

                                            <select name="map[areaid3]" id="area" class="select2 w100 fl ml10">
                                            <option value="">请选择</option>
                                            <#if result.areaList?? && result.areaList?size gt 0>

                                                <#list result.areaList as area >

                                                    <option city="${area.areaParentId}"
                                                            value="${area.areaId}">${area.areaName}</option>

                                                </#list>

                                            </#if>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-2">
                                </div>
                            </div>
                            <!-- form-group -->
                            
    
    						<div class="form-group">
                                <label class="col-sm-3 control-label">*机构：</label>
                                <div class="col-sm-7">
                                    <div class="col-sm-7">
	                                    <input type="text" id="store_name" name="store_name" value="${result.techie.storeName !''}" store_id="${result.techie.storeId !'0'}" class="form-control input-sm" required remote="/event/validateStore.htm">
	                                </div>
                                </div>
                                <div class="col-sm-2">
                                </div>
                            </div><!-- form-group -->
                            
                            <div class="form-group">
                                <label class="col-sm-3 control-label" for="readonlyinput">*专业：</label>

                                <div class="col-sm-7">
                                    <div class="form-horizontal cb pt5">
                                        <div class="form-line">
                                            <select name="map[major]" id="clzone" class="select2 w100 fl ml10">
                                            <option value="">请选择专业</option>
                                            <#if result.classOneList?? && result.classOneList?size gt 0>

	                                            <#list result.classOneList as classone >
	
	                                                <option parent="${classone.classParentId}"
	                                                        value="${classone.classId}">${classone.className}</option>
	
	                                            </#list>
	
	                                        </#if>
                                            </select>
                                            <select name="map[grade]" id="clztwo" class="select2 w100 fl ml10">
                                            <option value="">请选择等级</option>
                                            <#if result.classTwoList?? && result.classTwoList?size gt 0>

	                                            <#list result.classTwoList as classtwo>
	
	                                                <option parent="${classtwo.classParentId}"
	                                                        value="${classtwo.classId}">${classtwo.className}</option>
	
	                                            </#list>
	
	                                        </#if>
                                            </select>

                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- form-group -->
                            
                            <div class="form-group">
                                <label class="col-sm-3 control-label">工龄：</label>
                                <div class="col-sm-7">
                                    <div class="col-sm-7">
	                                    <input type="text" id="seniority" name="seniority" value="${result.techie.gAge !''}" class="form-control input-sm" required>
	                                </div>
	                                	年
                                </div>
                            </div><!-- form-group -->
                            
                            <div class="form-group">
                                <label class="col-sm-3 control-label">资格证书（单图）：</label>
                                <div class="col-sm-7">
               							<img src="${imgUrl}/cert/${result.techie.certificate1 !''}" />
               							<!--<input id="input-3" name="uploadFile" type="file" multiple class="file-loading" data-min-file-count="1" data-name="qualification">-->
                                </div>
                                <div class="col-sm-2">
                                </div>
                            </div><!-- form-group -->
                            
                            <div class="form-group">
                                <label class="col-sm-3 control-label">* 一寸免冠照/头像（单图）：</label>
                                <div class="col-sm-7">
                                		<img src="${imgUrl}/portrait/${result.techie.img !''}" />
               							<!--<input id="input-3" name="uploadFile" type="file" multiple class="file-loading" data-min-file-count="1" data-name="photo">-->
                                </div>
                                <div class="col-sm-2">
                                </div>
                            </div><!-- form-group -->
                            
                            <div class="form-group">
                                <label class="col-sm-3 control-label">*个人介绍：</label>
                                <div class="col-sm-7">
                                    <textarea id="ckeditor" class="form-control" name="ckeditor" rows="15" required>${result.techie.techieIntroduce !''}</textarea>
                                </div>
                            </div><!-- form-group -->
    
    						<!--
                            <div class="form-group">
                                <label class="col-sm-3 control-label">相册（多图）：</label>
                                <div class="col-sm-7">
               							<input id="input-3" name="uploadFile" type="file" multiple class="file-loading" data-min-file-count="1" data-name="photo">
                                </div>
                                <div class="col-sm-2">
                                </div>
                            </div><!-- form-group -->
                            
                            <!--
                            <div class="form-group">
                                <label class="col-sm-3 control-label">结算账户：</label>
                                <div class="col-sm-7">
                                <label class="col-sm-3 control-label">开户名称：</label>
                                    <div class="col-sm-7">
	                                    <input type="text" id="seniority" name="seniority" value="" class="form-control input-sm" required>
	                                </div>
                                </div>
                                
                                <label class="col-sm-3 control-label"></label>
                                <div class="col-sm-7">
                                <label class="col-sm-3 control-label">账号：</label>
                                    <div class="col-sm-7">
	                                    <input type="text" id="seniority" name="seniority" value="" class="form-control input-sm" required>
	                                </div>
                                </div>
                                
                                <label class="col-sm-3 control-label"></label>
                                <div class="col-sm-7">
                                <label class="col-sm-3 control-label">开户人：</label>
                                    <div class="col-sm-7">
	                                    <input type="text" id="seniority" name="seniority" value="" class="form-control input-sm" required>
	                                </div>
                                </div>
                            </div><!-- form-group -->
                            <!--
                            <div class="form-group">
                                <label class="col-sm-3 control-label">排序：</label>
                                <div class="col-sm-7">
                                    <div class="col-sm-7">
	                                    <input type="text" id="seniority" name="seniority" value="" class="form-control input-sm" required>
	                                </div>
	                                      排序越小越靠前
                                </div>
                            </div><!-- form-group -->
    
    						<!--
                            <div class="form-group">
                                <label class="col-sm-3 control-label">合同图片（单图）：</label>
                                <div class="col-sm-7">
               							<input id="input-3" name="uploadFile" type="file" multiple class="file-loading" data-min-file-count="1" data-name="photo">
                                </div>
                                <div class="col-sm-2">
                                </div>
                            </div><!-- form-group -->
                            
                            <hr>

                    		<div class="row center"><button id="closeBtn" class="btn btn-primary">返回</button>
                    			<!--<button id="saveBtn" type="submit" class="btn btn-primary ml10">保存</button>-->
                    		</div>

                     </form>
                    </div><!-- panel-body-->
                </div>
                
                <script src="/js/wangedit/wangEditor.js"></script>
                <script src="/js/ajaxfileupload/ajaxfileupload.js"></script>
                <script src="/js/jquery-validate/jquery.validate.min.js"></script>
                <script src="/js/jquery-validate/message_cn.js"></script>
       			<script>
					$(document).ready(function () {
						$("#closeBtn").click(function(){
							window.location.href="/techie/list.htm";
						});
					
						$('input[name="uploadFile"]').each(function(){
							//var id = $(this).attr('id');
							var name = $(this).attr('data-name');
							$(this).fileinput({
								language: 'zh', //设置语言
								uploadUrl:'/techie/uploadImg.ajax', //上传的地址
								allowedFileExtensions : ['jpg', 'png','gif'],//接收的文件后缀
								showUpload: true, //是否显示上传按钮
								showCaption: false,//是否显示标题
								browseClass: "btn btn-primary", //按钮样式
								maxFileSize: 2000,
								maxFileCount: 1,
								mainClass: "input-group-lg",
							});
							/**上传成功监听事件*/
							$(this).on("fileuploaded", function(event, data, previewId, index) {
								var imagePath = data.response.param.imagePath;
								var url = data.response.param.url;
								var _input = $(this).parents('td').find('input[name="'+name+'"]');
								if(_input.length == 0){
									$(this).parents('td').append('<input type="hidden" name="'+name+'" value="'+imagePath+'"><img src="' + url +imagePath+'" style="width:10%">');
								}else{
									_input.val(imagePath);
									_input.next().attr('src',url+imagePath);
									_input.next().show();
								}
							});
							/***移除事件*/
							$(this).on('fileclear',function(event, data, previewId, index){
								var _input = $(this).parents('td').find('input[name="'+name+'"]');
								_input.val('');
								_input.next().attr('src','');
								_input.next().hide();
							});
						});
					
					});
					
				$(function () {	
			        var proviceList = $("#province").find("option");
			        var cityList = $("#city").find("option");
			        var areaList = $("#area").find("option");
			        var oneList = $("#clzone").find("option");
        			var twoList = $("#clztwo").find("option");
					
					$("#city").empty();
        			$("#area").empty();
					$("#province").on("change", function () {
			
			            var _this = this;
			
			
			            var proId = $(_this).find("option:selected").val();
			
			
			            $("#city").empty();
			
			
			            var select = false;
			            for (var i = 0; i < cityList.length; i++) {
			
			
			                var _option = $(cityList[i]);
			
			
			                if (_option.attr("province") == proId) {
			
			
			                    if (!select) {
			                        _option.attr("selected", true);
			                        select = true;
			                    }
			                    $("#city").append(_option);
			                }
			
			
			            }
						
						$("#province").val(proId);
			
			            $("#city").trigger("change");
			        });
			
			
			        $("#city").on("change", function () {
			
			            var _this = this;
			
			
			            var cityId = $(_this).find("option:selected").val();
			
			
			            $("#area").empty();
			
			            var select = false;
			            for (var i = 0; i < areaList.length; i++) {
			
			
			                var _option = $(areaList[i]);
			
			                if (_option.attr("city") == cityId) {
			                    if (!select) {
			                        _option.attr("selected", true);
			                        select = true;
			                    }
			
			                    $("#area").append(_option);
			                }
			
			            }
			            $("#area").trigger("change");
			        });
			
			
			        $("#area").on("change", function () {
			
			            var _this = this;
			
			            var areaId = $(_this).find("option:selected").val();
			
			            var select = false;
						$("input[name='map[areaid2]']").val(areaId);
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
		              
		              $("#clztwo").empty();
		              $("#clzone").on("change", function () {

			            var _this = this;
			
			
			            var clzoneId = $(_this).find("option:selected").val();
			
			
			            $("#clztwo").empty();
			
			
			            var select = false;
			            for (var i = 0; i < twoList.length; i++) {
			
			
			                var _option = $(twoList[i]);
			
			                if (_option.attr("parent") == clzoneId) {
			                    if (!select) {
			                        _option.attr("selected", true);
			                        select = true;
			                    }
			
			                    $("#clztwo").append(_option);
			                }
			            }
			            $("#clztwo").select2({minimumResultsForSearch: -1});
			        });
			        
			        $("#province").val("${result.techie.provinceId !''}");
					$("#province").select2({minimumResultsForSearch: -1});
					$("#province").trigger("change");
					$("#city").val("${result.techie.cityId !''}");
					$("#city").select2({minimumResultsForSearch: -1});
					$("#city").trigger("change");
					$("#area").val("${result.techie.areaId !''}");
					$("#area").select2({minimumResultsForSearch: -1});
					
					oneList.each(function(index,dom){
						if($(dom).text() == "${result.techie.specialty !''}"){
							$(dom).attr("selected","selected");
						}
					});
					$("#clzone").trigger("change");
					$("#clzone").select2({minimumResultsForSearch: -1});
					twoList.each(function(index,dom){
						if($(dom).text() == "${result.techie.specialtyGrade !''}"){
							$(dom).attr("selected","selected");
						}
					});
					$("#clztwo").select2({minimumResultsForSearch: -1});
     		});
	            </script>
		</div>
	</div>
</section>
</body>
</html>