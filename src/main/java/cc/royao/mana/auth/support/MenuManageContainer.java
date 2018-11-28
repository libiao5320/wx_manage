package cc.royao.mana.auth.support;

import cc.royao.mana.auth.model.Menu;
import cc.royao.mana.auth.service.menu.MenuService;
import cc.royao.common.Constants;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;

import javax.servlet.ServletContext;
import java.util.List;
import java.util.Properties;

/**
 * Created by libia on 2016/1/20.
 */

@Service("menuManageContainer")
public class MenuManageContainer {

    private Logger logger  = Logger.getLogger(this.getClass());




    private static List menuList ;



    @Autowired
    private MenuService menuService;





    public MenuManageContainer(){
        super();
    }

    public void loadMenu() {
        menuList = menuService.getTopMenu();
        logger.info("===================================系统初始化获取所有菜单===================================");
        logger.info("===========================================================================================");

        if( null != menuList)
        {


            for(int i = 0 ; i < menuList.size() ; i++)
            {
                Menu menu = (Menu) menuList.get(i);
                logger.info(menu.getMenuId()+"菜单名："+menu.getMenuName());
            }

        }

        logger.info("===========================================================================================");

        WebApplicationContext webApplicationContext = ContextLoader.getCurrentWebApplicationContext();
        ServletContext servletContext = webApplicationContext.getServletContext();


        servletContext.setAttribute(Constants.SERVLETCONTEXT_MENU,menuList);
    }


    public static List getAllMenu() {
        return menuList;
    }

}
