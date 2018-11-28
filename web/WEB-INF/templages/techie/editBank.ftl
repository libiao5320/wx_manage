<#include "../head.ftl"/>
<script src="../../js/bootbox/bootbox.min.js"></script>
<script src="../../js/jquery-ui-1.10.3/jquery-ui-1.10.3.min.js"></script>
<link rel="stylesheet" type="text/css" href="/css/wangedit/wangEditor.min.css">
<style>.imglist{margin-right:5px;}body{margin-top:0!important;}</style>
<link href="/css/fileinput.css" rel="stylesheet">
<script src="/js/fileinput/fileinput.js"></script>
<script src="/js/fileinput/fileinput_locale_zh.js"></script>
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
                            <li>健康师管理</li>
                        </ul>
                        <h4>健康师账户编辑</h4>
                    </div>
                </div><!-- media -->
            </div><!-- pageheader -->
            
            <div class="contentpanel">
                <div class="alert alert-info">
                    <button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
                    <strong>说明：</strong>健康师账户资料
                </div>
                 <div class="panel panel-default">
                   <div class="panel-heading">
						<div class="form-horizontal cb pt5">
							<h4 class="panel-title"健康师账户信息</h4>
						</div>
                    </div><!-- panel-heading -->
                    <div class="panel-body">
                        <form class="form-horizontal form-bordered" id="form">
                            <div class="form-group">
                                <label class="col-sm-3 control-label">*姓名：</label>
                                <div class="col-sm-7">
                                    <input type="text" id="trueName" name="trueName" value="${result.techieBank.trueName !''}" class="form-control input-sm" required>
                                </div>
                            </div><!-- form-group -->
                            
                            <div class="form-group">
                                <label class="col-sm-3 control-label">*账户名称：</label>
                                <div class="col-sm-7">
                                    <input type="text" id="accounts" name="accounts" value="${result.techieBank.accounts !''}" class="form-control input-sm" required>
                                </div>
                            </div><!-- form-group -->
                            
                            <div class="form-group">
                                <label class="col-sm-3 control-label">*账户号：</label>
                                <div class="col-sm-7">
                                    <input type="text" id="accountsNo" name="accountsNo" value="${result.techieBank.accountsNo !''}" class="form-control input-sm" required>
                                </div>
                            </div><!-- form-group -->
                            
                            <div class="form-group">
                                <label class="col-sm-3 control-label">*开户人：</label>
                                <div class="col-sm-7">
                                    <input type="text" id="accountHolder" name="accountHolder" value="${result.techieBank.accountHolder !''}" class="form-control input-sm" required>
                                </div>
                            </div><!-- form-group -->
                            
                            <hr>

                    		<div class="row center"><button id="closeBtn" class="btn btn-primary">返回</button>
                    		<button id="saveBtn" type="submit" class="btn btn-primary ml10">保存</button>
                    		</div>

                     </form>
                    </div><!-- panel-body-->
                </div>
                
                <script src="/js/wangedit/wangEditor.js"></script>
                <script src="/js/ajaxfileupload/ajaxfileupload.js"></script>
                <script src="/js/jquery-validate/jquery.validate.min.js"></script>
                <script src="/js/jquery-validate/message_cn.js"></script>
       			<script>
				$(document).ready(function () {
					$("#closeBtn").click(function(){
						window.location.href="/techie/bank.htm";
						//redirect("/techie/bank.htm");
						return false;
					});
					
					$("#saveBtn").click(function(){
						var params = {
							id:${result.techieBank.id !''},
							techieId:${result.techieBank.techieId !''},
							trueName:$("#trueName").val(),
							accounts:$("#accounts").val(),
							accountsNo:$("#accountsNo").val(),
							accountHolder:$("#accountHolder").val()
						};
						$.ajax({
							url:'/techie/updateTechieBank.htm',
							type:'POST',
							data:{map: JSON.stringify(params)},
							dataType:'json',
							success:function(json){
								if(json.state == 1){
									bootbox.alert("更新成功！");
									setTimeout(function(){
										window.location.href = "/techie/bank.htm";
									},1000);
								}else{
									bootbox.alert("更新失败！");
								}
							},
							error:function(){
								bootbox.alert("网络忙，请稍后重试！");
							}
						});
						return false;
					});
				});
					
				$(function () {	
     		});
	            </script>
		</div>
	</div>
</section>
</body>
</html>