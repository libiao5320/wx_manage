<#include "../head.ftl"/>
<section>
    <div class="mainwrapper">
    <#include "../leftnav.ftl"/>
        <script type="text/javascript" src="/js/cityselect/jquery.cityselect.js"></script>
        <script src="../js/bootbox/bootbox.min.js"></script>
        <script type="text/javascript">
            $(function () {
                $("#city_5").citySelect({
                    url: '/class/queryGoodsClass.ajax',
                    prov: "",
                    city: "",
                    dist: "",
                    nodata: "none"
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
                        <h4>管理账号管理</h4>
                    </div>
                </div>
                <!-- media -->
            </div>
            <!-- pageheader -->

            <div class="contentpanel">
                <div class="alert alert-info">
                    <button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
                    <strong>说明：</strong>查看管理平台所有管理账号
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading">

                        <h4 class="panel-title">管理账号信息</h4>

                        <div class="pull-right mt-20">
                            <button type="button" class="btn btn-danger btn-sm" onclick="addManager();">添加管理账号</button>
                        </div>
                    </div>
                    <div class="panel-body">
                        <div class="row">
                            <table id="table"></table>
                        </div>
                        <!-- row -->
                    </div>
                    <!-- panel-body -->
                </div>
            </div>
            <!-- contentpanel -->
        </div>
    </div>
</section>


<script>


    var addManager = function(){

        window.location.href = "/manager/initAdd.htm";

    }

    var deleteManager = function(managerId){

        $.post("/managerId/delete/"+managerId+".htm",null,function(data){

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


    var QUERY_FLAG = false;    //是否使用了查询输入进行查询标志位
    $(document).ready(function () {
        renderTable(false);
        $("#queryBtn").click(function () {
            renderTable(true);
        });
    });

    var queryParams = function (params) {   //提交参数
        var map = {
            pageSize: params.limit,      //每页大小
            pageNo: params.offset / 10 + 1 //页码
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

    var renderTable = function (flag) {
        QUERY_FLAG = flag;
        $("#table").bootstrapTable('destroy', null);
        $("#table").bootstrapTable({
            method: 'get',
            url: '/manager/list.ajax',
            queryParams: queryParams,   //查询参数
            striped: true,
            pagination: true,
            pageList: [10],
            pageSize: 10,
            search: false,
            showColumns: false,
            clickToSelect: false,
            sidePagination: "server",//设置为服务器端分页
            columns: [{
                field: 'mamangerId',
                title: '管理员ID',
                align: 'left',
                valign: 'bottom'
            }, {
                field: 'managerLoginName',
                title: '登录帐号',
                align: 'left',
                valign: 'middle'
            },{
                field: 'managerName',
                title: '管理员名称',
                align: 'left',
                valign: 'middle'
            },{
                field: 'managerRoleName',
                title: '管理员角色',
                align: 'left',
                valign: 'middle'
            }, {
                field: 'managerPhone',
                title: '管理员手机',
                align: 'left',
                valign: 'middle'
            }, {
                field: 'managerQQ',
                title: '管理员QQ',
                align: 'left',
                valign: 'middle'
            }, {
                field: 'managerMail',
                title: '管理员邮箱',
                align: 'left',
                valign: 'middle'

            }, {
                field: 'managerStatue',
                title: '管理员状态',
                align: 'left',
                valign: 'middle',
                formatter: function (value, row, index) {
                    if (value == 'Y') {
                        return '正常';
                    }
                    else if (value == 'N') {
                        return "异常";
                    }
                    else {
                        return '删除';
                    }
                }
            },
            {
                field: 'managerRemark',
                title: '管理员备注',
                align: 'left',
                valign: 'middle'
            }
            , {
                field: 'managerCt',
                title: '管理员创建时间',
                align: 'left',
                valign: 'middle'

            }
            , {
                field: '',
                title: '操作',
                align: 'left',
                valign: 'top',
                formatter: function (value, row, index) {
                    return "<a class='edit' managerId='" + row.mamangerId + "'>编辑</a>&nbsp;&nbsp;<a class='delete' managerId='" + row.mamangerId + "'>删除</a>";

                }

            }],
            onLoadSuccess: function (data) {
                $(".edit").click(function () {
                    window.location.href = "/manager/update/" + $(this).attr("managerId") + ".htm";
                });
                $(".delete").click(function () {
                    var managerId = $(this).attr("managerId");
                    bootbox.confirm("您确定要删除这个管理账号吗?", function (result) {
                        if (result) {
                            deleteManager(managerId);
                        }
                    });
                });
            }
        });
    };

</script>
</body>
</html>