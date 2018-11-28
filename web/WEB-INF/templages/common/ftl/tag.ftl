<#ftl strip_whitespace=true>


<#-- 
<@tag.bannerImg />
banner图
-->

<#macro bannerImg >
	<#assign resultBannerImg = tagHandler("bannerImg",'')>
	<#if resultBannerImg.success>
		<#list resultBannerImg.resultData as img>
			<#nested img img_index/>
		</#list>
	<#else>
		${resultBannerImg.message}
	</#if>
</#macro>

<#--
会员通知
<@tag.listMemberMessage />
-->
<#macro listMemberMessage >
	<#assign resultListMemberMessage = tagHandler("listMemberMessage","")>
	<#if resultListMemberMessage.success>
			<#list resultListMemberMessage.resultData as message>
				<#nested message message_index/>
			</#list>
	<#else>
		${resultListContent.message}
	</#if>
</#macro>


<#-- 
<@tag.listShopAddress />
收货地址列表
-->

<#macro listShopAddress >
	<#assign resultListShopAddress = tagHandler("listShopAddress",'')>
	<#if resultListShopAddress.success>
		<#list resultListShopAddress.resultData as res>
			<#nested res res_index/>
		</#list>
	<#else>
		${resultListShopAddress.message}
	</#if>
</#macro>



<#--
会员信息
<@tag.MemberInfo />
-->
<#macro MemberInfo >
	<#assign resultMemberInfo = tagHandler("MemberInfo","")>
		<#if resultMemberInfo.success && resultMemberInfo.resultData??>
		<#nested resultMemberInfo.resultData />
		<#else>
		没有相关会员信息
		</#if>
</#macro>


<#--
会员头像
<@tag.memberFace />
-->
<#macro memberFace  id="">
    <#assign parameter = "id:'${id}'"> 
	<#assign resultMemberFace = tagHandler("memberFace",parameter)>
		<#nested resultMemberFace.resultData />
</#macro>

<#--
分享二维码
<@tag.QRcode />
-->
<#macro QRcode >
	<#assign resultQRcode = tagHandler("QRcode","")>
		<#nested resultQRcode.resultData />
</#macro>

<#--
是否关注
<@tag.isAttention />
-->
<#macro isAttention id="">
  <#assign parameter = "id:'${id}'"> 
	<#assign resultIsAttention = tagHandler("isAttention",parameter)>
		<#nested resultIsAttention.resultData />
</#macro>


<#--
<@tag.listCategory />
-->
<#macro listCategory isNav="" parentId="">
	<#assign parameter = "isNav:'${isNav}',parentId:'${parentId}'">
	<#assign resultListCategory = tagHandler("listCategory",parameter)>
	<#if resultListCategory.success>
		<#list resultListCategory.resultData as category>
			<#nested category category_index/>
		</#list>
	<#else>
		${resultListCategory.message}
	</#if>
</#macro>

<#--
<@tag.category />
-->
<#macro category id="" categoryCode="">
	<#assign parameter = "id:'${id}',categoryCode:'${categoryCode}'">
	<#assign resultCategory = tagHandler("category",parameter)>
	<#if resultCategory.success && resultCategory.resultData??>
		<#nested resultCategory.resultData/>
	<#else>
		${resultWebappCategory.message}
	</#if>
</#macro>

<#--
<@tag.categoryText />
-->

<#macro categoryText id>
	<#assign parameter = "id:'${id}'">
	<#assign resultContentText = tagHandler("categoryText",parameter)>
	<#if resultContentText.success && resultContentText.resultData??>
		${resultContentText.resultData}
	<#else>
		${resultContentText.message}
	</#if>
</#macro>


<#--
<@tag.listWebappCategory />
-->
<#macro listWebappCategory parentId="">
	<#assign parameter = "parentId:'${parentId}'">
	<#assign resultWebappCategory = tagHandler("listWebappCategory",parameter)>
	<#if resultWebappCategory.success && resultWebappCategory.resultData??>
		<#list resultWebappCategory.resultData as category>
			<#nested category category_index/>
		</#list>
	<#else>
		${resultWebappCategory.message}
	</#if>
</#macro>

<#--
<@tag.listContent />
-->
<#macro listContent isPay="" memberId="" isDynamic="" id="" parentId="" p="" size="" categoryId="" categoryCode="" categoryIdString="" isIndexRecommend="" 
	isChannelRecommend="" isHot="" isFlash="" isPic="" showPage="Y"  name="" value="" searchKey="" content="">
	<#assign parameter = "isPay:'${isPay}',memberId:'${memberId}',isDynamic:'${isDynamic}',id:'${id}',parentId:'${parentId}',p:'${p}',size:'${size}',categoryId:'${categoryId}',categoryCode:'${categoryCode}',categoryIdString:'${categoryIdString}',isIndexRecommend:'${isIndexRecommend}',isChannelRecommend:'${isChannelRecommend}',isHot:'${isHot}',isFlash:'${isFlash}',isPic:'${isPic}',name:'${name}',value:'${value}',searchKey:'${searchKey}',content:'${content}'">
	<#assign resultListContent = tagHandler("listContent",parameter)>
	<#if resultListContent.success>
		<#if resultListContent.resultData.data?? && resultListContent.resultData.data?size gt 0>
			<#list resultListContent.resultData.data as c>
				<#nested c c_index/>
			</#list>
			<#if categoryId?? && categoryId != '' && resultListContent.resultData.paginator?? && showPage=='Y'>
				${resultListContent.resultData.paginator}
			</#if>
		<#else>
			没有相关的记录
		</#if>
	<#else>
		${resultListContent.message}
	</#if>
</#macro>

<#--
<@tag.listPageMarketingData />
-->
<#macro listPageMarketingData  p="" size="" status="" groupId="">
	<#assign parameter = "p:'${p}',size:'${size}',status:'${status}',groupId:'${groupId}'">
	<#assign resultListMarketingData = tagHandler("listPageMarketingData",parameter)>
		<#if resultListMarketingData.resultData.data?? && resultListMarketingData.resultData.data?size gt 0>
			<#nested resultListMarketingData.resultData.data resultListMarketingData.resultData.paginator />
		<#else>
			没有相关的记录
		</#if>
</#macro>


<#--
<@tag.listPageContent />
-->
<#macro listPageContent isPay="" memberId="" isDynamic="" id="" p="" size="" parentId="" categoryId="" categoryCode="" categoryIdString="" isIndexRecommend="" 
	isChannelRecommend="" isHot="" isFlash="" isPic="">
	<#assign parameter = "isPay:'${isPay}',memberId:'${memberId}',isDynamic:'${isDynamic}',id:'${id}',p:'${p}',size:'${size}',parentId:'${parentId}',categoryId:'${categoryId}',categoryCode:'${categoryCode}',categoryIdString:'${categoryIdString}',isIndexRecommend:'${isIndexRecommend}',isChannelRecommend:'${isChannelRecommend}',isHot:'${isHot}',isFlash:'${isFlash}',isPic:'${isPic}'">
	<#assign resultListContent = tagHandler("listContent",parameter)>
	<#if resultListContent.success>
			<#nested resultListContent.resultData.data resultListContent.resultData.paginator resultListContent.resultData.totle/>
	<#else>
		${resultListContent.message}
	</#if>
</#macro>



<#--
购物车列表
<@tag.listCart />
-->
<#macro listCart  p="" size="">
	<#assign parameter = "p:'${p}',size:'${size}'">
	<#assign resultListCart = tagHandler("listCart",parameter)>
	<#if resultListCart.success>
		<#if resultListCart.resultData.data?? && resultListCart.resultData.data?size gt 0>
		<#nested resultListCart.resultData.data resultListCart.resultData.paginator />
		<#else>
			没有相关的记录
		</#if>
	<#else>
		${resultListCart.message}
	</#if>
</#macro>


<#--
订单列表
<@tag.listOrder />
-->
<#macro listOrder  p="" size="" memberId="" isPay="">
	<#assign parameter = "isPay:'${isPay}',memberId:'${memberId}',p:'${p}',size:'${size}'">
	<#assign resultListOrder = tagHandler("listOrder",parameter)>
	<#if resultListOrder.success>
		<#if resultListOrder.resultData.data?? && resultListOrder.resultData.data?size gt 0>
             <#nested resultListOrder.resultData.data resultListOrder.resultData.paginator />
		<#else>
			没有相关的记录
		</#if>
	<#else>
		${resultListOrder.message}	
	</#if>
</#macro>



<#--
评论列表
<@tag.listShopComment />
-->
<#macro listShopComment  p="" size=""  contentId="">
	<#assign parameter = "p:'${p}',size:'${size}',contentId:'${contentId}'">
	<#assign resultListShopComment = tagHandler("listShopComment",parameter)>
	<#if resultListShopComment.success>
		<#if resultListShopComment.resultData.data?? && resultListShopComment.resultData.data?size gt 0>
             <#nested resultListShopComment.resultData.data resultListShopComment.resultData.paginator />
		<#else>
			没有相关的记录
		</#if>
	<#else>
		${listShopComment.message}
	</#if>
</#macro>



<#--
<@tag.contentText />
-->
<#macro contentText id>
	<#assign parameter = "id:'${id}'">
	<#assign resultContentText = tagHandler("ContentText",parameter)>
	<#if resultContentText.success && resultContentText.resultData??>
		${resultContentText.resultData}
	<#else>
        没有相关内容
	</#if>
</#macro>




<#--
<@tag.contentMultiImage />
-->
<#macro contentMultiImage id>
	<#assign parameter = "id:'${id}'">
	<#assign resultContentMultiImage = tagHandler("ContentMultiImage",parameter)>
	<#if resultContentMultiImage.success && resultContentMultiImage.resultData??>
		<#list resultContentMultiImage.resultData as c>
			<#nested c c_index resultContentMultiImage.resultData?size/>
		</#list>
	<#else>
		${resultContentText.message}
	</#if>
</#macro>

<#--
<@tag.crumb />
-->
<#macro crumb categoryId>
	<#assign parameter = "categoryId:'${categoryId}'">
	<#assign resultCrumb = tagHandler("crumb",parameter)>
	<#if resultCrumb.success && resultCrumb.resultData??>
		${resultCrumb.resultData}
	<#else>
		${resultCrumb.message}
	</#if>
</#macro>

<#--
<@tag.preContent />
-->
<#macro preContent>
	<#assign parameter = "id:'${_content.id}',categoryId:'${_category.id}'">
	<#assign resultPreContent = tagHandler("preContent",parameter)>
	<#if resultPreContent.success && resultPreContent.resultData??>
		<a class="prev" title="${resultPreContent.resultData.title}" href="${resultPreContent.resultData.url}">${resultPreContent.resultData.title}</a>
	<#else>
	<a class="prev" title="${resultPreContent.message!'没有上一篇内容'}" href="javascript:void(0);">${resultPreContent.message!'没有上一篇内容'}</a>
	</#if>
</#macro>

<#--
<@tag.nextContent />
-->
<#macro nextContent>
	<#assign parameter = "id:'${_content.id}',categoryId:'${_category.id}'">
	<#assign resultNextContent = tagHandler("nextContent",parameter)>
	<#if resultNextContent.success && resultNextContent.resultData??>
		<a class="next" title="${resultNextContent.resultData.title}" href="${resultNextContent.resultData.url}">${resultNextContent.resultData.title}</a>
	<#else>
	<a class="next" title="${resultNextContent.message!'没有下一篇内容'}" href="javascript:void(0);">${resultNextContent.message!'没有下一篇内容'}</a>
	</#if>
</#macro>


<#--
<@tag.friendLink />
-->
<#macro friendLink groupId="" isShow="" isPicLink="" isRecommend="">
	<#assign parameter = "groupId:'${groupId}',isShow:'${isShow}',isPicLink:'${isPicLink}',isRecommend:'${isRecommend}'">
	<#assign resultFriendLink = tagHandler("friendLink",parameter)>
	<#if resultFriendLink.success && resultFriendLink.resultData??>
		<#list resultFriendLink.resultData as data>
			<#nested data data_index/>
		</#list>
	</#if>
</#macro>

<#--
<@tag.advertising />
-->
<#macro advertising id>
	<#assign parameter = "id:'${id}'">
	<#assign resultAdvertising = tagHandler("advertising",parameter)>
	<#if resultAdvertising.success && resultAdvertising.resultData??>
		<#assign data = resultAdvertising.resultData.data>
		<#include "../advertising/${resultAdvertising.resultData.type}.html"/>
	</#if>
</#macro>

<#--
<@tag.marketing_form />
-->
<#macro marketing_form groupId formId="ajax-submit-form" contentTitle="" formName="marketing-form">
<form name="${formName}" id="${formId}" class="ajax-submit-form" action="/marketing/data/save/${groupId}.ajax" method="post">
	<input type="hidden" name="contentTitle" value="${contentTitle}" />
	<#nested />
	<div id="validator-form-message"></div>
</form>
</#macro>

<#--
提交订单
<@tag.weborder_form />
-->
<#macro weborder_form formId="ajax-from" formName="ajax-from">
<form name="${formName}" id="${formId}"  action="/insert.ord" method="post">
<input type="hidden" name="comeBackPage" value="/success">
	<#nested />
</form>
</#macro>


<#--
加入购物车
<@tag.shoppingCart />
-->
<#macro shoppingCart formId="ajax-submit-form" formName="shoppingCart-form">
<form name="${formName}" id="${formId}" class="form" action="/shoppingCart.ord" method="post">
<input type="hidden" name="contentId" value="${_content.id !''}">
<input type="hidden" name="contentTitle" value="${_content.title !''}"> 
<input type="hidden" name="priceDollar" value="${_content.pPrice !''}">
<input type="hidden" name="litpic"  value="${_content.litpic !''} ">
	<#nested />
	<div id="validator-form-message"></div>
</form>
</#macro>









<#--
支付订单
<@tag.orderPay />
-->
<#macro orderPay formId="charge-form" formName="charge-form">
<form name="${formName}" id="${formId}"  action="/charge.ajax" method="GET">
<input name="amountDollar" type="hidden"  value="${cmsWebOrder.priceSum/100}" />
<input name="orderNumber" type="hidden"  value="${cmsWebOrder.orderNumber}" />
<input name="id" type="hidden"  value="${cmsWebOrder.id}" />
	<#nested />
	<div id="validator-form-message"></div>
</form>
</#macro>


<#--
删除购物车中的商品
<@tag.deleteCart />
-->
<#macro deleteCart >
<a href="javascript:;" url="/deleteCart.ord?id=${r.id}"  class="delete" ><img src="/images/close.png" alt="" /></a>
</#macro>

<#--
提交商品评价
<@tag.shop_comment />
-->
<#macro shop_comment >
<form  class="comment-from"  action="/comment.ajax" method="post">
	<#nested />
</form>
</#macro>




<#--
会员注册
<@tag.regist_form />
-->
<#macro regist_form formId="regist-from" formName="regist-from">
<form name="${formName}" id="${formId}"  action="/member/regist.ajax" method="post">
	<#nested />
</form>
</#macro>

<#--
会员简单注册
<@tag.simpleRegistform />
-->
<#macro simpleRegistform formId="simpleRegistform" formName="simpleRegistform">
<form name="${formName}" id="${formId}"  action="/member/simpleRegist.ajax" method="post">
	<#nested />
</form>
</#macro>

<#--
修改信息
<@tag.member_form />
-->
<#macro member_form formId="member-from" formName="member-from">
<form name="${formName}" id="${formId}"  action="/member/savemessage.ajax" method="post">
	<#nested />
</form>
</#macro>

<#--
身份验证
<@tag.verif_form />
-->
<#macro verif_form formId="verif-from" formName="verif-from">
<form name="${formName}" id="${formId}"  action="/member/verify.ajax" method="post">
	<#nested />
</form>
</#macro>

<#--
更换邮箱
<@tag.changeEmail_from />
-->
<#macro changeEmail_from formId="changeEmail-from" formName="changeEmail-from">
<form name="${formName}" id="${formId}"  action="/member/chemail.ajax" method="post">
	<#nested />
</form>
</#macro>


<#--
更换手机
<@tag.changeMobile_from />
-->
<#macro changeMobile_from formId="changeMobile-from" formName="changeMobile-from">
<form name="${formName}" id="${formId}"  action="/member/chmobile.ajax" method="post">
	<#nested />
</form>
</#macro>


<#--
更换默认收货地址
<@tag.defaultAddress />
-->
<#macro defaultAddress formId="defaultAddress" formName="defaultAddress">
<form name="${formName}" id="${formId}"  action="/member/defaultAddress.ajax" method="post">
	<#nested />
</form>
</#macro>

<#--
发表评论
<@tag.comment />
-->
<#macro comment formId="ajax-form" formName="comment-form">
<form name="${formName}" id="${formId}" class="ajax-submit-form" action="/saveComment.ajax" method="post">
  <input type="hidden" name="contentId" value="${_content.id !''}" />
	<#nested />
	<div id="comment-form-message"></div>
</form>
</#macro>

<#--
发表文章
<@tag.publishArtcle />
-->
<#macro publishArtcle formId="ajax-form" formName="publish-form">
<form name="${formName}" id="${formId}" class="ajax-submit-form" action="/publishArtcle.ajax" method="post">
	<input type="hidden" name="categoryId" value="${_category.id !''}">
	<#nested />
</form>
</#macro>


<#-- 
评论列表
<@tag.commentList/>
-->

<#macro commentList  contentId="">
    <#assign parameter = "contentId:'${contentId}'">
	<#assign resultCommentList = tagHandler("commentList",parameter)>
	<#if resultCommentList.success>
		<#list resultCommentList.resultData as comment>
			<#nested comment comment_index/>
		</#list>
	<#else>
		${resultCommentList.message}
	</#if>
</#macro>


<#--
总评论数,以及当前用户是否评论
<@tag.praiseNum />
-->
<#macro praiseNum  contentId="">
	<#assign parameter = "contentId:'${contentId}'">
	<#assign resultPraiseNum = tagHandler("praiseNum",parameter)>
	<#if resultPraiseNum.success && resultPraiseNum.resultData??>
	   <#nested resultPraiseNum.resultData />
	<#else>
	系统错误！
	</#if>
</#macro>


<#-- 
<@tag.enum/>
枚举
-->

<#macro enum  parentId="">
    <#assign parameter = "parentId:'${parentId}'">
	<#assign resultEnum = tagHandler("enum",parameter)>
	<#if resultEnum.success>
		<#list resultEnum.resultData as e>
			<#nested e e_index/>
		</#list>
	<#else>
		${resultEnum.message}
	</#if>
</#macro>

