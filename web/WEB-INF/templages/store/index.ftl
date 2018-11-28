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
                                    <li>商家管理</li>
                                </ul>
                                <h4>商家管理</h4>
                            </div>
                        </div><!-- media -->
                    </div><!-- pageheader -->
                    
                    <div class="contentpanel">
                        <div class="alert alert-info">
                            <button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
                            <strong>说明：</strong>商家列表，总销售额为商家已完成订单基础价格之和，总结算金额为商家结算单金额之和
                        </div>
                         <div class="panel panel-default">
                           <div class="panel-heading">
	                        <form id="from-data">
                                <div class="form-horizontal cb pt5">
                                    <div class="form-line">
                                        <select class="select2 w100 fl" name="typeName">
                                          <option value="storeId">商家ID</option>
                                          <option value="storeName">商家名称</option>
                                        </select>
                                        <input type="text" placeholder="" class="form-control input-sm w160 fl ml10" name="typeValue">
                                        
                                        <label class="w100 fl control-label lh20">排序</label>
                                        <select class="select2 w100 fl ml10" name="orderBy" style="width:150px;">
                                          <option value="store_id">商家Id最大</option>
                                          <option value="amount">总交易额最大</option>
                                        </select>
                                        <div class="cb"></div>
                                    </div>
                                </div>
                                <input type="hidden" name="limit" value="10">
                                <input type="hidden" name="offset" value="1">
                                </form>
                                <div class="pull-right mt-30">
                                    <button type="button" class="btn btn-primary btn-sm" id="serach" onclick="returnList();">查询</button>    
                                    <button type="button" class="btn btn-primary btn-sm" onclick="dataReset();">清空</button>
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
            $(function(){
            	returnList();
				$("#exportBtn").click(function(){
					var data = $('#table').bootstrapTable('getData');
					if(data.length > 0){
						$(".bootstrap-table .export .dropdown-menu > li[data-type='excel']").click();					
					}else{
						bootbox.alert("没有数据可以导出!");
					}
				});			            	
            	$('.delete').live('click',function(){
            		var url = $(this).attr('url');
            		if(confirm('确定要删除吗？')){
            			$.get(url,function(json){
	            			if(json.state){
	            				alert(json.message);
	            			}else{
	            				alert(json.message);
	            			}
	            			window.location.reload();
            			},'json');
            		}
            	});
            	$('.normal').live('click',function(){
            		var url = $(this).attr('url');
            		if(confirm('确定要恢复吗？')){
            			$.get(url,function(json){
	            			if(json.state){
	            				alert(json.message);
	            			}else{
	            				alert(json.message);
	            			}
	            			window.location.reload();
            			},'json');
            		}
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
	                url : '/store/index.ajax',
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
                        field : 'store_id',
                        title : '商家ID',
                        align : 'left',
                        valign : 'bottom',
                    },{
                        field : 'store_name',
                        title : '商家名称',
                        align : 'left',
                        valign : 'middle',
                    },
                     {
                        field : 'goods_sum',
                        title : '产品数',
                        align : 'left',
                        valign : 'top',
                        formatter:function(value,row,index){
                        	if(value != null && value !='' && value !='undefined'){
                        		return value;
                        	}else{
                        		return 0;
                        	}
                        }
                    }, {
                        field : 'goods_num',
                        title : '成功订单',
                        align : 'left',
                        valign : 'top',
                        formatter:function(value,row,index){
                        	if(value != null && value !='' && value !='undefined'){
                        		return value;
                        	}else{
                        		return 0;
                        	}
                        }
                    },{
                        field : 'amount',
                        title : '总销售额',
                        align : 'left',
                        valign : 'top',
                        sortable : true,
                        formatter:function(value,row,index){
                        	return moneyFormat(value);
                        }
                    },{
                        field : 'clear_fees',
                        title : '总结算金额',
                        align : 'left',
                        valign : 'top',
                        sortable : true,
                        formatter:function(value,row,index){
                        	return moneyFormat(value);
                        }
                    },{
                        field : 'status',
                        title : '状态',
                        align : 'left',
                        valign : 'top',
                        sortable : true,
                        formatter:function(value,row,index){
                        	if(value == "normal"){
                        		return "正常";
                        	}else{
                        		return "删除";
                        	}
                        }
                    },{
                        field : 'store_id',
                        title : '订单操作',
                        align : 'center',
                        valign : 'top',
                        formatter: function(value, row, index){
                        	var status = '';
                        	if(row.status == "normal"){
                        		status = '<a href="javascript:;" url="/store/delete/'+value+'.ajax?type=delete" class="delete">删除</a>';
                        	}else{
                        		status = '<a href="javascript:;" url="/store/normal/'+value+'.ajax?type=normal" class="normal">恢复</a>';
                        	}
                            return '<a href="/store/edit.htm?storeId='+value+'">编辑</a>/'+status;    
                        }
                    },]
                });
            }
        </script>
    </body>
</html>