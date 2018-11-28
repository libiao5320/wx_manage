<div class="locked  center-block ">
	<div class="lockedpanel" style="width:535px;">
		
		<div class="container" >
			<div class="row">
  				<div class="col-xs-5" 
 					style="line-height:50px;height:50px;">
 					<strong>编辑等级</strong>
  				</div>
   			</div>
   			
   			<div class="row">
			      <div class="col-xs-5">
			        	<div class="form-group">
							<label class="col-sm-6 control-label">*等级：</label>
							<div class="col-sm-6">
								<input class="form-control" id="className" value="${result.dgroupbuyClass.className !'null'}" >
							</div>
						</div>
								
						<div class="form-group">
							<div>
								<label class="col-sm-6 control-label">*所属专业：
									</label>
							</div>
							<div class="col-sm-6">
								<div id="u52" class="ax_下拉列表框">
									<select id="major"  class="form-control">
		        				        <#if  result.major?? && result.major?size gt 0 >  
								        	<#list result.major as a ><option  value="${a.classId}">${a.className}</option></#list>
								        </#if>
		                            </select>
								</div>
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
    	
	 $("#major").val("${result.parent.classId}");
	 $("#saveBtn").click(function(){
			var parentId=$("#major").val();
          	  var params = {
              	classId: '${result.dgroupbuyClass.classId !'null'}',
              	className: $("#className").val(),
              	classParentId: parentId,
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
