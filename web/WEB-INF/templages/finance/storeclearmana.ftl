
<#include "../head.ftl"/>
<style>.clear{display:none;}</style>
<section>
    <div class="mainwrapper">
    <#include "../leftnav.ftl"/>
        <script type="text/javascript" src="/js/cityselect/jquery.cityselect.js"></script>
        <script src="../js/bootbox/bootbox.min.js"></script>


        <div class="mainpanel">
            <div class="pageheader">
                <div class="media">
                    <div class="pageicon pull-left">
                        <i class="fa fa-bars"></i>
                    </div>
                    <div class="media-body">
                        <ul class="breadcrumb">
                            <li><a href=""><i class="fa fa-home"></i></a></li>
                            <li>财务管理</li>
                        </ul>
                        <h4>商家结算管理</h4>
                    </div>
                </div>
                <!-- media -->
            </div>
            <!-- pageheader -->

            <div class="contentpanel">
                <div class="alert alert-info">
                    <button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
                    <strong>说明：</strong>商家账户列表，对单个或所有商家按账单月进行结算操作。账单月份为上月账单日第二天至本月账单日，如账单日11号，则3月账期为2.12-3.11
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading">


                        <form>
                            <div class="form-horizontal cb pt5">
                                <div class="form-line">
                                    <label class="w10 fl control-label lh20"></label>
                                    <select id="storeFieldName" class="select2 w160 fl">
                                        <option value="storeName">商家名称</option>
                                        <option value="storeId">商家ID</option>


                                    </select>
                                    <input type="text" id="storeFieldValue" placeholder="" class="form-control input-sm w160 fl ml10">
                                </div>

                                <div class="form-line">

                                    <label class="w100 fl control-label lh20">账单月份：</label><input type="text"
                                                                                                  id="cycletime"
                                                                                                  placeholder=""
                                                                                                  class="form-control    input-sm w160 fl ml10">
                                </div>


								<div style="clear:both;width:100%;"></div>
                                <div class="form-line mt10">
                                    <label class="w160 fl control-label lh20">产品排序:</label>
                                    <select id="sort" class="select2 w160 fl ml10">
                                        <option value="sortClearFee">未结算资金最多</option>
                                        <option value="sortStoreId">商家ID最大</option>
                                    </select>
                                    <div class="cb"></div>
                                </div>


                                <#--<div class="form-line mt10" id="city_5">-->
                                    <#--<label class="w100 fl control-label lh20">产品分类:</label>-->
                                    <#--<select name="prov" class="select2 w160 fl ml10 "></select>-->
                                    <#--<select name="city" class="select2 w100 fl ml10 " id="gcId2" disabled="disabled"></select>-->
                                    <#--<select name="dist" class="select2 w160 fl ml10 " style="display:none"disabled="disabled" ></select>-->

                                    <#--<div class="cb"></div>-->
                                <#--</div>-->


                            </div>



                            <div class="pull-right mt-30">
                                <button type="button" id="queryBtn" class="btn btn-primary btn-sm">查询</button>
                                <button type="button" id="createClear" class="btn btn-primary btn-sm" canClear="false">生成结算单</button>
                                <button type="reset"  class="btn btn-primary btn-sm">清空</button>

                                <#--<button type="button" class="btn btn-dark btn-sm" >生成结算单</button>-->
                            </div>
                        </form>
                    </div>
                    <div class="panel-body">
                        <div class="row">
                            <table id="table"></table>
                        </div>
                        <!-- row -->
                    </div>
                    <!-- panel-body -->
                </div>
            </div>
            <!-- contentpanel -->
        </div>
    </div>
</section>


<script>




    var QUERY_FLAG = false;    //是否使用了查询输入进行查询标志位
    $(document).ready(function () {

        $("#queryBtn").click(function () {
            renderTable(true);
        });
        $("#createClear").click(function () {
        	var cycleTime = $("#cycletime").val().trim();
        	if(cycleTime == ''){
        		bootbox.alert("请选择一个账单月份！");
        	}else{
	        	if($("#createClear").attr("canClear") == "true"){
	            	createAllClear(cycleTime);
	            }else{
	            	bootbox.alert("还没到此月份结算日期！");
	            }
            }
        });
        $('#cycletime').datetimepicker(
                {
                    format: "yyyy-mm",
                    weekStart: 1,
                    startView: "year",
                    minView: "year",
                    maxView: "year",
                    language: "zh-CN",
                    initialDate:new Date()
                }
        );

       // var dd = new Date();
        //$('#cycletime').val(dd.getFullYear() +"-" + (dd.getMonth()+1));

        renderTable(false);
    });
    
    var createAllClear = function(cycleTime){
    	var params = {};
        var map = {
            cycleTime: cycleTime
        }
        params.map = JSON.stringify(map);
    	$.ajax({
            url: '/kiting/createAllClear.ajax' ,
            data: params,
            type: 'POST',
            dataType: 'json',
            success: function(data){
            	if(data.flag){
	            	showAlert("创建结算单成功" , function(){
	                    $("#table").bootstrapTable('refresh');
	                })
                }else{
                	showAlert("创建结算单失败");
                }
            } ,
            error: function(){
            	showAlert("创建结算单失败");
            }
        });
    };

    var queryParams = function (params) {   //提交参数

        var map = {
            pageSize : params.limit,      //每页大小
            pageNo : params.offset/10 + 1, //页码
        };
		if(QUERY_FLAG){
            map.storeFieldName= $("#storeFieldName").val(),
            map.storeFieldValue= $("#storeFieldValue").val(),
            map.cycletime = $("#cycletime").val(),
            map.sort =$("#sort").find("option:selected").val()
        }
        params.map = JSON.stringify(map);
        return params;
    };


    var genClear = function( storeId , cycleTime){
        var params = {};
        var map = {
            storeId : storeId,
            cycleTime: cycleTime
        }
        params.map = JSON.stringify(map);
        
        $.post("/kiting/genClear.ajax" ,params  ,function(data){
            var flag = data.flag ;
            if ( flag )
                showAlert("创建结算单成功" , function(){
                    $("#table").bootstrapTable('refresh');
                })
            else
                showAlert("创建结算单失败");
        },"json");
    }

    var renderTable = function (flag) {


        var cycleTime  = $("#cycletime").val();

        QUERY_FLAG = flag;
        $("#table").bootstrapTable('destroy', null);
        $("#table").bootstrapTable({
            method: 'get',
            url: '/kiting/storeClearList.ajax',
            queryParams: queryParams,   //查询参数
            striped: true,
            pagination: true,
            pageList: [10],
            pageSize: 10,
            search: false,
            showColumns: false,
            clickToSelect: false,
            sidePagination: "server",//设置为服务器端分页
            columns: [{
                field: 'storeId',
                title: '商家ID',
                align: 'left',
                valign: 'bottom'
            }, {
                field: 'storeName',
                title: '商家名称',
                align: 'left',
                valign: 'middle'
            },
                 {
                    field: 'unClear',
                    title: '未结算资金（元）',
                    align: 'left',
                    valign: 'middle',
                     formatter: function (value, row, index) {
                         return value / 100;
                     }
                },{
                field: 'clearIng',
                title: '正在结算资金（元）',
                align: 'left',
                valign: 'middle',
                    formatter: function (value, row, index) {
                        return value / 100;
                    }
            }, {
                    field: 'cleared',
                    title: '已结算资金（元）',
                    align: 'left',
                    valign: 'middle',
                    formatter: function (value, row, index) {
                        return value / 100;
                    }
                },
                {
                    field: '',
                    title: '账单月份',
                    align: 'left',
                    valign: 'middle',
                    formatter: function (value, row, index) {
                        return $("#cycletime").val() =='' ? "全部账单" :  $("#cycletime").val();
                    }
                },{
                    field: '',
                    title: '操作',
                    align: 'left',
                    valign: 'top',
                    formatter: function (value, row, index) {
                        return "<a class='detail' storeId='" + row.storeId + "' storeName='" + row.storeName + "'>查看明细</a>&nbsp;&nbsp;<a class='clear' unClear='" + row.unClear + "' storeId='" + row.storeId + "'>结算</a>";

                    }

                }],
            onLoadSuccess: function (data) {
            if(data.canClear == "true" && $("#cycletime").val() != ''){
            	$("#createClear").attr("canClear", "true");
	            $(".clear").each(function(index,dom){
	            	var unclear = $(dom).attr("unClear");
	            	if(unclear > 0){
	            		$(dom).show();
	            	}else{
	            		$(dom).hide();
	            	}
	            });
            }
                $(".detail").click(function () {
                    window.location.href = "/kiting/storeClearDetail/" + $(this).attr("storeId") + "/" + ($("#cycletime").val()=='' ? 'all' : $("#cycletime").val()) + "/" + $(this).attr("storeName") + ".htm";
                });
                $(".clear").click(function () {
                    var storeId = $(this).attr("storeId");
	               	 bootbox.confirm("您确定要结算吗?", function(result) {
	                    if(result){
		                    genClear(storeId,cycleTime);
	                    }
	                });
                });
            }
        });
    };

</script>
</body>
</html>