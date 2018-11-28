package cc.royao.mana.auth.model;

import cc.royao.common.StatusEnum;

import java.io.Serializable;
import java.util.List;

/**
 * Created by libia on 2016/1/19.
 */
public class Manager extends BaseEntity implements Serializable{


    private Long mamangerId;
    private String managerName;
    private StatusEnum managerStatue;
    private String managerCt;
    private String managerRoleName;
    private String managerRemark;
    private String managerPhone;
    private String managerQQ;
    private String managerMail;
    private String managerLoginName;
    private String managerLoginPwd;


    private List<Role> role;

    public List<Role> getRole() {
        return role;
    }

    public void setRole(List<Role> role) {
        this.role = role;
    }

    public Long getMamangerId() {
        return mamangerId;
    }

    public void setMamangerId(Long mamangerId) {
        this.mamangerId = mamangerId;
    }

    public String getManagerName() {
        return managerName;
    }

    public void setManagerName(String managerName) {
        this.managerName = managerName;
    }

    public StatusEnum getManagerStatue() {
        return managerStatue;
    }

    public void setManagerStatue(StatusEnum managerStatue) {
        this.managerStatue = managerStatue;
    }

    public String getManagerCt() {
        return managerCt;
    }

    public void setManagerCt(String managerCt) {
        this.managerCt = managerCt;
    }

    public String getManagerRoleName() {
        return managerRoleName;
    }

    public void setManagerRoleName(String managerRoleName) {
        this.managerRoleName = managerRoleName;
    }

    public String getManagerRemark() {
        return managerRemark;
    }

    public void setManagerRemark(String managerRemark) {
        this.managerRemark = managerRemark;
    }

    public String getManagerPhone() {
        return managerPhone;
    }

    public void setManagerPhone(String managerPhone) {
        this.managerPhone = managerPhone;
    }

    public String getManagerQQ() {
        return managerQQ;
    }

    public void setManagerQQ(String managerQQ) {
        this.managerQQ = managerQQ;
    }

    public String getManagerMail() {
        return managerMail;
    }

    public void setManagerMail(String managerMail) {
        this.managerMail = managerMail;
    }

    public String getManagerLoginName() {
        return managerLoginName;
    }

    public void setManagerLoginName(String managerLoginName) {
        this.managerLoginName = managerLoginName;
    }

    public String getManagerLoginPwd() {
        return managerLoginPwd;
    }

    public void setManagerLoginPwd(String managerLoginPwd) {
        this.managerLoginPwd = managerLoginPwd;
    }
}
