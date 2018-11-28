<#include "../head.ftl"/>
<section>
    <div class="mainwrapper">
    <#include "../leftnav.ftl"/>
        <script type="text/javascript" src="/js/cityselect/jquery.cityselect.js"></script>
        <script src="../js/bootbox/bootbox.min.js"></script>

        <div class="mainpanel">
            <div class="pageheader">
                <div class="media">
                    <div class="pageicon pull-left">
                        <i class="fa fa-bars"></i>
                    </div>
                    <div class="media-body">
                        <ul class="breadcrumb">
                            <li><a href=""><i class="fa fa-home"></i></a></li>
                            <li>系统设置</li>
                        </ul>
                        <h4>菜单管理</h4>
                    </div>
                </div><!-- media -->
            </div><!-- pageheader -->

            <div class="contentpanel">
                <div class="alert alert-info">
                    <button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
                    <strong>说明：</strong>二级菜单排序
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading">
	                    <div class="form-line">
	                        <select class="select2 w160 fl" id="topMenu">
	                        	<#if menus ?? && menus?size gt 0>
	                        		<#list menus as menu>
	                          		<option value="${menu.menuId}">${menu.menuName}</option>
	                          		</#list>
	                      		</#if>
	                        </select>
	                        <div class="cb"></div>
	                    </div>
                    </div>
                    <div class="panel-body">
                        <div class="row">
                            <table id="table"></table>
                        </div><!-- row -->
                    </div><!-- panel-body -->
                    <div class="center">
                    	<button id="goback" class="btn btn-primary btn-xs">返回</button>
                    </div>
                </div>
            </div><!-- contentpanel -->
        </div>
    </div>
</section>


<script>
    $(document).ready(function(){
        renderTable();
        $("#topMenu").change(function(){
        	renderTable();
        });
        $("#goback").click(function(){
        	window.location.href = "/menu/list.htm";
        });
    });

     var renderTable = function(){
        $("#table").bootstrapTable('destroy', null);
        $("#table").bootstrapTable({
            method : 'get',
            url : '/menu/getChildMenu/' + $("#topMenu").val() + '.ajax',
            striped : true,
            pagination : false,
            search : false,
            showColumns : false,
            clickToSelect : false,
           sidePagination:"server",//设置为服务器端分页
            columns : [ {
                field : 'menuId',
                title : '菜单ID',
                align : 'left',
                valign : 'middle'
            }, {
                field : 'menuName',
                title : '菜单名称',
                align : 'left',
                valign : 'middle'
            }, {
                field : 'menuId',
                title : '操作',
                align : 'left',
                valign : 'middle',
                formatter: function(value,row,index){
                	return "<a class='crp' onclick='upMenu(" + value + ")'>上移</a>&nbsp;&nbsp;<a class='crp' onclick='downMenu(" + value + ")'>下移</a>";
                }
            }]
        });
    };
    
    var upMenu = function(menuId){
    	$.ajax({
			url:'/menu/upMenu.ajax',
			type:'POST',
			data:{'menuId':menuId} ,
			dataType:'json',
			success:function(json){
				if(json.state == 1){
					$('#table').bootstrapTable('refresh');
				}else{
					bootbox.alert(json.message);
				}
			},
			error:function(){
				bootbox.alert("网络忙，请稍后重试！");
			}
		});
    };
    
    var downMenu = function(menuId){
    	$.ajax({
			url:'/menu/downMenu.ajax',
			type:'POST',
			data:{'menuId':menuId} ,
			dataType:'json',
			success:function(json){
				if(json.state == 1){
					$('#table').bootstrapTable('refresh');
				}else{
					bootbox.alert(json.message);
				}
			},
			error:function(){
				bootbox.alert("网络忙，请稍后重试！");
			}
		});
    };
</script>
</body>
</html>
