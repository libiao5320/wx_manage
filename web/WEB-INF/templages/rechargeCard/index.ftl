<#include "../head.ftl"/>
<script src="/js/bootbox/bootbox.min.js"></script>
<script src="/js/bootstrap-table/bootstrap-table-export.js"></script>
<script src="/js/bootstrap-table/tableExport.js"></script>
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
                                <h4>充值卡管理</h4>
                            </div>
                        </div><!-- media -->
                    </div><!-- pageheader -->
                    <div class="contentpanel">
                        <div class="alert alert-info">
                            <button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
                            <strong>说明：</strong>生成并管理充值卡，未使用的充值卡可注销作废
                        </div>
                         <div class="panel panel-default">
                           <div class="panel-heading">
	                        <form id="form-data">
                                <div class="form-horizontal cb pt5">
                                    <div class="form-line">
                                        <select class="select2 w100 fl" id="typeName">
                                          <option value="memberName">顾客姓名</option>
                                          <option value="memberMobile">顾客电话</option>
                                          <option value="createBy">生成人</option>
                                        </select>
                                        <input type="text" placeholder="" class="form-control input-sm w160 fl ml10" id="typeValue">
                                        
                                        <label class="w100 fl control-label lh20">状态</label>
                                        <select class="select2 w160 fl ml10" id="status">
                                          <option value="">请选择</option>
                                          <option value="Y">已充值</option>
                                          <option value="N">未充值</option>
                                          <option value="D">已过期</option>
                                         </select>
                                        
                                        <div class="cb"></div>
                                    </div>
                                    
                                    <div class="form-line mt10">
                                        <select class="select2 w160 fl" id="timeName">
                                          <option value="createTime">生成时间</option>
                                          <option value="updateTime">充值时间</option>
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
                                    <button type="button" class="btn btn-primary btn-sm" id="createCard">生成充值卡</button>    
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
							$("#createCard").click(function(){
								$("#createPage").load("/rechargeCard/createPage.htm");	
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
									map.typeValue = $("#typeValue").val().trim();
								}
								if($("#bedin").val() != '' || $("#end").val() != ''){
									map.timeName = $("#timeName").val();
									map.begin = $("#begin").val().trim();
									map.end = $("#end").val().trim();
								}
								if($("#status").val() != ''){
									map.status = $("#status").val();
								}
							}
							params.map = JSON.stringify(map);
							
							return params;
						}; 
						function getStatusStr(status){
							if(status == "Y"){
								return "已充值";
							}else if(status == "N"){
								return "未充值";
							}else{
								return "已过期";
							}
						}
		                var renderTable = function(flag){
		                	QUERY_FLAG = flag;
		                	$("#table").bootstrapTable('destroy', null);
			                $("#table").bootstrapTable({
			                    method : 'get',
			                    url : '/rechargeCard/list.ajax',   
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
			                        field : 'id',
			                        title : '充值卡ID',
			                        align : 'left',
			                    },{
			                        field : 'rechargeSn',
			                        title : '卡号',
			                        align : 'left',
			                    },{
			                        field : 'moneyDollar',
			                        title : '金额',
			                        align : 'left',
			                    },{
			                        field : 'createTimeStr',
			                        title : '生成时间',
			                        align : 'left',
			                    }, {
			                        field : 'createBy',
			                        title : '生成人',
			                        align : 'left',
			                    },{
			                        field : 'status',
			                        title : '状态',
			                        align : 'left',
			                        formatter: function(value,row,index){
			                        	return getStatusStr(value);
			                        }			                        
			                    },{
			                        field : 'updateTimeStr',
			                        title : '充值时间',
			                        align : 'left',
			                    },{
			                        field : 'memberName',
			                        title : '顾客姓名',
			                        align : 'left',
			                    },{
			                        field : 'memberMobile',
			                        title : '顾客电话',
			                        align : 'left',
			                    },{
			                        field : '',
			                        title : '操作',
			                        align : 'left',
			                        formatter: function(value,row,index){
			                        	if(row.status == "D"){
				                        	return "已注销";
			                        	}else if(row.status == "Y"){
			                        		return "";
			                        	}else{
				                        	return '<a class="delete" cardId="' + row.id + '">注销</a>';
			                        	}
			                        }
			                    }],
			                    onLoadSuccess: function(data){
				                    $(".delete").click(function(){
				                        var cardId = $(this).attr("cardId");
				                        bootbox.confirm("您确定要注销此充值卡吗?", function(result) {
				                            if(result){
				                                deleteCard(cardId);
				                            }
				                        });
				                    });
			                	}
			                });
		                };
		                
		                var deleteCard = function(id){
				            $.ajax({
				                url: '/rechargeCard/delete.ajax' ,
				                type: 'POST',
				                data: {id:id} ,
				                dataType: 'json',
				                success: function(json){
				                    if(json.state == 1){
				                        bootbox.alert("注销成功！");
				                        $('#table').bootstrapTable('refresh');
				                    }else{
				                        bootbox.alert(json.message);
				                    }
				                } ,
				                error: function(){
				                    bootbox.alert("网络忙，请稍后重试！");
				                    //$('#table').bootstrapTable('refresh');
				                }
				            });
				        };
					})(window);

        </script>
        <div id="createPage"></div>
    </body>
</html>


