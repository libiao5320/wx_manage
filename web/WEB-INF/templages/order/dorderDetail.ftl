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
                                <h4>退款申请管理</h4>
                            </div>
                        </div><!-- media -->
                    </div><!-- pageheader -->
                    
                    <div class="contentpanel">
                        <div class="alert alert-info">
                            <button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
                            <strong>说明：</strong>退款列表，审核C端发起的未验证订单退款，审核通过后退款至储值账户
                        </div>
                         <div class="panel panel-default">
                           <div class="panel-heading">
	                        <form id="form-data">
                                <div class="form-horizontal cb pt5">
                                    <div class="form-line">
                                        <select class="select2 w100 fl" id="typeName">
                                          <option value="goodsName">产品名称</option>
                                          <option value="orderSn">订单编号</option>
                                          <option value="memberName">顾客姓名</option>
                                        </select>
                                        <input type="text" placeholder="" class="form-control input-sm w160 fl ml10" id="typeValue">
                                        
                                        <label class="w100 fl control-label lh20">退款状态</label>
                                        <select class="select2 w100 fl ml10" id="status" style="width:150px;">
                                          <option value="">请选择</option>
                                          <option value="unhande">退款已拒绝</option>
                                          <option value="handling">退款中</option>
                                          <option value="handled">已退款</option>
                                         </select>
                                        
                                        
                                        
                                        <label class="w100 fl control-label lh20">排序</label>
                                        <select class="select2 w160 fl ml10" id="sort">
                                          <option value="createTime">申请时间最新</option>
                                          <option value="addTime">订购时间最新</option>
                                        </select>
                                        <div class="cb"></div>
                                    </div>
                                    
                                    <div class="form-line mt10">
                                        <select class="select2 w100 fl" id="timeName">
                                          <option value="addTime">订购时间</option>
                                          <option value="createTime">申请时间</option>
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
                                    <button type="button" class="btn btn-primary btn-sm" onclick="document.getElementById('form-data').reset();tablestrop();">清空</button>
                                    <button type="button" class="btn btn-primary btn-sm" id="exportBtn">导出</button>
                                </div>
                            </div>
                            <div class="panel-body">
                                <div class="row">
                                    <table id="table"  data-show-export="true" >
								 	</table>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                </div>
            </div>
        </section>
        <script>
            (function(){
				var QUERY_FLAG = false;    //是否使用了查询输入进行查询标志位
				$(document).ready(function(){
					tablestrop(false);
					$("#queryBtn").click(function(){
						tablestrop(true);
					});
					$("#reset").click(function(){
						$("#form-data")[0].reset();
						tablestrop();
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
					if($("#sort").val() != ''){
						map.sort = $("#sort").val();
					}
				}else{
					if("${indexStatus}" != "false"){
						map.status = ${indexStatus};
					}
				}
				params.map = JSON.stringify(map);
				return params;
			}; 
            var tablestrop = function(flag){
            	QUERY_FLAG = flag;
            	$("#table").bootstrapTable('destroy', null);
                $("#table").bootstrapTable({
                    method : 'get',
	                url : '/dorder/list.ajax',
			   		queryParams : queryParams,
	            	striped : true,
	                cache : false,
	                pagination : true,
	                pageSize : 10,
	                pageList : [ 10,25,50,100,'All' ],
	                search : false,
	                showColumns : false,
	                minimumCountColumns : 2,
	                clickToSelect : false,
	                sidePagination:"server",//设置为服务器端分页
                    columns : [ {           //表头
                        field : 'order.orderSn',
                        title : '订单号',
                        align : 'left',
                        valign : 'bottom',
                    },{
                        field : 'order.memberName',
                        title : '顾客姓名',
                        align : 'left',
                        valign : 'middle',
                    },
                     {
                        field : 'order.goodsName',
                        title : '产品名称',
                        align : 'left',
                        valign : 'top',
                    }, {
                        field : 'order.addTimeStr',
                        title : '订购时间',
                        align : 'left',
                        valign : 'top',
                    },{
                        field : 'order.pdAmount',
                        title : '实付金额（元）',
                        align : 'left',
                        valign : 'top',
                        sortable : true,
                        formatter:function(value,row,index){
                        	return moneyFormat(value);
                        }
                    },{
                        field : 'createTimeStr',
                        title : '申请时间',
                        align : 'left',
                        valign : 'top',
                        sortable : true,
                    },{
                        field : 'reason',
                        title : '申请理由',
                        align : 'left',
                        valign : 'top',
                        sortable : true,
                    },{
                        field : 'status',
                        title : '退款状态',
                        align : 'left',
                        valign : 'top',
                     	formatter: function(value, row, index){
                     		if(value == "handled"){
                     			return "已退款";
                     		}else if(value == "handling"){
                     			return "退款中";
                     		}else{
                     			return "拒绝退款";
                     		}
                        }
                    },{
                        field : 'orderId',
                        title : '操作',
                        align : 'center',
                        valign : 'top',
                        formatter: function(value, row, index){
                    		if(row.status == "handling"){
	                           return '<a href="/dorder/pc_detail/'+value+'.htm">处理</a>';    
                     		}else{
	                           return '<a href="/dorder/pc_detail/'+value+'.htm">查看</a>';    
                     		}
                        }
                    }]
                });
            };
			})(window);
        </script>
    </body>
</html>