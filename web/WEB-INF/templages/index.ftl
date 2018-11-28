<#include "head.ftl"/>
<section>
	<div class="mainwrapper">
	<#include "leftnav.ftl"/>
		<div class="mainpanel">
			<div class="pageheader">
                        <div class="media">
                            <div class="pageicon pull-left">
                                <i class="fa fa-home"></i>
                            </div>
                            <div class="media-body">
                                <ul class="breadcrumb">
                                    <li><a href=""><i class="glyphicon glyphicon-home"></i></a></li>
                                    <li>首页</li>
                                </ul>
                                <h4>首页</h4>
                            </div>
                        </div><!-- media -->
             </div><!-- pageheader -->
             <div class="contentpanel" id="content" name="content">
                         <div class="alert alert-info">
                            <button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
                            <strong>说明：</strong>查看平台基础情况及待处理事项
                        </div>
                         <div class="panel panel-default">
                            <div class="panel-heading"> <div>待处理事项</div>
                            </div>
                        </div>                        
                        <div class="row row-stat">
                            <div class="col-md-4">
                                <div class="panel panel-success-alt noborder">
                                    <div class="panel-heading noborder">
                                        <div class="panel-btns" style="display: none;">
                                            <a href="" class="panel-close tooltips" data-toggle="tooltip" title="" data-original-title="Close Panel"><i class="fa fa-times"></i></a>
                                        </div><!-- panel-btns -->
                                        <div class="panel-icon"><i class="fa fa-dollar"></i></div>
                                        <div class="media-body crp">
                                            <h5 class="md-title nomargin">新订单</h5>
                                            <h1 class="mt5" id="newOrder">0</h1>
                                        </div><!-- media-body -->
                                        <hr>
                                        <div class="clearfix mt20">
                                            <div class="pull-left crp">
                                                <h5 class="md-title nomargin">退款订单</h5>
                                                <h4 class="nomargin" id="refund">0</h4>
                                            </div>
                                            <div class="pull-right crp">
                                                <h5 class="md-title nomargin crp">投诉订单</h5>
                                                <h4 class="nomargin" id="complain">0</h4>
                                            </div>
                                        </div>
                                        
                                    </div><!-- panel-body -->
                                </div><!-- panel -->
                            </div><!-- col-md-4 -->
                            
                            <div class="col-md-4">
                                <div class="panel panel-primary noborder">
                                    <div class="panel-heading noborder">
                                        <div class="panel-btns">
                                            <a href="" class="panel-close tooltips" data-toggle="tooltip" title="" data-original-title="Close Panel"><i class="fa fa-times"></i></a>
                                        </div><!-- panel-btns -->
                                        <div class="panel-icon"><i class="fa fa-users"></i></div>
                                        <div class="media-body crp">
                                            <h5 class="md-title nomargin">商家结算</h5>
                                            <h1 class="mt5" id="storeClear">0</h1>
                                        </div><!-- media-body -->
                                        <hr>
                                        <div class="clearfix mt20">
                                            <div class="pull-left crp">
                                                <h5 class="md-title nomargin">余款提现</h5>
                                                <h4 class="nomargin" id="kiting">0</h4>
                                            </div>
                                            <div class="pull-right">
                                                <h5 class="md-title nomargin"></h5>
                                                <h4 class="nomargin"></h4>
                                            </div>
                                        </div>
                                        
                                    </div><!-- panel-body -->
                                </div><!-- panel -->
                            </div><!-- col-md-4 -->
                            
                            <div class="col-md-4">
                                <div class="panel panel-dark noborder">
                                    <div class="panel-heading noborder">
                                        <div class="panel-btns">
                                            <a href="" class="panel-close tooltips" data-toggle="tooltip" data-placement="left" title="" data-original-title="Close Panel"><i class="fa fa-times"></i></a>
                                        </div><!-- panel-btns -->
                                        <div class="panel-icon"><i class="fa fa-pencil"></i></div>
                                        <div class="media-body crp">
                                            <h5 class="md-title nomargin">商家审核</h5>
                                            <h1 class="mt5" id="storeExamine">0</h1>
                                        </div><!-- media-body -->
                                        <hr>
                                        <div class="clearfix mt20">
                                            <div class="pull-left crp">
                                                <h5 class="md-title nomargin">活动审核</h5>
                                                <h4 class="nomargin" id="eventExamine">0</h4>
                                            </div>
                                            <div class="pull-right crp">
                                                <h5 class="md-title nomargin">融耀达人审核</h5>
                                                <h4 class="nomargin" id="topmanExamine">0</h4>
                                            </div>
                                        </div>
                                        
                                    </div><!-- panel-body -->
                                </div><!-- panel -->
                            </div><!-- col-md-4 -->
                        </div><!-- row -->
                         <div class="panel panel-default">
                            <div class="panel-heading"> <div>业务概述</div>
                            </div>
                        </div>
                        
                    </div><!-- contentpanel -->
                    
		</div>
	</div>
</section>
<script>
		var fillData = function(json){
			$("#newOrder").html(0);
			$("#refund").html(json.refund);
			$("#complain").html(json.complain);
			$("#storeClear").html(json.storeClear);
			$("#kiting").html(json.kiting);
			$("#storeExamine").html(json.storeExamine);
			$("#eventExamine").html(json.eventExamine);
			$("#topmanExamine").html(json.topmanExamine);
		}
		
		$(document).ready(function(){
	            $("#newOrder").parent().click(function(){
	            	window.location.assign("/order/index.htm");
	            });
	            $("#refund").parent().click(function(){
	            	window.location.assign("/dorder/dorder1.htm?status='handling'");
	            });
	            $("#complain").parent().click(function(){
	            	window.location.assign("/complain/index.htm?status='handling'");
	            });
	            $("#storeClear").parent().click(function(){
	            	window.location.assign("/kiting/storeClearTicketMana.htm?state=2");
	            });
	            $("#kiting").parent().click(function(){
	            	window.location.assign("/kiting/list.htm?status='AUDIT'");
	            });
	            $("#storeExamine").parent().click(function(){
	            	window.location.assign("/store/auditIndex.htm?state=2");
	            });
	            $("#eventExamine").parent().click(function(){
	            	window.location.assign("/event/examine.htm?status='passing'");
	            });
	            $("#topmanExamine").parent().click(function(){
	            	window.location.assign("/topman/list.htm?status='examining'");
	            });
	            
	            $.ajax({
	                url: '/indexQuery.ajax' ,
	                type: 'POST',
	                dataType: 'json',
	                success: function(json){
	                	fillData(json);
	                } ,
	                error: function(){
	                	console.log("error");
	                }
	            });
	            
		});
</script>
</body>
</html>

    


