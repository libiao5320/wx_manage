package cc.royao.mana.auth.service.role.impl;

import cc.royao.mana.auth.mapper.role.RoleMapper;
import cc.royao.mana.auth.model.Role;
import cc.royao.mana.auth.service.role.RoleSevice;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by libia on 2016/1/18.
 */

@Service("roleSevice")
public class RoleServiceImpl implements RoleSevice {

    @Autowired
    private RoleMapper roleMapper ;


    public List getAllRole() throws Exception {
        return  roleMapper.getAllRole();
    }

    public List getAllRole(Map params) throws Exception {
        return roleMapper.getAllRoleWithPageCondition(params);
    }

    public Long queryAllCount() throws Exception {
        return roleMapper.queryAllCount();
    }

    public boolean addRole(Role role, String privileges) throws Exception {


        boolean flag = false;

        flag = roleMapper.addRole( role ) > 0 ;

        String [] privilegeArr = privileges.split(",");


        for( int i = 0 ; i < privilegeArr.length ; i++)
        {
            Map m  = new HashMap();
            m.put("roleId" , role.getRoleId());
            m.put("privilegeId" , privilegeArr[i]);
            flag =  roleMapper.addRolePrivilege( m ) > 0 ;
        }

        return flag;
    }

    public boolean deleteRole(Long roleId) throws Exception {
        return roleMapper.deleteRole(roleId) > 0;
    }

    public boolean updateRole(Role role, String privileges) throws Exception {

        boolean flag = false;

        flag = roleMapper.updateRole( role ) > 0 ;

        String [] privilegeArr = privileges.split(",");

        roleMapper.deleteRolePrivilege( role.getRoleId() );
        for( int i = 0 ; i < privilegeArr.length ; i++)
        {
            Map m  = new HashMap();
            m.put("roleId" , role.getRoleId());
            m.put("privilegeId" , privilegeArr[i]);
            flag =  roleMapper.addRolePrivilege( m ) > 0 ;
        }
        return flag;
    }

    public Role queryById(Long roleId) throws Exception {
        return roleMapper.queryById(roleId);
    }
}
