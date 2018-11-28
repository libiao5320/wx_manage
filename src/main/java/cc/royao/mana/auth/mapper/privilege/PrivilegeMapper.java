package cc.royao.mana.auth.mapper.privilege;

import cc.royao.mana.auth.model.Privilege;

import java.util.List;
import java.util.Map;

/**
 * Created by libia on 2016/1/18.
 */
public interface PrivilegeMapper {


    public List getAllPrivilege();
    public List getAllPrivilegeWithPageCondition(Map params);
    public Long queryAllCount();
    public int addPrivilege(Privilege privilege) ;
    public int deletePrivilege(Long privilegeId);
    public int updatePrivilege(Privilege privilege);
    public Privilege queryById(Long privilegeId);

}

