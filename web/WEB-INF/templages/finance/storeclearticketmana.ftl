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
                        <h4>商家结算单管理</h4>
                    </div>
                </div>
                <!-- media -->
            </div>
            <!-- pageheader -->

            <div class="contentpanel">
                <div class="alert alert-info">
                    <button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
                    <strong>说明：</strong>商家结算单列表，商家审核通过后按实际金额打款并操作修改结算成功，结算金额=基础价格-（基础价格*服务费比例*评价系数）
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
                                    <input type="text" id="storeFieldValue" placeholder=""
                                           class="form-control input-sm w160 fl ml10">
                                </div>


                                <div class="form-line">
                                    <label class="w100 fl control-label lh20">账单月份：</label>
                                    <input type="text"  id="cycletime"  placeholder=""  class="form-control input-sm w160 fl ml10">
                                <#--<label class="w100 fl control-label lh20">账单月份：</label><input type="text" id="orderEndTime" placeholder="" data-date-format="yyyy-mm" class="form-control datepicker input-sm w160 fl ml10">-->
                                </div>

                            <#--<div class="form-line">-->

                            <#--<select id="timefieldName" class="select2 w160 fl ml10">-->
                            <#--<option value="orderfinishTime">账单月</option>-->
                            <#--<option value="clearTime">结算时间</option>-->
                            <#--</select>-->
                            <#--<label class="w100 fl control-label lh20">开始：</label><input type="text" id="begin" placeholder="" class="form-control input-sm datepicker w160 fl ml10">-->
                            <#--<label class="w100 fl control-label lh20">结束：</label><input type="text" id="end" placeholder="" class="form-control input-sm datepicker w160 fl ml10">-->
                            <#--</div>-->
							</div>
							<div class="form-horizontal cb pt5">
                                <div class="form-line">

                                    <label class="w160 fl control-label lh20">结算状态：</label>
                                    <select id="orderClearState" class="select2 w160 fl">
                                        <option value="">请选择</option>
                                        <option value="-1">商家未对账</option>
                                        <option value="1">商家已对账（有误）</option>
                                        <option value="2">商家已对账（正常）</option>
                                        <option value="3">结算失败</option>
                                        <option value="4">结算成功</option>
                                    </select>

                                </div>


                                <div class="form-line">
                                    <label class="w100 fl control-label lh20">排序:</label>
                                    <select id="sort" class="select2 w160 fl ml10">
                                        <option value="creatime">创建时间最新</option>
                                        <option value="cleartime">结算时间最新</option>
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
                                <button type="reset" class="btn btn-primary btn-sm">清空</button>

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
        renderTable(false);
        $("#queryBtn").click(function () {
            renderTable(true);
        });

        $('#cycletime').datetimepicker(
                {
                    format: "yyyy-mm",
                    weekStart: 1,
                    startView: "year",
                    minView: "year",
                    maxView: "year",
                    language: "zh-CN",
                }
        );
    });

    var queryParams = function (params) {   //提交参数
        var map = {
            pageSize: params.limit,      //每页大小
            pageNo: params.offset / 10 + 1, //页码
        };
        
        if(QUERY_FLAG){
          	map.storeFieldName = $("#storeFieldName").find("option:selected").val(),
            map.storeFieldValue = $("#storeFieldValue").val(),
            map.cycletime = $("#cycletime").val(),
            map.sort = $("#sort").find("option:selected").val()
			map.orderClearState = $("#orderClearState").find("option:selected").val();
        }else{
        	if("${indexState}" != "false"){
				map.orderClearState = "${indexState}";
			}
        }
		
        params.map = JSON.stringify(map);
        return params;
    };


    var genParams = function (storeId) {

        var params = {};
        var map = {
            storeId: storeId
        }
        params.map = JSON.stringify(map);
        return params;
    }


    var renderTable = function (flag) {
        QUERY_FLAG = flag;
        $("#table").bootstrapTable('destroy', null);
        $("#table").bootstrapTable({
            method: 'get',
            url: '/kiting/storeClearTicketMana.ajax',
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
                field: 'seriNo',
                title: '结算流水号',
                align: 'left',
                valign: 'bottom'
            }, {
                field: 'storeName',
                title: '结算商家',
                align: 'left',
                valign: 'middle'
            },
                {
                    field: 'clearFee',
                    title: '结算金额',
                    align: 'left',
                    valign: 'middle',
                    formatter: function (value, row, index) {
                        return value / 100;
                    }
                }, {
                    field: 'clearModel',
                    title: '结算方式',
                    align: 'left',
                    valign: 'middle'
                },
                {
                    field: 'createTime',
                    title: '创建时间',
                    align: 'left',
                    valign: 'middle'
                },
                {
                    field: 'clearState',
                    title: '结算状态',
                    align: 'left',
                    valign: 'middle',
                    formatter: function (value, row, index) {
                        switch (value)
                        {
                            case -1:
                                return "商家未对账";
                            break;
                            case 1:
                                return "商家已经对账(有误)";
                                break;
                            case 2:
                                return "商家已经对账（正常）";
                            break;
                            case 3:
                                return "结算失败";
                            break;
                            case 4:
                                return "结算成功";
                                break;
                            default :
                                return value;
                            break;
                        }
                    }
                },
                {
                    field: 'clearTime',
                    title: '结算时间',
                    align: 'left',
                    valign: 'middle'
                },
                {
                    title: '操作',
                    align: 'left',
                    valign: 'middle',
                    formatter: function (value, row, index) {
                        if ( row.clearState  == -1 || row.clearState == 4 ) {
                            return "<a href='/kiting/dealClearTicket/"+row.id+".htm'>查看</a>";
                        }else{
                            return "<a href='/kiting/dealClearTicket/"+row.id+".htm'>处理</a>";
                        }
                    }
                }
               ]
        });
    };

</script>
</body>
</html>