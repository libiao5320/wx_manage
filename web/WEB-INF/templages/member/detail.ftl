<#include "../head.ftl"/>
<section>
	<div class="mainwrapper">
	<#include "../leftnav.ftl"/>
		<div class="mainpanel">
			<div class="container" style="">
			   <div class="row">
			      <div class="col-xs-12" 
			         style="background-color: #eee;line-height:50px;height:50px;">
			         <strong>顾客管理-顾客详情</strong>
			      </div>
			   </div>
			   <div class="row">
			      <div class="col-xs-12" 
			         style="background-color: #fff;line-height:50px;height:50px;">
			         说明：1.管理顾客信息2.分配私人健康师3.V查看健康档案4.开通VIP卡
			      </div>
			   </div>
			   <#if member??>
			   <div class="row">
			      <div class="col-xs-12" 
			         style="background-color: #eee;line-height:50px;height:50px;">
			        	基本信息
			      </div>
			   </div>
			   <div class="row">
			      <div class="col-xs-12">
			        	<table class="table" style="margin: 10px;">
			        		<tr>
			        			<td style="background-color: #eee;">顾客ID:</td><td>${member.memberId !'-'}</td>
			        			<td style="background-color: #eee;">微信名:</td><td>${member.memberName !'-'}</td>
			        		</tr>
			        		<tr>
			        			<td style="background-color: #eee;">手机号:</td><td>${member.memberMobile !'-'}</td>
			        			<td style="background-color: #eee;">注册时间:</td><td>${member.memberTime !'-'}</td>
			        		</tr>
			        		<tr>
			        			<td style="background-color: #eee;">邀请码:</td><td>${member.recommendCode !'-'}</td>
			        			<td style="background-color: #eee;">地址定位:</td><td><#if member.city??>${member.city.areaName !'-'}<#else>-</#if></td>
			        		</tr>
			        	</table>
			      </div>
			   </div>
			   <div class="row">
			      <div class="col-xs-12" 
			         style="background-color: #eee;line-height:50px;height:50px;">
			        	会员及融耀达人&nbsp;&nbsp;&nbsp;<button class="btn btn-info" type="button" id="topman">保存</button>
			      </div>
			   </div>
			   <div class="row">
			      <div class="col-xs-12">
			        	<table class="table" style="margin: 10px;">
			        		<tr>
			        			<td style="background-color: #eee;">融耀达人:</td>
			        			<td>
			        			<select id="topManState" name="topManState">
									<option value="1" <#if (member.topManState??) && (member.topManState == 1)>selected="selected"</#if>>非荣耀达人</option>
								    <option value="2" <#if (member.topManState??) && (member.topManState == 2)>selected="selected"</#if>>荣耀达人</option>
								</select>
								</td>
			        			<td style="background-color: #eee;">VIP等级:</td><td>${member.vipRankId !'0'}</td>
			        		</tr>
			        		<tr>
			        			<td style="background-color: #eee;">储值金额:</td><td>${member.savingsAmountDollar !'-'}</td>
			        			<td style="background-color: #eee;">余额:</td><td>${member.balance !'-'}</td>
			        		</tr>
			        	</table>
			      </div>
			   </div>
			   
			   <div class="row">
			      <div class="col-xs-12" 
			         style="background-color: #eee;line-height:50px;height:50px;">
			        	备注&nbsp;&nbsp;&nbsp;<button class="btn btn-info" type="button" id="addremarkBtn">添加备注</button>
			      </div>
			   </div>
			   <div class="row">
			      <div class="col-xs-12">
			        	<table class="table" style="margin: 10px;">
			        		<thead style="background-color: #eee;">
			        			<th>备注人</th>
			        			<th>备注时间</th>
			        			<th>备注内容</th>
			        			<th>操作</th>
			        		</thead>
			        		<tbody>
			        			<#if remarkList?? && (remarkList?size > 0)>
			        			<#list remarkList as remark>
			        			<tr>
			        				<td>${remark.manager !''}</td>
			        				<td>${remark.strCreateTime !''}</td>
			        				<td title="${remark.content !''}">${remark.content !''}</td>
			        				<td><button class="btn btn-warning btn-sm" type="button" remarkId="${remark.id !''}" onclick="javascript:if(confirm('确认删除吗')){delRemark($(this));}">删除</button></td>
			        			</tr>
			        			</#list>
			        			<#else>
			        			<tr>
			        				<td colspan='4' style='text-align:center;'>还没有添加备注</td>
			        			</tr>
			        			</#if>
			        		</tbody>
			        	</table>
			      </div>
			   </div>
			  
			   <div class="row">
			      <div class="col-xs-12" style="text-align:center;">
			      	<a href="javascript:history.go(-1);" class="btn btn-info" type="button" id="close">返回</a>
			      </div>
			   </div>
			   
			</div>
				
			</#if>
		</div>
	</div>
</section>
<div id = "addremark"></div>
<script>
$(function(){
	$("#topman").click(function(){
		var topManState =  $("#topManState").val();

		$.ajax({
			url:'/member/updateTopManState.ajax',
			type:'POST',
			data:{'id':${member.memberId !'null'},'topManState':topManState} ,
			dataType:'json',
			success:function(json){
				alert(json.message);
			},
			error:function(){
				alert("网络忙，请稍后重试！");
			}
		
		});
	});
	
	$("#addremarkBtn").click(function(){
		$("#addremark").load("/member/remark/"+${member.memberId !''}+".htm");
	});
});

function delRemark(data){
	var id = data.attr("remarkId");
	
	if(id == null || id == '' || id == 'undefined'){
		alert("参数错误!");
		return;
	}
	
	$.ajax({
		url:'/member/delremark.ajax',
		type:'POST',
		data:{'id':id} ,
		dataType:'json',
		success:function(json){
			if(json.state){
				data.parent().parent().remove();
			}else{
				if(json.message == 'login'){
					return;
				}
			}
			
			alert(json.message);
		},
		error:function(){
			alert("网络忙，请稍后重试！");
		}
	
	});
}
</script>
	</body>
</html>

    