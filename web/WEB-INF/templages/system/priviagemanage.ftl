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
                        <h4>权限管理</h4>
                    </div>
                </div><!-- media -->
            </div><!-- pageheader -->

            <div class="contentpanel">
                <div class="alert alert-info">
                    <button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
                    <strong>说明：</strong>编辑管理平台所有权限
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading">

                        <h4 class="panel-title">权限信息</h4>

                        <div class="pull-right mt-20">
                            <button type="button" class="btn btn-danger btn-sm" onclick="addPrivilege();">添加权限</button>
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


    var addPrivilege = function(){

        window.location.href = "/priviage/initAdd.htm";

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


    var deletePrivilege = function(priId){

        $.post("/priviage/delete/"+priId+".htm",null,function(data){

            var flag =  data.flag;


            if( flag ) {
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
            url : '/priviage/list.ajax',
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
                field : 'privilegeId',
                title : '权限ID',
                align : 'left',
                valign : 'bottom'
            }, {
                field : 'privilegeName',
                title : '权限名称',
                align : 'left',
                valign : 'middle'
            },  {
                field : 'privilegeType',
                title : '权限类型',
                align : 'left',
                valign : 'middle',
                formatter: function(value,row,index){
                    if(value=='MENU'){
                        return '菜单类型';
                    }else{
                        return '功能类型';
                    }
                }
            },  {
                field : 'privilegeUrl',
                title : '权限URL',
                align : 'left',
                valign : 'middle'
            },  {
                field : 'privilegeRemark',
                title : '权限备注',
                align : 'left',
                valign : 'middle'

            },   {
                field : 'privilegeStatus',
                title : '权限状态',
                align : 'left',
                valign : 'middle',
                formatter: function(value,row,index){
                    if(value=='Y'){
                        return '启用';
                    }else{
                        return '停用';
                    }
                }

            }, {
                field : '',
                title : '操作',
                align : 'left',
                valign : 'top',
                formatter: function(value,row,index){
                    return "<a class='edit' privilegeId='" + row.privilegeId + "'>编辑</a>&nbsp;&nbsp;<a class='delete' privilegeId='" + row.privilegeId + "'>删除</a>";

                }

            }],
            onLoadSuccess: function(data){
                $(".edit").click(function(){
                    window.location.href = "/priviage/update/" + $(this).attr("privilegeId") + ".htm";
                });
                $(".delete").click(function(){
                    var privilegeId = $(this).attr("privilegeId");
                    bootbox.confirm("您确定要删除这个权限吗?", function(result) {
                        if(result){
                            deletePrivilege(privilegeId);
                        }
                    });
                });
            }
        });
    };

</script>
</body>
</html>