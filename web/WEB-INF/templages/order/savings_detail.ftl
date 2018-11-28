<#include "../head.ftl"/>
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
                                    <li>财务管理</li>
                                </ul>
                                <h4>顾客储值管理</h4>
                            </div>
                        </div><!-- media -->
                    </div><!-- pageheader -->
                    
                    <div class="contentpanel">
                        <div class="alert alert-info">
                            <button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
                            <strong>说明：</strong>${name!''}顾客(ID:${id !''})储值明细
                        </div>
                         <div class="panel panel-default">
                           <div class="panel-heading">
							<form id="from-data">
                                <div class="form-horizontal cb pt5">
                                    <div class="form-line">
                                        <label class="w100 fl control-label lh20">项目：</label>
                                        <select class="select2 w100 fl" name="orderBy">
                                          <option value="">请选择</option>
                                          <option value="CARD">充值卡充值</option>
                                          <option value="WXPAY">充值</option>
                                          <option value="REWARD">打赏</option>
                                          <option value="KITING">提现</option>
                                          <option value="GST">消费</option>
                                        </select>
                                        <div class="cb"></div>
                                    </div>
                                </div>
                                <input type="hidden" name="limit" value="10">
                                <input type="hidden" name="offset" value="1">
                                <input type="hidden" name="id" value="${id !''}">
                                </form>
                                <div class="pull-right mt-30">
                                    <button type="button" class="btn btn-primary btn-sm" onclick="returnList();">查询</button>    
                                    <button type="button" class="btn btn-primary btn-sm" onclick="dataReset();">清空</button>
                                    <button type="button" class="btn btn-primary btn-sm">导出</button>
                                </div>
                            </div><!-- panel-heading -->
                            <div class="panel-body">
                                <div class="row">
                                    <table id="table"></table>
                                </div><!-- row -->
                            </div><!-- panel-body -->
                        </div>
                    </div><!-- contentpanel -->
                    
                </div><!-- mainpanel -->
            </div><!-- mainwrapper -->
        </section>


        <script async="" src="js/analytics/analytics.js"></script>
        <script src="js/jquery-1.11.1/jquery-1.11.1.min.js"></script>
        <script src="js/jquery-migrate-1.2.1/jquery-migrate-1.2.1.min.js"></script>
        <script src="js/jquery-ui-1.10.3/jquery-ui-1.10.3.min.js"></script>
        <script src="js/jquery-ui-1.10.3/jquery.ui.datepicker-zh-CN.js"></script>
        <script src="js/bootstrap/bootstrap.min.js"></script>

        <script src="js/select2/select2.min.js"></script>
        <script src="js/bootstrap-table/bootstrap-table.js"></script>
        <script src="js/bootstrap-table/bootstrap-table-zh-CN.js"></script>
        
        <script src="js/modernizr/modernizr.min.js"></script>
        <script src="js/pace/pace.min.js"></script>
        <script src="js/retina/retina.min.js"></script>
        <script src="js/jquery.cookies/jquery.cookies.js"></script>
        
         <script src="js/custom/custom.js"></script>  
        <script>
            $(function(){
				returnList();
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
	                url : '/order/savings/detail.ajax',
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
	                    field : 'method',
	                    title : '项目',
	                    align : 'left',
	                    valign : 'bottom',
	                    formatter:function(value,row,index){
	                    	var msg = '-';
	                    	switch(value){
	                    		case 'GST': msg='消费';break;
	                    		case 'CARD':msg='充值卡充值';break;
	                    		case 'WXPAY':msg='充值';break;
	                    		case 'KITING':msg='提现';break;
	                    		case 'REWARD':msg='打赏';break;
	                    	}
	                    	return msg;
	                    }
	                },
	                 {
	                    field : 'amount',
	                    title : '金额（元）',
	                    align : 'left',
	                    valign : 'middle',
	                    formatter:function(value,row,index){
	                     	var t = row.method;
	                     	if(t =='GST' || t == 'KITING' || t == 'REWARD'){
	                     		return '-'+moneyFormat(value);	
	                     	}else{
	                     		return '+'+moneyFormat(value);
	                     	}
	                    }
	                },{
	                    field : 'addTime',
	                    title : '时间',
	                    align : 'left',
	                    valign : 'top',
	                    formatter:function(value,row,index){
                        	return value;
                        }
	                },{
	                    field : 'sn',
	                    title : '详细',
	                    align : 'left',
	                    valign : 'top',
	                    formatter:function(value,row,index){
	                    	var r = row.method;
	                    	if(r == 'GST'){
	                    		return '订单号：'+value;
	                    	}else{
	                    		return '流水号：'+row.id;
	                    	}
	                    }
	                }]
	            });
            }
        </script>
    </body>
</html>