<#include "../head.ftl"/>
<script src="../js/bootbox/bootbox.min.js"></script>
<script src="../js/bootstrap-table/bootstrap-table-export.js"></script>
<script src="../js/bootstrap-table/tableExport.js"></script>
<script src="/js/yxPublic.js"></script>
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
                                    <li>财务管理</li>
                                </ul>
                                <h4>处理私人健康师结算</h4>
                            </div>
                        </div><!-- media -->
                    </div><!-- pageheader -->
                    
                    <div class="contentpanel">
                        <div class="alert alert-info">
                            <button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
                            <strong>说明：</strong>点击结算按钮结算所有未结算资金，请在线下支付成功后确认结算！
                        </div>
                         <div class="panel panel-default">
                           <div class="panel-heading">
	                        	 <table class="table table-striped table-bordered table-hover table-condensed">
	                               		<caption>结算</caption>
	                               		<div class="pull-right mt-35">
	                               			<button type="button" class="btn btn-primary btn-sm" id="reward">结算</button>
	                               		</div>
	                               		<tbody>
	                               			<tr>
	                               				<td>私人健康师ID</td>
	                               				<td>${techie.techieId !''}</td>
	                               				<td>已结算资金</td>
	                               				<td>${(techie.yjsAmount/100) !'0'?string('0.00')}</td>
	                               			</tr>
	                               			<tr>
	                               				<td>私人健康师</td>
	                               				<td class="name">${techie.techieName !''}</td>
	                               				<td>未结算资金</td>
	                               				<td class="money">${(techie.wjsAmount/100)!'0'?string('0.00')}</td>
	                               			</tr>
	                               			<#if (wjsAmount??) && (techie.wjsAmount??) && ( wjsAmount != techie.wjsAmount)>
	                               			<tr>
	                               				<td colspan="2" style="color:red;text-align:right;">*未结算资金与实际清单总额(￥${(wjsAmount/100)!'0'?string('0.00')})不符</td>
	                               				<td>未结算资金</td>
	                               				<td class="money"><input type="text" class="actualAmount" value="${(techie.wjsAmount/100)!'0'?string('0.00')}" onkeyup="value=value.replace(/[^\-?\d.]/g,'')"><span style="color:red;text-align:right;">实际结算金额</span></td>
	                               			</tr>
	                               			</#if>
	                               			<input type="hidden" id="actualAmount" value="${(techie.wjsAmount/100)!'0'?string('0.00')}"
	                               		</tbody>
	                             </table>
                            </div><!-- panel-heading -->
                            <div class="panel-body">
                            
                            	<form id="from-data">
                                <div class="form-horizontal cb pt5">
                                    <div class="form-line">
                                    	<input type="hidden" name="techieId" value="${techie.techieId !''}">
                                    	<label class="w100 fl control-label lh20">收益类型：</label>
                                        <select class="select2 w100 fl ml10" name="rewardStatus">
                                          <option value="">请选择</option>
                                          <option value="allowinvite">邀请注册</option>
                                          <option value="reward">打赏</option>
                                        </select>
                                         <select class="select2 w100 fl ml10" name="typeName">
                                          <option value="created_time">打赏时间</option>
                                          <option value="clearing_time">结算时间</option>
                                        </select>
                                        <label class="w50 fl control-label lh20 ml15">开始：</label>
                                        <input type="text" placeholder="" class="datepicker input-sm form-control w160 fl ml10" name="start">
                                        <label class="w50 fl control-label lh20 ml15">结束：</label>
                                        <input type="text" placeholder="" class="datepicker input-sm form-control w160 fl ml10" name="end">
                                        <div class="cb"></div>
                                    </div>
                                    <div class="form-line mt10">
                                    	<label class="w100 fl control-label lh20">结算状态：</label>
                                        <select class="select2 w160 fl ml10" name="isClearing">
                                          <option value="">请选择</option>
                                          <option value="0">未结算</option>
                                          <option value="1">已结算</option>
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
			            <h4 class="modal-title" id="myModalLabel">确认结算</h4>
			         </div>
			         <input type="hidden" name="id" value="">
			         <div class="modal-body">
			         </div>
			         <div class="modal-footer">
			            <button type="button" class="btn btn-primary confirm">确定</button>
			            <button type="button" class="btn btn-default cancel">取消</button>
			         </div>
			      </div><!-- /.modal-content -->
			</div><!-- /.modal -->
        </section>
        <script>
            $(function(){
            	returnList();
            	
            	$(".actualAmount").bind('input propertychange',function(){
					var money = $(this).val();
					if(check(money)){
						if(checkFloat(money,$(this))){
							money = $(this).val();
							$("#actualAmount").val(money);
						}else{
							$(this).val('');
						}
					}else{
						$(this).val('');
					}
					
				});
            	
				$("#exportBtn").click(function(){
					$(".bootstrap-table .export .dropdown-menu > li[data-type='excel']").click();
				});
				
				$('#reward').click(function(){
					var name = $('.name').text();
					var money = $("#actualAmount").val();
					if(money != null && money != '' && money != 'undefined' && parseFloat(money) > 0){
						var text = '确定要结算'+name+'未结算资金'+money+'元吗？请在线下结算支付成功后再点击确认！';
						$('.modal-body').text(text);
						$('.auditButton').click();
					}else{
						bootbox.alert('对不起，你没有可结算的金额！',function(){
							
						});
					}
				})
				
				$('.cancel').click(function(){
            		$('#myModal').modal('hide');
            	})
            	
            	$('.confirm').click(function(){
            		$('#myModal').modal('hide');
            		var id = $('input[name="techieId"]').val();
            		var money = $("#actualAmount").val();
            		$.ajax({
            			url:'/techie/clearing.ajax',
            			data:{'id':id,'money':money*100},
            			type:'post',
            			dataType:'json',
            			success:function(json){
            				if(json.state){
            					alert(json.message);
            					window.location.reload();
            				}else{
            					alert(json.message);
            				}
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
	                url : '/techie/reward.ajax',
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
                        field : 'rewardStatus',
                        title : '收益类型',
                        align : 'left',
                        valign : 'bottom',
                        formatter:function(value,row,index){
                        	if(value != null && value !='' && value !='undefined'){
                        		if(value='reward'){
                        			return '打赏';
                        		}else{
                        			return '邀请注册';
                        		}
                        	}else{
                        		return '-';
                        	}
                        }
                    },{
                        field : 'memberName',
                        title : '顾客',
                        align : 'left',
                        valign : 'middle',
                    },
                     {
                        field : 'moneyDouble',
                        title : '金额',
                        align : 'left',
                        valign : 'top',
                    }, {
                        field : 'createdTime',
                        title : '收益时间',
                        align : 'left',
                        valign : 'top',
                    },{
                        field : 'isClearing',
                        title : '结算状态',
                        align : 'left',
                        valign : 'top',
                        formatter:function(value,row,index){
                        		if(value == 1){
                        			return '已结算';
                        		}else{
                        			return '未结算';
                        		}
                        }
                    }, {
                        field : 'clearingTime',
                        title : '结算时间',
                        align : 'left',
                        valign : 'top',
                    },{
                        field : 'clearingName',
                        title : '结算人',
                        align : 'center',
                        valign : 'top',
                    },]
                });
            }
        </script>
    </body>
</html>