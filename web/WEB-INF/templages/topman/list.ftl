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
                                    <li>融耀达人审核</li>
                                </ul>
                                <h4>融耀达人审核</h4>
                            </div>
                        </div><!-- media -->
                    </div><!-- pageheader -->
                    
                    <div class="contentpanel">
                        <div class="alert alert-info">
                            <button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
                            <strong>说明：</strong>审核由C端发起的荣耀达人申请，审核通过后顾客可通过完成任务获得实际收益
                        </div>
                         <div class="panel panel-default">
                           <div class="panel-heading">
								<form id="form1">
								<div class="form-horizontal cb pt5">
									<div class="form-line">
										<select class="select2 w100 fl" id="fieldName">
										  <option value="memberName">顾客姓名</option>
										  <option value="memberId">顾客ID</option>
										  <option value="memberMobile">电话</option>
										</select>
										<input type="text" id="fieldValue" placeholder="" class="form-control input-sm w160 fl ml10">
										
										<label class="w100 fl control-label lh20">审核状态</label>
										<select class="select2 w100 fl ml10" id="status">
										  <option value=''>请选择</option>
										  <option value="examining">待审核</option>
										  <option value="unexamine">审核拒绝</option>
										  <option value="examined">审核通过</option>
										</select>
                                        <div class="cb"></div>
									</div>
								</div>
								
								<div class="pull-right mt-30">
									<button type="button" id="queryBtn" class="btn btn-primary btn-sm">查询</button>    
									<button type="button" class="btn btn-primary btn-sm" onclick="clears()">清空</button>
									<button type="button" class="btn btn-primary btn-sm" id="exportBtn">导出</button>
								</div>
								</form>
                            </div><!-- panel-heading -->
                            <div class="panel-body">
                                <div class="row">
                                    <table id="table" data-show-export="true">
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
		});
		
		$("#exportBtn").click(function(){
			$(".bootstrap-table .export .dropdown-menu > li[data-type='excel']").click();
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
			    url : '/topman/list.ajax',
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
	                field : 'memberId',
	                title : '顾客ID',
	                align : 'left',
	                valign : 'bottom'
	            }, {
	                field : 'member.memberName',
	                title : '顾客姓名',
	                align : 'left',
	                valign : 'middle'
	            },  {
	                field : 'member.memberMobile',
	                title : '电话',
	                align : 'left',
	                valign : 'middle'
	            },  {
	                field : 'strCreateTime',
	                title : '申请时间',
	                align : 'left',
	                valign : 'middle'
	            }, {
	                field : 'reason',
	                title : '申请理由',
	                align : 'left',
	                valign : 'middle'
	            }, {
	                field : 'status',
	                title : '审核状态',
	                align : 'left',
	                valign : 'middle',
	                formatter: function(value,row,index){
	                	if(value == 'examining'){
	                		return '待审核';
	                	}
	                	if(value == 'unexamine'){
	                		return '审核拒绝';
	                	}
	                	if(value == 'examined'){
	                		return '审核通过';
	                	}else{
	                		return '-';
	                	}
	                }
	            }, {
                    field : 'id',
                    title : '操作',
                    align : 'left',
                    formatter: function(value,row,index){
                    	if(row.status == 'examining'){
                    	return '<a href="javascript:;" onclick="detail('+value+')">查看</a>&nbsp;&nbsp;<a href="javascript:;" onclick="examine('+value+')">审核</a>';
                    	}else{
                    	return '<a href="javascript:;" onclick="detail('+value+')">查看</a>';
                    	}
                    }
                }]
	        });
        }
        
        
	})();
	
function detail(id){
	$("#detail").load("/topman/detail/"+id+".htm");
}
function examine(id){
	$("#detail").load("/topman/examine/"+id+".htm");
}

//清空
function clears(){
	
	$("#fieldName").val('memberName');
	$("#fieldName").select2({minimumResultsForSearch: -1});
	$("#status").val('');
	$("#status").select2({minimumResultsForSearch: -1});
	$("#fieldValue").val('');
}
</script>
<div id="detail"></div>
	</body>
</html>