package cc.royao.mana.listener;

import cc.royao.mana.auth.service.role.RoleSevice;
import cc.royao.mana.auth.support.SystemInit;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

/**
 * Created by libia on 2016/1/18.
 */
public class SystemContextLoaderListener extends SystemInit implements ServletContextListener {

//
    @Autowired
    private SystemInit systemInit;



    public void contextInitialized(ServletContextEvent servletContextEvent) {
        systemInit = this;
        this.systemInit.executeSystemInitParam(servletContextEvent);
    }

    @Override
    public void contextDestroyed(ServletContextEvent servletContextEvent) {
//        this.systemInit.closeSystemInitListener(servletContextEvent.getServletContext());

    }
//
//    public void contextDestroyed(ServletContextEvent servletContextEvent) {
//
//
//
//    }



}
