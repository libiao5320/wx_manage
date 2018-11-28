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
                                    <li>用户管理</li>
                                </ul>
                                <h4>编辑商家</h4>
                            </div>
                        </div><!-- media -->
                    </div><!-- pageheader -->
                    
                    <div class="contentpanel">
                        <div class="alert alert-info">
                            <button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
                            <strong>说明：</strong>贝多平台合作商家账户及信息管理
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
	                               		<caption>编辑商家信息</caption>
	                               		<input type="hidden" name="storeId" value="${Map.store.storeId}">
	                               		<tbody>
	                               			<tr>
	                               				<td>*商家名称：</td>
	                               				<td><input type="text" class="form-control input-sm" name="storeName" value="${Map.store.storeName !''}"></td>
	                               			</tr>
	                               			<tr>
	                               				<td>*商家登录用户名：</td>
	                               				<td><input type="text" class="form-control input-sm" name="sellerName" value="${Map.store.sellerName !''}"></td>
	                               			</tr>
	                               			<tr>
	                               				<td>*商家登录电话：</td>
	                               				<td><input type="text" class="form-control input-sm" name="storeLoginPhone" value="${Map.store.storeLoginPhone !''}"></td>
	                               			</tr>
	                               			<tr>
	                               				<td>*商家类型：</td>
	                               				<td>
	                               					<select class="select2 w100 fl" name="scId">
	                               							<option value="">请选择</option>
			                                         <#if Map ?? && Map.g_class ?? && (Map.g_class?size>0)>
			                                         	<#list Map.g_class as ss>
			                                          		<option value="${ss.classId}" <#if ss.classId == Map.store.scId>SELECTED</#if>>${ss.className !''}</option>
			                                          	</#list>
			                                         </#if>
			                                    	</select>
	                               				</td>
	                               			</tr>
	                               			<tr>
	                               				<td>*所在城市：</td>
	                               				<td>
	                               				<select class="select2 w100 fl area" name="provinceId">
	                               						<option value="">请选择</option>
	                               				<#if Map ?? && Map.area ?? && (Map.area?size>0)>
			                                          <#list Map.area as ar>
			                                          	<option value="${ar.areaId}" <#if ar.areaId==Map.store.provinceId>SELECTED</#if>>${ar.areaName !''}</option>
			                                          </#list>
		                                        </#if>
			                                    </select>
	                               				</td>
	                               			</tr>
	                               			<tr>
	                               				<td>*区域归属：</td>
	                               				<td>
	                               				<select class="select2 w100 fl area" name="cityId">
	                               						<option value="">请选择</option>
			                                    <#if Map ?? && Map.city ?? && (Map.city?size>0)>
			                                          <#list Map.city as ar>
			                                          	<option value="${ar.areaId}" <#if ar.areaId==Map.store.cityId>SELECTED</#if>>${ar.areaName !''}</option>
			                                          </#list>
		                                        </#if>
			                                    </select>
			                                    <select class="select2 w100 fl area" name="areaId">
			                                    		<option value="">请选择</option>
			                                     <#if Map ?? && Map.county ?? && (Map.county?size>0)>
			                                          <#list Map.county as ar>
			                                          	<option value="${ar.areaId}" <#if ar.areaId==Map.store.areaId>SELECTED</#if>>${ar.areaName !''}</option>
			                                          </#list>
		                                        </#if>
			                                    </select>
			                                    </td>
	                               			</tr>
	                               			<tr>
	                               				<td>附近地标：</td>
	                               				<td><input type="text" class="form-control input-sm" name="fjLandmark" value="${Map.store.fjLandmark !''}"></td>
	                               			</tr>
	                               			<tr>
	                               				<td>*详细地址：</td>
	                               				<td><input type="text" class="form-control input-sm" name="storeAddress" value="${Map.store.storeAddress !''}"></td>
	                               			</tr>
	                               			<tr>
	                               				<td>地图位置：</td>
	                               				<td><a href="javascript:;" id="locationMap"><#if Map.store.lbsX ?? && Map.store.lbsY ??>修改地图位置<#else>添加地图位置</#if></a><input type="text" name="lbsX" value="${Map.store.lbsX !''}"><input type="text" name="lbsY" value="${Map.store.lbsY !''}"></td>
	                               			</tr>
	                               			<tr>
	                               				<td>*商家电话：</td>
	                               				<td><input type="text" class="form-control input-sm" name="storePhone" value="${Map.store.storePhone !''}"></td>
	                               			</tr>
	                               			<tr>
	                               				<td>客户经理信息：</td>
	                               				<td>
	                               					<div class="form-group">
		                               					<label class="col-sm-2 control-label" >
		                               						客户经理姓名：
		                               					</label>
		                               					<div class="col-sm-7 control-label">
		                               						<input type="text" class="form-control input-sm" name="smName" value="<#if Map.store.manager ??>${Map.store.manager.smName !''}</#if>">
		                               					</div>
	                               					</div>
	                               					
	                               					<div class="form-group">
		                               					<label class="col-sm-2 control-label" >
		                               						联系电话：
		                               					</label>
		                               					<div class="col-sm-7 control-label">
		                               						<input type="text" class="form-control input-sm" name="smPhone" value="<#if Map.store.manager ??>${Map.store.manager.smPhone !''}</#if>">
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
		                               						<input type="text" class="form-control input-sm" name="accounts" value="<#if Map.store.extend ??>${Map.store.extend.accounts !''}</#if>">
		                               					</div>
	                               					</div>
	                               					
	                               					<div class="form-group">
		                               					<label class="col-sm-2 control-label">
		                               						账号：
		                               					</label>
		                               					<div class="col-sm-7 control-label">
		                               						<input type="text" class="form-control input-sm" name="accountsNo" value="<#if Map.store.extend ??>${Map.store.extend.accountsNo !''}</#if>">
		                               					</div>
	                               					</div>
	                               					
	                               					
	                               					<div class="form-group">
		                               					<label class="col-sm-2 control-label">
		                               						开户人：
		                               					</label>
		                               					<div class="col-sm-7 control-label">
		                               						<input type="text" class="form-control input-sm" name="accountHolder" value="<#if Map.store.extend ??>${Map.store.extend.accountHolder !''}</#if>">
		                               					</div>
	                               					</div>
	                               					
	                               				</td>
	                               			</tr>
	                               			<tr>
	                               				<td>*标准服务费比例：</td>
	                               				<td>
		                               				<div class="form-group">
		                               					<label class="col-sm-4 control-label" style="padding-left: 19px">
		                               						<input type="text" class="col-sm-5 form-control input-sm" name="serviceRatio" value="<#if Map.store.extend ??>${Map.store.extend.serviceRatio !'0'}</#if>">
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
	                               						<input type="text" class="form-control input-sm" name="serviceRatio5" style="width:40%" value="<#if Map.store.extend ??>${Map.store.extend.serviceRatio5 !''}</#if>">
	                               					</div>
	                               				</div>
	                               				
	                               				<div class="form-group">
	                               					<label class="col-sm-3 control-label">
	                               						<img src="/images/srjk_pj.png" style="width:28px"><img src="/images/srjk_pj.png" style="width:28px"><img src="/images/srjk_pj.png" style="width:28px"><img src="/images/srjk_pj.png" style="width:28px"><img src="/images/srjk_yhpj.png" style="width:28px">
	                               					</label>
	                               					<div class="col-sm-7 control-label">
	                               						<input type="text" class="form-control input-sm" name="serviceRatio4" style="width:40%" value="<#if Map.store.extend ??>${Map.store.extend.serviceRatio4 !'0'}</#if>">
	                               					</div>
	                               				</div>
	                               				
	                               				<div class="form-group">
	                               					<label class="col-sm-3 control-label">
	                               						<img src="/images/srjk_pj.png" style="width:28px"><img src="/images/srjk_pj.png" style="width:28px"><img src="/images/srjk_pj.png" style="width:28px"><img src="/images/srjk_yhpj.png" style="width:28px"><img src="/images/srjk_yhpj.png" style="width:28px">
	                               					</label>
	                               					<div class="col-sm-7 control-label">
	                               						<input type="text" class="form-control input-sm" name="serviceRatio3" style="width:40%" value="<#if Map.store.extend ??>${Map.store.extend.serviceRatio3 !'0'}</#if>">
	                               					</div>
	                               				</div>
	                               				
	                               				<div class="form-group">
	                               					<label class="col-sm-3 control-label">
	                               						<img src="/images/srjk_pj.png" style="width:28px"><img src="/images/srjk_pj.png" style="width:28px"><img src="/images/srjk_yhpj.png" style="width:28px"><img src="/images/srjk_yhpj.png" style="width:28px"><img src="/images/srjk_yhpj.png" style="width:28px">
	                               					</label>
	                               					<div class="col-sm-7 control-label">
	                               						<input type="text" class="form-control input-sm" name="serviceRatio2" style="width:40%" value="<#if Map.store.extend ??>${Map.store.extend.serviceRatio2 !'0'}</#if>">
	                               					</div>
	                               				</div>
	                               				
	                               				<div class="form-group">
	                               					<label class="col-sm-3 control-label">
	                               						<img src="/images/srjk_pj.png" style="width:28px"><img src="/images/srjk_yhpj.png" style="width:28px"><img src="/images/srjk_yhpj.png" style="width:28px"><img src="/images/srjk_yhpj.png" style="width:28px"><img src="/images/srjk_yhpj.png" style="width:28px">
	                               					</label>
	                               					<div class="col-sm-7 control-label">
	                               						<input type="text" class="form-control input-sm" name="serviceRatio1" style="width:40%" value="<#if Map.store.extend ??>${Map.store.extend.serviceRatio1 !'0'}</#if>">
	                               					</div>
	                               				</div>
	                               				</td>
	                               			</tr>
	                               			<tr>
	                               				<td>*商家Logo图片：(170*140px)</td>
	                               				<td>
	                               					<form enctype="multipart/form-data" method="POST">
                               							<input id="input-5" name="uploadFile" type="file" multiple class="file-loading" data-min-file-count="1" data-name="storeLabel">
	                               					</form>
	                               					<input type="hidden" name="storeLabel" value="${Map.store.storeLabel !''}">
	                               					<img src="/imgView/readStoreImage.htm?imagePath=${Map.store.storeLabel !''}" style="width:10%" />
	                               				</td>
	                               			</tr>
	                               			<tr>
	                               				<td>*营业时间：</td>
	                               				<td><input type="text" placeholder="示例:8:30-22:00" class="input-sm form-control w160 fl input-sm" name="storeWorkingtime" value="${Map.store.storeWorkingtime !''}"></td>
	                               			</tr>
	                               			<tr>
	                               				<td>*商家介绍</td>
	                               				<td>
	                               				<textarea id="storeDescribe" name="storeDescribe">${Map.store.storeDescribe !''}
	                               				</textarea>
	                               				</td>
	                               			</tr>
	                               			<tr>
	                               				<td>*商家详情</td>
	                               				<td>
	                               				<textarea id="summernote" name="storeDetail"><#if Map.store.text ??>${Map.store.text.text !''}</#if>
	                               				</textarea>
	                               				</td>
	                               			</tr>
	                               			<tr>
	                               				<td>排序：</td>
	                               				<td>
	                               					<div class="form-group">
		                               					<label class="col-sm-2 control-label" >
		                               						<input type="text" class="form-control input-sm ml5" name="sort" value="${Map.store.sort !'0'}">
		                               					</label>
		                               					<div class="col-sm-7 control-label" style="padding-top:20px;">
		                               						排序越小越靠前
		                               					</div>
	                               					</div>
	                               				</td>
	                               			</tr>
	                               			<tr>
	                               				<td>备注：</td>
	                               				<td><textarea rows="3" name="remark" style="width:100%;">${Map.store.remark !''}</textarea></td>
	                               			</tr>
	                               			<tr>
	                               				<td>合同图片：(无要求)</td>
	                               				<td>
	                               					<form enctype="multipart/form-data" method="POST">
                               							<input id="input-6" name="uploadFile" type="file" multiple class="file-loading" data-min-file-count="1" data-name="pactImg">
	                               					</form>
	                               					<input type="hidden" name="pactImg" value="${Map.store.pactImg !''}">
                               						<img src="/imgView/readStoreImage.htm?imagePath=${Map.store.pactImg !''}" style="width:10%" />
	                               				</td>
	                               			</tr>
	                               		</tbody>
	                               </table>
	                               <table class="table table-striped table-bordered table-hover table-condensed">
                                    	<tbody>
                                    		<caption><button type="button" class="btn btn-primary" onclick="window.history.go(-1);">返回 </button>&nbsp;&nbsp;&nbsp;<button type="button" class="btn btn-primary save">保存</button></caption>
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
  					lang: 'zh-CN',
  					onImageUpload: function(files, editor, welEditable) {
                        alert(1);
                    }
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