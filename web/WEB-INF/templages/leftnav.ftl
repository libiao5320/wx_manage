 <div class="leftpanel">
                    <div class="media profile-left">
                        <a class="pull-left profile-thumb" href="#">
                            <img class="img-circle" src="https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=1183223528,3058066243&fm=116&gp=0.jpg" alt="">
                        </a>
                        <div class="media-body">
                        	<#if  userinfo??>
                            <h4 class="media-heading">${userinfo.managerName}</h4>
                            <small class="text-muted">${userinfo.managerRoleName}</small>
                            </#if>
                        </div>
                    </div><!-- media -->
                    
                     <h5 class="leftpanel-title">导航</h5>
                    <ul class="nav nav-pills nav-stacked">
                        <li class=""><a id="nav-index" class="nav-a" href="/index.htm"><i class="fa fa-home"></i> <span>首页</span></a></li>



                        <#if  MENU?? && MENU?size gt 0>

                            <#list  MENU as c>

								<!-- ${c.menuDisplay !''} -->
                                <#--<#if privilegeinfo?? && privilegeinfo?index_of("["+c.menuId+"]")!= -1>-->
                                <li class="parent"><a href="javascript:void(0);" ><i class="fa fa-male"></i> <span>${c.menuName}</span></a>
                                <#if  c.childMenu?? && c.childMenu?size gt 0>

                                <ul class="children">
                                    <#list  c.childMenu as dc>
                                        <#--<#if privilegeinfo?? && privilegeinfo?index_of("["+dc.menuId+"]")!= -1>-->
                                        <li><a class="nav-a" href="${dc.menuUrl}?isMenu=1&menuId=${dc.menuId}" >${dc.menuName}</a></li>
                                        <#--</#if>-->
                                     </#list>
                                </ul>
                                </#if>

                                <#--</#if>-->
                            </#list>

                        </#if>

                    </ul>
                    
                </div><!-- leftpanel -->
                
                <script>
                	$(document).ready(function(){
                		var url = window.location.href;
                		$(".nav-a").each(function(index,dom){
                			var _url = $(dom).attr("href");
                			if(url.indexOf(_url) > -1 && _url != '/index.htm'){
                				$(".leftpanel .nav-pills li").removeClass("active");
                				$(dom).parents(".parent").addClass("active");
                				$(dom).parent().addClass("active");
                			}else if(_url == '/index.htm'){
                				$("#nav-index").parent().addClass("active");
                			}
                		});
                	});
                </script>