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
                        <h4>添加菜单</h4>
                    </div>
                </div>
                <!-- media -->
            </div>
            <!-- pageheader -->

            <div class="contentpanel">
                <div class="alert alert-info">
                    <button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
                    <strong>说明：</strong>编辑菜单信息，再点击保存
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading">

                        <h4 class="panel-title">添加菜单</h4>

                        <div class="pull-right mt-30">
                            <button type="button" class="btn btn-danger btn-sm" onclick="addMenu();">保存菜单</button>
                                             </div>
                    </div>
                    <!-- panel-heading -->
                    <form id="menuForm" action="/menu/add.htm" method="post" class="form-horizontal form-bordered" >
                        <div id="info_panel" class="panel-body">
                            <div class="panel-body nopadding">


                                <div class="form-group">
                                    <label class="col-sm-3 control-label">*菜单名称：</label>

                                    <div class="col-sm-7">
                                        <input type="text" placeholder="" name="map[menuName]"
                                               class="form-control input-sm">
                                    </div>
                                </div>


                                <div class="form-group">
                                    <label class="col-sm-3 control-label">*父级菜单：</label>

                                    <div class="col-sm-7">
                                        <select name="map[menuParent]">
                                            <option value="-1"> 顶级菜单</option>
                                            <#if topMenus?? && topMenus?size gt 0 >

                                            <#list topMenus as topmenu>

                                                <option value="${topmenu.menuId}"> ${topmenu.menuName}</option>
                                            </#list>

                                            </#if>
                                        </select>
                                    </div>
                                </div>


                                <div class="form-group" id="js_menu_parent" style="display: none;">
                                    <label class="col-sm-3 control-label">*菜单URL：</label>

                                    <div class="col-sm-7">
                                        <input type="text" placeholder="" name="map[menuUrl]"
                                               class="form-control input-sm">
                                    </div>
                                </div>



                                <!-- form-group -->

                            </div>
                            <!-- panel-body -->
                        </div>


                    <#--<input type="hidden" name="map[privilege]" value=""/>-->
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


    var addMenu = function(){

        var _menuParent= $("select[name='map[menuParent]']").find("option:selected").val();
//        var _type = $("#js_privilge_type").find("option:selected").val();

        if( "" == $("input[name='map[menuName]']").val() )
        {

            showAlert("请输入菜单名称");
            return false;
        }



        if( "-1" != _menuParent)
        {
            if($("input[name='map[menuUrl]']").val() == "")
            {
                showAlert("请输入菜单URL");
                return false;
            }
        }




        $("#menuForm").submit();
    }


    $(function () {
        $("select[name='map[menuParent]']").on("change",function(){
            var _this  = this;
            var _type = $(_this).find("option:selected").val();



            if(_type == '-1')
            {
                $("#js_menu_parent").hide();
            }
            else
            {
                $("#js_menu_parent").show();
            }

        });
    });







</script>

</body>
</html>