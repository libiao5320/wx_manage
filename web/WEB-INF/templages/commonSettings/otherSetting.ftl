<#include "../head.ftl"/>
<style>.edit,.delete{cursor:pointer;}</style>
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
                                    <li>常用设置-其他设置</li>
                                </ul>
                                <h4>常用设置-其他设置</h4>
                            </div>
                        </div><!-- media -->
                    </div><!-- pageheader -->
                    
                    <div class="contentpanel">
                        <div class="alert alert-info">
                            <button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
                            <strong>说明：</strong>下单未付款超时订单自动取消；付余款超时自动支付余款；评价超时自动评价为3星；商家账单日为账单月起止时间，如账单日11号，则3月账期为2.12-3.11
                        </div>
                     						<#if  result?? && result?size gt 0 >  
				     		<#list result as a >
						<div class="form-group text-center">
							<label class="col-sm-3 control-label text-right" id="sname">
							*${a.sname!''}：
								<br />
							</label>
							<div class="col-sm-5">
							    <div class="col-sm-6 svalue" >
							    	<input placeholder="" class="form-control" type="text" name="svalue" value="${a.svalue!''}">
							    </div>
								<div class="text-left" >
									<div>${a.unit!''}</div>
								</div>
								<input placeholder="" class="form-control" type="hidden" name="sValueIds" value="${a.id!''}">
							</div>
						</div>
						 </#list>
				        </#if>
				        <div class="form-group text-center">
							<button id='save' class='btn btn-primary' >保存</button>
						</div>
                </div><!-- mainpanel -->
            </div><!-- mainwrapper -->
        </section>
	
			<script>
			$(document).ready(function(){
				$("#save").click(function(){
					var sv = $("input[name='svalue']");
					var sValueIds = $("input[name='sValueIds']");
					var sValues = [];
					for(var i=0; i<sv.length; i++){
						sValues[i] = {
							id: sValueIds[i].value,
							sValue: sv[i].value
						};
					}				
					
					updateSetting(sValues);
				});
			});
			function updateSetting(sValues){
						var params = { 
			              	sValues: sValues
			              };
			              $.ajax({
								url: '/SettingsCtrl/updateSetting.ajax' ,
								type: 'POST',
								data: {map: JSON.stringify(params)} ,
								dataType: 'json',
								success: function(json){
									if(json.state == 1){
										bootbox.alert("更新成功！");
										setTimeout(function(){
											window.location.href="/SettingsCtrl/queryotherSetting.htm";
										},800);
									}else{
										bootbox.alert(json.message);
									}
								} ,
								error: function(){
									bootbox.alert("网络忙，请稍后重试！");
								}
						 });
						 return false;
				}
		</script>
	</body>
</html>