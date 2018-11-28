package cc.royao.mana.auth.service.manager.impl;

import cc.royao.mana.auth.mapper.manager.ManagerMapper;
import cc.royao.mana.auth.model.Manager;
import cc.royao.mana.auth.model.ManagerLoginLogs;
import cc.royao.mana.auth.service.manager.ManagerService;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import cc.royao.utils.DateUtil;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by libia on 2016/1/19.
 */

@Service("managerService")
public class ManagerServiceImpl implements ManagerService {

    @Autowired
    private ManagerMapper managerMapper;



    private String encrypt(String s ) throws NoSuchAlgorithmException {
        MessageDigest md = MessageDigest.getInstance("MD5");
        return new String(md.digest(s.getBytes()));
    }

    public Manager managerLogin(String userName, String pwd , String loginIp) throws Exception {
        Manager manager =  managerMapper.managerLogin(userName, encrypt(pwd));

        if( null != manager)
        {
            ManagerLoginLogs  managerLoginLogs = new ManagerLoginLogs();
            managerLoginLogs.setManagerId(manager.getMamangerId());
            managerLoginLogs.setManagerLogCt(DateUtil.formatDate(DateUtil.current()));
            managerLoginLogs.setManagerLogIp(loginIp);
            managerMapper.insertLog(managerLoginLogs);
        }


        return manager;
    }

    public List getAllManage(Map params) throws SQLException {
        return managerMapper.getAllManageWithPageCondition(params);
    }

    public Long queryAllCount() throws SQLException {
        return managerMapper.queryAllCount();
    }

    public boolean addManager(Manager manager, String roles) throws Exception {
        boolean flag = false;

        flag = managerMapper.addManager(manager) > 0 ;

        String [] roleArr = roles.split(",");


        for( int i = 0 ; i < roleArr.length ; i++)
        {
            Map m  = new HashMap();
            m.put("managerId", manager.getMamangerId());
            m.put("roleId" , roleArr[i]);
            flag =  managerMapper.addManagerRole( m ) > 0 ;
        }

        return flag;
    }

    public boolean deleteManager(Long managerId) throws Exception {
        return managerMapper.deleteManager(managerId) > 0 ;
    }

    public boolean updateManager(Manager manager, String roles) throws Exception {
        boolean flag = false;

        flag = managerMapper.updateManager(manager) > 0 ;

        String [] roleArr = roles.split(",");
        managerMapper.deleteManagerRole(manager.getMamangerId());
        for( int i = 0 ; i < roleArr.length ; i++)
        {
            Map m  = new HashMap();
            m.put("managerId", manager.getMamangerId());
            m.put("roleId" , roleArr[i]);
            flag =  managerMapper.addManagerRole( m ) > 0 ;
        }

        return flag;
    }

    public Manager queryById(Long managerId) throws Exception {
        return managerMapper.queryById(managerId);
    }
}
