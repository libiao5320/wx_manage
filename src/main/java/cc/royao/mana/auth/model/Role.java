package cc.royao.mana.auth.model;

import cc.royao.common.StatusEnum;

import java.io.Serializable;
import java.util.List;

/**
 * Created by libia on 2016/1/15.
 */
public class Role extends BaseEntity implements IRole,Serializable  {



    private Long roleId;
    private String roleName;
    private String roleCt;
    private Long roleAdmin;
    private String roleKeyword;
    private StatusEnum roleStatus;
    private List<Privilege> privileges;





    public Long getRoleId() {
        return roleId;
    }

    public void setRoleId(Long roleId) {
        this.roleId = roleId;
    }

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }

    public String getRoleCt() {
        return roleCt;
    }

    public void setRoleCt(String roleCt) {
        this.roleCt = roleCt;
    }

    public Long getRoleAdmin() {
        return roleAdmin;
    }

    public void setRoleAdmin(Long roleAdmin) {
        this.roleAdmin = roleAdmin;
    }

    public String getRoleKeyword() {
        return roleKeyword;
    }

    public void setRoleKeyword(String roleKeyword) {
        this.roleKeyword = roleKeyword;
    }

    public StatusEnum getRoleStatus() {
        return roleStatus;
    }

    public void setRoleStatus(StatusEnum roleStatus) {
        this.roleStatus = roleStatus;
    }

    public List<Privilege> getPrivileges() {
        return privileges;
    }

    public void setPrivileges(List<Privilege> privileges) {
        this.privileges = privileges;
    }

    public boolean hasRight(int rightId) throws Exception {
        return false;
    }

    public List getAllRight() throws Exception {
        return null;
    }
}
