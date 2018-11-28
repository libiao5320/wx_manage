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
                                    <li>常用设置-储值设置</li>
                                </ul>
                                <h4>常用设置-储值设置</h4>
                            </div>
                        </div><!-- media -->
                    </div><!-- pageheader -->
                    
                    <div class="contentpanel">
                        <div class="alert alert-info">
                            <button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
                            <strong>说明：</strong>VIP1是充值为 VIP1会员最低金额；VIP2是充值为VIP2会员最低金额；余额提现额度即C端余额低于此值时可申请提现
                        </div>
                        <#if  vips?? && vips?size gt 0 >  
				     		<#list vips as vip >
                        	<div class="form-group text-center">
								<label class="col-sm-3 control-label text-right" id="name">
								*${vip.name!''}：
								</label>
								<div class="col-sm-5">
								    <div class="col-sm-6 svalue">
								    	<input placeholder="" class="form-control" type="text" name="require" value="${vip.require!''}">
								    </div>
								</div>
								<input placeholder="" class="form-control" type="hidden" name="vipIds" value="${vip.id!''}">
							</div>
                         </#list>
				        </#if>
                        
						<#if  result?? && result?size gt 0 >  
				     		<#list result as a >
						<div class="form-group text-center">
							<label class="col-sm-3 control-label text-right" id="sname">
							*${a.sname!''}：
							</label>
							<div class="col-sm-5">
							    <div class="col-sm-6 svalue">
						    	<input placeholder="" class="form-control" type="text" name="svalue" value="${a.svalue!''}" id="${a.skey!''}">
							    <#if "${a.skey!''}" == "account_tx_value">
							     	<input type="hidden" id="hide" value="${a.svalue!''}">
							     </#if>
							     	
							    </div>
								<div class="col-sm-6  text-left" >
									<small class="col-sm-6">${a.unit!''}</small>
								</div>
							</div>
							<input placeholder="" class="form-control" type="hidden" name="sValueIds" value="${a.id!''}">
						</div>
						 </#list>
				        </#if>
				        <div class="form-group text-center">
							<button id='save'  class='btn btn-primary '>保存</button>
						</div>
                </div><!-- mainpanel -->
            </div><!-- mainwrapper -->
        </section>
	
		<script>
			$(document).ready(function(){
				var hide = $("#hide").val();
				$("#account_tx_value").val(hide/100);
			
				$("#save").click(function(){
					var rs = $("input[name='require']");
					var vipIds = $("input[name='vipIds']");
					var requires = [];
					for(var i=0; i<rs.length; i++){
						requires[i] = {
							id: vipIds[i].value,
							requireValue: rs[i].value
						};
					}
					
					var sv = $("input[name='svalue']");
					var sValueIds = $("input[name='sValueIds']");
					var sValues = [];
					for(var i=0; i<sv.length; i++){
						if(sv[i].id == "account_tx_value"){
							sValues[i] = {
								id: sValueIds[i].value,
								sValue: sv[i].value * 100
							};
						}else{
							sValues[i] = {
								id: sValueIds[i].value,
								sValue: sv[i].value
							};
						}
					}				
					
					updateSetting(requires,sValues);
				});
			});
			function updateSetting(requires,sValues){
			             var params = { 
			              	requires: requires,
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
											window.location.href="/SettingsCtrl/storageSetting.htm";
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