<#include "../head.ftl"/>
<script src="../../js/bootbox/bootbox.min.js"></script>
<script src="../../js/jquery-ui-1.10.3/jquery-ui-1.10.3.min.js"></script>
<style>#groupClass{border-radius:3px;border-bottom:1px solid #ddd;} #groupClass li{width: 100%;} #groupClass > li > a{padding:8px 15px;margin-right:0px;border-radius:4px;border-bottom: 1px solid #ddd;}#groupClassContent{padding: 5px 15px;border: none;}#groupClassContent p{margin: 0;}</style>
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
                        <h4>编辑红包</h4>
                    </div>
                </div><!-- media -->
            </div><!-- pageheader -->
            
            <div class="contentpanel">
                <div class="alert alert-info">
                    <button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
                    <strong>说明：</strong>定额红包金额=红包总金额/红包数量；随机红包金额随机发放，但不大于定额红包金额1倍
                </div>
                 <div class="panel panel-default">
                   <div class="panel-heading">
						<div class="form-horizontal cb pt5">
							<h4 class="panel-title">编辑红包信息</h4>
						</div>
                    </div><!-- panel-heading -->
                    <div class="panel-body">
                        <form class="form-horizontal form-bordered" id="form">
                            <div class="form-group">
                                <label class="col-sm-3 control-label">*红包名称：</label>
                                <div class="col-sm-7">
                                    <input type="text" id="name" value="${redpackets.name !''}" name="name" class="form-control input-sm" required>
                                </div>
                            </div><!-- form-group -->
    
                            <div class="form-group">
                                <label class="col-sm-3 control-label" for="readonlyinput">*红包类型：</label>
                                <div class="col-sm-7">
                                   <select id="type" name="type" class="select2 w160 fl" onchange="showSingle(this)">
									  <option value="quota">定额红包</option>
									  <option value="random">随机红包</option>
									  <option value="infinite">无限红包</option>
									</select>
                                </div>
                            </div><!-- form-group -->
                            
                            <div class="form-group">
                                <label class="col-sm-3 control-label" for="readonlyinput">*是否为平台红包：</label>
                                <div class="col-sm-7">
                                   <select id="isBdRed" name="isBdRed" class="select2 w160 fl" onchange="changeSelect(this)">
									  <option value="N">否</option>
									  <option value="Y">是</option>
									</select>
                                </div>
                            </div><!-- form-group -->
                            
                            <div class="form-group">
                                <label class="col-sm-3 control-label" for="readonlyinput">*红包用途：</label>
                                <div class="col-sm-7">
                                   <select id="purpose" class="select2 w160 fl" name="purpose">
									  <option value="hd">活动</option>
									  <option value="fx">分享</option>
									  <option value="zc">注册</option>
									</select>
                                </div>
                            </div><!-- form-group -->
                            
                            <div class="form-group" id="singleAmountForm" style="display:none;">
                                <label class="col-sm-3 control-label" for="readonlyinput">*单个红包金额：</label>
                                <div class="col-sm-7">
                                   <input type="number" id="singleAmount" value="" class="input-sm form-control w160 fl" name="singleAmount"><span class="lh30">元</span>
                                </div>
                            </div><!-- form-group -->
                            
                            <div id="randomDiv" style="display:none;">
                            <div class="form-group">
                                <label class="col-sm-3 control-label" for="readonlyinput">*红包最小金额：</label>
                                <div class="col-sm-7">
                                   <input type="number" id="minAmount" value="0" class="input-sm form-control w160 fl" name="minAmount" required><span class="lh30">元</span>
                                </div>
                            </div><!-- form-group -->
                            
                            <div class="form-group">
                                <label class="col-sm-3 control-label" for="readonlyinput">*红包最大金额：</label>
                                <div class="col-sm-7">
                                   <input type="number" id="maxAmount" value="0" class="input-sm form-control w160 fl" name="maxAmount" required><span class="lh30">元</span>
                                </div>
                            </div><!-- form-group -->
                            </div>
                            
                            <div id="amountForm">
                            <div class="form-group">
                                <label class="col-sm-3 control-label" for="readonlyinput">*红包总金额：</label>
                                <div class="col-sm-7">
                                    <input type="number" id="amount" value="${redpackets.amount !''}" class="input-sm form-control w160 fl" name="amount" required><span class="lh30">元</span>
                                </div>
                            </div><!-- form-group -->
                            
                            <div class="form-group">
                                <label class="col-sm-3 control-label" for="readonlyinput">*红包数量：</label>
                                <div class="col-sm-7">
                                   <input type="number" id="quantity" value="${redpackets.quantity !''}" class="input-sm form-control w160 fl" name="quantity" required><span class="lh30">个</span>
                                </div>
                            </div><!-- form-group -->
                            </div>
    
                            <div class="form-group" style="display:none;">
                                <label class="col-sm-3 control-label" for="disabledinput">*有效期：</label>
                                <div class="col-sm-7">
                                    <input type="text" id="validityTime" name="validityTime" value="" class="datepicker input-sm form-control w160" required>
                                </div>
                            </div><!-- form-group -->
                            
                            <div class="form-group">
                                <label class="col-sm-3 control-label" for="disabledinput">*子红包有效期：</label>
                                <div class="col-sm-7">
                                    <input type="number" id="sonValidityTime" value="${redpackets.sonValidityTime !''}" class="input-sm form-control w160 fl" name="sonValidityTime" required><span class="lh30">天</span>
                                </div>
                            </div><!-- form-group -->
    
                            <div class="form-group">
                                <label class="col-sm-3 control-label" for="readonlyinput">* 自动上架时间：</label>
                                <div class="col-sm-7">
                                    <input type="text" id="mountingTime" name="mountingTime" value="" class="datepicker input-sm form-control w160" required>
                                </div>
                            </div><!-- form-group -->
                            
                            <div class="form-group">
                                <label class="col-sm-3 control-label" for="readonlyinput">* 自动下架时间：</label>
                                <div class="col-sm-7">
                                    <input type="text" id="reduceTime" name="reduceTime" value="" class="datepicker input-sm form-control w160" required>
                                </div>
                            </div><!-- form-group -->
                            
                            <div class="form-group">
                                <label class="col-sm-3 control-label" for="readonlyinput">*状态：</label>
                                <div class="col-sm-7">
                                    <select id="status" name="status" class="select2 w160 fl">
									  <option value="on">已上架</option>
									  <option value="off">已下架</option>
									  <option value="stock">库存</option>
									</select>
                                </div>
                            </div><!-- form-group -->
                            
                            <div class="form-group">
                                <label class="col-sm-3 control-label" for="readonlyinput">排序：</label>
                                <div class="col-sm-7">
                                    <input type="number" id="orderBy" name="orderBy" value="${redpackets.orderBy !''}" class="input-sm form-control w160 fl"><span class="lh30">排序数字越小排序越靠前</span>
                                </div>
                            </div>
                            
                            <div class="form-group">
                                <label class="col-sm-3 control-label" for="readonlyinput">*红包说明：</label>
                                <div class="col-sm-7">
                                	<textarea id="remark" class="form-control" rows="5" name="remark" required>${redpackets.remark !''}</textarea>
                                </div>
                            </div><!-- form-group -->
                            
                            <div class="form-group">
                                <label class="col-sm-3 control-label">*每人领取次数：</label>
                                <div class="col-sm-7">
                                    <input type="text" id="receiveNumber" name="receiveNumber" value="${redpackets.receiveNumber !''}" class="form-control input-sm w160" required>
                                </div>
                            </div><!-- form-group -->
                            
                            <div class="form-group" id="storeSelect">
                                <label class="col-sm-3 control-label" for="readonlyinput">派发商家：</label>
                                <div class="col-sm-7">
                                	<select id="storeList" multiple class="select2 fl" name="storeList" style="width:500px;">
									  	<#if storeList?? && storeList?size gt 0>
                                                    <#list storeList as store >
                                                    	<option value="${store.storeId}">${store.storeName}</option>
                                                    </#list>
                                        </#if>
									</select>
									
									<select style="display:none;" id="hideStore">
										<#if store?? && store?size gt 0>
                                                    <#list store as st >
                                                    	<option value="${st.store_id}">${st.store_name}</option>
                                                    </#list>
                                        </#if>
									</select>
                                </div>
                            </div><!-- form-group -->
                            <hr>
                     		<div class="row center"><a id="saveBtn" class="btn btn-primary">保存</a></div>
                     </form>
                    </div><!-- panel-body -->
                </div>
                
                <script src="/js/jquery-validate/jquery.validate.min.js"></script>
                <script src="/js/jquery-validate/message_cn.js"></script>
       			<script>
       				$("#isBdRed").val("${redpackets.isBdRed !''}");
		            $("#purpose").val("${redpackets.purpose !''}");
       				$("#amount").val(${redpackets.initMoney !'0'}/100);
       				$("#singleAmount").val(${redpackets.singleAmount !'0'}/100);
       				$("#minAmount").val(${redpackets.minAmount !'0'}/100);
       				$("#maxAmount").val(${redpackets.maxAmount !'0'}/100);
       				$("#status").val("${redpackets.status !''}");
       				
       				var stringToDate = function(value){
       					if(isNaN(value)){
       						value = value.substring(0,value.indexOf(" "));
							return value;
						}
       					var date = new Date(parseInt(value));
       					var year=date.getFullYear();     
              			var month=date.getMonth()+1;     
              			if(month < 10){
              				month = "0" + month;
              			}   
              			var date=date.getDate();
              			if(date < 10){
              				date = "0" + date;
              			}  
		              	return year + "-" + month + "-" + date
		            };
		            $("#validityTime").val(stringToDate('${redpackets.validityTime !'null'}'));
		            $("#mountingTime").val(stringToDate('${redpackets.mountingTime !'null'}'));
		            $("#reduceTime").val(stringToDate('${redpackets.reduceTime !'null'}'));
		            
		            jQuery(document).ready(function(){
		              jQuery("#form").validate({
	                    highlight: function(element) {
	                        jQuery(element).closest('.form-group').removeClass('has-success').addClass('has-error');
	                    },
	                    success: function(element) {
	                        jQuery(element).closest('.form-group').removeClass('has-error');
	                    }
	                  });
	                  
	                  $("#type").val("${redpackets.type !''}");
		              $("#type").select2({minimumResultsForSearch: -1});
	                  if($("#type").val() == 'infinite'){
	                  		$("#singleAmountForm").show();
	            			$("#amountForm").hide();
	            			$("#randomDiv").hide();
	                  }else if($("#type").val() == 'random'){
	                  		/*$("#randomDiv").show();
	                  		$("#type").prop("disabled",true);
	                  		$("#amount").prop("disabled",true);
	                  		$("#singleAmount").prop("disabled",true);
	                  		$("#quantity").prop("disabled",true);
	                  		$("#minAmount").prop("disabled",true);
	                  		$("#maxAmount").prop("disabled",true);*/
	                  		$("#singleAmountForm").hide();
		            		$("#amountForm").show();
		            		$("#randomDiv").hide();
	                  }else{
	                  		$("#singleAmountForm").hide();
		            		$("#amountForm").show();
		            		$("#randomDiv").hide();
	                  }
	                  if($("#isBdRed").val() == 'Y'){
	                  	$("#storeSelect").hide();
	                  }
	                  $("#hideStore option").each(function(index,dom){
	                  	var storeId = $(dom).val();
	                  	$("#storeList option[value='" + storeId + "']").attr("selected",true);
	                  });
	                  $("#storeList").select2();
		              
		              $("#saveBtn").click(function(){
		                  if(!$("#form").valid()){
		              	  	return;
		              	  }
		              	  if($("#isBdRed").val() == 'N' && $("#storeList").val() == null){
			            	  bootbox.alert("请添加派发商家");
			            	  return;
			              }
			              if($("#orderBy").val() == ''){
			              	$("#orderBy").val(0);
			              }
		              	  var params = {
			              	id: '${redpackets.id !'null'}',
			              	name: $("#name").val(),
			              	type: $("#type").val(),
			              	initMoney: parseInt($("#amount").val()*100), 
			              	singleAmount: parseInt($("#singleAmount").val()*100),
			              	quantity: parseInt($("#quantity").val()), 
			              	validityTime: date2Timestamp($("#reduceTime").val()), 
			              	sonValidityTime: $("#sonValidityTime").val(),
			              	mountingTime: date2Timestamp($("#mountingTime").val()), 
			              	reduceTime: date2Timestamp($("#reduceTime").val()),
			              	status: $("#status").val(), 
			              	orderBy: $("#orderBy").val(),
			              	isBdRed: $("#isBdRed").val(),
			              	purpose: $("#purpose").val(),
			              	minAmount: parseInt($("#minAmount").val()*100),
			              	maxAmount: parseInt($("#maxAmount").val()*100),
			              	remark: $("#remark").val(),
			              	receiveNumber: $("#receiveNumber").val(),
			              	storeList: $("#storeList").val()
			              };
			              $.ajax({
								url: '/redpackets/updateRedpacketsById.ajax' ,
								type: 'POST',
								data: {map: JSON.stringify(params)} ,
								dataType: 'json',
								success: function(json){
									if(json.state == 1){
										bootbox.alert("更新成功！");
										setTimeout(function(){
											window.location.href="/redpackets/index.htm";
										},800);
									}else{
										bootbox.alert(json.message);
									}
								} ,
								error: function(){
									bootbox.alert("网络忙，请稍后重试！");
								}
						 });
		              });
		            });
		            var date2Timestamp = function(date){
		            	date = date.replace(/-/g,'/');
		            	return new Date(date).getTime();
		            };
		            var showSingle = function(obj){
		            	if($(obj).val() == 'random'){
		            		$("#singleAmountForm").hide();
		            		$("#amountForm").show();
		            		$("#randomDiv").hide();
		            	}else if($(obj).val() == 'quota'){
		            		$("#singleAmountForm").hide();
		            		$("#amountForm").show();
		            		$("#randomDiv").hide();
		            	}else{
		            		$("#singleAmountForm").show();
		            		$("#amountForm").hide();
		            		$("#randomDiv").hide();
		            	}
		            };
		            var changeSelect = function(obj){
		            	if($(obj).val() == 'N'){
		            		$("#storeSelect").show();
		            	}else{
		            		$("#storeSelect").hide();
		            	}
		            };
	            </script>
		</div>
	</div>
</section>
</body>
</html>