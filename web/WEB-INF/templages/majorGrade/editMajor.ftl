<div class="locked  center-block ">
	<div class="lockedpanel" style="width:535px;">
		
		<div class="container" >
			<div class="row">
  				<div class="col-xs-5" 
 					style="line-height:50px;height:50px;">
 					<strong>编辑专业</strong>
  				</div>
   			</div>
   			
   			<div class="row">
			      <div class="col-xs-5">
			        	<div class="form-group">
							<label class="col-sm-6 control-label">*专业：</label>
							<div class="col-sm-6">
								<input class="form-control" id="major" value="${result.dgroupbuyClass.className !'null'}" >
							</div>
						</div>
								
						<div class="form-group">
							<label class="col-sm-6 control-label">*排序：
								<br/>
								<small>优先级小排序靠前</small></label>
							<div class="col-sm-6">
								<input class="form-control" id="sort" value="${result.dgroupbuyClass.sort !'null'}">
							</div>
						</div>
						
						<button class="btn btn-danger" id="closeBtn">取消</button>
						<button class="btn btn-success" id="saveBtn">保存</button>
						
					</div>
		    </div>
		</div>
	</div>
</div>
<script>
  jQuery(document).ready(function(){
		$("#closeBtn").click(function(){
			$("#editPage div", window.parent.document).remove();
    	});
    	
	 $("#saveBtn").click(function(){
          	  var params = {
              	classId: '${result.dgroupbuyClass.classId !'null'}',
              	className: $("#major").val(),
              	classParentId: 2,
              	sort: $("#sort").val(),
              	deep:'${result.dgroupbuyClass.deep !'null'}',
              };
              $.ajax({
					url: '/majorGrade/updateMajorGrade.ajax' ,
					type: 'POST',
					data: {map: JSON.stringify(params)} ,
					dataType: 'json',
					success: function(json){
						if(json.state == 1){
							alert("更新成功！");
							window.location.href="/majorGrade/index.htm";
						}else{
							alert(json.message);
						}
					} ,
					error: function(){
						alert("网络忙，请稍后重试！");
					}
			 });
      });
    	
});
</script>
