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
                        <h4>修改权限</h4>
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

                        <h4 class="panel-title">修改权限</h4>

                        <div class="pull-right mt-30">
                            <button type="button" class="btn btn-danger btn-sm" onclick="editPrivilege();">保存权限</button>
                        </div>
                    </div>
                    <!-- panel-heading -->
                    <form id="privilegeForm" action="/priviage/update.htm" method="post"
                          class="form-horizontal form-bordered">
                        <div id="info_panel" class="panel-body">
                            <div class="panel-body nopadding">


                                <div class="form-group">
                                    <label class="col-sm-3 control-label">*权限名称：</label>

                                    <div class="col-sm-7">
                                        <input type="text" placeholder="" name="map[privilegeName]"
                                               value="${privilege.privilegeName !''}"
                                               class="form-control input-sm">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-3 control-label">*权限状态：</label>

                                    <div class="col-sm-7 checkbox">
                                        <input type="radio" placeholder="" name="map[privilegeStatus]"
                                               value="Y" <#if privilege.privilegeStatus == 'Y'> checked="checked" </#if>/>启用
                                        <input type="radio" placeholder="" name="map[privilegeStatus]"
                                               value="N" <#if privilege.privilegeStatus == 'N'> checked="checked" </#if>/>停用
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-sm-3 control-label">*权限类型：</label>

                                    <div class="col-sm-7">
                                        <select id="js_privilge_type" name="map[privilegeType]">

                                        <#if privilege.privilegeType == "URL">
                                            <option value="URL" selected="true">功能权限</option>
                                            <option value="MENU">菜单权限</option>
                                        <#else>
                                            <option value="URL">功能权限</option>
                                            <option value="MENU" selected="true">菜单权限</option>
                                        </#if>

                                        </select>
                                    </div>
                                </div>


                                <div class="form-group" id="js_privilege_url"     <#if privilege.privilegeType == "MENU">style="display: none;"</#if> >
                                    <label class="col-sm-3 control-label">*权限URL：</label>

                                    <div class="col-sm-7">
                                        <input type="text" placeholder="" name="map[privilegeUrl]"
                                               class="form-control input-sm" value="${privilege.privilegeUrl !''}">
                                    </div>
                                </div>


                                <div class="form-group" <#if privilege.privilegeType == "URL">style="display: none;"</#if> id="js_privilege_menu">
                                    <label class="col-sm-3 control-label">*权限菜单： </label>

                                    <div class="col-sm-7">
                                        <select name="map[menuId]">
                                        <#if menuList?? && menuList?size gt 0>
                                            <#list menuList as menu >
                                                <#if privilege.privilegeType == 'MENU' && menu.menuId == privilege.menuId>
                                                    <option value="${menu.menuId !0}"
                                                            selected="true">${menu.menuName !""}</option>
                                                <#else>
                                                    <option value="${menu.menuId !0}">${menu.menuName !""}</option>
                                                </#if>
                                            </#list>
                                        </#if>

                                        </select>
                                    </div>
                                </div>


                                <div class="form-group">
                                    <label class="col-sm-3 control-label">*权限备注：</label>

                                    <div class="col-sm-7">
                                        <input type="text" placeholder="" name="map[privilegeRemark]"
                                               class="form-control input-sm" value="${privilege.privilegeRemark !''}">
                                    </div>
                                </div>


                                <div class="form-group">
                                    <label class="col-sm-3 control-label">*权限关键字：</label>

                                    <div class="col-sm-7">
                                        <input type="text" placeholder="" name="map[privilegeKey]"
                                               class="form-control input-sm" value="${privilege.privilegeKey !''}">
                                    </div>
                                </div>

                                <!-- form-group -->

                            </div>
                            <!-- panel-body -->
                        </div>
                        <input type="hidden" name="map[privilegeId]" value="${privilege.privilegeId !''}"/>
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


    var editPrivilege = function () {


        var _type = $("#js_privilge_type").find("option:selected").val();

        if ("" == $("input[name='map[privilegeName]']").val()) {

            showAlert("请输入权限名称");
            return false;
        }


        if (_type == "URL") {
            if ("" == $("input[name='map[privilegeUrl]']").val()) {

                showAlert("请输入权限URL");
                return false;
            }
        }


        $("#privilegeForm").submit();
    }


    $(function () {
        $("#js_privilge_type").on("change", function () {


            var _this = this;
            var _type = $(_this).find("option:selected").val();


            if (_type == 'MENU') {


                $("#js_privilege_menu").show();
                $("#js_privilege_url").hide();
            }
            else {


                $("#js_privilege_menu").hide();
                $("#js_privilege_url").show();
            }

        });
    });


</script>

</body>
</html>