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
                                <h4>订单管理</h4>
                            </div>
                        </div><!-- media -->
                    </div><!-- pageheader -->
                    
                    <div class="contentpanel">
                        <div class="alert alert-info">
                            <button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
                            <strong>说明：</strong>订单列表，查看订单详情及消费券使用情况
                        </div>
                         <div class="panel panel-default">
                           <div class="panel-heading">
	                        <form id="from-data">
                                <div class="form-horizontal cb pt5">
                                    <div class="form-line">
                                        <select class="select2 w100 fl" name="typeName">
                                          <option value="proText">产品名称</option>
                                          <option value="orderId">订单ID</option>
                                          <option value="userName">顾客姓名</option>
                                          <option value="conName">商家名称</option>
                                        </select>
                                        <input type="text" placeholder="" class="form-control input-sm w160 fl ml10" name="typeValue">
                                        
                                        <label class="w100 fl control-label lh20">订单状态</label>
                                        <select class="select2 w100 fl ml10" name="orderState" style="width:150px;">
                                          <option value="">请选择</option>
                                          <option value="1">待付款</option>
                                          <option value="2">未消费</option>
                                          <option value="3">未付余款</option>
                                          <option value="4"> 待评价</option>
                                           <option value="7">退款中</option>
                                          <option value="8">已退款</option>
                                          <option value="9">退款已拒绝</option>
                                           <option value="10">投诉处理中</option>
                                          <option value="11">投诉已解决</option>
                                          <option value="5">已评价</option>
                                           <option value="6">已取消</option>
                                          <option value="12">已过期</option>                                       
                                        </select>
                                        
                                        <label class="w100 fl control-label lh20">排序</label>
                                        <select class="select2 w160 fl ml10" name="orderBy">
                                          <option value="payTime">订购时间最新</option>
                                          <option value="finTime">验证时间最新</option>
                                        </select>
                                        <div class="cb"></div>
                                    </div>
                                    
                                    <div class="form-line mt10">
                                        <select class="select2 w100 fl" name="timeName">
                                          <option value="payTime">订购时间</option>
                                          <option value="finTime">验证时间</option>
                                        </select>
                                         <label class="w50 fl control-label lh20 ml15">开始</label>
                                        <input type="text" placeholder="" class="datepicker input-sm form-control w160 fl ml10" name="startTime">
                                        <label class="w50 fl control-label lh20 ml15">结束</label>
                                        <input type="text" placeholder="" class="datepicker input-sm form-control w160 fl ml10" name="endTime">
                                        <div class="cb"></div>
                                    </div>
                                    
                                </div>
                                <input type="hidden" name="limit" value="10">
                                <input type="hidden" name="offset" value="1">
                                </form>
                                <div class="pull-right mt-30">
                                    <button type="button" class="btn btn-primary btn-sm" id="serach" onclick="returnList();">查询</button>    
                                    <button type="button" class="btn btn-primary btn-sm" onclick="dataReset();">清空</button>
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
            $(function(){
            	returnList();
				$("#exportBtn").click(function(){
					$(".bootstrap-table .export .dropdown-menu > li[data-type='excel']").click();
				});			            	
            	$('.delete').live('click',function(){
            		var url = $(this).attr('url');
            		$.get(url,function(json){
            			
            		},'json');
            	});
            });
            var queryParams = function(params){
            	$('input[name="limit"]').val(params.limit);
            	$('input[name="offset"]').val(params.offset/params.limit + 1);
            	
            	return $('form').serialize();
            }
            function returnList(){
            	$("#table").bootstrapTable('destroy', null);
                $("#table").bootstrapTable({
                    method : 'get',
	                url : '/order/list.ajax',
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
                        field : 'orderSn',
                        title : '订单号',
                        align : 'left',
                        valign : 'bottom',
                    },{
                        field : 'goodsName',
                        title : '产品名称',
                        align : 'left',
                        valign : 'middle',
                    },
                     {
                        field : 'memberName',
                        title : '顾客',
                        align : 'left',
                        valign : 'top',
                    }, {
                        field : 'storeName',
                        title : '商家',
                        align : 'left',
                        valign : 'top',
                    },{
                        field : 'addTime',
                        title : '订购时间',
                        align : 'left',
                        valign : 'top',
                        sortable : true,
                    },{
                        field : 'pdAmount',
                        title : '支付金额（元）',
                        align : 'left',
                        valign : 'top',
                        sortable : true,
                        formatter:function(value,row,index){
                        	return moneyFormat(value);
                        }
                    },{
                        field : 'finnshedTime',
                        title : '验证时间',
                        align : 'left',
                        valign : 'top',
                        sortable : true,
                    },{
                        field : 'bookFinalPayment',
                        title : '支付余款（元）',
                        align : 'left',
                        valign : 'top',
                        sortable : true,
                        formatter:function(value,row,index){
                        	return moneyFormat(value);
                        }
                    },{
                        field : 'orderState',
                        title : '订单状态',
                        align : 'left',
                        valign : 'top',
                     	formatter: function(value, row, index){
                            return judgeState(value);  
                        }
                    },{
                        field : 'orderId',
                        title : '订单操作',
                        align : 'center',
                        valign : 'top',
                        formatter: function(value, row, index){
                               return '<a href="/order/pc_detail/'+value+'.htm">查看订单</a>';    
                        }
                    },]
                });
            }
        </script>
    </body>
</html>