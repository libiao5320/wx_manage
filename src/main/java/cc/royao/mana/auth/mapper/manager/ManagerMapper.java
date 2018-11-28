package cc.royao.mana.auth.mapper.manager;

import cc.royao.mana.auth.model.Manager;
import cc.royao.mana.auth.model.ManagerLoginLogs;
import org.apache.ibatis.jdbc.SQL;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

/**
 * Created by libia on 2016/1/19.
 */
public interface ManagerMapper {

        public Manager managerLogin(String userName,String pwd) throws SQLException;
        public int insertLog(ManagerLoginLogs managerLoginLogs) throws SQLException;
        public List getAllManageWithPageCondition(Map params) throws SQLException;
        public Long queryAllCount() throws SQLException;
        public Long addManager(Manager manager) throws SQLException;
        public Long updateManager(Manager manager) throws SQLException;
        public Long deleteManager(Long managerId) throws SQLException;

        int addManagerRole ( Map params)throws SQLException ;
        int deleteManagerRole(Long managerId)throws SQLException ;
        public Manager queryById(Long managerId) throws Exception;

}
