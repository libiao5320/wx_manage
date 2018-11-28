package cc.royao.mana.interrupter;

import cc.royao.mana.auth.model.Manager;
import cc.royao.mana.auth.model.Role;
import cc.royao.mana.auth.service.manager.ManagerService;
import cc.royao.mana.auth.support.RoleManageContainer;

import cc.royao.common.Constants;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import cc.royao.utils.CookieUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.util.List;
import java.util.concurrent.CopyOnWriteArraySet;

/**
 * Created by libia on 2016/1/19.
 */
public class AuthInterrupter implements HandlerInterceptor {
	
	Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired
	ManagerService managerService;
    private final String NO_PRIVILEGE = "/manager/noprivilege.htm";
    private final String NO_SESSION = "/login.htm";

    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {


        boolean flag = true;
//        HttpSession session =  request.getSession();
//        String requestUrl = request.getRequestURI() ;
//
//        String isMenu = request.getParameter("isMenu");
//        String menuId = request.getParameter("menuId");
//
//        Manager manager = (Manager) session.getAttribute(Constants.SESSION_USERINFO);
//
//        if(manager == null){
//        	manager = CookieUtil.readCookieAndLogon(request, response, managerService);
//        }
//
//        if(null != manager) {
//
//            List<Role> roles =  manager.getRole();
//                for (int i = 0; i < roles.size(); i++) {
//                    Role role = roles.get(i);
//
//                    if (null != isMenu && "1".equals(isMenu))
//                    {
//                        CopyOnWriteArraySet temMenu = (CopyOnWriteArraySet) RoleManageContainer.CACHE_ROLE_PRIVILEGEMENU.get(role.getRoleId());
//
//                        if (temMenu.contains(Long.valueOf(menuId))) {
//                            flag = true;
//                            break;
//                        }
//                    }
//                    else
//                    {
//                        flag  = true;
//                        break;
//                    }
//
//                    /**
//                     *   功能级别权限控制 ，放开的话需要配置 功能的URL 放到 权限表中去 ，暂时不控制功能级别的权限.
//                     */
////                    else {
////                        CopyOnWriteArraySet temPrivilege = (CopyOnWriteArraySet) RoleManageContainer.CACHE_ROLE_PRIVILEGEURL.get(role.getRoleId());
////
////                        if (temPrivilege.contains(requestUrl)) {
////                            flag = true;
////                            break;
////                        }
////                    }
//                }
//        }
//        else
//        {
//            response.sendRedirect(NO_SESSION);
//
//            return flag;
//        }
//
//        if( !flag ){
//        	response.sendRedirect(NO_PRIVILEGE);
//        }

         return flag;
    }

	public void postHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub
		
	}

	public void afterCompletion(HttpServletRequest request,
			HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// TODO Auto-generated method stub
		
	}

}
