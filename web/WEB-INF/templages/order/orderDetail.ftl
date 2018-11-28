<#include "../head.ftl"/>
<style>
.table  tbody tr:first-child td{width:25%;}
</style>
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
                                <h4>订单详情</h4>
                            </div>
                        </div><!-- media -->
                    </div><!-- pageheader -->
                    
                    <div class="contentpanel">
                        <div class="alert alert-info">
                            <button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
                            <strong>说明：</strong>查看订单详情及消费券使用情况
                        </div>
                         <div class="panel panel-default">
                           <div class="panel-heading">
	                           	<div class="row">
	                           	</div>
                            </div><!-- panel-heading -->
                            <form>
                            <div class="panel-body">
                                <div class="column">
                                	<!--基本信息-->
	                               <table class="table table-striped table-bordered table-hover table-condensed">
	                               		<caption>基本信息</caption>
	                               		<tbody>
	                               			<tr>
	                               				<td class="td">订单号</td>
	                               				<td>${res.order.orderSn !''}</td>
	                               				<td class="td">产品名称</td>
	                               				<td>${res.order.goodsName !''}</td>
	                               			</tr>
	                               			<tr>
	                               				<td>下单会员</td>
	                               				<td>${res.order.memberName !''}</td>
	                               				<td>商家 </td>
	                               				<td>${res.order.storeName !''}</td>
	                               			</tr>
	                               			<tr>
	                               				<td>下单会员电话</td>
	                               				<td>
	                               					<#if res.user??>
	                               					${res.user.memberMobile !''}
	                               					</#if>
	                               				</td>
	                               				<td>商家电话</td>
	                               				<td>${res.order.goods.dstore.storePhone !''}</td>
	                               			</tr>
	                               			<tr>
	                               				<td>基础价格</td>
	                               				<td>${res.order.goods.goodsPriceDollar !'0.00'}</td>
	                               				<td>定金</td>
	                               				<td>${res.order.bookDownPaymentDollar !'0.00'}</td>
	                               			</tr>
	                               			<tr>
	                               				<td>会员等级</td>
	                               				<td>
	                               					<#if res.user??>
	                               					VIP${res.user.vipRankId !'0'}
	                               					</#if>
	                               				</td>
	                               				<td>会员价格</td>
	                               				<td>${res.order.orderAmountDollar !'0.00'}</td>
	                               			</tr>
	                               		</tbody>
	                               </table>
	                               
	                               <!--活动信息-->
	                               <table class="table table-striped table-bordered table-hover table-condensed">
	                           		<caption>活动信息</caption>
	                           		<tbody>
	                           			<tr>
	                           				<td class="td">使用红包</td>
	                           				<td><#if res.dis ??>${res.dis.name !''}</#if></td>
	                           				<td class="td">红包金额</td>
	                           				<td><#if res.dis ??>${res.dis.moneyDollar !'0.00'}</#if></td>
	                           			</tr>
	                           		</tbody>
	                           	   </table>
	                           	   
	                           	   <!--订购信息-->
	                           	   <table class="table table-striped table-bordered table-hover table-condensed">
	                           		<caption>订购信息</caption>
	                           		<tbody>
	                           			<tr>
	                           				<td class="td">订单生成时间</td>
	                           				<td>${res.order.addTimeStr !''}</td>
	                           				<td class="td">定金支付时间</td>
	                           				<td>${res.order.paymentTimeStr !''}</td>
	                           			</tr>
	                           			<tr>
	                           				<td>定金支付方式</td>
	                           				<td>${res.order.paymentCode !'储值支付'}</td>
	                           				<td>实际支付定金</td>
                           					<td>${res.realBDP ! '0.00'}</td> 
	                           			</tr>
	                           			<tr>
	                           				<td>订单状态</td>
	                           				<td>${res.order.orderState !''}</td>
	                           				<td>支付流水号</td>
	                           				<td>${res.order.paySn !''}</td>
	                           			</tr>
	                           		</tbody>
	                           	   </table>
                                	<!--验证信息-->
                                    <table class="table table-striped table-bordered table-hover table-condensed">
                                    	<caption>验证信息</caption>
		                           		<tbody>
		                           			<tr>
		                           				<td class="td">消费券</td>
		                           				<td>${res.order.consumptionCode !''}</td>
		                           				<td class="td">过期时间</td>
		                           				<td>${res.order.delayTimeStr !''}</td>
		                           			</tr>
		                           			<tr>
		                           				<td>验证时间</td>
		                           				<td>${res.order.finnshedTimeStr !''}</td>
		                           				<td>余款</td>
		                           				<td>${res.order.bookFinalPaymentDollar !'0.00'}</td>
		                           			</tr>
		                           			<tr>
		                           				<td>余款支付状态</td>
		                           				<td><#if res.order.orderState lt 4>未支付<#else>已支付</#if></td>
		                           				<td>余款支付时间</td>
		                           				<td>${res.order.verifyConsumptionTimeStr !''}</td>
		                           			</tr>
		                           			<tr>
		                           				<td>余款支付方式</td>
		                           				<td>${res.order.paymentCode !'储值支付'}</td>
		                           				<td>支付流水号</td>
		                           				<td>${res.order.paySn !''}</td>
		                           			</tr>
		                           		</tbody>
                                    </table>
                                    
                                    
                                    
                                    <!-- 顾客要求-->
                                    <table class="table table-striped table-bordered table-hover table-condensed">
                                    	<caption>顾客要求</caption>
		                           		<tbody>
		                           			<tr>
		                           				<td class="td">姓名</td>
		                           				<td>${res.order.mTrueName !''}</td>
		                           				<td class="td">电话</td>
		                           				<td>${res.order.mMobile !''}</td>
		                           			</tr>
		                           			<tr>
		                           				<td>服务日期</td>
		                           				<td>${res.order.mDate !''}</td>
		                           				<td>服务时间</td>
		                           				<td></td>
		                           			</tr>
		                           			<tr>
		                           				<td>上门地址</td>
		                           				<td>${res.order.mAddress !''}</td>
		                           				<td>留言</td>
		                           				<td colspan="3"></td>
		                           			</tr>
		                           		</tbody>
                                    </table>
                                    
                                    <!--管理备注 -->
                                    <table class="table table-striped table-bordered table-hover table-condensed">
                                    	<tbody>
                                    		<caption>订单备注</caption>
                                    		<tr>
	                                    		<td align="center" style="padding-top:4%">订单备注：</td>
	                                    		<input type="hidden" name="id" value="${res.order.orderId !''}">
	                                    		<td><textarea class="form-control" rows="3" name="remark">${res.order.remark !''}</textarea></td>
	                                    		<td align="center" style="padding-top:4%"><button type="button" class="btn btn-primary disabled" onclick="save()">保存</button></td>
                                    		</tr>
                                    	</tbody>
                                    </table>
                                    <table class="table table-striped table-bordered table-hover table-condensed">
                                    	<tbody>
                                    		<caption><button type="button" class="btn btn-primary" onclick="window.history.go(-1);">返回</button></caption>
                                    	</tbody>
                                    </table>
                                </div><!-- row -->
                            </div><!-- panel-body -->
                            </form>
                        </div>
                    </div><!-- contentpanel -->
                    
                </div><!-- mainpanel -->
            </div><!-- mainwrapper -->
        </section>
        <script>
        	$(function(){
        		
        		var r = $('.table:eq(2)').find('tr:last').find('td:eq(1)').text();
        		r = judgeState(Number(r));
        		$('.table:eq(2)').find('tr:last').find('td:eq(1)').text(r);	
        		$('.form-control').bind('input propertychange',function(){
        			var text = $(this).val();
        			if(text != null && text !='' && text !='undefined'){
        				$(this).parent().next().find('button').removeClass('disabled');
        			}
        		});
        	});
        	function save(){
        		$.ajax({
        			url:'/order/update_order.ajax',
        			data:$('form').serialize(),
        			type:'post',
        			dataType:'json',
        			success:function(json){
        				if(json.state){
        					if(confirm(json.message)){
        						window.location.reload();
        					}
        				}else{
        					alert(json.message);
        				}
        			},error:function(){
        				alert('系统繁忙，请稍候再试。。。');
        			}
        		});
        	}
        </script>
    </body>
</html>