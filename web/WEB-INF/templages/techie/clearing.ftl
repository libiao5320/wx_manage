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
                                    <li>财务管理</li>
                                </ul>
                                <h4>私人健康师结算清单</h4>
                            </div>
                        </div><!-- media -->
                    </div><!-- pageheader -->
                    
                    <div class="contentpanel">
                        <div class="alert alert-info">
                            <button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
                            <strong>说明：</strong>私人健康师历史结算列表，仅供查看
                        </div>
                         <div class="panel panel-default">
                           <div class="panel-heading">
	                        <form id="from-data">
                                <div class="form-horizontal cb pt5">
                                    <div class="form-line">
                                        <select class="select2 w100 fl" name="typeName">
                                          <option value="techieName">私人健康师</option>
                                          <option value="techieId">私人健康师Id</option>
                                          <option value="clearingName">结算人</option>
                                        </select>
                                        <input type="text" placeholder="" class="form-control input-sm w160 fl ml10" name="typeValue">
                                        
                                       <select class="select2 w100 fl ml10" name="typeName">
                                          <option value="clearing_time">结算时间</option>
                                        </select>
                                        <label class="w50 fl control-label lh20 ml15">开始：</label>
                                        <input type="text" placeholder="" class="datepicker input-sm form-control w160 fl ml10" name="start">
                                        <label class="w50 fl control-label lh20 ml15">结束：</label>
                                        <input type="text" placeholder="" class="datepicker input-sm form-control w160 fl ml10" name="end">
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
	                url : '/techie/clearingIndex.ajax',
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
                        field : 'techieId',
                        title : '私人健康师ID',
                        align : 'left',
                        valign : 'bottom',
                    },{
                        field : 'techieName',
                        title : '私人健康师',
                        align : 'left',
                        valign : 'middle',
                    },
                     {
                        field : 'moneyDouble',
                        title : '结算金额',
                        align : 'left',
                        valign : 'top',
                    }, {
                        field : 'createdTime',
                        title : '结算时间',
                        align : 'left',
                        valign : 'top',
                    },{
                        field : 'clearingName',
                        title : '结算人',
                        align : 'center',
                        valign : 'top',
                    },]
                });
            }
        </script>
    </body>
</html>