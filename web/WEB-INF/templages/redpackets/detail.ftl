<#include "../head.ftl"/>
<style>.edit,.delete{cursor:pointer;}</style>
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
                        <h4>红包领取详情</h4>
                    </div>
                </div><!-- media -->
            </div><!-- pageheader -->
            
            <div class="contentpanel">
                <div class="alert alert-info">
                    <button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
                    <strong>说明：</strong>查看红包领取及使用情况
                </div>
                 <div class="panel panel-default">
                   <div class="panel-heading">

						<div class="form-horizontal cb pt5">
							<div class="form-line">
								<select id="fieldName" class="select2 w100 fl">
								  <option value="memberName">顾客姓名</option>
								</select>
								<input type="text" id="fieldValue" placeholder="" class="form-control input-sm w160 fl ml10">
								
								<label class="w100 fl control-label lh20">使用状态</label>
								<select id="status" class="select2 w100 fl ml10">
								  <option value="">请选择</option>
								  <option value="unuse">已领取</option>
								  <option value="used">已使用</option>
								</select>
                                
                                <div class="cb"></div>
							</div>
						</div>
						
						<div class="pull-right mt-30">
							<button type="button" id="queryBtn" class="btn btn-primary btn-sm">查询</button>    
							<button type="button" class="btn btn-primary btn-sm">清空</button>
							<button type="button" class="btn btn-primary btn-sm">导出</button>
						</div>
                    </div><!-- panel-heading -->
                    <div class="panel-body">
                        <div class="row">
                            <table id="table"></table>
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
							}
							map.redpacketsId = '${id}';
							params.map = JSON.stringify(map);
							
							return params;
						}; 
		                var renderTable = function(flag){
		                	QUERY_FLAG = flag;
		                	$("#table").bootstrapTable('destroy', null);
			                $("#table").bootstrapTable({
			                    method : 'get',
			                    url : '/redpackets/detailList.ajax',   //获取表格的后台url
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
			                        field : 'money',
			                        title : '红包金额（元）',
			                        align : 'left',
			                        formatter: function(value,row,index){
			                        	return value/100;
			                        }
			                    }, {
			                        field : 'member_name',
			                        title : '顾客姓名',
			                        align : 'left',
			                    }, {
			                        field : 'create_time',
			                        title : '领取时间',
			                        align : 'left',
			                    }, {
			                        field : 'status',
			                        title : '使用状态',
			                        align : 'left',
			                        formatter: function(value,row,index){
			                        	if(value == 'unuse'){
			                        		return "已领取"
			                        	}else if(value == 'used'){
			                        		return "已使用"
			                        	}
			                        }
			                    }, {
			                        field : 'update_time',
			                        title : '使用时间',
			                        align : 'left',
			                    }, {
			                        field : 'order_id',
			                        title : '订单号',
			                        align : 'left',
			                    }]
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
