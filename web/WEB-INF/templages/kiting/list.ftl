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
                                <h4>顾客提现管理</h4>
                            </div>
                        </div><!-- media -->
                    </div><!-- pageheader -->
                    
                    <div class="contentpanel">
                        <div class="alert alert-info">
                            <button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
                            <strong>说明：</strong>审核由C端发起的余额提现申请，操作修改提现成功请确认已转账成功
                        </div>
                         <div class="panel panel-default">
                           <div class="panel-heading">
								<form id="form1">
								<div class="form-horizontal cb pt5">
									<div class="form-line">
										<select class="select2 w100 fl" id="fieldName">
										  <option value="memberName">顾客姓名</option>
										  <option value="memberMobile">电话</option>
										</select>
										<input type="text" id="fieldValue" placeholder="" class="form-control input-sm w160 fl ml10">
										
										<label class="w100 fl control-label lh20">提现状态</label>
										<select class="select2 w100 fl ml10" id="status">
										  <option value="">请选择</option>
										  <option value="FAIL">提现失败</option>
										  <option value="HANDLE_OK">提现成功</option>
										  <option value="AUDIT">未处理</option>
										  <option value="REJECT">拒绝提现</option>
										</select>
										<label class="w100 fl control-label lh20">提现类型</label>
										<select class="select2 w100 fl ml10" id="type">
										  <!--<option value="">请选择</option>-->
										  <option value="balance">余额提现</option>
										  <!--<option value="income">收益提现</option>-->
										</select>
                                        <div class="cb"></div>
									</div>
								</div>
								
								<div class="pull-right mt-30">
									<button type="button" class="btn btn-primary btn-sm" id="queryBtn">查询</button>    
									<button type="button" class="btn btn-primary btn-sm" onclick="clears()">清空</button>
									<button type="button" class="btn btn-primary btn-sm" id="exportBtn">导出</button>
								</div>
								</form>
                            </div><!-- panel-heading -->
                            <div class="panel-body">
                                <div class="row">
                                    <table id="table"  data-show-export="true">
                                    </table>
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
	(function(){
     	var QUERY_FLAG = false;    //是否使用了查询输入进行查询标志位
		$(document).ready(function(){
			renderTable(false);
			$("#queryBtn").click(function(){
				renderTable(true);
			});
			
			$("#exportBtn").click(function(){
				$(".bootstrap-table .export .dropdown-menu > li[data-type='excel']").click();
			});
		});
	
		var queryParams = function(params){   //提交参数
			var map = {
				pageSize : params.limit,      //每页大小
				pageNo : params.offset/10 + 1 //页码
			};
			if(QUERY_FLAG){
				if($("#fieldValue").val() != ''){
					var field = $("#fieldName").val();
					map[field] = $("#fieldValue").val();
				}
				if($("#status").val() != ''){
					map.status = $("#status").val();
				}
				if($("#type").val() != ''){
					map.type = $("#type").val();
				}
			}else{
				if("${indexStatus}" != "false"){
					map.status = ${indexStatus};
				}
			}
			
			params.map = JSON.stringify(map);
			
			return params;
		};  
		
		 var renderTable = function(flag){
			 QUERY_FLAG = flag;
	        $("#table").bootstrapTable('destroy', null);
	        $("#table").bootstrapTable({
	            method : 'get',
			    url : '/kiting/query.ajax',
			    queryParams : queryParams,
	            striped : true,
	            pagination : true,
	            pageList : [10],
	            pageSize : 10,
	            search : false,
	            showColumns : false,
	            clickToSelect : false,
	            sidePagination:"server",//设置为服务器端分页
	            columns : [ {
	                field : 'id',
	                title : '提现ID',
	                align : 'left',
	                valign : 'bottom'
	            }, {
	                field : 'name',
	                title : '顾客姓名',
	                align : 'left',
	                valign : 'middle'
	            },  {
	                field : 'phone',
	                title : '顾客电话',
	                align : 'left',
	                valign : 'middle'
	            },  {
	                field : 'moneyDollar',
	                title : '申请提现金额',
	                align : 'left',
	                valign : 'middle'
	            }, {
	                field : 'strCreatedTime',
	                title : '申请时间',
	                align : 'left',
	                valign : 'middle'
	            }, {
	                field : 'status',
	                title : '提现状态',
	                align : 'left',
	                valign : 'middle',
	                formatter: function(value,row,index){
	                	if(value == 'HANDLE_OK'){
	                		return '提现成功';
	                	}
	                	if(value == 'AUDIT'){
	                		return '未处理';
	                	}
	                	if(value == 'REJECT'){
	                		return '拒绝提现';
	                	}
	                	if(value == 'FAIL'){
	                		return '提现失败';
	                	}else{
	                		return '-';
	                	}
	                }
	            }, {
	                field : 'actualMoneyDollar',
	                title : '实际提现金额',
	                align : 'left',
	                valign : 'middle'
	            }, {
	            
                    field : 'id',
                    title : '操作',
                    align : 'left',
                    formatter: function(value,row,index){
                    	if(row.status == 'AUDIT' || row.status == 'FAIL'){
                    		return '<a href="/kiting/detail/'+value+'.htm">处理</a>';
                    	}else{
                    		return '<a href="/kiting/detail/'+value+'.htm">查看</a>';
                    	}
                    }
                }]
	        });
        }
	})();
//清空
function clears(){
	
	$("#fieldName").val('memberName');
	$("#fieldName").select2({minimumResultsForSearch: -1});
	$("#status").val('');
	$("#status").select2({minimumResultsForSearch: -1});
	$("#type").val('');
	$("#type").select2({minimumResultsForSearch: -1});
	$("#fieldValue").val('');
	$('#queryBtn').click();
}
</script>
	</body>
</html>