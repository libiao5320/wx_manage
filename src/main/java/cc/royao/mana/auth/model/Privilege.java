package cc.royao.mana.auth.model;

import cc.royao.common.PrivateTypeEnum;
import cc.royao.common.StatusEnum;

import java.io.Serializable;

/**
 * Created by libia on 2016/1/18.
 */
public class Privilege  implements Serializable {


        private Long privilegeId;
        private Long roleId;
        private Long menuId;
        private String privilegeName;
        private StatusEnum privilegeStatus;
        private PrivateTypeEnum privilegeType;
        private String privilegeUrl;
        private String  privilegeCt;
        private String privilegeRemark;
        private String privilegeKey;


    public Long getPrivilegeId() {
        return privilegeId;
    }

    public void setPrivilegeId(Long privilegeId) {
        this.privilegeId = privilegeId;
    }

    public Long getRoleId() {
        return roleId;
    }

    public void setRoleId(Long roleId) {
        this.roleId = roleId;
    }

    public Long getMenuId() {
        return menuId;
    }

    public void setMenuId(Long menuId) {
        this.menuId = menuId;
    }

    public String getPrivilegeName() {
        return privilegeName;
    }

    public void setPrivilegeName(String privilegeName) {
        this.privilegeName = privilegeName;
    }

    public StatusEnum getPrivilegeStatus() {
        return privilegeStatus;
    }

    public void setPrivilegeStatus(StatusEnum privilegeStatus) {
        this.privilegeStatus = privilegeStatus;
    }

    public PrivateTypeEnum getPrivilegeType() {
        return privilegeType;
    }

    public void setPrivilegeType(PrivateTypeEnum privilegeType) {
        this.privilegeType = privilegeType;
    }

    public String getPrivilegeUrl() {
        return privilegeUrl;
    }

    public void setPrivilegeUrl(String privilegeUrl) {
        this.privilegeUrl = privilegeUrl;
    }

    public String getPrivilegeCt() {
        return privilegeCt;
    }

    public void setPrivilegeCt(String privilegeCt) {
        this.privilegeCt = privilegeCt;
    }

    public String getPrivilegeRemark() {
        return privilegeRemark;
    }

    public void setPrivilegeRemark(String privilegeRemark) {
        this.privilegeRemark = privilegeRemark;
    }

    public String getPrivilegeKey() {
        return privilegeKey;
    }

    public void setPrivilegeKey(String privilegeKey) {
        this.privilegeKey = privilegeKey;
    }
}
