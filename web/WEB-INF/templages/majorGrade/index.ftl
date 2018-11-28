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
                                    <li>常用设置-专业等级设置</li>
                                </ul>
                                <h4>常用设置-专业等级设置</h4>
                            </div>
                        </div><!-- media -->
                    </div><!-- pageheader -->
                    
                    <div class="contentpanel">
                        <div class="alert alert-info">
                            <button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
                            <strong>说明：</strong>编辑健康师专业等级
                        </div>
                         <div class="panel panel-default">
                           <div class="panel-heading">

								<div class="form-horizontal cb pt5">
									<div class="form-line">
										
										<label class="w100 fl control-label lh20">专业等级</label>
                                        <div class="cb"></div>
									</div>
								</div>
								
								<div class="pull-right mt-30">
									<button type="button"  class="btn btn-primary btn-sm" id="addMajor"  onClick="addMajor()">添加专业</button>
									<button type="button"  class="btn btn-primary btn-sm" id="addGrade"  onClick="addGrade()">添加等级</button>
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
				$(document).ready(function(){
					renderTable();
					$("#queryBtn").click(function(){
						renderTable();
					});
				});
			
				var queryParams = function(params){   //提交参数
					var map = {
						pageSize : params.limit,      //每页大小
						pageNo : params.offset/10 + 1 //页码
					};
					
					params.map = JSON.stringify(map);
					
					return params;
				};  
				
				 var renderTable = function(){
			        $("#table").bootstrapTable('destroy', null);
			        $("#table").bootstrapTable({
			            method : 'get',
					    url : '/majorGrade/list.ajax',
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
			                title : '专业ID',
			                align : 'left',
			                valign : 'bottom'
			            }, {
			                field : 'firstClass',
			                title : '专业',
			                align : 'left',
			                valign : 'middle'
			            },  {
			                field : 'secondClass',
			                title : '等级',
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
			                	return "<a class='edit' rowid='" + value + "' grade='"+ row.secondClass +"'>编辑</a>&nbsp;&nbsp;<a class='delete' rowid='" + value + "'>删除</a>";
			                }
			            }],
			             onLoadSuccess: function(data){
		                    	$(".edit").click(function(){
		                    		$("#editPage").load("/majorGrade/editPage/" + $(this).attr("rowid") + "/" + $(this).attr("grade") +".htm");
		                    	});
		                    	$(".delete").click(function(){
		                    		var classId = $(this).attr("rowid");
		                    		bootbox.confirm("您确定要删除这条记录吗?", function(result) {
										if(result){
											deleteMajor(classId);
										}
									});
		                    	});
			             }
			        });
			    }
			});
			
			 function addMajor(){
			 	$("#addMajorPage").load("/majorGrade/addMajorPage.htm");
			 }
			 function addGrade(){
			 	$("#addGradePage").load("/majorGrade/addGradePage.htm");
			 }
			 
			function deleteMajor(data){
				var id = data;
				if(id == null || id == '' || id == 'undefined'){
					alert("参数错误!");
					return;
				}
				$.ajax({
					url:'/majorGrade/deleteMajorGrade.ajax',
					type:'POST',
					data:{'id':id} ,
					dataType:'json',
					success:function(json){
						if(json.state){
							bootbox.alert("删除成功！");
							setTimeout(function(){
								window.location.href="/majorGrade/index.htm";
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
	<div id="addMajorPage"></div>
	<div id="addGradePage"></div>
	<div id="editPage"></div>
	</body>
</html>