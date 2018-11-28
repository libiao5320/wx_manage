<script src="/js/jquery-validate/jquery.validate.min.js"></script>
<script src="/js/jquery-validate/message_cn.js"></script>
<form class="form-horizontal form-bordered" id="form">
<div class="locked  center-block " style="overflow-y:auto;">
	<div class="lockedpanel" style="width:535px;margin-top: 0px" >
			<div class="">
			
				<div class="container" >
	  				<div class="col-xs-6" style="line-height:50px;height:50px;">
	 					<strong>生成充值卡</strong>
	  				</div>
   				</div>
	   			<div class="">
				      <div class="">
			        			<div class="form-group">
									<label class="col-sm-6 control-label">充值卡数量:</label>
									<div class="col-sm-6">
										<input class="form-control" id="num" required onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')">
									</div>
								</div>
								 
								<div class="form-group">
									<label class="col-sm-6 control-label">充值卡金额:</br>（单个金额，单位：元）</label>
									<div class="col-sm-6" >
										<input class="form-control" id="sum" required >
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-sm-6 control-label">过期时间:</label>
									<div class="col-sm-6">
										<input type="date" placeholder="" class="datepicker form-control" id="deadline" required>
									</div>
								</div>
								
								<button type="button" class="btn btn-primary btn-sm" id="create">生成</button>
						</div>
						<div class="panel-body">
                                <div class="row">
                                    <table id="urlTable"  data-show-export="true" >
								 	</table>
                                </div><!-- row -->
                        </div><!-- panel-body -->
						<button type="button" class="btn btn-primary btn-sm" id="exportBtn1">导出</button>
						<button type="button" class="btn btn-primary btn-sm" id="close">关闭</button>
				</div>
                <input type="hidden" name="limit" value="3">
                <input type="hidden" name="offset" value="1">				
		    </div>
	</div>
</div>
</form>
<script>
            	$(function(){
		              jQuery("#form").validate({
		              	debug:true,
	                    highlight: function(element) {
	                        jQuery(element).closest('.form-group').removeClass('has-success').addClass('has-error');
	                    },
	                    success: function(element) {
	                        jQuery(element).closest('.form-group').removeClass('has-error');
	                    }
	                   });            	
						var queryParams = function(params){   //提交参数
							var map = {
								pageSize : params.limit,      //每页大小
								pageNo : params.offset/3 + 1, //页码
							};
							
							params.map = JSON.stringify(map);
							
							return params;
						}; 
						var createCard = function(){
							var params = {
								num: $("#num").val().trim(),
								sum: $("#sum").val().trim(),
								deadline: $("#deadline").val().trim()
							};
						
							$.ajax({
				                url: '/rechargeCard/create.ajax' ,
				                type: 'POST',
				                data: {map: JSON.stringify(params)} ,
				                dataType: 'json',
				                success: function(json){
				                    if(json.state == 1){
				                        alert(json.message);
				                        $('#urlTable').bootstrapTable('refresh');
				                        $('#table').bootstrapTable('refresh');
				                    }else{
				                        alert(json.message);
				                    }
				                } ,
				                error: function(){
				                    alert("网络忙，请稍后重试！");
				                }
				            });
						}
		                var renderTable = function(){
		                	$("#urlTable").bootstrapTable('destroy', null);
			                $("#urlTable").bootstrapTable({
			                    method : 'get',
			                    url : '/rechargeCard/list.ajax',   //获取表格的后台url
			                    queryParams : queryParams,   //查询参数
			                    striped : true,
			                    pagination : true,
			                    pageList : [3],
			                    pageSize : 3,
			                    search : false,
			                    showColumns : false,
			                    clickToSelect : false,
			                    sidePagination:"server",//设置为服务器端分页
			                    columns : [ {           //表头
			                        field : 'rechargeSn',
			                        title : '卡号',
			                        align : 'left',
			                    },{
			                        field : 'scanUrl',
			                        title : '充值卡地址',
			                        align : 'left',
			                    }]
			                });
		                };
		                
		               $('.datepicker').datetimepicker({
					      format: "yyyy-mm-dd",
					      weekStart: 1,
					      startView: "year",
					      minView: "month",
					      maxView: "month",
					      language: "zh-CN"
					   });	
						renderTable();
						$("#exportBtn1").click(function(){
							$(".bootstrap-table .export .dropdown-menu > li[data-type='excel']").click();
						});		
						$("#create").click(function(){
							if(!$("#form").valid()){
					     	  	return;
					      	};
							createCard();
						});
						$("#close").click(function(){
							$("#createPage div", window.parent.document).remove();
						});		
						
						$("#sum").blur(function(){
							var patt = new RegExp(/^[1-9]?\d(\.\d{1,2})?$/g);
							if(!patt.test($(this).val())){
								$(this).val("");
							}
						});		
	              }); 
</script>
