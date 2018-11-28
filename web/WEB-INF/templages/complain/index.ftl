<#include "../head.ftl"/>
<script src="../js/bootbox/bootbox.min.js"></script>
<script src="../js/bootstrap-table/bootstrap-table-export.js"></script>
<script src="../js/bootstrap-table/tableExport.js"></script>
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
                                    <li>订单管理</li>
                                </ul>
                                <h4>投诉管理</h4>
                            </div>
                        </div><!-- media -->
                    </div><!-- pageheader -->
                    
                    <div class="contentpanel">
                        <div class="alert alert-info">
                            <button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
                            <strong>说明：</strong>投诉列表，投诉线下协商处理，线上修改投诉状态
                        </div>
                         <div class="panel panel-default">
                           <div class="panel-heading">
	                        <form id="form-data">
                                <div class="form-horizontal cb pt5">
                                    <div class="form-line">
                                        <select class="select2 w100 fl" id="typeName">
                                          <option value="goodsName">产品名称</option>
                                          <option value="orderSn">订单ID</option>
                                          <option value="memberName">顾客姓名</option>
                                          <option value="storeName">商家名称</option>
                                        </select>
                                        <input type="text" placeholder="" class="form-control input-sm w160 fl ml10" id="typeValue">
                                        
                                          
                                        <label class="w100 fl control-label lh20">投诉状态</label>
                                        <select class="select2 w160 fl ml10" id="status">
                                          <option value="">请选择</option>
                                          <option value="handling">投诉处理中</option>
                                          <option value="handled">投诉已解决</option>
                                         </select>
                                        
                                        <div class="cb"></div>
                                    </div>
                                    
                                    <div class="form-line mt10">
                                        
                                        <select class="select2 w160 fl" id="timeName">
                                          <option value="verifyConsumptionTime">验证时间</option>
                                          <option value="createTime">申请售后时间</option>
                                        </select>
                                        <label class="w50 fl control-label lh20 ml15">开始</label>
                                        <input type="text" placeholder="" class="datepicker input-sm form-control w160 fl ml10" id="begin">
                                        <label class="w50 fl control-label lh20 ml15">结束</label>
                                        <input type="text" placeholder="" class="datepicker input-sm form-control w160 fl ml10" id="end">
                                         
                                         <div class="cb"></div>
                                    </div>
                                    
                                </div>
                                <input type="hidden" name="limit" value="10">
                                <input type="hidden" name="offset" value="1">
                                </form>
                                <div class="pull-right mt-30">
                                    <button type="button" class="btn btn-primary btn-sm" id="queryBtn">查询</button>    
                                    <button type="button" class="btn btn-primary btn-sm" id="reset">清空</button>
                                    <button type="button" class="btn btn-primary btn-sm" id="exportBtn">导出</button>
                                </div>
                            </div><!-- panel-heading -->
                            <div class="panel-body">
                                <div class="row">
                                    <table id="table"  data-show-export="true" >
								 	</table>
                                </div><!-- row -->
                            </div><!-- panel-body -->
                        </div>
                    </div><!-- contentpanel -->
                </div><!-- mainpanel -->
            </div><!-- mainwrapper -->
        </section>
        <script>
            (function(){
						var QUERY_FLAG = false;    //是否使用了查询输入进行查询标志位
						$(document).ready(function(){
							renderTable(false);
							$("#queryBtn").click(function(){
								renderTable(true);
							});
							$("#reset").click(function(){
								$("#form-data")[0].reset();
								renderTable();
							});
							$("#exportBtn").click(function(){
								$(".bootstrap-table .export .dropdown-menu > li[data-type='excel']").click();
							});							
						});
						var queryParams = function(params){   //提交参数
							var map = {
								pageSize : params.limit,      //每页大小
								pageNo : params.offset/10 + 1, //页码
							};
							
							if(QUERY_FLAG){
								if($("#typeValue").val() != ''){
									map.typeName = $("#typeName").val();
									map.typeValue = $("#typeValue").val();
								}
								if($("#bedin").val() != '' || $("#end").val() != ''){
									map.timeName = $("#timeName").val();
									map.begin = $("#begin").val();
									map.end = $("#end").val();
								}
								if($("#status").val() != ''){
									map.status = $("#status").val();
								}
							}else{
								if("${indexStatus}" != "false"){
									map.status = ${indexStatus};
								}
							}
							params.map = JSON.stringify(map);
							
							return params;
						}; 
						//根据数据库中投诉状态得到在页面应显示的字符串
						function getStatusStr(status){
							if(status == "handling"){
								return "投诉处理中";
							}else{
								return "投诉已解决";
							}
						}
		                var renderTable = function(flag){
		                	QUERY_FLAG = flag;
		                	$("#table").bootstrapTable('destroy', null);
			                $("#table").bootstrapTable({
			                    method : 'get',
			                    url : '/complain/list.ajax',   //获取表格的后台url
			                    queryParams : queryParams,   //查询参数
			                    striped : true,
			                    pagination : true,
			                    pageList : [10],
			                    pageSize : 10,
			                    search : false,
			                    showColumns : false,
			                    clickToSelect : false,
			                    sidePagination:"server",//设置为服务器端分页
			                    columns : [ {           //表头
			                        field : 'order.orderSn',
			                        title : '订单ID',
			                        align : 'left',
			                    },{
			                        field : 'order.goodsName',
			                        title : '产品名称',
			                        align : 'left',
			                    },
			                     {
			                        field : 'order.memberName',
			                        title : '顾客姓名',
			                        align : 'left',
			                    }, {
			                        field : 'order.storeName',
			                        title : '验证商户',
			                        align : 'left',
			                    },{
			                        field : 'order.strVerifyConsumptionTime',
			                        title : '验证时间',
			                        align : 'left',
			                    },{
			                        field : 'createTimeStr',
			                        title : '申请售后时间',
			                        align : 'left',
			                    },{
			                        field : 'status',
			                        title : '处理状态',
			                        align : 'left',
			                        formatter: function(value,row,index){
			                        	return getStatusStr(value);
			                        }
			                    },{
			                        field : '',
			                        title : '操作',
			                        align : 'left',
			                        formatter: function(value,row,index){
			                        	return '<a href="/complain/handleComplain/' + row.id + '.htm">查看处理</a>';
			                        }
			                    }]
			                });
		                };
					})(window);
					

        </script>
    </body>
</html>


