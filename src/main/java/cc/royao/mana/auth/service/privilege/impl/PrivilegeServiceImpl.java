package cc.royao.mana.auth.service.privilege.impl;

import cc.royao.mana.auth.mapper.privilege.PrivilegeMapper;
import cc.royao.mana.auth.model.Privilege;
import cc.royao.mana.auth.service.privilege.PrivilegeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * Created by libia on 2016/1/18.
 */
@Service("privilegeService")
public class PrivilegeServiceImpl implements PrivilegeService {

    @Autowired
    private PrivilegeMapper privilegeMapper;

    public List getAllPrivilege() {
        return privilegeMapper.getAllPrivilege();
    }

    public List getAllPrivilege(Map params) {

        return privilegeMapper.getAllPrivilegeWithPageCondition(params);


    }

    public Long queryAllCount() {
        return privilegeMapper.queryAllCount();
    }

    public Privilege queryById(Long privilegeId) {
        return privilegeMapper.queryById(privilegeId);
    }

    public boolean addPrivilege(Privilege privilege) {
        return privilegeMapper.addPrivilege(privilege) > 0 ;
    }
    public boolean updatePrivilege(Privilege privilege) {
        return privilegeMapper.updatePrivilege(privilege) > 0 ;
    }


    public boolean deletePrivilege(Long privilegeId) {
        return privilegeMapper.deletePrivilege(privilegeId) > 0 ;
    }
}
