<!DOCTYPE html>
<!-- saved from url=(0052)http://themepixels.com/demo/webpage/chain/index.html -->
<html lang="en" class="js flexbox flexboxlegacy canvas canvastext webgl no-touch geolocation postmessage websqldatabase indexeddb hashchange history draganddrop websockets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshadow textshadow opacity cssanimations csscolumns cssgradients cssreflections csstransforms csstransforms3d csstransitions fontface generatedcontent video audio localstorage sessionstorage webworkers applicationcache svg inlinesvg smil svgclippaths">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
        <meta name="description" content="">
        <meta name="author" content="">

        <title>融耀运营管理系统</title>
        <link rel="stylesheet" href="/css/bootstrap-table/bootstrap-table.css">
		<link href="/css/select2/select2.css" rel="stylesheet">
        <link href="/css/style.default.css" rel="stylesheet">
        <link href="http://cdn.bootcss.com/summernote/0.8.1/summernote.css" rel="stylesheet">
        <link href="/css/bootstarp-date/bootstrap-datetimepicker.min.css" rel="stylesheet">
        <!--<link href="http://themepixels.com/demo/webpage/chain//css/morris.css" rel="stylesheet">
        <link href="http://themepixels.com/demo/webpage/chain/css/select2.css" rel="stylesheet">-->

        <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!--[if lt IE 9]>
        <script src="/js/html5shiv.js"></script>
        <script src="/js/respond.min.js"></script>
        <![endif]-->
		<style type="text/css">
		.jqstooltip { position: absolute;left: 0px;top: 0px;visibility: hidden;background: rgb(0, 0, 0) transparent;background-color: rgba(0,0,0,0.6);filter:progid:DXImageTransform.Microsoft.gradient(startColorstr=#99000000, endColorstr=#99000000);-ms-filter: "progid:DXImageTransform.Microsoft.gradient(startColorstr=#99000000, endColorstr=#99000000)";color: white;font: 10px arial, san serif;text-align: left;white-space: nowrap;padding: 5px;border: 1px solid white;z-index: 10000;}.jqsfield { color: white;font: 10px arial, san serif;text-align: left;}
		.mids{background-color: #dedede;}
		.delete{cursor: pointer;}
		</style>


        <script async="" src="/js/analytics/analytics.js"></script>
		<script src="/js/jquery-1.11.1/jquery-1.11.1.min.js"></script>
        <script src="/js/jquery-migrate-1.2.1/jquery-migrate-1.2.1.min.js"></script>
        <#--<script src="/js/jquery-ui-1.10.3/jquery-ui-1.10.3.min.js"></script>-->

        <#--<script src="/js/jquery-ui-1.10.3/jquery.ui.datepicker-zh-CN.js"></script>-->
        <script src="/js/bootstrap/bootstrap.min.js"></script>
        <script src="/js/bootstarp-date/bootstrap-datetimepicker.min.js"></script>
        <script src="/js/bootstarp-date/locales/bootstrap-datetimepicker.zh-CN.js"></script>
        <script src="/js/select2/select2.min.js"></script>
        <script src="/js/bootstrap-table/bootstrap-table.js"></script>
        <script src="/js/bootstrap-table/bootstrap-table-zh-CN.js"></script>
        <script src="/js/modernizr/modernizr.min.js"></script>
        <script src="/js/pace/pace.min.js"></script>
        <script src="/js/retina/retina.min.js"></script>
        <script src="/js/jquery.cookies/jquery.cookies.js"></script>
        <script src="/js/custom/custom.js"></script>
        <script src="/js/common.js"></script>
        <script src="/js/yxPublic.js"></script>
        <#--<script src="../../js/jquery-ui-1.10.3/jquery-ui-timepicker-addon.js"></script>-->
		<script src="../../js/bootbox/bootbox.min.js"></script>
        <script src="/js/sms.js"></script>
        <script src="http://cdn.bootcss.com/summernote/0.8.1/summernote.js"></script>
        <script src="http://cdn.bootcss.com/summernote/0.8.1/summernote.min.js"></script>
        <script src="//cdn.bootcss.com/summernote/0.8.1/lang/summernote-zh-CN.js"></script>
        <script src="//cdn.bootcss.com/summernote/0.8.1/lang/summernote-zh-CN.min.js"></script>
        <link rel="shortcut icon" href="/images/royao-logo.ico"/>
	</head>

    <body class=" pace-done">
		<div class="pace  pace-inactive">
			<div class="pace-progress" data-progress-text="100%" data-progress="99" style="width: 100%;">
			  <div class="pace-progress-inner"></div>
			</div>
			<div class="pace-activity"></div>
		</div>
        
        <header>
            <div class="headerwrapper">
                <div class="header-left">
                    <h style="color: white;font-size: 22px;"><span class="fa fa-twitter"></span>融耀健康管理</h>
                    <div class="pull-right">
                        <a href="#" class="menu-collapse">
                            <i class="fa fa-bars"></i>
                        </a>
                    </div>
                </div><!-- header-left -->
                
                <div class="header-right">
                    
                    <div class="pull-right">
                        <!--
                        <form class="form form-search" action="#">
                            <input type="search" class="form-control" placeholder="Search">
                        </form>
                        -->
                        <#--<div class="btn-group btn-group-list btn-group-notification">-->
                            <#--<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">-->
                              <#--<i class="fa fa-bell-o"></i>-->
                              <#--<span class="badge">5</span>-->
                            <#--</button>-->
                            <#--<div class="dropdown-menu pull-right">-->
                                <#--<a href="#" class="link-right"><i class="fa fa-search"></i></a>-->
                                <#---->
                            <#--</div><!-- dropdown-menu &ndash;&gt;-->
                        <#--</div><!-- btn-group &ndash;&gt;-->
                        <#---->
                        <#--<div class="btn-group btn-group-list btn-group-messages">-->
                            <#--<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">-->
                                <#--<i class="fa fa-envelope-o"></i>-->
                                <#--<span class="badge">2</span>-->
                            <#--</button>-->
                           <#---->
                        <#--</div><!-- btn-group &ndash;&gt;-->
                        
                        <div class="btn-group btn-group-option">
                            <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
                              <i class="fa fa-caret-down"></i>
                            </button>
                            <ul class="dropdown-menu pull-right" role="menu">
                              <#--<li><a href="http://themepixels.com/demo/webpage/chain/index.html#"><i class="glyphicon glyphicon-user"></i>我的资料</a></li>-->
                              <#--<li><a href="http://themepixels.com/demo/webpage/chain/index.html#"><i class="glyphicon glyphicon-star"></i>日志</a></li>-->
                              <#--<li><a href="http://themepixels.com/demo/webpage/chain/index.html#"><i class="glyphicon glyphicon-cog"></i>修改密码</a></li>-->
                              <#--<li><a href="http://themepixels.com/demo/webpage/chain/index.html#"><i class="glyphicon glyphicon-question-sign"></i>帮助</a></li>-->
                              <#--<li class="divider"></li>-->
                              <li><a href="/manager/logout.htm"><i class="glyphicon glyphicon-log-out"></i>退出</a></li>
                            </ul>
                        </div><!-- btn-group -->
                        
                    </div><!-- pull-right -->
                    
                </div><!-- header-right -->
                
            </div><!-- headerwrapper -->
        </header>