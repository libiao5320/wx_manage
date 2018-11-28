<div class="locked  center-block ">
	<div class="lockedpanel" style="width:535px;">
		<div class="pageheader" style="height:220px;">
            <div class="row">
		      <div class="col-xs-12" 
		         style="background-color: #eee;line-height:50px;height:50px;">
		         	添加备注
		      </div>
		   </div>
		   <div class="row">
		      <div class="col-xs-12" 
		         style="background-color: #fff;">
		         	<textarea id="remark" style="width:80%;height:100px;" placeholder="请输入备注信息"></textarea>
		      </div>
		   </div>
		   <div class="row">
			      <div class="col-xs-12" style="text-align:center;">
			      	<a class="btn btn-info" type="button" id="remarkSubmit">提交</a>
			      	<a href="javascript:;" class="btn btn-info" type="button" id="closeR">关闭</a>
			      </div>
			   </div>
        </div><!-- pageheader -->
	</div>
</div>

<script>
$(function(){
	$("#remarkSubmit").click(function(){
		var remark =  $("#remark").val();
		
		$.ajax({
			url:'/member/remark.ajax',
			type:'POST',
			data:{'memberId':${memberId !'null'},'remark':remark} ,
			dataType:'json',
			success:function(json){
				if(json.message == 'login'){
					window.location.href="/manager/loginPage.htm";
					return;
				}
				alert(json.message);
				if(json.state){
					window.parent.location.reload();
				}
			},
			error:function(){
				alert("网络忙，请稍后重试！");
			}
		
		});
	});
	
	$("#closeR").click(function(){
		$("#addremark div", window.parent.document).remove();
	});
});
</script>