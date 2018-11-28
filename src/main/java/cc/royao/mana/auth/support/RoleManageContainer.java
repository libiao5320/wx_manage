package cc.royao.mana.auth.support;

import cc.royao.mana.auth.model.Privilege;
import cc.royao.mana.auth.model.Role;
import cc.royao.mana.auth.service.role.RoleSevice;
import cc.royao.common.PrivateTypeEnum;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.CopyOnWriteArrayList;
import java.util.concurrent.CopyOnWriteArraySet;

/**
 * Created by libia on 2016/1/15.
 */


@Service("roleManageContainer")
public class RoleManageContainer extends AbstractRoleLoader{





    private Logger logger  = Logger.getLogger(this.getClass());


    private static List<Role> roleList;

    public  final static Map<Long , Set> CACHE_ROLE_PRIVILEGEURL = new ConcurrentHashMap<Long, Set>() ;
    public  final static Map<Long , Set> CACHE_ROLE_PRIVILEGEMENU  = new ConcurrentHashMap<Long, Set>() ;




    @Autowired
    private RoleSevice roleSevice;





    public RoleManageContainer(){
            super();
    }

    public void loadRole() {
        try {
            roleList = roleSevice.getAllRole();
        } catch (Exception e) {
            e.printStackTrace();
        }
        logger.info("===================================系统初始化获取所有角色===================================");
        logger.info("===================================****PUT到缓存中去****===================================");
        logger.info("===========================================================================================");
        if( null != roleList)
        {


            for(int i = 0 ; i < roleList.size() ; i++) {
                Role role = (Role) roleList.get(i);
                List privilegeList = role.getPrivileges();
                CopyOnWriteArraySet privileges =  new CopyOnWriteArraySet();
                CopyOnWriteArraySet menues  =  new CopyOnWriteArraySet();
                if (null != privilegeList)
                    for (int j = 0; j < privilegeList.size(); j++) {
                        Privilege privilege = (Privilege) privilegeList.get(j);
                        if(privilege.getPrivilegeType() == PrivateTypeEnum.URL) {
//                            if (privileges.indexOf("" + privilege.getPrivilegeId()) == -1) {
//                                if (j == (privilegeList.size() - 1)) {
//                                    privilegeStr.append(privilege.getPrivilegeUrl());
//                                } else
//                                    privilegeStr.append(privilege.getPrivilegeUrl() + ",");
//                            }
                            privileges.add(privilege.getPrivilegeUrl());
                        }
                        else
                        {

//                            if (j == (privilegeList.size() - 1)) {
//                                menuStr.append(privilege.getMenuId());
//                            } else
//                                menuStr.append(privilege.getMenuId() + ",");

                            menues.add(privilege.getMenuId());
                        }

                    }

                CACHE_ROLE_PRIVILEGEURL.put(role.getRoleId(), privileges);
                CACHE_ROLE_PRIVILEGEMENU.put(role.getRoleId() , menues);
                logger.info("角色名：" + role.getRoleName());
                }
            }
        logger.info("===========================================================================================");

    }




    public static List getAllRole() {
        return roleList;
    }
}
