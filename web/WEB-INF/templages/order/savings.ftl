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
                                <h4>储值管理</h4>
                            </div>
                        </div><!-- media -->
                    </div><!-- pageheader -->
                    
                    <div class="contentpanel">
                        <div class="alert alert-info">
                            <button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
                            <strong>说明：</strong>会员储值列表，账号余额为当前实际可用金额，总储值为历史储值金额总和
                        </div>
                         <div class="panel panel-default">
                           <div class="panel-heading">
							<form id="from-data">
                                <div class="form-horizontal cb pt5">
                                    <div class="form-line">
                                        <select class="select2 w100 fl" name="typeName">
                                          <option value="userName">顾客姓名</option>
                                          <option value="id">顾客ID</option>
                                          <option value="phone">顾客电话</option>
                                        </select>
                                        <input type="text" placeholder="" class="form-control input-sm w160 fl ml10" name="typeValue">
                                        
                                        <label class="w100 fl control-label lh20">排序</label>
                                        <select class="select2 w100 fl ml10" name="orderBy" style="width:120px;">
                                          <option value="">请选择</option>
                                          <option value="amount">账号余额最多</option>
                                          <option value="savings">总储蓄最多</option>
                                        </select>
                                        <div class="cb"></div>
                                    </div>
                                </div>
                                <input type="hidden" name="limit" value="10">
                                <input type="hidden" name="offset" value="1">
                                </form>
                                <div class="pull-right mt-30">
                                    <button type="button" class="btn btn-primary btn-sm" onclick="returnList();">查询</button>    
                                    <button type="button" class="btn btn-primary btn-sm" onclick="dataReset();">清空</button>
                                    <button type="button" class="btn btn-primary btn-sm" id="exportBtn">导出</button>
                                </div>
                            </div><!-- panel-heading -->
                            <div class="panel-body">
                                <div class="row">
                                    <table id="table" data-show-export="true"></table>
                                </div><!-- row -->
                            </div><!-- panel-body -->
                        </div>
                    </div><!-- contentpanel -->
                    
                </div><!-- mainpanel -->
            </div><!-- mainwrapper -->
        </section>

		<script src="../js/bootstrap-table/bootstrap-table-export.js"></script>
		<script src="../js/bootstrap-table/tableExport.js"></script>
         
        <script>
            $(function(){
				returnList();
				$("#exportBtn").click(function(){
					$(".bootstrap-table .export .dropdown-menu > li[data-type='excel']").click();
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
	                url : '/order/savings.ajax',
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
	                    field : 'memberId',
	                    title : '顾客ID',
	                    align : 'left',
	                    valign : 'bottom',
	                },
	                 {
	                    field : 'memberName',
	                    title : '顾客姓名',
	                    align : 'left',
	                    valign : 'middle',
	                },{
	                    field : 'memberMobile',
	                    title : '顾客电话',
	                    align : 'left',
	                    valign : 'top',
	                },{
	                    field : 'storedDollar',
	                    title : '账号余额（元）',
	                    align : 'left',
	                    valign : 'top',
	                    sortable : true,
	                    formatter:function(value,row,index){
	                    	return moneyFormat(value);
	                    }
	                },{
	                    field : 'savingsAmount',
	                    title : '总储值（元）',
	                    align : 'left',
	                    valign : 'top',
	                    sortable : true,
	                    formatter:function(value,row,index){
	                    	return moneyFormat(value);
	                    }
	                },
	                {
	                    field : 'memberId',
	                    title : '操作',
	                    align : 'left',
	                    valign : 'top',
	                    formatter: function(value, row, index){
                               return '<a href="/order/savings/detail/'+value+'.htm" style="cursor: pointer; ">查看明细</a>';    
                        }
	                }]
	            });
            }
        </script>
    </body>
</html>