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
                                    <li>常用设置-产品分类设置</li>
                                </ul>
                                <h4>常用设置-产品分类设置</h4>
                            </div>
                        </div><!-- media -->
                    </div><!-- pageheader -->
                    
                    <div class="contentpanel">
                        <div class="alert alert-info">
                            <button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
                            <strong>说明：</strong>用于C端分类页面，产品一级分类即C端微信首页五宫格入口，二级分类为一级分类子分类
                        </div>
                         <div class="panel panel-default">
                           <div class="panel-heading">

								<div class="form-horizontal cb pt5">
									<div class="form-line">
										
										<label class="w100 fl control-label lh20">产品分类</label>
                                        <div class="cb"></div>
									</div>
								</div>
								
								<div class="pull-right mt-30">
									<button type="button"  class="btn btn-primary btn-sm" id="addFristClass"  onClick="addFristClass()">添加一级分类</button>
									<button type="button"  class="btn btn-primary btn-sm" id="addSecondClass"  onClick="addSecondClass()">添加二级分类</button>
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
					    url : '/GroupbuyClassCtrl/queryAllGoodsClass.ajax',
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
			                field : 'classId',
			                title : '分类ID',
			                align : 'left',
			                valign : 'bottom'
			            }, {
			                field : 'firstClass',
			                title : '一级分类',
			                align : 'left',
			                valign : 'middle'
			            },  {
			                field : 'secondClass',
			                title : '二级分类',
			                align : 'left',
			                valign : 'middle'
			            },  {
			                field : 'sort',
			                title : '排序',
			                align : 'left',
			                valign : 'middle'
			            }, {
			                field : 'classId',
			                title : '管理操作',
			                align : 'left',
			                formatter: function(value,row,index){
			                	return "<a class='edit' rowid='" + value + "'>编辑</a>&nbsp;&nbsp;<a class='delete' rowid='" + value + "'>删除</a>";
			                }
			            }],
			             onLoadSuccess: function(data){
			                    	$(".edit").click(function(){
			                    		$("#updateGoodClass").load("/GroupbuyClassCtrl/goUpdatePage/" + $(this).attr("rowid") + ".htm");
			                    	});
			                    	$(".delete").click(function(){
			                    		var classId = $(this).attr("rowid");
			                    		bootbox.confirm("您确定要删除这条记录吗?", function(result) {
											if(result){
												deleteGoodClass(classId);
											}
										});
			                    	});
			             }
			        });
			    }
			});
			
			 function addFristClass(){
			 	$("#addFristClass1").load("/GroupbuyClassCtrl/addFristClassPage.htm");
			 }
			 function addSecondClass(){
			 	$("#addSecondClass1").load("/GroupbuyClassCtrl/addSecondClassPage.htm");
			 }
			function deleteGoodClass(data){
				var id = data;
				if(id == null || id == '' || id == 'undefined'){
					alert("参数错误!");
					return;
				}
				$.ajax({
					url:'/GroupbuyClassCtrl/deleteGoodsClass.ajax',
					type:'POST',
					data:{'id':id} ,
					dataType:'json',
					success:function(json){
						if(json.state){
							bootbox.alert("删除成功！");
							setTimeout(function(){
								window.location.href="/GroupbuyClassCtrl/goodsClassPage.htm";
							},800);
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
	<div id="addFristClass1">
	
	</div>
	<div id="addSecondClass1"></div>
	<div id="updateGoodClass"></div>
	</body>
</html>