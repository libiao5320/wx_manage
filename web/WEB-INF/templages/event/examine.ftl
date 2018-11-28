<#include "../head.ftl"/>
<style>.edit,.delete,.examine{cursor:pointer;}</style>
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
                            <li>营销管理</li>
                        </ul>
                        <h4>主题活动审核</h4>
                    </div>
                </div><!-- media -->
            </div><!-- pageheader -->
            
            <div class="contentpanel">
                <div class="alert alert-info">
                    <button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
                    <strong>说明：</strong>审核由B端发起的活动，编辑活动信息确认无误后再审核通过
                </div>
                 <div class="panel panel-default">
                   <div class="panel-heading">

						<div class="form-horizontal cb pt5">
							<div class="form-line">
								<select id="fieldName" class="select2 w100 fl">
								  <option value="name">活动名称</option>
								  <option value="storeName">承办方</option>
								</select>
								<input type="text" id="fieldValue" placeholder="" class="form-control input-sm w160 fl ml10">
								
								<label class="w100 fl control-label lh20">审核状态</label>
								<select id="examine_status" class="select2 w100 fl ml10">
								  <option value="">请选择</option>
								  <option value="passing">待审核</option>
								  <option value="pass">审核通过</option>
								  <option value="unpass">审核拒绝</option>
								</select>
                                
                                <div class="cb"></div>
							</div>
						</div>
						
						<div class="pull-right mt-30">
							<button type="button" id="queryBtn" class="btn btn-primary btn-sm">查询</button>    
							<button type="button" class="btn btn-primary btn-sm" id="clearBtn">清空</button>
							<button type="button" class="btn btn-primary btn-sm" id="exportBtn">导出</button>
						</div>
                    </div><!-- panel-heading -->
                    <div class="panel-body">
                        <div class="row">
                            <table id="table" data-show-export="true"></table>
                        </div><!-- row -->
                    </div><!-- panel-body -->
                </div>
                <script>
					(function(){
						var QUERY_FLAG = false;    //是否使用了查询输入进行查询标志位
						$(document).ready(function(){
							renderTable(false);
							$("#queryBtn").click(function(){
								renderTable(true);
							});
							$("#clearBtn").click(function(){
								$("#fieldName").val('name');
								$("#fieldName").select2({minimumResultsForSearch: -1});
								$("#fieldValue").val("");
								$("#examine_status").val('');
								$("#examine_status").select2({minimumResultsForSearch: -1});
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
								if($("#examine_status").val() != ''){
									map.examineStatus = $("#examine_status").val();
								}
							}else{
								if("${indexStatus}" != "false"){
									map.examineStatus = ${indexStatus};
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
			                    url : '/event/query.ajax',   //获取表格的后台url
			                    queryParams : queryParams,   //查询参数
			                    striped : true,
			                    pagination : true,
			                    pageList : [10],
			                    pageSize : 10,
			                    search : false,
			                    showColumns : false,
			                    clickToSelect : false,
			                    sidePagination:"server",//设置为服务器端分页
			                    columns : [ {
			                        field : 'name',
			                        title : '活动名称',
			                        align : 'left',
			                    }, {
			                        field : 'profile',
			                        title : '活动产品',
			                        align : 'left',
			                    }, {
			                        field : 'create_time',
			                        title : '提交时间',
			                        align : 'left',
			                        formatter: function(value,row,index){
			                        	if(isNaN(value)){
			                        		return value;
			                        	}
			                        	return new Date(value).toLocaleString()
			                        }
			                    }, {
			                        field : 'store_name',
			                        title : '承办方',
			                        align : 'left',
			                    }, {
			                        field : 'examine_status',
			                        title : '审核状态',
			                        align : 'left',
			                        formatter: function(value,row,index){
			                        	if(value == "passing"){
			                        		return "待审核"
			                        	}
			                        	if(value == "pass"){
			                        		return "审核通过"
			                        	}
			                        	if(value == "unpass"){
			                        		return "审核拒绝"
			                        	}
			                        }
			                    }, {
			                        field : 'examine_status',
			                        title : '审核',
			                        align : 'left',
			                        formatter: function(value,row,index){
			                        	if(value == "passing"){
			                        		return "<a class='examine' rowid='" + row.id + "'>审核</a>";
			                        	}
			                        	if(value == "pass"){
			                        		return "已审核"
			                        	}
			                        	if(value == "unpass"){
			                        		return "已审核"
			                        	}
			                        }
			                    }, {
			                        field : '',
			                        title : '管理操作',
			                        align : 'left',
			                        formatter: function(value,row,index){
			                        	return "<a class='edit' rowid='" + row.id + "'>编辑</a>&nbsp;&nbsp;<a class='delete' rowid='" + row.id + "'>删除</a>";
			                        }
			                    }],
			                    onLoadSuccess: function(data){
			                    	$(".edit").click(function(){
			                    		window.location.href = "edit/" + $(this).attr("rowid") + ".htm";
			                    	});
			                    	$(".delete").click(function(){
			                    		var eventId = $(this).attr("rowid");
			                    		bootbox.confirm("您确定要删除这条记录吗?", function(result) {
											if(result){
												deleteEvent(eventId);
											}
										});
			                    	});
			                    	$(".examine").click(function(){
			                    		var eventId = $(this).attr("rowid");
			                    		bootbox.dialog({
											message: '<div class="row ml10">' + 
															'<div class="radio fl w100"><label><input type="radio" value="pass" name="examine"> 审核通过</label></div>' +
															'<div class="radio fl w100 mt9"><label><input type="radio" value="unpass" name="examine"> 审核拒绝</label></div>' +
														'</div>',
											title: "活动审核",
											buttons: {
												success: {
													label: "确定",
													className: "btn-primary btn-xs",
													callback: function() {
														var params = {
															id: eventId,
															examineStatus: $("input[name='examine']:checked").val()
														};
														$.ajax({
																url: '/event/updateEventById.ajax' ,
																type: 'POST',
																data: {map: JSON.stringify(params)} ,
																dataType: 'json',
																success: function(json){
																	if(json.state == 1){
																		bootbox.alert("更新成功！");
																		$('#table').bootstrapTable('refresh');
																	}else{
																		bootbox.alert(json.message);
																	}
																} ,
																error: function(){
																	bootbox.alert("网络忙，请稍后重试！");
																}
														 });
													}
												},
												cancel: {
													label: "取消",
													className: "btn-default btn-xs",
													callback: function() {
														
													}
												}
											}
										});
			                    	});
			                    }
			                });
		                };
		                
		                var deleteEvent = function(id){
		                	$.ajax({
								url: '/event/deleteEventById.ajax' ,
								type: 'POST',
								data: {id:id} ,
								dataType: 'json',
								success: function(json){
									if(json.state == 1){
										bootbox.alert("删除成功！");
										$('#table').bootstrapTable('refresh');
									}else{
										bootbox.alert(json.message);
									}
								} ,
								error: function(){
									bootbox.alert("网络忙，请稍后重试！");
								}
							});
		                };
					})(window);
				</script>
                
            </div><!-- contentpanel -->
		</div>
	</div>
</section>
	</body>
</html>
