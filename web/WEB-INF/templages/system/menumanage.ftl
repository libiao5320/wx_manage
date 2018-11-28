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
                    <strong>说明：</strong>查看管理平台所有菜单
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading">

                        <h4 class="panel-title">菜单信息</h4>

                        <div class="pull-right mt-20">
                            <button type="button" class="btn btn-danger btn-sm" onclick="addMenu();">添加菜单</button>
                            <button type="button" class="btn btn-danger btn-sm" onclick="sortFirstMenu();">顶级菜单排序</button>
                            <button type="button" class="btn btn-danger btn-sm" onclick="sortSecondMenu();">二级菜单排序</button>
                        </div>
                    </div>
                    <div class="panel-body">
                        <div class="row">
                            <table id="table"></table>
                        </div><!-- row -->
                    </div><!-- panel-body -->
                </div>
            </div><!-- contentpanel -->
        </div>
    </div>
</section>


<script>

    var addMenu = function(){
        window.location.href = "/menu/initAdd.htm";
    }
    var sortFirstMenu = function(){
        window.location.href = "/menu/sortFirstMenu.htm";
    }
    var sortSecondMenu = function(){
        window.location.href = "/menu/sortSecondMenu.htm";
    }

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

        params.map = JSON.stringify(map);
        return params;
    };


    var deleteMenu = function(menuId){

        $.post("/menu/delete/"+menuId+".htm",null,function(data){

            var flag =  data.flag;


            if( flag ) {
                showAlert("删除成功",function(){
                    window.location.href="/menu/list.htm";
                });

            }
            else

                showAlert("删除失败");

        },"JSON");

    }

    var renderTable = function(flag){
        QUERY_FLAG = flag;
        $("#table").bootstrapTable('destroy', null);
        $("#table").bootstrapTable({
            method : 'get',
            url : '/menu/list.ajax',
            queryParams : queryParams,   //查询参数
            striped : true,
            pagination : true,
            pageList : [10],
            pageSize : 10,
            search : false,
            showColumns : false,
            clickToSelect : false,
            sidePagination:"server",//设置为服务器端分页
            columns : [ {
                field : 'menuId',
                title : '菜单ID',
                align : 'left',
                valign : 'bottom'
            }, {
                field : 'menuName',
                title : '菜单名称',
                align : 'left',
                valign : 'middle'
            },
                {
                field : 'menuPraentName',
                title : '父级菜单',
                align : 'left',
                valign : 'middle',
                 formatter: function(value,row,index){
                    if(value==''){
                        return '无';
                    }
                    else{
                        return value;
                    }
                }
            },   {
                field : 'menuLevel',
                title : '菜单级别',
                align : 'left',
                valign : 'middle',
                formatter: function(value,row,index){
                    if(value==1){
                        return '顶级菜单';
                    }
                    else{
                        return '二级菜单';
                    }
                }

            },
                {
                    field : 'menuDisplay',
                    title : '是否显示',
                    align : 'left',
                    valign : 'middle',
                    formatter: function(value,row,index){
                        if(value=='Y'){
                            return '是';
                        }
                        else{
                            return '否';
                        }
                    }

                },


                {
                    field : 'menuUrl',
                    title : '菜单URL',
                    align : 'left',
                    valign : 'middle',


                },

                {
                    field : 'menuIcon',
                    title : '菜单图标',
                    align : 'left',
                    valign : 'middle',


                }
                , {
                field : '',
                title : '操作',
                align : 'left',
                valign : 'top',
                formatter: function(value,row,index){
                    return "<a class='edit' menuId='" + row.menuId + "'>编辑</a>&nbsp;&nbsp;<a class='delete' menuId='" + row.menuId + "'>删除</a>";

                }

            }],
            onLoadSuccess: function(data){
                $(".edit").click(function(){
                    window.location.href = "/menu/update/" + $(this).attr("menuId") + ".htm";
                });
                $(".delete").click(function(){
                    var menuId = $(this).attr("menuId");
                    bootbox.confirm("您确定要删除这个菜单吗?", function(result) {
                        if(result){
                            deleteMenu(menuId);
                        }
                    });
                });
            }
        });
    };

</script>
	<div id="sortFirstMenuPage"></div>
	<div id="sortSecondMenuPage"></div>
</body>
</html>