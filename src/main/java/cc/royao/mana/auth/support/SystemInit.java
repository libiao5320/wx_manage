package cc.royao.mana.auth.support;

import cc.royao.mana.auth.model.Role;
import cc.royao.mana.auth.service.role.RoleSevice;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.support.PropertiesLoaderUtils;
import org.springframework.web.context.ConfigurableWebApplicationContext;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import java.io.IOException;
import java.util.Properties;

/**
 * Created by libia on 2016/1/15.
 */
public class SystemInit  {


    private WebApplicationContext context;

//    private static String configLocation = "sysconfig.properties";
//    private static Properties configProperties ;


    /**
     * 系统初始化获取所有角色和权限
     * @param servletContextEvent
     */
    public void executeSystemInitParam (ServletContextEvent servletContextEvent){
            WebApplicationContext appctx = WebApplicationContextUtils.getWebApplicationContext(servletContextEvent.getServletContext());
            RoleManageContainer  roleManageContainer  = (RoleManageContainer) appctx.getBean("roleManageContainer");
            PrivilegeManageContainer  privilegeManageContainer  = (PrivilegeManageContainer) appctx.getBean("privilegeManageContainer");
            MenuManageContainer  menuManageContainer  = (MenuManageContainer) appctx.getBean("menuManageContainer");
            roleManageContainer.loadRole();
            privilegeManageContainer.loadPrivilege();
            menuManageContainer.loadMenu();

    }



    public void closeSystemInitListener(ServletContext servletContext){


    }

//
//    static {
//        try {
//            ClassPathResource ex = new ClassPathResource(configLocation);
//            configProperties = PropertiesLoaderUtils.loadProperties(ex);
//        } catch (IOException e) {
//            e.printStackTrace();
//        }
//
//    }
}
