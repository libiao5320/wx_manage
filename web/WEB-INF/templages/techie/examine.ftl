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
                            <li>商家管理</li>
                        </ul>
                        <h4>健康师审核</h4>
                    </div>
                </div><!-- media -->
            </div><!-- pageheader -->
            
            <div class="contentpanel">
                <div class="alert alert-info">
                    <button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
                    <strong>说明：</strong>审核健康师注册，审核通过的健康师进入健康师管理
                </div>
                 <div class="panel panel-default">
                   <div class="panel-heading">

						<div class="form-horizontal cb pt5">
							<div class="form-line">
								<label class="w100 fl control-label lh20">审核状态</label>
								<select id="state" class="select2 w100 fl ml10">
								  <option value="">请选择</option>
								  <option value="0">未激活</option>
								  <option value="2">待审核</option>
								  <option value="3">审核拒绝</option>
								  <option value="1">审核通过</option>
								</select>
							
								<select id="typeName" class="select2 w100 fl" style="margin-left:50px;">
								  <option value="trueName">健康师姓名</option>
								  <option value="mobile">电话</option>
								</select>
								<input type="text" id="typeValue" placeholder="" class="form-control input-sm w160 fl ml10">
								
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
								$("#typeName").val('');
								$("#typeName").select2({minimumResultsForSearch: -1});
								$("#typeValue").val("");
								$("#state").val('');
								$("#state").select2({minimumResultsForSearch: -1});
								$('#queryBtn').click();
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
								if($("#typeValue").val() != ''){
									var field = $("#typeName").val();
									map[field] = $("#typeValue").val();
								}
								if($("#state").val() != ''){
									map.state = $("#state").val();
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
			                    url : '/techie/listWithPageCondition.ajax',   //获取表格的后台url
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
			                        field : '',
			                        title : '邀请码',
			                        align : 'left',
			                    }, {
			                        field : 'trueName',
			                        title : '健康师姓名',
			                        align : 'left',
			                    }, {
			                        field : 'mobile',
			                        title : '电话',
			                        align : 'left',
			                    }, {
			                        field : 'storeName',
			                        title : '机构',
			                        align : 'left',
			                    }, {
			                        field : 'specialty',
			                        title : '专业',
			                        align : 'left',
			                    }, {
			                        field : 'addTime',
			                        title : '注册时间',
			                        align : 'left',
			                    }, {
			                        field : 'state',
			                        title : '审核状态',
			                        align : 'left',
			                        formatter: function(value,row,index){
			                        	if(value == 2){
			                        		return "待审核";
			                        	}else if(value == 0){
			                        		return "未激活";
			                        	}else if(value == 1){
			                        		return "审核通过";
			                        	}else{
			                        		return "审核拒绝"
			                        	}
			                        }
			                    }, {
			                        field : '',
			                        title : '审核',
			                        align : 'left',
			                        formatter: function(value,row,index){
			                        	if(row.state == 2){
			                        		return "<a class='examine' rowid='" + row.techieId + "'>审核</a>";
			                        	}else if(row.state == 0){
			                        		return "未激活";
			                        	}else{
			                        		return "已审核";
			                        	}
			                        }
			                    }, {
			                        field : '',
			                        title : '管理操作',
			                        align : 'left',
			                        formatter: function(value,row,index){
			                        	return "<a class='edit' rowid='" + row.techieId + "'>查看</a>&nbsp;&nbsp;<a class='delete' rowid='" + row.techieId + "'>删除</a>";
			                        }
			                    }],
			                    onLoadSuccess: function(data){
			                    	$(".edit").click(function(){
			                    		window.location.href = "/techie/editTechie/" + $(this).attr("rowid") + ".htm";
			                    		//alert("还在开发中");
			                    	});
			                    	$(".delete").click(function(){
			                    		var techieId = $(this).attr("rowid");
			                    		bootbox.confirm("您确定要删除这条记录吗?", function(result) {
											if(result){
												deleteTechie(techieId);
											}
										});
			                    	});
			                    	
			                    	$(".examine").click(function(){
			                    		var techieId = $(this).attr("rowid");
			                    		bootbox.dialog({
											message: '<div class="row ml10">' + 
															'<div class="radio fl w100"><label><input type="radio" value="1" name="examine"> 审核通过</label></div>' +
															'<div class="radio fl w100 mt9"><label><input type="radio" value="3" name="examine"> 审核拒绝</label></div>' +
														'</div>',
											title: "健康师审核",
											buttons: {
												success: {
													label: "确定",
													className: "btn-primary btn-xs",
													callback: function() {
														var params = {
															techieId: techieId,
															state: $("input[name='examine']:checked").val()
														};
														$.ajax({
																url: '/techie/examineTechieById.ajax' ,
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
		                
		                var deleteTechie = function(id){
		                	$.ajax({
								url: '/techie/deleteTechieById.ajax' ,
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
		                
		                var stringToDate = function(value){
	       					if(isNaN(value)){
	       						value = value.substring(0,value.indexOf(" "));
								return value;
							}
	       					var date = new Date(parseInt(value));
	       					var year=date.getFullYear();     
	              			var month=date.getMonth()+1;     
	              			if(month < 10){
	              				month = "0" + month;
	              			}   
	              			var date=date.getDate();
	              			if(date < 10){
	              				date = "0" + date;
	              			}  
			              	return year + "-" + month + "-" + date
			            };
					})(window);
				</script>
                
            </div><!-- contentpanel -->
		</div>
	</div>
</section>
	</body>
</html>
