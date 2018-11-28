<#include "../head.ftl"/>
<section>
    <div class="mainwrapper">
    <#include "../leftnav.ftl"/>
        <script type="text/javascript" src="/js/cityselect/jquery.cityselect.js"></script>
        <script src="../js/bootbox/bootbox.min.js"></script>
        <script type="text/javascript">
            $(function(){
                $("#city_5").citySelect({
                    url:'/class/queryGoodsClass.ajax',
                    prov:"",
                    city:"",
                    dist:"",
                    nodata:"none"
                });

            });
        </script>

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
                        <h4>角色管理</h4>
                    </div>
                </div><!-- media -->
            </div><!-- pageheader -->

            <div class="contentpanel">
                <div class="alert alert-info">
                    <button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
                    <strong>说明：</strong>查看管理平台所有角色
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading">

                        <h4 class="panel-title">角色信息</h4>

                        <div class="pull-right mt-20">
                            <button type="button" class="btn btn-danger btn-sm" onclick="addRole();">添加角色</button>
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

    var addRole = function(){

        window.location.href = "/role/initAdd.htm";

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
//        if(QUERY_FLAG){
//            if($("#fieldValue").val() != ''){
//                var field = $("#fieldName").val();
//                map[field] = $("#fieldValue").val();
//            }
//            if($("#sort").val() != ''){
//                map.sort = $("#sort").val();
//            }
//            if($("#goodsState").val() != ''){
//                map.goodsState = $("#goodsState").val();
//            }
//            if($("#gcId2").val() != ''){
//                map.gcId2 = $("#gcId2").val();
//            }
//        }
        params.map = JSON.stringify(map);
        return params;
    };


    var deleteRole = function(roleId){

        $.post("/role/delete/"+roleId+".htm",null,function(data){

            var flag =  data.flag;


            if( flag )
            {
                showAlert("删除成功",function(){
                    window.location.reload();
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
            url : '/role/list.ajax',
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
                field : 'roleId',
                title : '角色ID',
                align : 'left',
                valign : 'bottom'
            }, {
                field : 'roleName',
                title : '角色名称',
                align : 'left',
                valign : 'middle'
            },
                {
                field : 'roleAdmin',
                title : '是否超级管理员',
                align : 'left',
                valign : 'middle',
                    formatter: function(value,row,index){
                        if(value=='1'){
                            return '是';
                        }else{
                            return '否';
                        }
                    }

            },   {
                field : 'roleStatus',
                title : '角色状态',
                align : 'left',
                valign : 'middle',
                formatter: function(value,row,index){
                    if(value=='Y'){
                        return '正常';
                    }
                    else if(value == 'N')
                    {
                        return "异常";
                    }
                    else{
                        return '删除';
                    }
                }

            },

                {
                    field : 'roleCt',
                    title : '创建时间',
                    align : 'left',
                    valign : 'middle',


                }
                , {
                field : '',
                title : '操作',
                align : 'left',
                valign : 'top',
                formatter: function(value,row,index){
                    return "<a class='edit' roleId='" + row.roleId + "'>编辑</a>&nbsp;&nbsp;<a class='delete' roleId='" + row.roleId + "'>删除</a>";

                }

            }],
            onLoadSuccess: function(data){
                $(".edit").click(function(){
                    window.location.href = "/role/update/" + $(this).attr("roleId") + ".htm";
                });
                $(".delete").click(function(){
                    var roleId = $(this).attr("roleId");
                    bootbox.confirm("您确定要删除这个角色吗?", function(result) {
                        if(result){
                            deleteRole(roleId);
                        }
                    });
                });
            }
        });
    };

</script>
</body>
</html>