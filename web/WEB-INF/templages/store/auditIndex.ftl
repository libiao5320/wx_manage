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
                                <h4>商家审核</h4>
                            </div>
                        </div><!-- media -->
                    </div><!-- pageheader -->
                    
                    <div class="contentpanel">
                        <div class="alert alert-info">
                            <button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
                            <strong>说明：</strong>审核由B端注册的商家，编辑商家信息确认无误后再审核通过
                        </div>
                         <div class="panel panel-default">
                           <div class="panel-heading">
	                        <form id="from-data">
                                <div class="form-horizontal cb pt5">
                                    <div class="form-line">
                                        <label class="w100 fl control-label lh20">审核状态：</label>
                                        <select class="select2 w100 fl ml10" name="state" style="width:150px;">
                                          <option value="">请选择</option>
                                          <option value="2">待审核</option>
                                          <option value="5">审核拒绝</option>
                                          <option value="4">重新提交</option>
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
            
            
            <!-- 按钮触发模态框 -->
			<button class="btn btn-primary btn-lg auditButton" data-toggle="modal" data-target="#myModal" style="display:none;">
			</button>
            <!-- 模态框（Modal） -->
			<div class="modal fade" id="myModal" tabindex="-1" role="dialog" 
			   aria-labelledby="myModalLabel" aria-hidden="true">
			   <div class="modal-dialog">
			      <div class="modal-content">
			         <div class="modal-header">
			            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
			                  &times;
			            </button>
			            <h4 class="modal-title" id="myModalLabel">审核（弹窗）</h4>
			         </div>
			         <input type="hidden" name="id" value="">
			         <div class="modal-body">
			            	<input type="radio" name="state" value="1">审核通过
			            	<input type="radio" name="state" value="5">审核拒绝
			         </div>
			         <div class="modal-footer">
			            <button type="button" class="btn btn-primary confirm">确定</button>
			            <button type="button" class="btn btn-default cancel">取消</button>
			         </div>
			      </div><!-- /.modal-content -->
			</div><!-- /.modal -->
        </section>
        <script>
        var indexQuery = true;
            $(function(){
            	returnList();
				$("#exportBtn").click(function(){
					$(".bootstrap-table .export .dropdown-menu > li[data-type='excel']").click();
				});			            	
            	$('.delete').live('click',function(){
            		var url = $(this).attr('url');
            		var label = $(this).text();
            		var type = "delete";
            		if(label == "恢复"){
            			type = "normal";
            		}
            		if(confirm('确定要' + label + '吗？')){
            			$.get(url + "?type=" + type,function(json){
	            			if(json.state){
	            				alert(json.message);
	            				window.location.reload();
	            			}else{
	            				alert(json.message);
	            			}
            			},'json');
            		}
            	});
            	
            	$('.audit').live('click',function(){
            		$('input[name="id"]').val($(this).attr('mid'));
            		$('.auditButton').click();
            	});
            	
            	$('.cancel').click(function(){
            		$('#myModal').modal('hide');
            	})
            	
            	$('.confirm').click(function(){
            		$('#myModal').modal('hide');
            		var id = $('input[name="id"]').val();
        			var state = $('input[name="state"]:checked').val();
        			$('input[name="state"]').attr("checked", false);
            		$.ajax({
            			url:'/store/audit.ajax',
            			data:{'id':id,'state':state},
            			type:'post',
            			dataType:'json',
            			success:function(json){
            				if(json.state){
            					bootbox.confirm(json.message,function(reslut){
            						if(reslut){
            							$("#table").bootstrapTable("refresh");
            						}
            					})
            				}else{
            					bootbox.alert(json.message,function(){
            					
            					})
            				}
            			}
            		})
            	});
            });
            var queryParams = function(params){
            	params.offset = params.offset/params.limit + 1;
            	if("${indexState}" != "false" && indexQuery == true){
            		params.state = "${indexState}";
            		indexQuery = false;
            	}else{
            		params.state = $('select[name="state"]').val();
            	} 
            	return params;
            }
            function returnList(){
            	$("#table").bootstrapTable('destroy', null);
                $("#table").bootstrapTable({
                    method : 'get',
	                url : '/store/auditIndex.ajax',
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
                    columns : [
                    {
                        field : 'storeName',
                        title : '商家名称',
                        align : 'left',
                        valign : 'middle',
                    },
                     {
                        field : 'storeTime',
                        title : '注册时间',
                        align : 'left',
                        valign : 'top',
                    }, {
                        field : 'manager.smName',
                        title : '经理姓名',
                        align : 'left',
                        valign : 'top',
                    },{
                        field : 'manager.smPhone',
                        title : '联系电话',
                        align : 'left',
                        valign : 'top',
                        sortable : true,
                    },{
                        field : 'storeAddress',
                        title : '详细地址',
                        align : 'left',
                        valign : 'top',
                        sortable : true,
                    },{
                        field : 'storeState',
                        title : '审核状态',
                        align : 'center',
                        valign : 'top',
                        formatter: function(value, row, index){
                        	if(value=='2'){
                        		return "待审核";
                        	}else if(value == '5'){
                        		return "审核拒绝";
                        	}else if(value =='4'){
                        		return "重新提交";    
                        	}else{
                        		return value;
                        	}
                        }
                    },{
                        field : 'storeId',
                        title : '审核',
                        align : 'center',
                        valign : 'top',
                        formatter: function(value, row, index){
                               return '<a href="javascript:;" mid="'+value+'" class="audit">审核</a>';    
                        }
                    },{
                        field : 'storeId',
                        title : '管理操作',
                        align : 'center',
                        valign : 'top',
                        formatter: function(value, row, index){
                        	   var label = "删除";
                        	   if(row.status == "delete"){
                        	   		label = "恢复";
                        	   }
                               return '<a href="/store/edit.htm?storeId='+value+'">编辑</a>/<a href="javascript:;" url="/store/delete/'+value+'.ajax" class="delete">' + label + '</a>';    
                        }
                    }]
                });
            }
        </script>
    </body>
</html>