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
                                    <li>销售管理管理</li>
                                </ul>
                                <h4>未付余额管理</h4>
                            </div>
                        </div><!-- media -->
                    </div><!-- pageheader -->
                    
                    <div class="contentpanel">
                        <div class="alert alert-info">
                            <button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
                            <strong>说明：</strong>查看所有超时未付余款的订单，并人工处理。完成订单后可对商家结算，未支付余款从结算金额中扣除。
                        </div>
                         <div class="panel panel-default">
                           <div class="panel-heading">
	                        <form id="form-data">
                                <div class="form-horizontal cb pt5">
                                    <div class="form-line">
                                        <select class="select2 w100 fl" name="typeName">
                                          <option value="goodsname">产品名称</option>
                                          <option value="orderid">订单ID</option>
                                          <option value="memberName">顾客姓名</option>
                                          <option value="storename">商家名称</option>
                                        </select>
                                        <input type="text" placeholder="" class="form-control input-sm w160 fl ml10" name="typeValue">
                                        
                                        <label class="w100 fl control-label lh20">状态</label>
                                        <select class="select2 w100 fl ml10" name="orderState" style="width:150px;">
                                          <option value="">请选择</option>
                                          <option value="">未通过</option>
                                          <option value="1">已通过</option>
                                                                              
                                        </select>
                                        
                                       
                                        <div class="cb"></div>
                                    </div>
                                    
                                    <div class="form-line mt10">
                                        
                                        <div class="cb"></div>
                                    </div>
                                    
                                </div>
                                <input type="hidden" name="limit" value="10">
                                <input type="hidden" name="offset" value="1">
                                </form>
                                <div class="pull-right mt-30">
                                    <button type="button" class="btn btn-primary btn-sm" id="serach" onclick="tablestrop();">查询</button>    
                                    <button type="button" class="btn btn-primary btn-sm" onclick="document.getElementById('form-data').reset();tablestrop();">清空</button>
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
            	tablestrop();
				$("#exportBtn").click(function(){
					$(".bootstrap-table .export .dropdown-menu > li[data-type='excel']").click();
				});		            	
            });
            var queryParams = function(params){
            	$('input[name="limit"]').val(params.limit);
            	$('input[name="offset"]').val(params.offset/params.limit + 1);
            	
            	console.log($('form').serialize())
            	return $('form').serialize();
            }
            function tablestrop(){
            	$("#table").bootstrapTable('destroy', null);
                $("#table").bootstrapTable({
                    method : 'get',
	                url : '/dorder/list1.ajax',
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
                        title : '订单id',
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
                        field : 'finnshedTime',
                        title : '验证时间',
                        align : 'left',
                        valign : 'top',
                        sortable : true,
                    },{
                        field : 'bookFinalPayment',
                        title : '未支付余款（元）',
                        align : 'left',
                        valign : 'top',
                        sortable : true,
                        formatter:function(value,row,index){
                        	return moneyFormat(value);
                        }
                    },{
                        field : '',
                        title : '管理操作',
                        align : 'left',
                        valign : 'top',
                        sortable : true,
                        formatter: function(value, row, index){
                           return '<a href="/dorder/operate.htm">通过</a>';    
                        }
                    },]
                });
            }
        </script>
    </body>
</html>