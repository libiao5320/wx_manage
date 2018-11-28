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
                                    <li>顾客管理</li>
                                </ul>
                                <h4>顾客管理</h4>
                            </div>
                        </div><!-- media -->
                    </div><!-- pageheader -->
                    
                    <div class="contentpanel">
                        <div class="alert alert-info">
                            <button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
                            <strong>说明：</strong>顾客列表，管理顾客信息并分配私人健康师
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
										  <!--<option value="WY">邀请码</option>-->
										</select>
										<input type="text" id="fieldValue" placeholder="" class="form-control input-sm w160 fl ml10">
										
										<!--
										<label class="w100 fl control-label lh20">健康档案</label>
										<select class="select2 w100 fl ml10">
										  <option value="AL">空缺</option>
										  <option value="WY">部分完善</option>
										  <option value="WY">完整</option>
										</select>
										-->
                                        
                                        <label class="w100 fl control-label lh20">排序</label>
										<select class="select2 w160 fl ml10" id="orderBy">
										  <option value="1">注册时间最近</option>
										  <!--<option value="WY">私人健康师数量</option>-->
										</select>
                                        
                                        <div class="cb"></div>
									</div>
                                    
                                    <div class="form-line mt10">
										<select class="select2 w100 fl" id="regTime">
										  <option value="AL">注册时间</option>
										</select>
                                        
										<input type="text" id="startTime" placeholder="" class="datepicker input-sm form-control w160 fl ml10">
                                        <label class="w50 fl control-label lh20 ml15">至</label>
                                        <input type="text" id="endTime" placeholder="" class="datepicker input-sm form-control w160 fl ml10">
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
				if($("#orderBy").val() != ''){
					map.orderBy = $("#orderBy").val();
				}
				if($("#startTime").val() != '' && $("#endTime").val() != ''){
					map.startTime = $("#startTime").val();
					map.endTime = $("#endTime").val();
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
			    url : '/member/list.ajax',
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
	                field : 'memberName',
	                title : '顾客姓名',
	                align : 'left',
	                valign : 'middle'
	            },  {
	                field : 'memberMobile',
	                title : '电话',
	                align : 'left',
	                valign : 'middle'
	            },  {
	                field : 'memberTime',
	                title : '注册时间',
	                align : 'left',
	                valign : 'middle'
	            }, {
                    field : 'memberId',
                    title : '操作',
                    align : 'left',
                    formatter: function(value,row,index){
                    	return '<a href="/member/detail/' + value + '.htm">查看</a>';
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
	$("#orderBy").val('1');
	$("#orderBy").select2({minimumResultsForSearch: -1});
	$("#regTime").val('AL');
	$("#orderBy").select2({minimumResultsForSearch: -1});
	$("#fieldValue").val('');
	$("#startTime").val('');
	$("#endTime").val('');
	$("#queryBtn").click();
}	
</script>
	</body>
</html>