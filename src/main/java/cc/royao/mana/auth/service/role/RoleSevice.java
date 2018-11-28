package cc.royao.mana.auth.service.role;

import cc.royao.mana.auth.model.Role;

import java.util.List;
import java.util.Map;

/**
 * Created by libia on 2016/1/18.
 */
public interface RoleSevice {



        public List getAllRole() throws Exception;
        public List getAllRole(Map params) throws Exception;
        public Long queryAllCount()throws Exception;
        public boolean addRole(Role role , String privileges) throws Exception;
        public boolean deleteRole(Long roleId) throws Exception;
        public boolean updateRole(Role role , String privileges) throws Exception;
        public Role queryById(Long roleId) throws Exception;
}
