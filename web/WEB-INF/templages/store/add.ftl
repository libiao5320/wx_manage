<#include "../head.ftl"/>
        <section>
        	<link href="/css/fileinput.css" rel="stylesheet">
        	<script src="/js/store.js"></script>
        	<script src="/js/fileinput/fileinput.js"></script>
			<script src="/js/fileinput/fileinput_locale_zh.js"></script>
            <div class="mainwrapper">
            <#include "../leftnav.ftl"/>
                <div class="mainpanel">
                    <div class="pageheader">
                        <div class="media">
                            <div class="pageicon pull-left">
                                <i class="fa fa-home"></i>
                            </div>
                            <div class="media-body">
                                <ul class="breadcrumb">
                                    <li><a href=""><i class="glyphicon glyphicon-home"></i></a></li>
                                    <li>商家管理</li>
                                </ul>
                                <h4>添加商家</h4>
                            </div>
                        </div><!-- media -->
                    </div><!-- pageheader -->
                    
                    <div class="contentpanel">
                        <div class="alert alert-info">
                            <button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
                            <strong>说明：</strong>添加商家，默认登录密码为商家登录电话后六位数
                        </div>
                         <div class="panel panel-default">
                           <div class="panel-heading">
	                           	<div class="row">
	                           	</div>
                            </div><!-- panel-heading -->
                            <form class="form-horizontal">
                            <div class="panel-body">
                                <div class="column form-group">
                                	<!--基本信息-->
	                               <table class="table table-striped table-bordered table-hover table-condensed">
	                               		<caption>添加商家信息</caption>
	                               		<tbody>
	                               			<tr>
	                               				<td>*商家名称：</td>
	                               				<td><input type="text" class="form-control input-sm" name="storeName"></td>
	                               			</tr>
	                               			<tr>
	                               				<td>*商家登录用户名：</td>
	                               				<td><input type="text" class="form-control input-sm" name="sellerName"></td>
	                               			</tr>
	                               			<tr>
	                               				<td>*商家登录电话：</td>
	                               				<td><input type="number" class="form-control input-sm" name="storeLoginPhone"></td>
	                               			</tr>
	                               			<tr>
	                               				<td>*商家类型：</td>
	                               				<td>
	                               					<select class="select2 w100 fl" name="scId" style="width:20%;">
	                               					<#if Map ?? && Map.g_class ?? && (Map.g_class?size>0)>
	                               						<#list Map.g_class as ss>
			                                          	<option value="${ss.classId}">${ss.className !''}</option>
			                                          	</#list>
			                                        </#if>
			                                    	</select>
	                               				</td>
	                               			</tr>
	                               			<tr>
	                               				<td>*所在城市：</td>
	                               				<td>
	                               				<select class="select2 w100 fl area" name="provinceId" id="provinceId">
	                               				<option value="">请选择</option>
			                                    <#if Map ?? && Map.area ?? && (Map.area?size>0)>
			                                          <#list Map.area as ar>
			                                          	<option value="${ar.areaId}">${ar.areaName !''}</option>
			                                          </#list>
		                                        </#if>
			                                    </select>
	                               				</td>
	                               			</tr>
	                               			<tr>
	                               				<td>*区域归属：</td>
	                               				<td>
		                               					<label class="col-sm-5 control-label" >
		                               						<select class="select2 w100 fl area" style="text-align:left;margin-left:-10px;" name="cityId" id="cityId">
				                               					<option value="">请选择</option>
						                                    </select>
		                               					</label> 
		                               					<div class="col-sm-5 control-label">
		                               					<select class="select2 w100 fl area" style="text-align:left;" name="areaId" id="areaId">
					                                    	<option value="">请选择</option>
					                                    </select>
		                               					</div>
			                                    </td>
	                               			</tr>
	                               			<tr>
	                               				<td>附近地标：</td>
	                               				<td><input type="text" class="form-control input-sm" name="fjLandmark"></td>
	                               			</tr>
	                               			<tr>
	                               				<td>*详细地址：</td>
	                               				<td><input type="text" class="form-control input-sm" name="storeAddress"></td>
	                               			</tr>
	                               			<tr>
	                               				<td>地图位置：</td>
	                               				<td><a href="javascript:;" id="locationMap">添加地图位置</a><input type="text" name="lbsX"><input type="text" name="lbsY"></td>
	                               			</tr>
	                               			<tr>
	                               				<td>*商家电话：</td>
	                               				<td><input type="text" class="form-control input-sm" name="storePhone"></td>
	                               			</tr>
	                               			<tr>
	                               				<td>客户经理信息：</td>
	                               				<td>
	                               					<div class="form-group">
		                               					<label class="col-sm-2 control-label" >
		                               						客户经理姓名：
		                               					</label>
		                               					<div class="col-sm-7 control-label">
		                               						<input type="text" class="form-control input-sm" name="smName">
		                               					</div>
	                               					</div>
	                               					
	                               					<div class="form-group">
		                               					<label class="col-sm-2 control-label" >
		                               						联系电话：
		                               					</label>
		                               					<div class="col-sm-7 control-label">
		                               						<input type="number" class="form-control input-sm" name="smPhone">
		                               					</div>
	                               					</div>
	                               				</td>
	                               			</tr>
	                               			<tr>
	                               				<td>*商家结算账户：</td>
	                               				<td align="left">
	                               					<div class="form-group">
		                               					<label class="col-sm-2 control-label" >
		                               						开户名称：
		                               					</label>
		                               					<div class="col-sm-7 control-label">
		                               						<input type="text" class="form-control input-sm" name="accounts">
		                               					</div>
	                               					</div>
	                               					
	                               					<div class="form-group">
		                               					<label class="col-sm-2 control-label">
		                               						账号：
		                               					</label>
		                               					<div class="col-sm-7 control-label">
		                               						<input type="text" class="form-control input-sm" name="accountsNo">
		                               					</div>
	                               					</div>
	                               					
	                               					
	                               					<div class="form-group">
		                               					<label class="col-sm-2 control-label">
		                               						开户人：
		                               					</label>
		                               					<div class="col-sm-7 control-label">
		                               						<input type="text" class="form-control input-sm" name="accountHolder">
		                               					</div>
	                               					</div>
	                               					
	                               				</td>
	                               			</tr>
	                               			<tr>
	                               				<td>*标准服务费比例：</td>
	                               				<td>
		                               				<div class="form-group">
		                               					<label class="col-sm-4 control-label">
		                               						<input type="number" class="form-control input-sm ml10" name="serviceRatio">
		                               					</label>
		                               					<label class="col-sm-1 text-left" style="margin-top:20px">
		                               						<span>%</span>
		                               					</label>
		                               				</div>	
	                               				</td>
	                               			</tr>
	                               			<tr>
	                               				<td>*评价服务费系数：</td>
	                               				<td>
	                               				<div class="form-group">
	                               					<label class="col-sm-3 control-label">
	                               						<img src="/images/srjk_pj.png" style="width:28px"><img src="/images/srjk_pj.png" style="width:28px"><img src="/images/srjk_pj.png" style="width:28px"><img src="/images/srjk_pj.png" style="width:28px"><img src="/images/srjk_pj.png" style="width:28px">
	                               					</label>
	                               					<div class="col-sm-7 control-label">
	                               						<input type="number" class="form-control input-sm" name="serviceRatio5" style="width:40%">
	                               					</div>
	                               				</div>
	                               				
	                               				<div class="form-group">
	                               					<label class="col-sm-3 control-label">
	                               						<img src="/images/srjk_pj.png" style="width:28px"><img src="/images/srjk_pj.png" style="width:28px"><img src="/images/srjk_pj.png" style="width:28px"><img src="/images/srjk_pj.png" style="width:28px"><img src="/images/srjk_yhpj.png" style="width:28px">
	                               					</label>
	                               					<div class="col-sm-7 control-label">
	                               						<input type="number" class="form-control input-sm" name="serviceRatio4" style="width:40%">
	                               					</div>
	                               				</div>
	                               				
	                               				<div class="form-group">
	                               					<label class="col-sm-3 control-label">
	                               						<img src="/images/srjk_pj.png" style="width:28px"><img src="/images/srjk_pj.png" style="width:28px"><img src="/images/srjk_pj.png" style="width:28px"><img src="/images/srjk_yhpj.png" style="width:28px"><img src="/images/srjk_yhpj.png" style="width:28px">
	                               					</label>
	                               					<div class="col-sm-7 control-label">
	                               						<input type="number" class="form-control input-sm" name="serviceRatio3" style="width:40%">
	                               					</div>
	                               				</div>
	                               				
	                               				<div class="form-group">
	                               					<label class="col-sm-3 control-label">
	                               						<img src="/images/srjk_pj.png" style="width:28px"><img src="/images/srjk_pj.png" style="width:28px"><img src="/images/srjk_yhpj.png" style="width:28px"><img src="/images/srjk_yhpj.png" style="width:28px"><img src="/images/srjk_yhpj.png" style="width:28px">
	                               					</label>
	                               					<div class="col-sm-7 control-label">
	                               						<input type="number" class="form-control input-sm" name="serviceRatio2" style="width:40%">
	                               					</div>
	                               				</div>
	                               				
	                               				<div class="form-group">
	                               					<label class="col-sm-3 control-label">
	                               						<img src="/images/srjk_pj.png" style="width:28px"><img src="/images/srjk_yhpj.png" style="width:28px"><img src="/images/srjk_yhpj.png" style="width:28px"><img src="/images/srjk_yhpj.png" style="width:28px"><img src="/images/srjk_yhpj.png" style="width:28px">
	                               					</label>
	                               					<div class="col-sm-7 control-label">
	                               						<input type="number" class="form-control input-sm" name="serviceRatio1" style="width:40%">
	                               					</div>
	                               				</div>
	                               				</td>
	                               			</tr>
	                               			<tr>
	                               				<td>*商家Logo图片：(170*140px)</td>
	                               				<td>
	                               					<form enctype="multipart/form-data" method="POST">
                               							<input id="input-4" name="uploadFile" type="file" multiple class="file-loading" data-min-file-count="1" data-name="storeLabel">
	                               					</form>
	                               				</td>
	                               			</tr>
	                               			<tr>
	                               				<td>*营业时间：</td>
	                               				<td><input type="text" class="input-sm form-control w160 fl" name="storeWorkingtime" placeholder="示例:8:30-22:00"></td>
	                               			</tr>
	                               			<tr>
	                               				<td>*商家介绍</td>
	                               				<td><textarea id="storeDescribe" name="storeDescribe"></textarea></td>
	                               			</tr>
	                               			<tr>
	                               				<td>*商家详情</td>
	                               				<td><textarea id="summernote" name="storeDetail"></textarea></td>
	                               			</tr>
	                               			<tr>
	                               				<td>排序：</td>
	                               				<td>
		                               					<label class="col-sm-2 control-label" >
		                               						<input type="number" class="form-control input-sm" style="margin-left:-10px;" name="sort">
		                               					</label>
		                               					<div class="col-sm-2 control-label">
		                               						排序越小越靠前
		                               					</div>
	                               				</td>
	                               			</tr>
	                               			<tr>
	                               				<td>备注：</td>
	                               				<td><textarea rows="3" style="width:100%;" name="remark"></textarea></td>
	                               			</tr>
	                               			<tr>
	                               				<td>合同图片：(无要求)</td>
	                               				<td>
	                               					<form enctype="multipart/form-data" method="POST">
                               							<input id="input-3" name="uploadFile" type="file" multiple class="file-loading" data-min-file-count="1" data-name="pactImg">
	                               					</form>
	                               				</td>
	                               			</tr>
	                               		</tbody>
	                               </table>
	                               <table class="table table-striped table-bordered table-hover table-condensed">
                                    	<tbody>
                                    		<caption><button type="button" class="btn btn-primary" onclick="window.history.go(-1);">返回</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<button type="button" id="addStore" class="btn btn-primary save">保存</button></caption>
                                    	</tbody>
                                    </table>
                                </div><!-- row -->
                            </div><!-- panel-body -->
                            </form>
                        </div>
                    </div><!-- contentpanel -->
                </div><!-- mainpanel -->
            </div><!-- mainwrapper -->
        </section>
         <script>
        	$(function(){
				$('#summernote').summernote({
					height:300,
					minHeight: null,             // set minimum height of editor
  					maxHeight: null,             // set maximum height of editor
  					focus: false,
  					lang: 'zh-CN'
				});
				$('#storeDescribe').summernote({
					height:300,
					minHeight: null,             // set minimum height of editor
  					maxHeight: null,             // set maximum height of editor
  					focus: false,
  					lang: 'zh-CN'
				});
        	});
        </script>
    </body>
</html>