package cc.royao.mana.auth.support;



import cc.royao.mana.auth.model.Privilege;
import cc.royao.mana.auth.service.privilege.PrivilegeService;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Properties;

/**
 * Created by libia on 2016/1/18.
 */

@Service("privilegeManageContainer")
public class PrivilegeManageContainer {





    private Logger logger  = Logger.getLogger(this.getClass());


    private static List privilegeList ;



    @Autowired
    private PrivilegeService privilegeService;





    public PrivilegeManageContainer(){
        super();
    }

    public List loadPrivilege() {
        privilegeList = privilegeService.getAllPrivilege();
        logger.info("===================================系统初始化获取所有权限===================================");
        logger.info("===========================================================================================");

        if( null != privilegeList)
        {


            for(int i = 0 ; i < privilegeList.size() ; i++)
            {
                Privilege privilege = (Privilege) privilegeList.get(i);
                logger.info(privilege.getMenuId()+"权限名："+privilege.getPrivilegeName());
            }

        }

        logger.info("===========================================================================================");
        return privilegeList;
    }


    public static List getAllRole() {
        return privilegeList;
    }
}
