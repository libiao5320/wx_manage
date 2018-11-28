package cc.royao.mana.auth.service.privilege;

import cc.royao.mana.auth.model.Privilege;

import java.util.List;
import java.util.Map;

/**
 * Created by libia on 2016/1/18.
 */
public interface PrivilegeService {

    public List getAllPrivilege();
    public List getAllPrivilege(Map params);
    public Long queryAllCount();

    public Privilege queryById(Long privilegeId);
    public boolean addPrivilege(Privilege privilege) ;
    public boolean updatePrivilege(Privilege privilege) ;
    public boolean deletePrivilege(Long privilegeId) ;
}
