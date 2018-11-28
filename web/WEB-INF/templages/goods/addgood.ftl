<#include "../head.ftl"/>
<style>
body{margin-top: 0 !important;}
#listImg{display:none;}
</style>
<link rel="stylesheet" type="text/css" href="/css/wangedit/wangEditor.min.css">
<section>
    <div class="mainwrapper">
    <#include "../leftnav.ftl"/>
        <div class="mainpanel">
            <div class="pageheader">
                <div class="media">
                    <div class="pageicon pull-left">
                        <i class="fa fa-bars"></i>
                    </div>
                    <div class="media-body">
                        <ul class="breadcrumb">
                            <li><a href=""><i class="fa fa-home"></i></a></li>
                            <li>产品管理</li>
                        </ul>
                        <h4>添加产品</h4>
                    </div>
                </div>
                <!-- media -->
            </div>
            <!-- pageheader -->

            <div class="contentpanel">
                <div class="alert alert-info">
                    <button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
                    <strong>说明：</strong>完善产品信息、产品价格、产品设置后再点击保存产品。若补货，库存应在原库存基础上累加
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading">

                        <h4 class="panel-title">编辑产品信息</h4>

                        <div class="pull-right mt-30">
                            <button type="button" class="btn btn-danger btn-sm" onclick="addGood();">保存产品</button>
                            <button type="button" id="infobtn" class="btn btn-primary btn-sm">产品信息</button>
                            <button type="button" id="pricebtn" class="btn btn-primary btn-sm">产品价格</button>
                            <button type="button" id="setbtn" class="btn btn-primary btn-sm">产品设置</button>
                        </div>
                    </div>
                    <!-- panel-heading -->
                    <form id="goodForm" action="/goods/addGood.htm" method="post" class="form-horizontal form-bordered" enctype="multipart/form-data">
                        <div id="info_panel" class="panel-body">
                            <div class="panel-body nopadding">


                                <div class="form-group">
                                    <label class="col-sm-3 control-label">*产品名称：</label>

                                    <div class="col-sm-7">
                                        <input type="text" placeholder="" name="map[goodsName]"
                                               class="form-control input-sm">
                                    </div>
                                </div>
                                <!-- form-group -->

                                <div class="form-group">
                                    <label class="col-sm-3 control-label" for="disabledinput">*产品简介：</label>

                                    <div class="col-sm-7">
                                        <textarea name="map[goodsIntroduce]" class="form-control" rows="5"></textarea>
                                    </div>
                                    <div class="col-sm-2">

                                    </div>
                                </div>
                                <!-- form-group -->

                                <div class="form-group">
                                    <label class="col-sm-3 control-label" for="readonlyinput">*内容介绍：(图文混排672*276px)</label>

                                    <div class="col-sm-7">
                                        <textarea id="content" name="map[contentIntroduce]"
                                                  rows="15"></textarea>
                                    </div>
                                    <div class="col-sm-2">
                                        <#--<button type="button" class="btn btn-primary btn-sm">存为模板</button>-->
                                        <#--<button type="button" class="btn btn-primary btn-sm" onclick="loadTmp(1);">-->
                                            <#--选择模板-->
                                        <#--</button>-->
                                    </div>
                                </div>
                                <!-- form-group -->
                                <div class="form-group">
                                    <label class="col-sm-3 control-label" for="readonlyinput">*贝多会员权益：</label>

                                    <div class="col-sm-7">
                                        <textarea id="right" name="map[memberInterest]"
                                                  rows="15"></textarea>
                                    </div>
                                    <div class="col-sm-2">
                                        <button type="button" class="btn btn-primary btn-sm" onclick="saveTmp(2);">存为模板</button>
                                        <button type="button" class="btn btn-primary btn-sm" onclick="loadTmp(2);">
                                            选择模板
                                        </button>
                                    </div>
                                </div>
                                <!-- form-group -->
                                <div class="form-group">
                                    <label class="col-sm-3 control-label" for="readonlyinput">*购买须知：</label>

                                    <div class="col-sm-7">
                                        <textarea id="needknow" name="map[buyKnow]"
                                                  rows="15"></textarea>
                                    </div>
                                    <div class="col-sm-2">
                                        <button type="button" class="btn btn-primary btn-sm" onclick="saveTmp(3);">存为模板</button>
                                        <button type="button" class="btn btn-primary btn-sm" onclick="loadTmp(3);">
                                            选择模板
                                        </button>
                                    </div>
                                </div>
                                <!-- form-group -->
                                <div class="form-group">
                                    <label class="col-sm-3 control-label" for="readonlyinput">产品列表图片：(208*208px)</label>

                                    <div class="col-sm-7">
                                        <input type="file" onchange="uploadImg(this);" id="fileinfo0" name="fileinfo"  />
										<br><img id="listImg" width="50px;" src="">
										<input type="hidden" id="mainImg" value="" name="map[goodsImage]">
                                    </div>
                                    <div class="col-sm-2">
                                    </div>
                                </div>
                                
                                
                                
                                <div class="form-group">
                                    <label class="col-sm-3 control-label" for="readonlyinput">产品图片1：(720*354px)</label>

                                    <div class="col-sm-7">
                                        <input type="file" onchange="uploadImg(this);" id="fileinfo1" name="fileinfo"  />

                                    </div>
                                    <div class="col-sm-2">

                                    </div>
                                </div>


                                <div class="form-group">
                                    <label class="col-sm-3 control-label" for="readonlyinput">产品图片2：(720*354px)</label>

                                    <div class="col-sm-7">
                                        <input type="file" onchange="uploadImg(this);" id="fileinfo2" name="fileinfo"  />

                                    </div>
                                    <div class="col-sm-2">

                                    </div>
                                </div>


                                <div class="form-group">
                                    <label class="col-sm-3 control-label" for="readonlyinput">产品图片3：(720*354px)</label>

                                    <div class="col-sm-7">
                                        <input type="file" onchange="uploadImg(this);" id="fileinfo3" name="fileinfo"  />

                                    </div>
                                    <div class="col-sm-2">

                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-sm-3 control-label" for="readonlyinput">产品图片4：(720*354px)</label>

                                    <div class="col-sm-7">
                                        <input type="file" onchange="uploadImg(this);" id="fileinfo4" name="fileinfo"  />

                                    </div>
                                    <div class="col-sm-2">

                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-sm-3 control-label" for="readonlyinput">产品图片5：(720*354px)</label>

                                    <div class="col-sm-7">
                                        <input type="file" onchange="uploadImg(this);" id="fileinfo5" name="fileinfo"  />

                                    </div>
                                    <div class="col-sm-2">

                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-sm-3 control-label" for="readonlyinput"></label>

                                    <div class="col-sm-7">
                                           <div id="imglist">

                                               <img width="50px;" height="50px;"/>
                                               <img width="50px;" height="50px;" />
                                               <img width="50px;" height="50px;"/>
                                               <img width="50px;" height="50px;"/>
                                               <img width="50px;" height="50px;"/>

                                           </div>
                                    </div>
                                    <div class="col-sm-2">
                                        <input type="hidden" id="goodsImageList" name="map[goodsImages]" />
                                    </div>
                                </div>
                                <!-- form-group -->
                                <div class="form-group">
                                    <label class="col-sm-3 control-label" for="readonlyinput">*合作商家：</label>

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

                                                <select name="map[storeId]" id="store" class="select2 w100 fl ml10" onchange="setStoreName(this)">
                                                <option value="">请选择</option>
                                                <#if result.storeList?? && result.storeList?size gt 0>

                                                    <#list result.storeList as store >

                                                        <option area="${store.areaId !''}"
                                                                value="${store.storeId}">${store.storeName !'null'}</option>

                                                    </#list>

                                                </#if>
                                                </select>
                                                <#if result.storeList?? && result.storeList?size gt 0>
                                                    <#list result.storeList as store >
                                                    	<#if store_index == 0>
															<input type="hidden" name="map[storeName]" value="${store.storeName !''}">
														</#if>
													</#list>
												<#else>
													<input type="hidden" name="map[storeName]" value="">
												</#if>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-2">

                                    </div>
                                </div>
                                <!-- form-group -->

                                <div class="form-group">
                                    <label class="col-sm-3 control-label" for="readonlyinput">显示优先级：</label>

                                    <div class="col-sm-7">
                                        <input type="number" name="map[showPriority]" placeholder=""
                                               class="form-control input-sm w160">
                                    </div>
                                    <div class="col-sm-2">

                                    </div>
                                </div>
                                <!-- form-group -->
                                <div class="form-group">
                                    <label class="col-sm-3 control-label" for="readonlyinput">*产品分类：</label>

                                    <div class="col-sm-7">

                                        <select name="map[gcId1]" id="clzone" class="select2 w100 fl ml10">
                                        <option value="">请选择</option>
                                        <#if result.classOneList?? && result.classOneList?size gt 0>

                                            <#list result.classOneList as classone >

                                                <option parent="${classone.classParentId}"
                                                        value="${classone.classId}">${classone.className}</option>

                                            </#list>

                                        </#if>
                                        </select>

                                        <select name="map[gcId2]" id="clztwo" class="select2 w100 fl ml10">
                                        <option value="">请选择</option>
                                        <#if result.classTwoList?? && result.classTwoList?size gt 0>

                                            <#list result.classTwoList as classtwo>

                                                <option parent="${classtwo.classParentId}"
                                                        value="${classtwo.classId}">${classtwo.className}</option>

                                            </#list>

                                        </#if>
                                        </select>


                                    </div>
                                    <div class="col-sm-2">

                                    </div>
                                </div>
                                <!-- form-group -->
                                
                                <div class="form-group">
                                    <label class="col-sm-3 control-label" for="readonlyinput">*是否为预定商品：</label>

                                    <div class="col-sm-7">
                                        <select id="isBook" name="map[isBook]" class="select2 w100 fl ml10">
                                            <option value="1" >否</option>
                                            <option value="2">是</option>
                                         </select>
                                    </div>
                                    <div class="col-sm-2">

                                    </div>
                                </div>

                            </div>
                            <!-- panel-body -->
                        </div>

                        <div id="price_panel" class="panel-body" style="display: none;">
                            <div class="panel-body nopadding">

                                <!-- Table -->
                                <table class="table" id="specTab">
                                    <thead>
                                    <th>* 规格编号</th>
                                    <th>* 规格名称</th>
                                    <th>* 基础价格（元）</th>
                                    <th>* 原价（元）</th>
                                    <th>* VIP0（元）</th>
                                    <th>* VIP1（元）</th>
                                    <th>* VIP2（元）</th>
                                    <th>推荐激励单价</th>
                                    <th style="display:none;">* VIP4（元）</th>
                                    <th>* 定金（元）</th>
                                    <th> 单位</th>
                                    <th> 库存</th>
                                    <th>管理</th>
                                    </thead>

                                    <tbody>
                                    <tr align="right">

                                        <td colspan="12">
                                            <button type="button" class="btn btn-danger btn-sm" onclick="addSpec();">
                                                	添加规格
                                            </button>
                                        </td>

                                    </tr>

                                    </tbody>
                                </table>
                            </div>
                        </div>


                        <div id="set_panel" class="panel-body" style="display: none;">
                            <div class="panel-body nopadding">
								<div class="form-group">
                                    <label class="col-sm-3 control-label">*销售开始时间：</label>

                                    <div class="col-sm-7">
                                        <input type="text" placeholder="" name="map[beginTime]" class="datepicker form-control input-sm">
                                    </div>
                                </div>
                                
                                <div class="form-group">
                                    <label class="col-sm-3 control-label">*销售结束时间：</label>

                                    <div class="col-sm-7">
                                        <input type="text" placeholder="" name="map[endTime]" class="datepicker form-control input-sm">
                                    </div>
                                </div>
                                
                                <div class="form-group">
                                    <label class="col-sm-3 control-label">*有效期至：</label>

                                    <div class="col-sm-7">
                                        <input type="text" placeholder="" name="map[periodOfValidity]" class="datepicker form-control input-sm">
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-sm-3 control-label" for="readonlyinput">*状态：</label>

                                    <div class="col-sm-7">
                                        <select name="map[goodsState]" class="select2 w100 fl ml10">
                                            <option value="2" >已上架</option>
                                            <option value="1" >已下架</option>
                                            <option value="3">库存</option>
                                         </select>
                                    </div>
                                    <div class="col-sm-2">

                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-sm-3 control-label" for="readonlyinput">*是否可用红包：</label>

                                    <div class="col-sm-7">
                                        <select name="map[isPtRed]" class="select2 w100 fl ml10">

                                            <option value="Y" >可用红包</option>
                                            <option value="N">不可用红包</option>
                                        </select>
                                    </div>
                                    <div class="col-sm-2">

                                    </div>
                                </div>
								
								<div class="form-group">
                                    <label class="col-sm-3 control-label">顾客购买填写信息：</label>

                                    <div class="col-sm-7">
                                        <input type="checkbox" id="isDiyText" onclick="changeIsBuyInfo(this)">姓名、电话、上门地址、时间
                                        <input type="hidden" name="map[isDiyText]" value="N">
                                    </div>
                                </div>

								<div class="form-group">
                                    <label class="col-sm-3 control-label">私人健康师：</label>

                                    <div class="col-sm-7">
                                        <select name="map[technicianId]" class="select2 w100">
                                            <option value="">无</option>
                                        	<#if result.techie?? && result.techie?size gt 0>

	                                            <#list result.techie as techie >
	
	                                                <option value="${techie.techieId}">${techie.techieName}</option>
	
	                                            </#list>
	
	                                        </#if>
                                        </select>
                                    </div>
                                </div>
                                
                                <div class="form-group">
                                    <label class="col-sm-3 control-label">*消费券有效期（小时）：</label>

                                    <div class="col-sm-7">
                                        <input type="number" placeholder="" name="map[xfqYxqValues]"
                                               class="form-control input-sm w100">
                                    </div>
                                </div>
                                
                                <div class="form-group">
                                    <label class="col-sm-3 control-label" for="readonlyinput">*售后投诉：</label>

                                    <div class="col-sm-7">
                                        <select name="map[serviceShComplaint]" class="select2 w100 fl ml10">
                                            <option value="0" >不支持</option>
                                            <option value="1">支持</option>
                                        </select>
                                    </div>
                                    <div class="col-sm-2">

                                    </div>
                                </div>
                                
                                <div class="form-group">
                                    <label class="col-sm-3 control-label" for="readonlyinput">*售后退款：</label>

                                    <div class="col-sm-7">
                                        <select name="map[serviceShRefund]" class="select2 w100 fl ml10">
                                            <option value="0" >不支持</option>
                                            <option value="1">支持</option>
                                        </select>
                                    </div>
                                    <div class="col-sm-2">

                                    </div>
                                </div>
                            </div>
                        </div>
                        <input type="hidden" name="specStr"/>
                    </form>
                </div>

            </div>
            <!-- contentpanel -->
        </div>
        <!-- mainpanel -->
    </div>
    <!-- mainwrapper -->
</section>
<script src="/js/wangedit/wangEditor.js"></script>
<script src="/js/ajaxfileupload/ajaxfileupload.js"></script>
<script src="/js/bootbox/bootbox.min.js"></script>
<script defer="defer">
	function setStoreName(obj){
		$("input[name='map[storeName]']").val($(obj).find("option:selected").text());
	}
	function changeIsBuyInfo(obj){
		if($(obj).prop("checked")){
			$("input[name='map[isDiyText]']").val("Y");
		}else{
			$("input[name='map[isDiyText]']").val("N");
		}
	}
    $(function () {
		$("select[name='map[technicianId]']").select2();

        var proviceList = $("#province").find("option");
        var cityList = $("#city").find("option");
        var areaList = $("#area").find("option");
        var storeList = $("#store").find("option");
        var oneList = $("#clzone").find("option");
        var twoList = $("#clztwo").find("option");

        var editor1 = new wangEditor('content');//$('#content').wangEditor();
        editor1.config.uploadImgUrl = '/goods/uploadTmpImg.htm';
		editor1.create();
        var editor2 = new wangEditor('right');//$('#right').wangEditor();
        editor2.config.uploadImgUrl = '/goods/uploadTmpImg.htm';
		editor2.create();
        var editor3 = new wangEditor('needknow');//$('#needknow').wangEditor();
        editor3.config.uploadImgUrl = '/goods/uploadTmpImg.htm';
		editor3.create();
	
        $("#city").empty();
        $("#area").empty();
        $("#store").empty();

        $("#store").append("<option value='-1'>请选择</option>");
        $("#store").find("option:eq(0)").get(0).selected = true;



        $("#clztwo").empty();


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


            $("#store").empty();

//            $("#store").css("display","block");

            var select = false;
            for (var i = 0; i < storeList.length; i++) {


                var _option = $(storeList[i]);

                if (_option.attr("area") == areaId) {
                    if (!select) {
                        _option.attr("selected", true);
                        select = true;
                    }

                    $("#store").append(_option);
                }


            }
			$("input[name='map[areaid2]']").val(areaId);
        });


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
        
        $("#province").val(18);
		$("#province").select2({minimumResultsForSearch: -1});
		$("#province").trigger("change");
		$("#city").val(275);
		$("#city").select2({minimumResultsForSearch: -1});
		$("#city").trigger("change");

        $("#infobtn").on("click", function () {

            $("#info_panel").css("display", "block");
            $("#info_panel").siblings().each(function (i, o) {
                $(o).css("display", "none");
            });
        });
        $("#pricebtn").on("click", function () {
            var _this = this;

            $("#price_panel").css("display", "block");
            $("#price_panel").siblings().each(function (i, o) {
                $(o).css("display", "none");
            });
        });
        $("#setbtn").on("click", function () {

            $("#set_panel").css("display", "block");
            $("#set_panel").siblings().each(function (i, o) {
                $(o).css("display", "none");
            });


        });


    });

	var saveTmp = function (_type) {
		var type;
        var _targetTxt;
        var _target;
        switch (_type) {

            case 1:
                type = 'introduce';
                _target = $("#content");
                _targetTxt = $("#content").next(".wangEditor-container").find(".wangEditor-txt");
                break;
            case 2:
                type = 'know';
                _target = $("#right");
                _targetTxt = $("#right").next(".wangEditor-container").find(".wangEditor-txt");
                break;
            case 3:
                type = 'right';
                _target = $("#needknow");
                _targetTxt = $("#needknow").next(".wangEditor-container").find(".wangEditor-txt");
                break;
        }
        
        bootbox.dialog({  
            message: '<div class="form-group"><label class="col-sm-3 control-label">模板名称：</label><div class="col-sm-7"><input type="text" id="tmpName" name="name" value="" class="form-control input-sm"></div></div><div class="form-group"><div class="col-sm-12"><textarea id="tmpContent" class="form-control" rows="15" name="profile"></textarea></div></div>',  
            title: "存为模板",  
            buttons: {  
                Cancel: {  
                    label: "取消",  
                    className: "btn-default",  
                    callback: function () {  
                        
                    }  
                }, OK: {  
                    label: "确定",  
                    className: "btn-primary",  
                    callback: function () {  
                        if($("#tmpName").val() == ''){
                        	alert("模板名称为空!");
                        	return;
                        }
                        if($("#tmpContent").val() == ''){
                        	alert("模板内容为空!");
                        	return;
                        }  
                        $.ajax({
	                        url: '/goods/saveGoodTmp.htm' ,
							type: 'POST',
							data: {
								goodTmpName: $("#tmpName").val(),
								goodTmpCt: new Date(),
								goodTmpContent: $("#tmpContent").val(),
								goodTmpType: type
							},
							dataType: 'json',
							success: function(json){
								if(json != null && json != 'null' && json != ''){
									bootbox.alert("添加成功！");
								}else{
									bootbox.alert("添加失败！");
								}
							} ,
							error: function(){
								bootbox.alert("网络忙，请稍后重试！");
							}
	                    });
                    }  
                }  
            }  
        });  
        setTimeout(function(){
        	//$('#tmpContent').wangEditor();
        	var editor = new wangEditor('tmpContent');
        	editor.config.uploadImgUrl = '/goods/uploadTmpImg.htm';
			editor.create();
        	//$('#tmpContent').text(_targetTxt.html());
        	//$("#tmpContent").prev(".wangEditor-container").find(".wangEditor-textarea").html(_targetTxt.html());
        	editor.$txt.html(_targetTxt.html());
        },200);
        
	};
	var useTmp = null;
	var editTmp = null;

    var loadTmp = function (_type) {
        var type;

        var _targetTxt;
        var _target;

        switch (_type) {

            case 1:
                type = 'introduce';
                _target = $("#content");
                _targetTxt = $("#content").next(".wangEditor-container").find(".wangEditor-txt");
                break;
            case 2:
                type = 'know';
                _target = $("#right");
                _targetTxt = $("#right").next(".wangEditor-container").find(".wangEditor-txt");
                break;
            case 3:
                type = 'right';
                _target = $("#needknow");
                _targetTxt = $("#needknow").next(".wangEditor-container").find(".wangEditor-txt");
                break;


        }

        $.post("/goods/loadGoodTmp.htm", {type: type}, function (data) {


            var ele = $(document).find(".tmpSel");


            var _html = '<form class="form-horizontal form-bordered"><div class="form-group"><div class="col-sm-12">  <table id="tmpSel" class="table"><tr><th>模板名称</th><th>模板概要</th><th>操作</th></tr>'
            if (null != data && data.length > 0) {
                for (var i = 0; i < data.length; i++) {
                    var tmp = data[i];
                    _html += '<tr><td>' + tmp["goodTmpName"] + '</td>' + '<td value="' + tmp["goodTmpId"] + '">' + tmp["goodTmpName"] + '</td>' + '<td value="' + tmp["goodTmpId"] + '"><a onclick="useTmp(this)" class="crp">使用</a> <a onclick="editTmp(this)" class="crp">编辑</a></td></tr>';
                }
            }
            else {
                _html += '<tr><td value="">没有模版</td></tr>';
            }

            _html += '</table> </div></div> </form>';

			useTmp = function(obj){
				var tmpId = $(obj).parent().attr("value");
				
				bootbox.hideAll();
				
		        $.post("/goods/choseTmp.htm", {tmpId: tmpId}, function (data) {
		            _target.text(data);
		            _targetTxt.html(data);
		
		        }, "html").error(
		                function () {
		                    alert("error");
		                }
		        )
			};

			editTmp = function(obj){
				var tmpId = $(obj).parent().attr("value");
				var tmpName = $(obj).parent().prev().text();
				
				bootbox.hideAll();
				var tmpContent = '';
				
				$.post("/goods/choseTmp.htm", {tmpId: tmpId}, function (data) {
					tmpContent = data;
                }, "html").error(
                        function () {
                            alert("error");
                        }
                );
				
				bootbox.dialog({  
		            message: '<div class="form-group"><label class="col-sm-3 control-label">模板名称：</label><div class="col-sm-7"><input type="text" id="tmpName" name="name" value="" class="form-control input-sm"></div></div><div class="form-group"><div class="col-sm-12"><textarea id="tmpContent" class="form-control" rows="15" name="profile"></textarea></div></div>',  
		            title: "存为模板",  
		            buttons: {  
		                Cancel: {  
		                    label: "取消",  
		                    className: "btn-default",  
		                    callback: function () {  
		                        
		                    }  
		                }, OK: {  
		                    label: "保存",  
		                    className: "btn-primary",  
		                    callback: function () {  
		                        if($("#tmpName").val() == ''){
		                        	alert("模板名称为空!");
		                        	return;
		                        }
		                        if($("#tmpContent").val() == ''){
		                        	alert("模板内容为空!");
		                        	return;
		                        }  
		                        $.ajax({
			                        url: '/goods/updateGoodTmp.htm' ,
									type: 'POST',
									data: {
										goodTmpId: tmpId,
										goodTmpName: $("#tmpName").val(),
										goodTmpContent: $("#tmpContent").val(),
										goodTmpType: type
									},
									dataType: 'json',
									success: function(json){
										if(json != null && json != 'null' && json != ''){
											bootbox.alert("更新成功！");
										}else{
											bootbox.alert("更新失败！");
										}
									} ,
									error: function(){
										bootbox.alert("网络忙，请稍后重试！");
									}
			                    });
		                    }  
		                }  
		            }  
		        });  
		        setTimeout(function(){
		        	//$('#tmpContent').wangEditor();
		        	var editor = new wangEditor('tmpContent');
		        	editor.config.uploadImgUrl = '/goods/uploadTmpImg.htm';
					editor.create();
		        	//$('#tmpContent').text(tmpContent);
		        	//$("#tmpContent").prev(".wangEditor-container").find(".wangEditor-textarea").html(tmpContent);
    				editor.$txt.html(tmpContent);
		        	$('#tmpName').val(tmpName);
		        },200);
			};

            showDiaLog({

                content: _html,
                title: "选择模板",
                success: function () {
					
					return;
					
                    var tmpId = $("#tmpSel").find("option:selected").val();

                    $.post("/goods/choseTmp.htm", {tmpId: tmpId}, function (data) {


                        _target.text(data);
                        _targetTxt.html(data);

                    }, "html").error(
                            function () {

                                alert("error");
                            }
                    )


                },
                cancel: function () {

                }

            });

        }, "json");
    }

    var uploadImg = function(obj){
       var _this = $(obj);
       var imglist = $("#imglist");

        var _index =  parseInt(_this.attr("id").substring(_this.attr("id").length -1,_this.attr("id").length)) -1;

       $.ajaxFileUpload({
            url:"/goods/uploadGoodImg.htm",//需要链接到服务器地址
            secureuri:false,
            fileElementId:_this.attr("id"),//文件选择框的id属性
            dataType: 'json',   //json
            success: function (data) {
            	if(_index == -1){
            		$("#listImg").show();
            		$("#listImg").attr("src","/imgView/readGoodImage.htm?imagePath="+data.imagePath);
            		$("#mainImg").val(data.imagePath);
            	}else{
                	var _img = $(imglist).find("img:eq("+_index+")");
                	_img.attr("src","/imgView/readGoodImage.htm?imagePath="+data.imagePath);
                }
            },error:function(XMLHttpRequest, textStatus, errorThrown){
                alert('上传失败！');
            }
        });


    }


    var addSpec = function () {


        var _tab = $("#specTab");


        var rowone = _tab.find("tbody").find("tr").eq(1);


        var specCode;
        if (!rowone.html()) {
            specCode = (function randomString(len) {
                len = len || 32;
                var $chars = 'ABCDEFGHJKMNPQRSTWXYZabcdefhijkmnprstwxyz2345678';
                /****默认去掉了容易混淆的字符oOLl,9gq,Vv,Uu,I1****/
                var maxPos = $chars.length;
                var pwd = '';
                for (i = 0; i < len; i++) {
                    pwd += $chars.charAt(Math.floor(Math.random() * maxPos));
                }
                return pwd;
            })(10);
        }
        else {

            specCode = rowone.find("td").eq(0).find("input").val();
        }


        var _html = '<tr><td><input type="text"  placeholder="" class="form-control input-sm w50" disabled="disabled" value="' + specCode + '" ></input></td>' +
                '<td><input type="text"  placeholder="" class="form-control input-sm w50" ></input></td>' +
                '<td><input type="number"  placeholder="" class="form-control input-sm w50" ></input></td>' +
                '<td><input type="number"  placeholder="" class="form-control input-sm w50" ></input></td>' +
                '<td><input type="number"  placeholder="" class="form-control input-sm w50" ></input></td>' +
                '<td><input type="number"  placeholder="" class="form-control input-sm w50" ></input></td>' +
                '<td><input type="number"  placeholder="" class="form-control input-sm w50" ></input></td>' +
                '<td><input type="number"  placeholder="" class="form-control input-sm w50" ></input></td>' +
                '<td style="display:none;"><input type="number" value="0"  placeholder="" class="form-control input-sm w50" ></input></td>' +
                '<td><input type="number"  placeholder="" class="form-control input-sm w50" ></input></td>' +
                '<td><input type="text"  placeholder="" class="form-control input-sm w50" ></input></td>' +
                '<td><input type="number"  placeholder="" class="form-control input-sm w50" ></input></td>' +
                '<td><button type="button" class="btn btn-primary btn-sm delspec">删除</button></td></tr>';


        $(_html).insertAfter(_tab.find("tbody").find("tr").eq(0));

        $(".delspec").unbind("click");
        $(".delspec").on("click", function () {


            var _this = $(this);
            _this.parent().parent().remove();
        });

    }


    var addGood = function () {
		$("input[name=specStr]").val("");
        var flag = true;
        var _tab = $("#specTab");

        var ls = _tab.find("tbody").find("tr:gt(0)");

        if( ls.length <1 )
        {

            showAlert("至少添加一个产品价格", function () {
                $("#pricebtn").trigger("click");
            });
            return false;
        }

         var priceflag = true;

         ls.each(function (i, o) {

            var _val;


            var specCode = $(o).find("td").eq(0).find("input").val();

            var specName = $(o).find("td").eq(1).find("input").val();
            var basePrice = $(o).find("td").eq(2).find("input").val();
            var p0 = $(o).find("td").eq(4).find("input").val();
            var p1 = $(o).find("td").eq(5).find("input").val();
            var p2 = $(o).find("td").eq(6).find("input").val();
            var cm = $(o).find("td").eq(7).find("input").val();
            var p3 = $(o).find("td").eq(3).find("input").val();
            var p4 = $(o).find("td").eq(8).find("input").val();
            var ppre = $(o).find("td").eq(9).find("input").val();
            var unit = $(o).find("td").eq(10).find("input").val();
            var sku = $(o).find("td").eq(11).find("input").val();



            if(  priceflag  &&  ( !specName || specName == "" )  )
            {

                showAlert("请输入价格信息第"+(i+1)+"行的规格名称", function () {
                    $("#pricebtn").trigger("click");
                });
                priceflag = false;
            }


            if( priceflag  &&  (!basePrice || basePrice == "")   )
            {

                showAlert("请输入价格信息第"+(i+1)+"行的基础价格", function () {
                    $("#pricebtn").trigger("click");
                });

                priceflag = false;
            }


            if( priceflag  && ( !p0 || p0 == ""  ) )
            {

                showAlert("请输入价格信息第"+(i+1)+"行的VIP0价格", function () {
                    $("#pricebtn").trigger("click");
                });
                priceflag = false;
            }


            if( priceflag  && ( !p1 || p1 == "" )  )
            {

                showAlert("请输入价格信息第"+(i+1)+"行的VIP1价格", function () {
                    $("#pricebtn").trigger("click");
                });
                priceflag = false;
            }

            if( priceflag  && ( !p2 || p2 == "" )  )
            {

                showAlert("请输入价格信息第"+(i+1)+"行的VIP2价格", function () {
                    $("#pricebtn").trigger("click");
                });
                priceflag = false;
            }
            if( priceflag  &&  (!p3 || p3 == "") )
            {

                showAlert("请输入价格信息第"+(i+1)+"行的VIP3价格", function () {
                    $("#pricebtn").trigger("click");
                });
                priceflag = false;
            }

            if(priceflag  && ( !p4 || p4 == "" )  )
            {

                showAlert("请输入价格信息第"+(i+1)+"行的VIP4价格", function () {
                    $("#pricebtn").trigger("click");
                });
                priceflag = false;
            }

            if( priceflag  && (!ppre || ppre == "" )  )
            {

                showAlert("请输入价格信息第"+(i+1)+"行的定金", function () {
                    $("#pricebtn").trigger("click");
                });
                priceflag = false;
            }else{
            	if($("#isBook").val() == "2" && parseInt(ppre) <= 0){
            		showAlert("预定定金商品定金不能为0", function () {
	                    $("#pricebtn").trigger("click");
	                });
	                priceflag = false;
            	}
            }



            _val = "[" + specCode + "|" + specName + "|" + basePrice + "|" + p0 + "|" + p1 + "|" + p2 + "|" + cm + "|" + p3 + "|" + p4 + "|" + ppre + "|" + unit + "|" + sku + "]"

            $("input[name=specStr]").val($("input[name=specStr]").val() + _val);
        });

        if( !priceflag  )
            return false;


        if (!$("input[name='map[goodsName]']").val() || $("input[name='map[goodsName]']").val() == "") {
            showAlert("请输入产品名称", function () {
                $("#infobtn").trigger("click");
            })
            return false;
        }






        if (!$("textarea[name='map[goodsIntroduce]']").val() || $("textarea[name='map[goodsIntroduce]']").val() == "") {
            showAlert("请输入产品简介", function () {
                $("#infobtn").trigger("click");
            })
            return false;
        }




        if (!$("textarea[name='map[contentIntroduce]']").val() || $("textarea[name='map[contentIntroduce]']").val() == "") {
            showAlert("请输入内容介绍", function () {
                $("#infobtn").trigger("click");
            })
            return false;
        }


        if (!$("textarea[name='map[memberInterest]']").val() || $("textarea[name='map[memberInterest]']").val() == "") {
            showAlert("请输入会员权益", function () {
                $("#infobtn").trigger("click");
            })
            return false;
        }

        if (!$("textarea[name='map[buyKnow]']").val() || $("textarea[name='map[buyKnow]']").val() == "") {
            showAlert("请输入产品购买须知", function () {
                $("#infobtn").trigger("click");
            })
            return false;
        }


        $("input[name='map[goodsImages]']").val(""); //清空图片列表
        var imgs =  $("#imglist").find("img");

            imgs.each(function( i , o ){
                    var _o  = $(o);
                    var img  = _o.attr("src");
                    if ( null != img && "" != img) {


                        img =  img.substring(img.indexOf("imagePath=")+"imagePath=".length,img.length);


                        img = "[" +img +"]";



                        $("#goodsImageList").val($("#goodsImageList").val() + img);
                    }

            });



        if(!$("input[name='map[goodsImage]']").val() ||  $("input[name='map[goodsImage]']").val() == "")
        {
            showAlert("请上传产品主图", function () {
                $("#infobtn").trigger("click");
            })
            return false;
        }
        
        if(!$("input[name='map[goodsImages]']").val() ||  $("input[name='map[goodsImages]']").val() == "")
        {
            showAlert("请上传产品图片", function () {
                $("#infobtn").trigger("click");
            })
            return false;
        }
            
         if($("input[name='map[showPriority]']").val() < 1){
         	showAlert("优先级不能小于1", function () {
                $("#infobtn").trigger("click");
            })
         	return false;
         }
            
         if($("input[name='map[beginTime]']").val() == ""){
         	showAlert("请输入销售开始时间", function () {
                $("#setbtn").trigger("click");
            })
         	return false;
         }   
         if($("input[name='map[endTime]']").val() == ""){
         	showAlert("请输入销售结束时间", function () {
                $("#setbtn").trigger("click");
            })
         	return false;
         }  
         if($("input[name='map[periodOfValidity]']").val() == ""){
         	showAlert("请输入有效期", function () {
                $("#setbtn").trigger("click");
            })
         	return false;
         }  
          if($("input[name='map[xfqYxqValues]']").val() == ""){
         	showAlert("请输入消费券有效期（小时）", function () {
                $("#setbtn").trigger("click");
            })
         	return false;
         }  
         if($("#province").val() == "" || !$("#province").val()){
         	showAlert("地区选择有误", function () {
                $("#infobtn").trigger("click");
            })
         	return false;
         }  
         $("input[name='map[areaid1]']").val($("#province").val());
         if($("#city").val() == "" || !$("#city").val()){
         	showAlert("地区选择有误", function () {
                $("#infobtn").trigger("click");
            })
         	return false;
         }  
         $("input[name='map[areaid2]']").val($("#city").val());
         if($("#area").val() == "" || !$("#area").val()){
         	showAlert("地区选择有误", function () {
                $("#infobtn").trigger("click");
            })
         	return false;
         }     
         $("input[name='map[areaid3]']").val($("#area").val());  
         if($("#store").val() == "" || !$("#store").val()){
         	showAlert("店铺选择有误", function () {
                $("#infobtn").trigger("click");
            })
         	return false;
         } 
         $("input[name='map[storeId]']").val($("#store").val());
         if($("#clzone").val() == "" || !$("#clzone").val()){
         	showAlert("产品分类有误", function () {
                $("#infobtn").trigger("click");
            })
         	return false;
         } 
         $("input[name='map[gcId1]']").val($("#clzone").val());
         if($("#clztwo").val() == "" || !$("#clztwo").val()){
         	showAlert("产品分类有误", function () {
                $("#infobtn").trigger("click");
            })
         	return false;
         } 
         $("input[name='map[gcId2]']").val($("#clztwo").val()); 
         
        $.ajax({
			url: '/goods/addGood.htm' ,
			type: 'POST',
			data: $("#goodForm").serialize() ,
			dataType: 'json',
			success: function(json){
				if(json.state == 1){
					bootbox.alert("更新成功！");
					setTimeout(function(){
						window.location.href = "/goods/goodslist.htm";
					},800);
				}else{
					bootbox.alert("更新失败！");
				}
			} ,
			error: function(){
				bootbox.alert("更新失败！");
			}
		});
    }

</script>

</body>
</html>