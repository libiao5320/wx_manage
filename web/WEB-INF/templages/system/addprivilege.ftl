<#include "../head.ftl"/>

<link rel="stylesheet" type="text/css" href="/css/wangedit/wangEditor-1.4.0.css">
<section>
    <div class="mainwrapper">
    <#include "../leftnav.ftl"/>
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
                        <h4>添加权限</h4>
                    </div>
                </div>
                <!-- media -->
            </div>
            <!-- pageheader -->

            <div class="contentpanel">
                <div class="alert alert-info">
                    <button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
                    <strong>说明：</strong>编辑权限信息，再点击保存
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading">

                        <h4 class="panel-title">添加权限</h4>

                        <div class="pull-right mt-30">
                            <button type="button" class="btn btn-danger btn-sm" onclick="addPrivilege();">保存权限</button>
                                             </div>
                    </div>
                    <!-- panel-heading -->
                    <form id="privilegeForm" action="/priviage/add.htm" method="post" class="form-horizontal form-bordered" >
                        <div id="info_panel" class="panel-body">
                            <div class="panel-body nopadding">


                                <div class="form-group">
                                    <label class="col-sm-3 control-label">*权限名称：</label>

                                    <div class="col-sm-7">
                                        <input type="text" placeholder="" name="map[privilegeName]"
                                               class="form-control input-sm">
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-sm-3 control-label">*权限类型：</label>

                                    <div class="col-sm-7">
                                        <select id="js_privilge_type" name="map[type]">
                                            <option value="URL">功能权限</option>
                                            <option value="MENU">菜单权限</option>
                                        </select>
                                    </div>
                                </div>


                                <div class="form-group" id="js_privilege_url" >
                                    <label class="col-sm-3 control-label">*权限URL：</label>

                                    <div class="col-sm-7">
                                        <input type="text" placeholder="" name="map[url]"
                                               class="form-control input-sm">
                                    </div>
                                </div>


                                <div class="form-group" style="display: none;" id="js_privilege_menu">
                                    <label class="col-sm-3 control-label">*权限菜单：</label>

                                    <div class="col-sm-7">
                                        <select name="map[menu]">
                                            <#if menuList?? && menuList?size gt 0>
                                            <#list menuList as menu >
                                                    <option value="${menu.menuId !0}">${menu.menuName !""}</option>
                                            </#list>
                                            </#if>

                                        </select>
                                    </div>
                                </div>


                                <div class="form-group">
                                    <label class="col-sm-3 control-label">*权限备注：</label>

                                    <div class="col-sm-7">
                                        <input type="text" placeholder="" name="map[remark]"
                                               class="form-control input-sm">
                                    </div>
                                </div>


                                <div class="form-group">
                                    <label class="col-sm-3 control-label">*权限关键字：</label>

                                    <div class="col-sm-7">
                                        <input type="text" placeholder="" name="map[key]"
                                               class="form-control input-sm">
                                    </div>
                                </div>

                                <!-- form-group -->

                            </div>
                            <!-- panel-body -->
                        </div>



                    </form>
                </div>

            </div>
            <!-- contentpanel -->
        </div>
        <!-- mainpanel -->
    </div>
    <!-- mainwrapper -->
</section>
<script src="/js/wangedit/wangEditor-1.4.0.min.js"></script>
<script src="/js/ajaxfileupload/ajaxfileupload.js"></script>
<script src="/js/bootbox/bootbox.min.js"></script>
<script defer="defer">


    var addPrivilege = function(){


        var _type = $("#js_privilge_type").find("option:selected").val();

        if( "" == $("input[name='map[privilegeName]']").val() )
        {

            showAlert("请输入权限名称");
            return false;
        }


        if( _type == "URL" )
        {
            if( "" == $("input[name='map[url]']").val() )
            {

                showAlert("请输入权限URL");
                return false;
            }
        }



        $("#privilegeForm").submit();
    }


    $(function () {
            $("#js_privilge_type").on("change",function(){
                var _this  = this;
                var _type = $(_this).find("option:selected").val();



                if(_type == 'MENU')
                {
                    $("#js_privilege_menu").show();
                    $("#js_privilege_url").hide();
                }
                else
                {


                    $("#js_privilege_menu").hide();
                    $("#js_privilege_url").show();
                }

            });
    });




</script>

</body>
</html>