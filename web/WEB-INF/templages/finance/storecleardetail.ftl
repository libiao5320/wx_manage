<#include "../head.ftl"/>
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
                        <h4>商家结算明细</h4>
                    </div>
                </div>
                <!-- media -->
            </div>
            <!-- pageheader -->

            <div class="contentpanel">
                <div class="alert alert-info">
                    <button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
                    <strong>说明：</strong>查看管理平台商家结算
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading">

                        <form>
                            <div class="form-horizontal cb pt5">
                                <div class="form-line">
                                    <label class="w10 fl control-label lh20"></label>
                                    <select id="idFileName" class="select2 w160 fl">
                                        <option value="goodName">产品名称</option>
                                        <option value="orderId">订单ID</option>
                                    </select>
                                    <input type="text" id="idFileValue" placeholder="" class="form-control input-sm w160 fl ml10">

                                    <label class="w100 fl control-label lh20">订单结算状态：</label>
                                    <select id="orderClearState" class="select2 w160 fl ml10">
                                        <option value="0">请选择</option>
                                        <option value="1">未结算</option>
                                        <option value="2">正在结算</option>
                                        <option value="3">已结算</option>
                                    </select>
                                    
									<label class="w100 fl control-label lh20">产品排序:</label>
                                    <select id="sort" class="select2 w160 fl ml10">
                                        <option value="sortOrderFinishTime">订单完成时间最新</option>
                                        <option value="sortOrderId">订单ID最大</option>
                                    </select>
                                    <div class="cb"></div>
                                </div>



                                <div class="form-line">
                                    
                                    <select id="timefieldName" class="select2 w160 fl">
                                        <option value="orderfinishTime">订单完成时间</option>
                                        <option value="clearTime">订单结算时间</option>
                                    </select>
                                    <label class="w50 fl control-label lh20 ml15 ">开始：</label><input type="text" id="begin" placeholder="" class="form-control input-sm datepicker w160 fl ml10">
                                    <label class="w50 fl control-label lh20 ml15">结束：</label><input type="text" id="end" placeholder="" class="form-control input-sm datepicker w160 fl ml10">
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
                                <button type="reset"  class="btn btn-primary btn-sm">清空</button>

                                <#--<button type="button" class="btn btn-dark btn-sm" >生成结算单</button>-->
                            </div>
                        </form>
                    </div>
                    <div class="panel-body">
                        <h4 id="title"></h4>
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
        renderTable(false);
        $("#queryBtn").click(function () {
            renderTable(true);
        });
    });

    var queryParams = function (params) {   //提交参数
        var map = {
            pageSize : params.limit,      //每页大小
            pageNo : params.offset/10 + 1, //页码
            storeId: ${storeId} ,
            cycleTime: "${cycleTime}",
            idFileName: $("#idFileName").find("option:selected").val(),
            idFileValue: $("#idFileValue").val(),
            timefieldName : $("#timefieldName").find("option:selected").val(),
            begin : $("#begin").val(),
            end : $("#end").val(),
            orderClearState :$("#orderClearState").find("option:selected").val() ,
            sort :$("#sort").find("option:selected").val()
        };




        params.map = JSON.stringify(map);
        return params;
    };

    var renderTable = function (flag) {
        QUERY_FLAG = flag;
        $("#table").bootstrapTable('destroy', null);
        $("#table").bootstrapTable({
            method: 'get',
            url: '/kiting/storeClearDetail.ajax',
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
                field: 'orderId',
                title: '订单ID',
                align: 'left',
                valign: 'bottom'
            }, {
                field: 'goodsName',
                title: '产品',
                align: 'left',
                valign: 'middle'
            },{
                    field: 'goodsPrice',
                    title: '基础价格',
                    align: 'left',
                    valign: 'middle',
                    formatter: function (value, row, index) {
                       return value / 100;
                    }
             },{
                    field: 'serviceRatio',
                    title: '服务费比例',
                    align: 'left',
                    valign: 'middle',
                    formatter: function (value, row, index) {
                        return value +"%";
                    }
               },{
                    field: 'evaluateRatio',
                    title: '评价系数',
                    align: 'left',
                    valign: 'middle'
                },{
                    field: 'serviceFee',
                    title: '服务费',
                    align: 'left',
                    valign: 'middle',
                    formatter: function (value, row, index) {
                        return value / 100;
                    }
                },{
                    field: 'finishTime',
                    title: '订单完成时间',
                    align: 'left',
                    valign: 'middle'
                },{
                    field: 'clearFee',
                    title: '结算金额',
                    align: 'left',
                    valign: 'middle',
                    formatter: function (value, row, index) {
                        return value / 100;
                    }
                },{
                    field: 'clearState',
                    title: '订单结算状态',
                    align: 'left',
                    valign: 'middle',
                    formatter: function (value, row, index) {
                    	if(value == 1){
                    		return "未结算";
                    	}else if(value == 2){
                    		return "正在结算";
                    	}else{
                    		return "已结算";
                    	}
                   }
                },{
                    field: 'settlementTime',
                    title: '结算时间',
                    align: 'left',
                    valign: 'middle'
                }],
                onLoadSuccess: function (data) {
		            $("#title").html("[${storeName}]" + " " + data.title);
	            }
            });
    }


</script>
</body>
</html>