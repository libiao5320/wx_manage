<div class="locked  center-block ">
	<div class="lockedpanel" style="width:535px;">
		
		<div class="container" >
			<div class="row">
  				<div class="col-xs-5" 
 					style="line-height:50px;height:50px;">
 					<strong>审核</strong>
  				</div>
   			</div>
   			
   			<div class="row">
				<div class="col-xs-5">
					<textarea id="remark" name="remark" placeholder="当您要拒绝时，写拒绝的理由" class="col-xs-12" style="height:200px;"></textarea>
				</div>
				
			 </div>
			 <div class="row" style="margin:20px;">
			 	<div class="col-xs-5">
					<input name="status" type="radio" value="examined" checked/>通过
					<input name="status" type="radio" value="unexamine" style="margin-left:50px;"/>拒绝
				</div>
			 </div>
		</div>
		
	
		<!-- input-group -->
		<div>
			<button class="btn btn-success" id="submitBtn">提交</button>
			<button class="btn btn-danger" id="closeBtn">关闭</button>
		</div>
	</div>
</div>
<script>
$(document).ready(function(){
	$("#closeBtn").click(function(){
    	$("#detail div", window.parent.document).remove();
    });
    
	$("#submitBtn").click(function(){
	
		var remark = $("#remark").val();
		
		if($('input:radio:checked').val() == 'unexamine'){
			if(remark == ''){
				alert('请填写拒绝的理由');
				return;
			}
		}
	
		
		if(remark == '' || remark == null || remark == 'undefined'){
			remark = '';
		}
		
		$.ajax({
			url: '/topman/examine.ajax' ,
		    type: 'get',
		    data: {'map[id]':${id !''},'map[remark]':remark,'map[status]':$('input:radio:checked').val()} ,
		    dataType: 'json',
		    success: function(json){
		    	alert(json.message);
		    	if(json.state){
					window.parent.location.reload();
				}
				
		     } ,
		    error: function(){
		    }
		});
    });
});
</script>