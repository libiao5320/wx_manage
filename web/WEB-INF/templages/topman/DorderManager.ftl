<#include "../head.ftl"/>
<section>
	<div class="mainwrapper">
	<#include "../leftnav.ftl"/>
		<div class="mainpanel">
			<div class="pageheader">
                        <div class="media">
                            <div class="pageicon pull-left">
                                <i class="fa fa-bars"></i>
                            </div>
                            <div class="media-body">
                                <ul class="breadcrumb">
                                    <li><a href=""><i class="fa fa-home"></i></a></li>
                                    <li>销售管理</li>
                                </ul>
                                <h4>未付余款管理</h4>
                            </div>
                        </div><!-- media -->
                    </div><!-- pageheader -->
                    
                    <div class="contentpanel">
                        <div class="alert alert-info">
                            <button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
                            <strong>说明：</strong>编辑管理平台所有产品
                        </div>
                         <div class="panel panel-default">
                           <div class="panel-heading">

								<div class="form-horizontal cb pt5">
									<div class="form-line">
										<select class="select2 w100 fl">
										  <option value="AL">产品名称</option>
										  <option value="WY">产品ID</option>
										  <option value="WY">顾客姓名</option>
										  <option value="WY">商家名称</option>
										</select>
										<input type="text" placeholder="" class="form-control input-sm w160 fl ml10">
										
										<label class="w100 fl control-label lh20">状态:</label>
										<select class="select2 w100 fl ml10">
										  <option value="AL">未通过</option>
										  <option value="WY">已通过</option>
										</select>
                                       
                                       <div class="cb"></div>
									</div>
                                    
                                   
                                    
								</div>
								
								<div class="pull-right mt-30">
									<button type="button" class="btn btn-primary btn-sm">查询</button>    
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
                    </div><!-- contentpanel -->
		</div>
	</div>
</section>
<script src="/js/custom/custom.js"></script>
<script>
	(function(){
     	var queryParams = function(params){
			return {
				pageSize: params.limit,
				pageNo: params.offset/10 + 1,
			};
		}; 
        $("#table").bootstrapTable('destroy', null);
        $("#table").bootstrapTable({
            method : 'get',
		    url : '/Dorder/index.htm',
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
                field : 'order_id',
                title : '产品ID',
                align : 'left',
                valign : 'bottom',
                sortable : true
            }, {
                field : 'goods_name',
                title : '产品名称',
                align : 'left',
                valign : 'middle',
                sortable : true
            },  {
                field : 'member_name',
                title : '顾客',
                align : 'left',
                valign : 'middle',
                sortable : true
            },  {
                field : 'store_name',
                title : '商家',
                align : 'left',
                valign : 'middle',
                sortable : true
            },  {
                field : 'finnshed_time',
                title : '订购时间',
                align : 'left',
                valign : 'middle',
                sortable : true
            },   {
                field : 'Delay_time',
                title : '验证时间',
                align : 'left',
                valign : 'middle',
                sortable : true
            }, {
                field : 'Final_payment',
                title : '未支付余款',
                align : 'left',
                valign : 'top',
                sortable : true,
            },{
                field : '',
                title : '管理操作',
                align : 'left',
                valign : 'top',
                sortable : true,
            }]
        });
	})();
</script>
</body>
</html>