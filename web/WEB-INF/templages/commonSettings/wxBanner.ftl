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
                                    <li>常用设置-微信C端首页设置</li>
                                </ul>
                                <h4>常用设置-微信C端首页设置</h4>
                            </div>
                        </div><!-- media -->
                    </div><!-- pageheader -->
                    
                    <div class="contentpanel">
                        <div class="alert alert-info">
                            <button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
                            <strong>说明：</strong>管理C端微信首页banner，可设为打开红包或超链接
                        </div>
                         <div class="panel panel-default">
                           <div class="panel-heading">

								<div class="form-horizontal cb pt5">
									<div class="form-line">
										
										<label class="w100 fl control-label lh20">首页banner设置</label>
                                        <div class="cb"></div>
									</div>
								</div>
								
								<div class="pull-right mt-30">
									<button type="button" class="btn btn-primary btn-sm" onClick="addBanner()">添加banner</button>
								</div>
                            </div><!-- panel-heading -->
                            <div class="panel-body">
                                <div class="row">
                                    <table id="table">
                                    </table>
                                </div><!-- row -->
                            </div><!-- panel-body -->
                        </div>
                    </div><!-- contentpanel -->
                    
                </div><!-- mainpanel -->
            </div><!-- mainwrapper -->
        </section>
	
	<script>
			
			$(function(){
       				
				var QUERY_FLAG = false;    //是否使用了查询输入进行查询标志位
				$(document).ready(function(){
					renderTable(false);
					$("#queryBtn").click(function(){
						renderTable(true);
					});
				});
			
				var queryParams = function(params){   //提交参数
					var map = {
						pageSize : params.limit,      //每页大小
						pageNo : params.offset/10 + 1 //页码
					};
					if(QUERY_FLAG){
						if($("#fieldValue").val() != ''){
							var field = $("#fieldName").val();
							map[field] = $("#fieldValue").val();
						}
						if($("#orderBy").val() != ''){
							map.orderBy = $("#orderBy").val();
						}
						if($("#startTime").val() != '' && $("#endTime").val() != ''){
							map.startTime = $("#startTime").val();
							map.endTime = $("#endTime").val();
						}
					}
					
					params.map = JSON.stringify(map);
					
					return params;
				};  
				
				 var renderTable = function(flag){
					 QUERY_FLAG = flag;
			        $("#table").bootstrapTable('destroy', null);
			        $("#table").bootstrapTable({
			            method : 'get',
					    url : '/WXBannerCtrl/queryAllWXBanner.ajax',
					    queryParams : queryParams,
			            striped : true,
			            pagination : true,
			            pageList : [10],
			            pageSize : 10,
			            search : false,
			            showColumns : false,
			            clickToSelect : false,
			            sidePagination:"server",//设置为服务器端分页
			            columns : [ {
			                field : 'name',
			                title : '品牌活动名称',
			                align : 'left',
			                valign : 'bottom'
			            }, {
			                field : 'img',
			                title : '活动图片',
			                align : 'left',
			                valign : 'middle'
			            },  {
			                field : 'url',
			                title : '内容',
			                align : 'left',
			                valign : 'middle',
			                width : 600
			            },  {
			                field : '',
			                title : '点击数',
			                align : 'left',
			                valign : 'middle'
			            },  {
			                field : 'order_by',
			                title : '排序',
			                align : 'left',
			                valign : 'middle'
			            }, {
			                field : 'id',
			                title : '管理',
			                align : 'left',
			                formatter: function(value,row,index){
			                	return "<a class='edit' rowid='" + value + "'>编辑</a>&nbsp;&nbsp;<a class='delete' rowid='" + value + "'>删除</a>";
			                }
			            }],
			             onLoadSuccess: function(data){
			                    	$(".edit").click(function(){
			                    		$("#updateBanner").load("/WXBannerCtrl/goWXBannerPage/" + $(this).attr("rowid") + ".htm");
			                    	});
			                    	$(".delete").click(function(){
			                    		var eventId = $(this).attr("rowid");
			                    		bootbox.confirm("您确定要删除这条记录吗?", function(result) {
											if(result){
												deleteBanner(eventId);
											}
										});
			                    	});
			             }
			        });
			    }
			});
			
			 function addBanner(){
			 	$("#addBanner").load("/WXBannerCtrl/addWXBannerPage.htm");
			 	
			 }
			function deleteBanner(data){
				var id = data;
				if(id == null || id == '' || id == 'undefined'){
					alert("参数错误!");
					return;
				}
				$.ajax({
					url:'/WXBannerCtrl/deleteWXBanner.ajax',
					type:'POST',
					data:{'id':id} ,
					dataType:'json',
					success:function(json){
						if(json.state){
							bootbox.alert("删除成功！");
							$('#table').bootstrapTable('refresh');
						}else{
							if(json.message == 'login'){
								return;
							}
						}
					},
					error:function(){
						alert("网络忙，请稍后重试！");
					}
				});
			}
		</script>
	<div id="addBanner">
	</div>
	<div id="updateBanner"></div>
	</body>
</html>