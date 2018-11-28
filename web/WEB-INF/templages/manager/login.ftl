<!DOCTYPE html>
<html lang="en" class="js flexbox flexboxlegacy canvas canvastext webgl no-touch geolocation postmessage websqldatabase indexeddb hashchange history draganddrop websockets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshadow textshadow opacity cssanimations csscolumns cssgradients cssreflections csstransforms csstransforms3d csstransitions fontface generatedcontent video audio localstorage sessionstorage webworkers applicationcache svg inlinesvg smil svgclippaths">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>登录</title>

    <link href="/css/style.default.css" rel="stylesheet">

    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="/js/html5shiv.js"></script>
    <script src="/js/respond.min.js"></script>
    <![endif]-->
</head>

<body class="signin  pace-done">
<div class="pace  pace-inactive">
    <div class="pace-progress" data-progress-text="100%" data-progress="99" style="width: 100%;">
        <div class="pace-progress-inner"></div>
    </div>
    <div class="pace-activity"></div>
</div>


<section>

    <div class="panel panel-signin">
        <div class="panel-body">
            <div class="logo text-center">
                <img src="/images/logo-primary.png" alt="Chain Logo">
            </div>
            <br>
            <h4 class="text-center mb5">融耀运营管理系统</h4>
            <p class="text-center">登录管理系统</p>

            <div class="mb30"></div>
            <div class="text-center" style="color:red;">${error !''}</div>

            <form action="/mana/login.htm" id="loginForm" method="post">
                <div class="input-group mb15">
                    <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                    <input type="text" class="form-control" name="managerLoginName" placeholder="用户名" value="${managerLoginName !''}">
                </div><!-- input-group -->
                <div class="input-group mb15">
                    <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
                    <input type="password" class="form-control" name="managerLoginPwd" placeholder="密码" value="${managerLoginPwd !''}">
                </div><!-- input-group -->

                <div class="clearfix">
                    <div class="pull-left">
                        <div class="ckbox ckbox-primary mt10">
                            <input type="checkbox" name="rememberMe" id="rememberMe" <#if rememberMe?? && (rememberMe == 1)> value="1" checked="checked" <#else>  value="0" </#if>/>
                            <label for="rememberMe">记住我</label>
                        </div>
                    </div>
                    <div class="pull-right">
                        <button type="submit" id="login-btn" class="btn btn-success">登录 <i class="fa fa-angle-right ml5"></i></button>
                    </div>
                </div>
            </form>

        </div><!-- panel-body -->

    </div><!-- panel -->

</section>


<script async="" src="/js/analytics/analytics.js"></script>
<script src="/js/jquery-1.11.1/jquery-1.11.1.min.js"></script>
<script src="/js/jquery-migrate-1.2.1/jquery-migrate-1.2.1.min.js"></script>
<script src="/js/bootstrap/bootstrap.min.js"></script>
<script src="/js/modernizr/modernizr.min.js"></script>
<script src="/js/pace/pace.min.js"></script>
<script src="/js/retina/retina.min.js"></script>
<script src="/js/jquery.cookies/jquery.cookies.js"></script>

<script src="js/custom/login.js"></script>
<script>
	$("#rememberMe").click(function(){
		if(this.checked){
			$("#rememberMe").val(1);
		}else{
			$("#rememberMe").val(0);
		}
	});
</script>
</body>
</html>