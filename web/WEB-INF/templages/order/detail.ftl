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
                                    <li>订单管理</li>
                                </ul>
                                <h4>处理退款申请</h4>
                            </div>
                        </div><!-- media -->
                    </div><!-- pageheader -->
                    
                    <div class="contentpanel">
                        <div class="alert alert-info">
                            <button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
                            <strong>说明：</strong>未验证的订单申请退款，审核通过后定金退至储值账户
                        </div>
                         
                       <div class="alert-success text-center">
							订单信息
					   </div>
                        
                       <div class="panel-body">
                            <div class="form-group">
                                <label class="col-sm-3 control-label">产品名称</label>
                                <label class="col-sm-3 control-label">${jsonData.refund.order.goodsName !''}</label>
                                <label class="col-sm-3 control-label">订单ID</label>
                                <label class="col-sm-3 control-label">${jsonData.refund.order.orderSn !''}</label>
                            </div><!-- form-group -->
		                            
                            <div class="form-group">
                                <label class="col-sm-3 control-label">顾客姓名</label>
                                <label class="col-sm-3 control-label">${jsonData.refund.order.memberName !''}</label>
                                <label class="col-sm-3 control-label">商家名称</label>
                                <label class="col-sm-3 control-label">${jsonData.refund.order.storeName !''}</label>
                            </div><!-- form-group -->		    
                            
                           <div class="form-group">
                                <label class="col-sm-3 control-label">顾客电话</label>
                                <label class="col-sm-3 control-label">${jsonData.memberMobile !''}</label>
                                <label class="col-sm-3 control-label">商家电话</label>
                                <label class="col-sm-3 control-label">${jsonData.storePhone !''}</label>
                            </div><!-- form-group -->	
		                           
                            <div class="form-group">
                                <label class="col-sm-3 control-label">支付时间</label>
                                <label class="col-sm-3 control-label">${jsonData.refund.order.paymentTimeStr !''}</label>
                                <label class="col-sm-3 control-label">实付金额（元）</label>
                                <label class="col-sm-3 control-label">${jsonData.refund.order.pdAmountDollar !''}</label>
                            </div><!-- form-group -->	
		                            
                            <div class="form-group">
                                <label class="col-sm-3 control-label">订单状态</label>
                                <#if jsonData.refund.order.orderState  == 1>
                                	<label class="col-sm-3 control-label" id="orderState">未付款</label>
                                <#elseif jsonData.refund.order.orderState == 2>
                                	<label class="col-sm-3 control-label" id="orderState">未消费</label>
                                <#elseif jsonData.refund.order.orderState == 3>
                                	<label class="col-sm-3 control-label" id="orderState">待评价未付余款</label>
                                <#elseif jsonData.refund.order.orderState == 4>
                                	<label class="col-sm-3 control-label" id="orderState">待评价已付余款</label>
                                <#elseif jsonData.refund.order.orderState == 5>
                                	<label class="col-sm-3 control-label" id="orderState">已评价</label>
                                <#elseif jsonData.refund.order.orderState == 6>
                                	<label class="col-sm-3 control-label" id="orderState">已取消</label>
                                <#elseif jsonData.refund.order.orderState == 7>
                                	<label class="col-sm-3 control-label" id="orderState">退款中</label>
                                <#elseif jsonData.refund.order.orderState == 8>
                                	<label class="col-sm-3 control-label" id="orderState">已退款</label>
                                <#elseif jsonData.refund.order.orderState == 9>
                                	<label class="col-sm-3 control-label" id="orderState">退款已拒绝</label>
                                <#elseif jsonData.refund.order.orderState == 10>
                                	<label class="col-sm-3 control-label" id="orderState">投诉处理中</label>
                                <#elseif jsonData.refund.order.orderState == 11>
                                	<label class="col-sm-3 control-label" id="orderState">投诉已解决</label>
                                <#elseif jsonData.refund.order.orderState == 12>
                                	<label class="col-sm-3 control-label" id="orderState">已过期</label>
                                <#else>
                                	<label class="col-sm-3 control-label" id="orderState">错误状态，请联系管理员</label>
                                </#if>
                                <label class="col-sm-3 control-label">申请时间</label>
                                <label class="col-sm-3 control-label">${jsonData.refund.createTimeStr !''}</label>
                            </div><!-- form-group -->	
                            <div class="form-group">
                                <label class="col-sm-3 control-label">退款人</label>
                                <label class="col-sm-3 control-label">${jsonData.refund.updateBy !''}</label>
                                <label class="col-sm-3 control-label">退款时间</label>
                                <label class="col-sm-3 control-label">${jsonData.refund.updateTimeStr !''}</label>
                            </div><!-- form-group -->		                            		                                                   
		                </div><!-- panel-body -->
                        
	                    <form class="form-horizontal form-bordered">
	                        <div class="alert-success text-center">
								申请详情
							</div>
	                        <div class="panel-body">
	                            <div class="form-group">
	                                <label class="col-sm-3 control-label">申请时间</label>
	                                <label class="col-sm-7 control-label">${jsonData.refund.createTimeStr !''}</label>
	                            </div><!-- form-group -->
	    
	    						<div class="form-group">
	                                <label class="col-sm-3 control-label">申请理由</label>
	                                <label class="col-sm-7 control-label">${jsonData.refund.reason !''}</label>
	                            </div><!-- form-group -->
		                     <hr>
		                    </div><!-- panel-body -->
		                    
		                    <div class="alert-success text-center">
								处理详情
							</div>
                            <div class="form-group" id="refundForm">
                                <label class="col-sm-3 control-label" for="readonlyinput">审核</label>
                                	<span><input type="radio" name="refund" value="refuse" checked >拒绝退款</span>
                                	<a id="saveBtnRefuse" class="btn btn-primary btn-xs">拒绝退款</a><br>
                                	<span><input type="radio" name="refund" value="agree">同意退款</span>
                                	<span><input type="text" id="refundValue" value="${jsonData.refund.order.refundAmountDollar !''}" >元（${jsonData.refund.order.pdAmountDollar !''}元以内）</span>
                                	<p class="center">
                                		（同意后自动退款至储值账户，请务必确认该订单款未验证消费！）
                                		<a id="saveBtn1" class="btn btn-primary btn-xs">同意退款</a>
                                	</p>                                	
                                	<br>
                                <label class="col-sm-7 control-label"></label>
                            </div><!-- form-group -->
                            <div class="form-group">
                                <label class="col-sm-3 control-label">备注</label>
                                 <div class="col-sm-7">
                               		<textarea class="form-control input-sm" rows="3" id="remark">${jsonData.refund.remark !''}</textarea>
                            	</div>
                            </div><!-- form-group -->
                            <div class="center">
                            	<button id="saveBtn2" class="btn btn-primary btn-xs">保存</button>
                            	<button id="goback" class="btn btn-primary btn-xs">返回</button>
                            </div>
                     		<hr>
	                    </div><!-- panel-body -->
	         		  </form>    
	                    
                    </div><!-- contentpanel -->
                    
                </div><!-- mainpanel -->
            </div><!-- mainwrapper -->
        </section>
        
			<script>
					var checkedValue = function(){
						var vals = $('input[name="refund"]:checked').val();
						if(vals == 'refuse'){
							$("#refundValue").val('');
							$("#refundValue").attr("disabled","disabled");
							$("#saveBtn1").attr("disabled","disabled");
							$("#saveBtnRefuse").removeAttr("disabled");
						}else{
							$("#refundValue").removeAttr("disabled");
							$("#saveBtn1").removeAttr("disabled");
							$("#saveBtnRefuse").attr("disabled","disabled");
						}
					}
				
			
			
		            jQuery(document).ready(function(){
		            	
		            	checkedValue();
						$("#refundValue").val("${jsonData.refund.order.refundAmountDollar !''}");
		            	$('input[name="refund"]').on('click',function(){
		            		checkedValue();
		            	});
		            
						if("${jsonData.refund.status}"!="handling"){
								$("input[name='refund']").attr("disabled","disabled");
								$("#refundValue").attr("disabled","disabled");
								$("#saveBtn1").remove();
								$("#saveBtnRefuse").remove();
								if("${jsonData.refund.status}"=="handled"){
									$("input[value='agree']").attr("checked","checked");
								}else{
									$("input[value='refuse']").attr("checked","checked");
								}
						}
		              
		              
		              $('#refundValue').on('input',function(e){
		              		var refund = '${jsonData.refund.order.pdAmountDollar !''}';
		              		var value = $(this).val();
		              		if(parseFloat(value) > parseFloat(refund)){
		              		//	alert('对不起，你只能退款'+refund+'元');
		              			$(this).val(refund);
		              		}
		              });
		              
		              $("#goback").click(function(){
		               		document.location.assign('/dorder/dorder1.htm');
		               		return false;
		               })
		              
		              $("#saveBtn1").click(function(){
			              if($("#refundValue").val() == '')
			              {
			              	alert("请填写退款金额");
			              	return false;
			              }
		              	var params = {
			              	orderId: '${jsonData.refund.orderId !''}',
			              	refund: $("input[name='refund']:checked").val(),
			              	refundValue: $("#refundValue").val()
			              };
			              $.ajax({
								url: '/dorder/updateState.ajax' ,
								type: 'POST',
								data: {map: JSON.stringify(params)} ,
								dataType: 'json',
								success:function(result){
									if(result.state > 0){
										bootbox.alert("保存成功");
										window.location.reload();
									}else{
										bootbox.alert("保存失败");
									}
								},
								error: function(){
									bootbox.alert("网络忙，请稍后重试！");
								}
						 });
						 return false;
		              });
		              
		              <!--拒绝退款-->
		              $("#saveBtnRefuse").click(function(){
		              	var params = {
			              	orderId: '${jsonData.refund.orderId !''}',
			              	refund: $("input[name='refund']:checked").val()
			              };
			              $.ajax({
								url: '/dorder/updateState.ajax' ,
								type: 'POST',
								data: {map: JSON.stringify(params)} ,
								dataType: 'json',
								success:function(result){
									if(result.state > 0){
										bootbox.alert("保存成功");
										window.location.reload();
									}else{
										bootbox.alert("保存失败");
									}
								},
								error: function(){
									bootbox.alert("网络忙，请稍后重试！");
								}
						 });
						 return false;
		              });
		              
		              $("#saveBtn2").click(function(){
		              	var params = {
			              	orderId: '${orderId}',
			              	remark: $("#remark").val()
			              };
			              $.ajax({
								url: '/dorder/updateRemark.ajax' ,
								type: 'POST',
								data: {map: JSON.stringify(params)} ,
								dataType: 'json',
								success:function(result){
									if(result.state > 0){
										bootbox.alert("保存成功");
									}else{
										bootbox.alert("保存失败");
									}
								},
								error: function(){
									bootbox.alert("网络忙，请稍后重试！");
								}
						 });
						 return false;
		              });
		              
		            });
	            </script>
    </body>
</html>