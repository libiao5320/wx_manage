package cc.royao.mana.auth.service.manager;

import cc.royao.mana.auth.model.Manager;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

/**
 * Created by libia on 2016/1/19.
 */
public interface ManagerService {


        public Manager managerLogin(String userName ,String pwd ,String loginIp) throws  Exception;
        public List getAllManage(Map params) throws SQLException;
        public Long queryAllCount() throws SQLException;

        public boolean addManager(Manager managerId , String roles) throws Exception;
        public boolean deleteManager(Long managerId) throws Exception;
        public boolean updateManager(Manager manager , String roles) throws Exception;
        public Manager queryById(Long managerId) throws Exception;


}
