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
                                    <li>订单详情</li>
                                </ul>
                                <h4>处理投诉</h4>
                            </div>
                        </div><!-- media -->
                    </div><!-- pageheader -->
                    
                    <div class="contentpanel">
                        <div class="alert alert-info">
                            <button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
                            <strong>说明：</strong>线上管理订单售后请求，线下协商处理
                        </div>
                         
						
				       <div class="column">
                           <table class="table table-striped table-bordered table-hover table-condensed">
                           		<caption>订单信息</caption>
                           		<tbody>
                           			<tr>
                           				<td class="td">顾客姓名</td>
                           				<td>${order.memberName !''}</td>
                           				<td class="td">顾客电话</td>
                           				<td>${order.mMobile !''}</td>
                           			</tr>
                           			<tr>
                           				<td>商家名称</td>
                           				<td>${order.storeName !''}</td>
                           				<td>商家电话</td>
                           				<td>${store.storePhone !''}</td>
                           			</tr>
                           			<tr>
                           				<td>订单编号</td>
                           				<td>${order.orderSn !''}</td>
                           				<td>订购时间</td>
                           				<td>${order.addTimeStr !''}</td>
                           			</tr>
                           			<tr>
                           				<td>产品名称</td>
                           				<td>${order.goodsName !''}</td>
                           				<td>验证时间</td>
                           				<td>${order.strVerifyConsumptioinTime !''}</td>
                           			</tr>
                           		</tbody>
                           </table>
                        
                        
	                    <form class="form-horizontal form-bordered">
	                    	<table class="table table-striped table-bordered table-hover table-condensed">
                           		<caption>申请详情</caption>
                           		<tbody>
                           			<tr>
                           				<td class="td">申请时间</td>
                           				<td>${complain.createTimeStr !''}</td>
                           			</tr>
                           			<tr>
                           				<td>申请理由</td>
                           				<td>${complain.reason !''}</td>
                           			</tr>
                           			<tr>
                           				<td>回复买家</br>（买家、商家可见）</td>
                           				<td><textarea class="form-control" rows="3" id="reply">${complain.reply !''}</textarea></td>
                           			</tr>
                           		</tbody>
                           </table>
                           
                           <table class="table table-striped table-bordered table-hover table-condensed">
                           		<caption>处理详情</caption>
                           		<tbody>
                           			<tr>
                           				<td class="td">处理详情</td>
                           				<td><textarea class="form-control" rows="3" id="handle">${complain.handle !''}</textarea></td>
                           			</tr>
                           			<tr>
                           				<td>投诉状态</td>
                           				<td>
                           					<select id="status" class="select2 w160 fl">
											  	<option value="handling">投诉处理中</option>
											 	<option value="handled">投诉已解决</option>
											</select>
                           				</td>
                           			</tr>
                           			<tr>
                           				<td>投诉解决时间</td>
                           				<td>${complain.updateTimeStr !''}</td>
                           			</tr>
                           			<tr>
                           				<td>备注</td>
                           				<td><textarea class="form-control" rows="3" id="remark">${complain.remark !''}</textarea></td>
                           			</tr>
                           		</tbody>
                           </table>
		                            
		                   <div class="row center"><button id="saveBtn" class="btn btn-primary">保存</button></div>
		                   
	         		  </form>    
	                  </div><!-- column -->
                    </div><!-- contentpanel -->
                    
                </div><!-- mainpanel -->
            </div><!-- mainwrapper -->
        </section>
        
			<script>
		            $(document).ready(function(){
		            	if('${complain.status}'=='handling'){
			            	$("#status").val("handling");
		            	}else{
		            		$("#status").val("handled");
		            		$("#status").select2({minimumResultsForSearch: -1});
		            		$("#status").attr("disabled", true);
		            	}
		              $("#saveBtn").click(function(){
		              	  var params = {
			              	id: '${complain.id !''}',
			              	reply: $("#reply").val(),
			              	handle: $("#handle").val(),
			              	status: $("#status").val(), 
			              	remark: $("#remark").val()
			              };
			              $.ajax({
								url: '/complain/update.ajax' ,
								type: 'POST',
								data: {map: JSON.stringify(params)} ,
								dataType: 'json',
								async: false,
								success: function(json){
									if(json.state == 1){
											bootbox.alert("操作成功，已保存！");
											window.location.assign('/complain/index.htm');
									}else{
											bootbox.alert("操作失败，请重试！");
									}
								} ,
								error: function(){
									bootbox.alert("操作失败，请重试！");
								}
						 });
							return false;
		              });
		            });
	            </script>
    </body>
</html>