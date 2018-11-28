<div class="locked  center-block ">
	<div class="lockedpanel" style="width:535px;">
		<div class="container" >
			<div class="row">
  				<div class="col-xs-5" 
 					style="line-height:50px;height:50px;">
 					<strong>融耀达人申请详情</strong>
  				</div>
   			</div>
   			
   			<div class="row">
			      <div class="col-xs-5">
			        	<table class="table">
			        		<tr>
			        			<td style="background-color: #eee;">顾客ID:</td><td>${topman.memberId !''}</td>
			        		</tr>
			        		<tr>
			        			<td style="background-color: #eee;">顾客姓名:</td><td>${topman.memberName !''}</td>
			        		</tr>
			        		<tr>
			        			<td style="background-color: #eee;">申请时间:</td><td>${topman.strCreateTime !''}</td>
			        		</tr>
			        		<tr>
			        			<td style="background-color: #eee;">申请理由:</td><td>${topman.reason !''}</td>
			        		</tr>
			        		<tr>
			        			<td style="background-color: #eee;">电话:</td><td>${topman.memberMobile !''}</td>
			        		</tr>
			        		<tr>
			        			<td style="background-color: #eee;">行业:</td><td>${topman.industry !''}</td>
			        		</tr>
			        		<tr>
			        			<td style="background-color: #eee;">职位:</td><td>${topman.job !''}</td>
			        		</tr>
			        		<tr>
			        			<td style="background-color: #eee;">是否是媒体从业人员:</td><td><#if topman.ifHavePubRes == 'Y'>是<#elseif topman.ifHavePubRes == 'N'>否<else>-</#if></td>
			        		</tr>
			        		<tr>
			        			<td style="background-color: #eee;">是否有自媒体资源:</td><td><#if topman.ifHaveMediaRes == 'Y'>是<#elseif topman.ifHaveMediaRes == 'N'>否<else>-</#if></td>
			        		</tr>
			        		<tr>
			        			<td style="background-color: #eee;">是否是行业专家:</td><td><#if topman.ifSpecial == 'Y'>是<#elseif topman.ifSpecial == 'N'>否<#else>-</#if></td>
			        		</tr>
			        		<tr>
			        			<td style="background-color: #eee;">是否有自己的推广资源:</td><td><#if topman.ifMeadia == 'Y'>是<#elseif topman.ifMeadia == 'N'>否<else>-</#if></td>
			        		</tr>
			        	</table>
			      </div>
			   </div>
		</div>
		
	
		<!-- input-group -->
		<div>
			<button class="btn btn-danger" id="closeBtn">关闭</button>
			<!--<button class="btn btn-success">导出</button>-->
		</div>
	</div>
</div>
<script>
$(document).ready(function(){
	$("#closeBtn").click(function(){
    	$("#detail div", window.parent.document).remove();
    });
});
</script>