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
                                    <li>订单管理</li>
                                </ul>
                                <h4>订单评价</h4>
                            </div>
                        </div><!-- media -->
                    </div><!-- pageheader -->
                    
                    <div class="contentpanel">
                        <div class="alert alert-info">
                            <button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
                            <strong>说明：</strong>评价列表，不适宜展示的评价点击拒绝，拒绝不影响商家最终等级或结算
                        </div>
                         <div class="panel panel-default">
                           <div class="panel-heading">
							<form id="from-data">
                                <div class="form-horizontal cb pt5">
                                    <div class="form-line">
                                        <select class="select2 w100 fl" name="typeName">
                                          <option value="proText">产品名称</option>
                                          <option value="orderSn">订单号</option>
                                          <option value="conName">商家名称</option>
                                          <option value="userName">顾客姓名</option>
                                        </select>
                                        <input type="text" placeholder="" class="form-control input-sm w160 fl ml10" name="typeValue">
                                        <select class="select2 w100 fl lh20" style="margin-left:30px;"> 
                                          <option value="ssss">评价时间</option>
                                        </select>
                                        <label class="w50 fl control-label lh20 ml15">开始</label>
                                        <input type="text" placeholder="" class="datepicker input-sm form-control w160 fl ml10" name="startTime">
                                        <label class="w50 fl control-label lh20 ml15">结束</label>
                                        <input type="text" placeholder="" class="datepicker input-sm form-control w160 fl ml10" name="endTime">
                                        <div class="cb"></div>
                                    </div>
                                    
                                    <div class="form-line mt10">                                        
                                       <label class="w100 fl control-label lh20">评价等级</label>
                                        <select class="select2 w100 fl ml10" name="orderState">
                                          <option value="">请选择</option>
                                          <option value="1">1星</option>
                                          <option value="2">2星</option>
                                          <option value="3">3星</option>
                                          <option value="4">4星</option>
                                          <option value="5">5星</option>
                                        </select>
                                        <label class="w100 fl control-label lh20">评价状态:</label>
                                        <select class="select2 w100 fl ml10" name="orderBy">
                                          <option value="">请选择</option>
                                          <option value="Y">审核通过</option>
                                          <option value="N">审核拒绝</option>
                                        </select>
                                        <div class="cb"></div>
                                    </div>
                                </div>
                                <input type="hidden" name="limit" value="10">
                                <input type="hidden" name="offset" value="1">
                                </form>
                                <div class="pull-right mt-30">
                                    <button type="button" class="btn btn-primary btn-sm" onclick="returnList();">查询</button>    
                                    <button type="button" class="btn btn-primary btn-sm" onclick="dataReset();">清空</button>
                                    <button type="button" class="btn btn-primary btn-sm" id="exportBtn">导出</button>
                                </div>
                            </div><!-- panel-heading -->
                            <div class="panel-body">
                                <div class="row">
                                    <table id="table"  data-show-export="true" >
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
				$('.update').live('click',function(){
					var url = $(this).attr('url');
					bootbox.confirm('是否对此评价进行'+$(this).text()+'操作?',function(result){
						if(result){
							$.get(url,function(json){
								
								if(json.state){
									bootbox.alert(json.message,function(){
										window.location.reload();
									})
								}else{
									bootbox.alert(json.message,function(){
									
									})
								}
							},'json');
						}
					})
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
	                url : '/order/evaluate.ajax',
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
	                    field : 'orderSn',
	                    title : '订单号',
	                    align : 'left',
	                    valign : 'bottom',
	                },
	                 {
	                    field : 'goodsName',
	                    title : '产品名称',
	                    align : 'left',
	                    valign : 'top',
	                },{
	                    field : 'userName',
	                    title : '顾客姓名',
	                    align : 'left',
	                    valign : 'middle',
	                },{
	                    field : 'storeName',
	                    title : '验证商户',
	                    align : 'left',
	                    valign : 'top',
	                },{
	                    field : 'time',
	                    title : '评价时间',
	                    align : 'left',
	                    valign : 'top',
	                    sortable : true,
	                },{
	                    field : 'grade',
	                    title : '评价等级',
	                    align : 'left',
	                    valign : 'top',
	                    formatter: function(value, row, index){
                             return judgeXgrade(value); 
                        }
	                },{
	                    field : 'text',
	                    title : '评价内容',
	                    align : 'left',
	                    valign : 'top',
	                },
	                {
	                    field : 'id',
	                    title : '操作',
	                    align : 'left',
	                    valign : 'top',
	                    formatter: function(value, row, index){
                    		if(row.isShow=='Y'){
                           		return '<a url="/order/update_show/'+value+'/N.ajax" class="update" style="cursor: pointer; ">拒绝</a>';    
                    		}else{
                    			return '<a url="/order/update_show/'+value+'/Y.ajax" class="update" style="cursor: pointer; ">通过</a>';
                    		}
                        }
	                }]
	            });
            }
        </script>
    </body>
</html>