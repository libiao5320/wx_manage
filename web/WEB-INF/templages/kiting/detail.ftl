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
	                            <li>财务管理</li>
	                        </ul>
	                        <h4>处理顾客提现</h4>
	                    </div>
	                </div><!-- media -->
	            </div><!-- pageheader -->
                    
               <div class="contentpanel">
			   		<div class="alert alert-info">
                        <button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
                        <strong>说明：</strong>顾客储值提现人工处理，审核通过并人工结算成功修改状态结算成功，结算成功后不可修改。
                    </div>
			   
			   <div class="row">
			      <div class="col-xs-12" 
			         style="text-align:center;line-height:50px;height:50px;">
			         	提现详情
			      </div>
			   </div>
			   <#if kiting??>
			   <div class="row">
			      <div class="col-xs-12">
			         <table class="table">
			         	<tr>
			         		<td style="text-align:center;background-color: #eee;">申请提现金额</td><td style="text-align:center;">${kiting.moneyDollar}</td>
			         		<td style="text-align:center;background-color: #eee;">提现类型</td><td style="text-align:center;"><#if kiting.type??><#if kiting.type == 'balance'>余额提款<#elseif kiting.type == 'income'>收益提款<#else>-</#if><#else>-</#if></td>
			         	</tr>
			         	<tr>
			         		<td style="text-align:center;background-color: #eee;">提现方式</td><td style="text-align:center;">银行转账[${kiting.bankName !'-'}]<br>[${kiting.name !'-'}]${kiting.bankCard !'-'}</td>
			         		<td style="text-align:center;background-color: #eee;">申请时间</td><td style="text-align:center;">${kiting.strCreatedTime !''}</td>
			         	</tr>
			         	<tr>
			         		<td style="text-align:center;background-color: #eee;">顾客姓名</td><td style="text-align:center;">${kiting.name !'-'}</td>
			         		<td style="text-align:center;background-color: #eee;">顾客电话</td><td style="text-align:center;">${kiting.phone !'-'}</td>
			         	</tr>
			         	<tr>
			         		<td style="text-align:center;background-color: #eee;">提现状态</td><td style="text-align:center;"><#if kiting.status == 'HANDLE_OK'>提现成功<#elseif kiting.status == 'REJECT'>拒绝提现<#elseif kiting.status == 'FAIL'>提现失败<#elseif kiting.status == 'AUDIT'>待处理<#else>-</#if></td>
			         		<td style="text-align:center;background-color: #eee;">实际提现金额</td><td style="text-align:center;">${kiting.actualMoneyDollar !'-'}</td>
			         	</tr>
			         	<tr>
			         		<td style="text-align:center;background-color: #eee;">操作人</td><td style="text-align:center;">${kiting.updateBy !'-'}</td>
			         		<td style="text-align:center;background-color: #eee;">操作时间</td><td style="text-align:center;">${kiting.updateTime !'-'}</td>
			         	</tr>
			         </table>
			      </div>
			   </div>
			   <#if kiting.status == 'AUDIT' || kiting.status == 'FAIL'>
			   <div class="row">
			      <div class="col-xs-12" 
			         style="text-align:center;line-height:50px;height:50px;">
			         	提现操作
			      </div>
			   </div>
			   <div class="row">
			   	
			      <div class="col-xs-12">
			         <table class="table">
			         	<tr>
			         		<td style="text-align:center;background-color: #eee;">提现状态</td>
			         		<td style="text-align:center;">
			         			<select name="status" id="status" class="col-xs-6">
			         				<option value="AUDIT">未处理</option>
			         				<option value="HANDLE_OK">提现成功</option>
			         				<option value="FAIL">提现失败</option>
			         				<option value="REJECT">拒绝提现</option>
			         			</select>
			         		</td>
			         		<td></td>
			         	</tr>
			         	<tr>
			         		<td style="text-align:center;background-color: #eee;">输入实际提现金额</td>
			         		<td style="text-align:center;">
			         			<input type="text" name="actualMoneyDollar" id="actualMoneyDollar" class="col-xs-6" onkeyup="clearNoNum(this)" value="${kiting.moneyDollar !'0'}"/>
			         			<span style="color:red;float: left;">小于等于申请提现金额</span></td>
			         		<td></td>
			         	</tr>
			         	
			         </table>
			      </div>
			      </#if>
			      <div style="text-align:center;">
					<!--<button class="btn btn-default" style="margin-right:30px;" id="detailList">查看全部明细</button>-->
					<#if kiting.status == 'AUDIT' || kiting.status == 'FAIL'>
					<button class="btn btn-success" style="margin-right:30px;" id="saveBtn">保存</button>
					</#if>
					<a href="/kiting/list.htm" class="btn btn-warning" style="margin-right:30px;">返回</a>
					</div>
			   </div>
			 </div>
			  </#if>
		</div><!-- contentpanel -->
	</div><!-- mainpanel -->
</div><!-- mainwrapper -->
</section>
<script>
$(document).ready(function(){
	$("#status").val('${kiting.status}');
	$("#actualMoneyDollar").blur(function(){
		var moneyDollar =  parseFloat(${kiting.moneyDollar !'0'}).toFixed(2);
		
		if($("#actualMoneyDollar").val() == '' || $("#actualMoneyDollar").val() == null){
			return;
		}
		
		var actualMoneyDollar =  parseFloat($("#actualMoneyDollar").val()).toFixed(2);
		
		if(moneyDollar < actualMoneyDollar){
			$("#actualMoneyDollar").val(moneyDollar);
		}else{
			$("#actualMoneyDollar").val(actualMoneyDollar);
		}
	});


	/**
	*第一期不做，后期做的时候，只需放开注释的代码，在detaillist中，修改请求的ajax即可，但是此ajax暂未实现逻辑
	**/
	$("#detailList").click(function(){
    	//$("#detail").load("/kiting/detaillist/"+${kiting.id !''}+".htm");
    });
    
    //保存
	$("#saveBtn").click(function(){
		var moneyDollar = ${kiting.moneyDollar !'0'};//申请金额
		
		//实际退款金额
		var actualMoneyDollar = $("#actualMoneyDollar").val();
		if(actualMoneyDollar == null || actualMoneyDollar == '' || actualMoneyDollar == 'undefined'){
			alert("金额填写错误！");
			return;
		}
    	$.ajax({
			url: '/kiting/dispose.ajax' ,//处理提现申请
		    type: 'POST',
		    data: {'map[id]':${kiting.id !'null'},'map[actualMoneyDollar]':actualMoneyDollar,'map[status]':$("#status").val()} ,
		    dataType: 'json',
		    success: function(json){
		    	if(json.message == 'login'){
		    		window.location.href="/manager/loginPage.htm";
		    		return;
		    	}
		    	/**
		    	if(json.state){
		    		var kiting = json.param;
		    		
		    		if(kiting != null && kiting != '' && kiting != 'undefined'){
		    			var flag = true;
		    			var content;
		    			if(kiting.status == 'HANDLE_OK'){//提现成功
		    				content="提现成功";
		    			}else if(kiting.status == 'FAIL'){//提现失败
		    				content="提现失败";
		    			}else if(kiting.status == 'REJECT'){//提现拒绝
		    				content="提现拒绝";
		    			}else{
		    				flag = false;
		    			}
		    			
		    			if(flag && kiting.phone != null && kiting.phone != '' && kiting.phone != 'undefined'){//发送短信
							smsYiMeiTixian(kiting.phone,content);  
							alert("短信通知成功！");
		    			}
		    		}
		    	}
		    	**/
		    	alert(json.message);
		    	window.location.reload();
		     } ,
		    error: function(){
		    }
		 });
    });
    
});
function clearNoNum(obj){   
    
				obj.value = obj.value.replace(/[^\d.]/g,"");  //清除“数字”和“.”以外的字符  
			
				obj.value = obj.value.replace(/^\./g,"");  //验证第一个字符是数字而不是. 
			
				obj.value = obj.value.replace(/\.{2,}/g,"."); //只保留第一个. 清除多余的.   
			
				obj.value = obj.value.replace(".","$#$").replace(/\./g,"").replace("$#$",".");
			
			}
</script>
<div id="detail"></div>
</body>
</html>