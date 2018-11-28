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
                            <button type="button" class="btn btn-danger btn-sm" onclick="editRole();">保存权限</button>
                        </div>
                    </div>
                    <!-- panel-heading -->
                    <form id="roleForm" action="/role/update.htm" method="post" class="form-horizontal form-bordered" >
                        <div id="info_panel" class="panel-body">
                            <div class="panel-body nopadding">


                                <div class="form-group">
                                    <label class="col-sm-3 control-label">*角色名称：</label>

                                    <div class="col-sm-7">
                                        <input type="text" placeholder="" name="map[roleName]"
                                               class="form-control input-sm" value="${role.roleName}">
                                    </div>
                                </div>



                                <div class="form-group">
                                    <label class="col-sm-3 control-label">*角色权限：</label>

                                    <div class="col-sm-7">
                                    <#assign count=1>
                                    <#if  privilegs?? && privilegs?size gt 0 >
                                        <#list privilegs as privilege>


                                            <#assign flag=0>
                                            <#if  role.privileges?? && role.privileges?size gt 0>
                                            <#list role.privileges as rolepri>

                                                        <#if privilege.privilegeId == rolepri.privilegeId>
                                                            <#assign flag= 1>
                                                        </#if>

                                            </#list>
                                            </#if>

                                            <input type="checkbox" name="privilege" value="${privilege.privilegeId}" <#if flag == 1>checked</#if>/>${privilege.privilegeName}
                                            <#if (count%7) == 0 >
                                                <br/>
                                            </#if>
                                            <#assign count= (count+1)>
                                        </#list>
                                    </#if>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-3 control-label">*角色状态：</label>

                                    <div class="col-sm-7 checkbox">
                                        <input type="radio" placeholder="" name="map[roleStatus]" value="Y" <#if role.roleStatus == 'Y'> checked="checked" </#if>>正常
                                        <input type="radio" placeholder="" name="map[roleStatus]" value="N" <#if role.roleStatus == 'N'> checked="checked" </#if>>异常
                                        <input type="radio" placeholder="" name="map[roleStatus]" value="D" <#if role.roleStatus == 'D'> checked="checked" </#if>>删除
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-3 control-label">*是否为管理员：</label>

                                    <div class="col-sm-7 checkbox">
                                        <input type="radio" placeholder="" name="map[roleAdmin]" value="1" <#if role.roleAdmin == 1> checked="checked" </#if>>是
                                        <input type="radio" placeholder="" name="map[roleAdmin]" value="0" <#if role.roleAdmin == 0> checked="checked" </#if>>否
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-3 control-label">*角色关键字：</label>

                                    <div class="col-sm-7">
                                        <input type="text" placeholder="" name="map[key]"
                                               class="form-control input-sm" value="${role.roleKeyword}">
                                    </div>
                                </div>

                                <!-- form-group -->

                            </div>
                            <!-- panel-body -->
                        </div>


                        <input type="hidden" name="map[privilege]" value=""/>
                        <input type="hidden" name="map[roleId]" value="${role.roleId}"/>
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


    var editRole = function () {


        if( "" == $("input[name='map[roleName]']").val() )
        {

            showAlert("请输入角色名称");
            return false;
        }

        var privilegeVal  = $("input[name='privilege']:checked").map(function(index,elem) {
            return $(elem).val();
        }).get().join(',');

        if( "" == privilegeVal)
        {
            showAlert("请选择角色权限");
            return false;
        }

        $("input[name='map[privilege]']").val(privilegeVal);


        $("#roleForm").submit();
    }





</script>

</body>
</html>