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
                        <h4>修改管理员信息</h4>
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

                        <h4 class="panel-title">修改管理员信息</h4>

                        <div class="pull-right mt-30">
                            <button type="button" class="btn btn-danger btn-sm" onclick="addManager();">保存角色</button>
                                             </div>
                    </div>
                    <!-- panel-heading -->
                    <form id="roleForm" action="/manager/update.htm" method="post" class="form-horizontal form-bordered" >
                        <div id="info_panel" class="panel-body">
                            <div class="panel-body nopadding">


                                <div class="form-group">
                                    <label class="col-sm-3 control-label">*登录账号：</label>

                                    <div class="col-sm-7">
                                        <input type="text" placeholder="" name="map[loginName]"
                                               class="form-control input-sm" value="${manager.managerLoginName}">
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-sm-3 control-label">*登录密码：</label>

                                    <div class="col-sm-7">
                                        <input type="password" placeholder="" name="map[loginPwd]"
                                               class="form-control input-sm" value="${manager.managerLoginPwd}">
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-sm-3 control-label">*确认登录密码：</label>

                                    <div class="col-sm-7">
                                        <input type="password" placeholder="" name="map[loginPwdSure]"
                                               class="form-control input-sm" value="${manager.managerLoginPwd}">
                                    </div>
                                </div>

                               <div class="form-group">
                                    <label class="col-sm-3 control-label">*管理员状态：</label>
                                    <div class="col-sm-7 checkbox">
                                        <input type="radio" placeholder="" name="map[managerStatue]" value="Y" <#if manager.managerStatue == 'Y'> checked="checked" </#if>>正常
                                        <input type="radio" placeholder="" name="map[managerStatue]" value="N" <#if manager.managerStatue == 'N'> checked="checked" </#if>>异常
                                        <input type="radio" placeholder="" name="map[managerStatue]" value="D" <#if manager.managerStatue == 'D'> checked="checked" </#if>>删除
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-sm-3 control-label">*角色：</label>

                                    <div class="col-sm-7">
                                    <#assign count=1>
                                    <#if  roles?? && roles?size gt 0 >
                                        <#list roles as role>
                                            <#assign flag=0>
                                            <#if  manager.role?? && manager.role?size gt 0>
                                                <#list manager.role as ro>

                                                    <#if role.roleId == ro.roleId>
                                                        <#assign flag= 1>
                                                    </#if>
                                                </#list>
                                            </#if>
                                            <input type="checkbox" name="role" value="${role.roleId}" <#if flag == 1>checked</#if>/> ${role.roleName}
                                            <#if (count%7) == 0 >
                                                <br/>
                                            </#if>
                                            <#assign count= (count+1)>
                                        </#list>
                                    </#if>
                                    </div>
                                </div>


                                <div class="form-group">
                                    <label class="col-sm-3 control-label">*管理者真实姓名：</label>

                                    <div class="col-sm-7">
                                        <input type="text" placeholder="" name="map[name]"
                                               class="form-control input-sm" value="${manager.managerName}">
                                    </div>
                                </div>


                                <div class="form-group">
                                    <label class="col-sm-3 control-label">*手机：</label>

                                    <div class="col-sm-7">
                                        <input type="text" placeholder="" name="map[phone]"
                                               class="form-control input-sm" value="${manager.managerPhone}">
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-sm-3 control-label">*QQ：</label>

                                    <div class="col-sm-7">
                                        <input type="text" placeholder="" name="map[qq]"
                                               class="form-control input-sm" value="${manager.managerQQ}">
                                    </div>
                                </div>


                                <div class="form-group">
                                    <label class="col-sm-3 control-label">*邮箱账号：</label>

                                    <div class="col-sm-7">
                                        <input type="text" placeholder="" name="map[mail]"
                                               class="form-control input-sm" value="${manager.managerMail}">
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-sm-3 control-label">备注：</label>

                                    <div class="col-sm-7">
                                        <input type="text" placeholder="" name="map[remark]"
                                               class="form-control input-sm" value="${manager.managerRemark}" >
                                    </div>
                                </div>


                                <!-- form-group -->

                            </div>
                            <!-- panel-body -->
                        </div>


                        <input type="hidden" name="map[role]" value=""/>
                        <input type="hidden" name="map[managerId]" value="${manager.mamangerId}"/>
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


    var addManager = function(){


//        var _type = $("#js_privilge_type").find("option:selected").val();

        if( "" == $("input[name='map[loginName]']").val() )
        {

            showAlert("请输入登录帐号");
            return false;
        }

        if( "" == $("input[name='map[loginPwd]']").val() )
        {

            showAlert("请输入登录密码");
            return false;
        }

        if( $("input[name='map[loginPwd]']").val() != $("input[name='map[loginPwdSure]']").val() )
        {

            showAlert("两次密码不一致");
            return false;
        }


        if( "" == $("input[name='map[name]']").val() )
        {

            showAlert("请输入真实姓名");
            return false;
        }

        if( "" == $("input[name='map[phone]']").val() )
        {

            showAlert("请输入手机号码");
            return false;
        }

        if( "" == $("input[name='map[qq]']").val() )
        {

            showAlert("请输入QQ号码");
            return false;
        }

        if( "" == $("input[name='map[mail]']").val() )
        {

            showAlert("请输入邮箱");
            return false;
        }





        var roleVal  = $("input[name='role']:checked").map(function(index,elem) {
            return $(elem).val();
        }).get().join(',');

        if( "" == roleVal)
        {
            showAlert("请选择角色");
            return false;
        }

        $("input[name='map[role]']").val(roleVal);


        $("#roleForm").submit();
    }







</script>

</body>
</html>