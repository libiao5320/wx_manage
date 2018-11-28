<#ftl strip_whitespace=true>

<#include "spring.ftl"/>
<#--
<@s.captcha />
-->
<#macro captcha id='captchaImage'>
<img src="<@s.url '/captcha.htm' />" id="${id}" style="cursor:pointer;" onclick="this.src = '<@s.url '/captcha.htm' />?_='+Math.random()" title="看不清？点击更换"/> 
</#macro>


<#--
<@s.paginator />
-->

<#macro paginator data ajax='false' showTotal='true'>
<#assign pageUrl="?" />
<#list RequestParameters?keys as key>
	<#if (key!="p" && RequestParameters[key]??)>
		<#assign pageUrl=pageUrl+key+'='+RequestParameters[key]+'&' />
	</#if>
</#list>

<div class="paginator">
	<#if data.hasPrePage>
		<a <#if ajax=='true'>href="javascript:;" ajaxUrl=<#else>href=</#if>"${pageUrl}p=${data.prePage}">上一页</a><#rt/>
	<#else>
		<span>上一页</span><#rt/>
	</#if>
	
	<#assign numPages=data.getSlider() />
	<#list numPages as n>
		<#if data.page == n>
			<span class='current'>${n}</span>
		<#else>
			<a <#if ajax=='true'>href="javascript:;" ajaxUrl=<#else>href=</#if>"${pageUrl}p=${n}">${n}</a><#rt/>
		</#if>
	</#list>
	<#if data.hasNextPage>
		<a <#if ajax=='true'>href="javascript:;" ajaxUrl=<#else>href=</#if>"${pageUrl}p=${data.nextPage}">下一页</a><#rt/>
	<#else>
		<span>下一页</span><#rt/>
	</#if>
	
	<#if showTotal =='true'>
		<span>共${data.totalPages}页${data.totalCount}条记录</span><#rt/>
	</#if>
</div>
</#macro>
