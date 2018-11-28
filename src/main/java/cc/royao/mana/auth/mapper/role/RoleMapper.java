package cc.royao.mana.auth.mapper.role;

import cc.royao.mana.auth.model.Role;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

/**
 * Created by libia on 2016/1/18.
 */
public interface RoleMapper {


        List getAllRole() throws SQLException;
        List getAllRoleWithPageCondition(Map params) throws SQLException;
        Long queryAllCount() throws SQLException;
        int addRole(Role privilege) throws SQLException;
        int updateRole(Role privilege)throws SQLException ;


        int deleteRole(Long roleId) throws SQLException;
        int addRolePrivilege ( Map params)throws SQLException ;
        int deleteRolePrivilege(Long roleId)throws SQLException ;
        public Role queryById(Long roleId) throws SQLException;

}
