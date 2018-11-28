<#include "../head.ftl"/>
<section>
    <div class="mainwrapper">
    <#include "../leftnav.ftl"/>
        <script type="text/javascript" src="/js/cityselect/jquery.cityselect.js"></script>
        <script src="/js/bootbox/bootbox.min.js"></script>


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
                        <h4>处理结算单</h4>
                    </div>
                </div>
                <!-- media -->
            </div>
            <!-- pageheader -->

            <div class="contentpanel">
                <div class="alert alert-info">
                    <button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
                    <strong>说明：</strong>商家对账无误后，手动打款结算，根据打款结果修改操作结果
                    结算金额=基础价格-（基础价格*服务费比例*评价系数）+未支付余款

                </div>
                <div class="panel panel-default">
                    <div class="panel-heading">

                        <div class="row">
                            <div class="col-md-12">
                                <div class="row">
                                    <div class="col-md-12">
                                        <h4 class="panel-title">处理结算单</h4>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <table class="table">
                                            <tr>
                                                <td>流水号</td>
                                                <td>${result.dclear.seriNo !""}</td>
                                                <td>结算方式</td>
                                                <td>${result.dclear.clearModel !""}</td>
                                            </tr>
                                            <tr>
                                                <td>结算商家</td>
                                                <td>${result.dclear.storeName !""}</td>
                                                <td>创建时间</td>
                                                <td>${result.dclear.createTime !""}</td>
                                            </tr>
                                            <tr>
                                                <td>结算金额</td>
                                                <td>${result.dclear.clearFeeDollar !""}</td>
                                                <td>销售金额</td>
                                                <td>${result.dclear.saleFeeDollar !""}</td>
                                            </tr>
                                            <tr>
                                                <td>结算状态</td>
                                                <td>
													<#if result.dclear.clearState == -1>
                                                        商家未对账
                                                    </#if>
                                                    <#if result.dclear.clearState == 1>
                                                        商家已对账（有误）
                                                    </#if>

                                                      <#if result.dclear.clearState == 2>
                                                         商家已对账（正常）
                                                    </#if>
                                                      <#if result.dclear.clearState == 3>
                                                          结算失败
                                                    </#if>
                                                      <#if result.dclear.clearState == 4>
                                                          结算成功
                                                    </#if>

                                                </td>
                                                <td>结算周期</td>
                                                <td>${result.begin !""} / ${result.end !""} </td>
                                            </tr>

                                            <tr>
                                                <td>对账人</td>
                                                <td>${result.dclear.confirmUser !""}</td>
                                                <td>对账时间</td>
                                                <td>${result.dclear.confirmTime !""} </td>
                                            </tr>
                                            <tr>
                                                <td>结算人</td>
                                                <td>${clearName}</td>
                                                <td>结算时间</td>
                                                <td>${result.dclear.clearTime !""}</td>
                                            </tr>
                                        </table>

                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-12">
                                <div class="row">
                                    <div class="col-md-12">
                                        操作结果
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">


                                        <form>
                                        <table class="table">
                                            <tr>
                                                <td style="width:100px">操作结果</td>
                                                <td  align="left"> <input type="radio" name="opresult" checked="checked" value="4" />结算成功 <input type="radio" name="opresult" value="3"/> 结算失败 </td>

                                            </tr>
                                            <tr>
                                                <td>备注</td>
                                                <td align="left"><textarea rows="5" name="map[clearRemark]" style="width:100%" >${result.dclear.clearRemark !''}</textarea> </td>

                                            </tr>
                                            <tr>
                                                <td>实际金额</td>
                                                <td align="left"><input type="text" name="map[realClearFee]" value="${result.dclear.realClearFeeDollar !''}"> </td>
                                            </tr>
                                            <tr>

                                                <td colspan="2"><input type="button" value="保存" onclick="saveDealClear();" id="save"/>   </td>
                                            </tr>

                                        </table>
                                        <input   type="hidden" name="map[id]" value="${result.dclear.id !''}" />
                                        <input   type="hidden" name="map[clearState]"  />
                                        </form>
                                        
                                    </div>
                                </div>
                            </div>
                        </div>



                    </div>
                    <div class="panel-body">
                        <div class="row">
                            <table id="table"></table>
                        </div>
                        <!-- row -->
                    </div>
                    <div class="row center">
                    	<button class="btn btn-primary" id="closeBtn">返回</button>
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
    var queryParams = function (params) {   //提交参数
        var map = {
            pageSize: params.limit,      //每页大小
            pageNo: params.offset / 10 + 1,
            clearId : '${result.dclear.id !""}'
        };

        params.map = JSON.stringify(map);
        return params;
    };

    var saveDealClear  = function()
    {


        var  opresult = $("input[name='opresult']:checked").val();

        if (opresult == "4" && $("input[name='map[realClearFee]']").val() == "")
        {
            showAlert("请输入实际打款金额");
            return false;
        }


        if ( opresult == "3")
        {

            if($("input[name='map[clearRemark]']").val() == "") {
                showAlert("请备注结算失败原因");
                return false;
            }
        }


        var genParams = function( storeId ){

            var params = {};
            var map = {
                realClearFee :$("input[name='map[realClearFee]']").val() * 100,
                clearRemark :$("textarea[name='map[clearRemark]']").val(),
                id : '${result.dclear.id !""}',
                clearState : opresult
            };
            params.map = JSON.stringify(map);
            return params;
        }

        var params = genParams ();


        $.post("/kiting/saveDealClear.ajax" ,params , function(data){

                var flag = data.flag ;

                if( flag )
                {
                    showAlert("操作成功");
                    window.location.assign("/kiting/storeClearTicketMana.htm");
                }
                else
                {
                    showAlert("操作失败");
                }


        },"json");


    }


    var renderTable = function (flag) {
        QUERY_FLAG = flag;
        $("#table").bootstrapTable('destroy', null);
        $("#table").bootstrapTable({
            method: 'get',
            url: '/kiting/dealClearTicketOrderList.ajax',
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
            },
                {
                    field: 'goodsPrice',
                    title: '基础价格',
                    align: 'left',
                    valign: 'middle',
                    formatter: function (value, row, index) {
                        return value / 100;
                    }
                },
                {
                    field: 'serviceRatio',
                    title: '服务费比例',
                    align: 'left',
                    valign: 'middle',
                    formatter: function (value, row, index) {
                        return value +"%";
                    }
                },
                {
                    field: 'evaluateRatio',
                    title: '评价系数',
                    align: 'left',
                    valign: 'middle'
                }
                ,
                {
                    field: 'serviceFee',
                    title: '服务费',
                    align: 'left',
                    valign: 'middle',
                    formatter: function (value, row, index) {
                        return value / 100;
                    }
                }
                ,
                {
                    field: 'finishTime',
                    title: '订单完成时间',
                    align: 'left',
                    valign: 'middle'
                }
                ,
                {
                    field: 'clearFee',
                    title: '结算金额',
                    align: 'left',
                    valign: 'middle',
                    formatter: function (value, row, index) {
                        return parseFloat(value / 100);
                    }
                }
                ,
                {
                    field: 'clearState',
                    title: '订单结算状态',
                    align: 'left',
                    valign: 'middle',
                    formatter: function (value, row, index) {
                        if ( value ==  1 ){
                            return "未结算";
                        }
                        else if(value == 2){
                            return "正在结算";
                        }
                        else{
                            return "已结算";
                        }
                    }
                }
                ,
                {
                    field: 'settlementTime',
                    title: '结算时间',
                    align: 'left',
                    valign: 'middle',
                }]

        }
    );
    };

    $(document).ready(function () {
        renderTable(false);
        $("input[name='opresult'][value='${result.dclear.clearState!''}']").attr("checked", true);
        
        if("${result.dclear.clearState!''}" == -1 || "${result.dclear.clearState!''}" == 4){
        	$("input[name='opresult']").attr("disabled", true);
        	$("input[name='map[realClearFee]']").attr("disabled", true);
        	$("textarea[name='map[clearRemark]']").attr("disabled", true);
        	$("#save").remove();
        	if("${result.dclear.clearState!''}" == 4){
        		$("input[name='map[realClearFee]']").val("${result.dclear.realClearFeeDollar !""}");
        	}
        }else{
        	$("input[name='map[realClearFee]']").val("${result.dclear.clearFeeDollar !""}");
        }
		$("#closeBtn").click(function(){
	    	window.location.assign("/kiting/storeClearTicketMana.htm");
	    });
    });



</script>
</body>
</html>