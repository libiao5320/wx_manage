<#include "../head.ftl"/>
<style>.edit,.delete{cursor:pointer;}</style>
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
                            <li>健康师管理</li>
                        </ul>
                        <h4>健康师银行账户管理</h4>
                    </div>
                </div><!-- media -->
            </div><!-- pageheader -->
            
            <div class="contentpanel">
                <div class="alert alert-info">
                    <button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
                    <strong>说明：</strong>此页面管理通过审核的健康师
                </div>
                 <div class="panel panel-default">
                   <div class="panel-heading">

						<div class="form-horizontal cb pt5">
							<div class="form-line">
								<select id="typeName" class="select2 w100 fl">
								  <option value="trueName">健康师姓名</option>
								  <option value="id">健康师ID</option>
								</select>
								<input type="text" id="typeValue" placeholder="" class="form-control input-sm w160 fl ml10">
								
                         <!--       <label class="w100 fl control-label lh20">排序</label>
								<select id="orderBy" class="select2 w100 fl ml10">
								  <option value="techieId">ID最大</option>
								  <option value="2">粉丝最多</option>
								</select> -->
                                
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
								$("#typeValue").val("");
								<!--$("#fieldName").select2({minimumResultsForSearch: -1});-->
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
								//if($("#status").val() != ''){
								//	map.status = $("#status").val();
								//}
							}
							map.state = 1;
							params.map = JSON.stringify(map);
							
							return params;
						}; 
		                var renderTable = function(flag){
		                	QUERY_FLAG = flag;
		                	$("#table").bootstrapTable('destroy', null);
			                $("#table").bootstrapTable({
			                    method : 'get',
			                    url : '/techie/bankListWithPageCondition.ajax',   //获取表格的后台url
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
			                        field : 'id',
			                        title : '健康师账户ID',
			                        align : 'left',
			                    }, {
			                        field : 'trueName',
			                        title : '健康师姓名',
			                        align : 'left',
			                    }, {
			                        field : 'accounts',
			                        title : '账户名称',
			                        align : 'left',
			                    }, {
			                        field : 'accountsNo',
			                        title : '账户号',
			                        align : 'left',
			                    }, {
			                        field : 'accountHolder',
			                        title : '开户人',
			                        align : 'left',
			                    }, {
			                        field : '',
			                        title : '管理操作',
			                        align : 'left',
			                        formatter: function(value,row,index){
			                        	return "<a class='edit' rowid='" + row.id + "'>编辑</a>&nbsp;&nbsp;";
			                        	<!--<a class='delete' rowid='" + row.id + "'>删除</a>";-->
			                        }
			                    }],
			                    onLoadSuccess: function(data){
			                    	$(".edit").click(function(){
			                    		window.location.href = "/techie/editTechieBank/" + $(this).attr("rowid") + ".htm";
			                    	});
			                    	$(".delete").click(function(){
			                    		var id = $(this).attr("rowid");
			                    		bootbox.confirm("您确定要删除这条记录吗?", function(result) {
											if(result){
												deleteTechieBank(id);
											}
										});
			                    	});
			                    }
			                });
		                };
		                
		                var deleteTechieBank = function(id){
		                	$.ajax({
								url: '/techie/deleteTechieBankById.ajax' ,
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
