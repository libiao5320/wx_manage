package cc.royao.mana.auth.model;

import java.io.Serializable;

/**
 * Created by libia on 2016/1/21.
 */
public class ManagerLoginLogs  extends BaseEntity implements Serializable {

        private Long id;
        private Long managerId;
        private String managerLogCt ;
        private String managerLogIp;


    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getManagerId() {
        return managerId;
    }

    public void setManagerId(Long managerId) {
        this.managerId = managerId;
    }

    public String getManagerLogCt() {
        return managerLogCt;
    }

    public void setManagerLogCt(String managerLogCt) {
        this.managerLogCt = managerLogCt;
    }

    public String getManagerLogIp() {
        return managerLogIp;
    }

    public void setManagerLogIp(String managerLogIp) {
        this.managerLogIp = managerLogIp;
    }
}
