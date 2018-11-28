package cc.royao.mana.ctrl;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import cc.royao.commons.formbean.MapVo;
import cc.royao.mana.auth.model.Privilege;
import cc.royao.mana.auth.model.Role;
import cc.royao.mana.auth.service.menu.MenuService;
import cc.royao.mana.auth.service.privilege.PrivilegeService;
import cc.royao.mana.auth.service.role.RoleSevice;
import cc.royao.mana.auth.support.RoleManageContainer;
import cc.royao.common.PrivateTypeEnum;
import cc.royao.common.StatusEnum;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import cc.royao.utils.DateUtil;
import cc.royao.utils.PageUtil;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;
import java.util.concurrent.CopyOnWriteArraySet;

/**
 * Created by libia on 2016/2/17.
 */


@Controller
@RequestMapping("/role")
public class RoleCtrl  {


    @Autowired
    private RoleSevice roleSevice ;

    @Autowired
    private PrivilegeService privilegeService;


    @RequestMapping("/list.htm")
    public String list( MapVo map ) {

        return  "system/rolemanage";

    }


    @RequestMapping("/initAdd.htm")
    public String initAdd( ModelMap modelMap)
    {


        List privilegs = privilegeService.getAllPrivilege();
        modelMap.put("privilegs",privilegs);
        return "system/addrole";


    }


    @RequestMapping( value = "/add.htm" )
    public String add( HttpServletRequest request  , MapVo mapVo )
    {

        Map map  = mapVo.getMap();

        Role role = new Role() ;


        String privileges = "";
        if( null !=  map.get("roleName"))
            role.setRoleName((String) map.get("roleName"));
        if( null != map.get("key"))
            role.setRoleKeyword((String) map.get("key"));
        if( null !=  map.get("privilege"))
            privileges = (String) map.get("privilege");

        role.setRoleCt(DateUtil.format("yyyy-MM-dd"));
        role.setRoleStatus(StatusEnum.N);

        boolean flag = false;
        try {
            flag = roleSevice.addRole(role, privileges);

            if( flag )
            {

                Role newRole = roleSevice.queryById(role.getRoleId());


                List<Privilege> newPrivileges = newRole.getPrivileges();
                if( null != newPrivileges && newPrivileges.size() > 0 ) {

                    CopyOnWriteArraySet menu = new CopyOnWriteArraySet();
                    CopyOnWriteArraySet url = new CopyOnWriteArraySet();
                    for ( Privilege p  : newPrivileges)
                    {
                        if  ( p.getPrivilegeType() == PrivateTypeEnum.MENU )
                            menu.add(p.getMenuId());
                        else
                            url.add(p.getPrivilegeUrl());
                    }

                    Map m = RoleManageContainer.CACHE_ROLE_PRIVILEGEMENU ;
                    m.put(role.getRoleId() ,menu );
                    Map m1 = RoleManageContainer.CACHE_ROLE_PRIVILEGEURL ;
                    m1.put(role.getRoleId() ,url );
                }


            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        if ( flag )
            return "forward:/role/list.htm";
        else
            return "forward:/role/list.htm";

    }


    @RequestMapping( value = "/update.htm" )
    public String update( HttpServletRequest request  , MapVo mapVo )
    {

        Map<?,?> map  = mapVo.getMap();
        System.out.println(map);
        boolean flag = false;
        if ( null !=  map.get("roleId")) {

            Long roleId =   Long.valueOf((String) map.get("roleId"));
            Role role = null;
            try {
                role = roleSevice.queryById(roleId);

                String privileges = "";
                if( null !=  map.get("roleName"))
                    role.setRoleName((String) map.get("roleName"));
                if( null != map.get("key"))
                    role.setRoleKeyword((String) map.get("key"));
                if( null !=  map.get("privilege"))
                    privileges = (String) map.get("privilege");

                if( null != map.get("roleStatus")){
                	if(map.get("roleStatus").equals("Y"))
                		role.setRoleStatus(StatusEnum.Y);
                	if(map.get("roleStatus").equals("N"))
                		role.setRoleStatus(StatusEnum.N);
                	if(map.get("roleStatus").equals("D"))
                		role.setRoleStatus(StatusEnum.D);
                }
                
            	if(null != map.get("roleAdmin"))
            		role.setRoleAdmin(Long.parseLong(map.get("roleAdmin").toString()));

            	flag = roleSevice.updateRole(role,privileges);

                if( flag )
                {

                    Role newRole = roleSevice.queryById(role.getRoleId());


                    List<Privilege> newPrivileges = newRole.getPrivileges();
                    if( null != newPrivileges && newPrivileges.size() > 0 ) {

                        CopyOnWriteArraySet menu = new CopyOnWriteArraySet();
                        CopyOnWriteArraySet url = new CopyOnWriteArraySet();
                        for ( Privilege p  : newPrivileges)
                        {
                            if  ( p.getPrivilegeType() == PrivateTypeEnum.MENU )
                                menu.add(p.getMenuId());
                            else
                                url.add(p.getPrivilegeUrl());
                        }

                        Map m = RoleManageContainer.CACHE_ROLE_PRIVILEGEMENU ;
                        m.put(role.getRoleId() ,menu );
                        Map m1 = RoleManageContainer.CACHE_ROLE_PRIVILEGEURL ;
                        m1.put(role.getRoleId() ,url );
                    }


                }

            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        if ( flag )
            return "forward:/role/list.htm";
        else
            return "forward:/role/list.htm";

    }


    @ResponseBody
    @RequestMapping(value ="/delete/{roleId}.htm")
    public String delete(@PathVariable String roleId)
    {
        boolean flag =false;
        if( null != roleId) {
            try {
                flag = roleSevice.deleteRole(Long.valueOf(roleId));
            } catch (Exception e) {
                e.printStackTrace();
            }

        }

        JSONObject  jsonObject = new JSONObject() ;
        jsonObject .put( "flag" , flag);
        return jsonObject.toString();
    }


    @ResponseBody
    @RequestMapping( value = "/list.ajax"  , produces = {"application/json;charset=UTF-8"})
    public String listAllPriviage(HttpServletRequest request)
    {


        MapVo mapVo = new MapVo();
        mapVo.setMap(JSON.parseObject(request.getParameter("map")));
        Map params = mapVo.getMap();

        Integer page = null ==  params.get("pageNo") ? 0 : Integer.valueOf(""+params.get("pageNo"));
        Integer pageSize = null ==  params.get("pageSize") ? 0 : Integer.valueOf(""+params.get("pageSize"));

        params.put("begin" , PageUtil.getPageRange(page)[0]);
        params.put("end", PageUtil.getPageRange(page)[1]);

        List l = null;
        Long count = 0l;
        try {
            l = roleSevice.getAllRole(params);
            count = roleSevice.queryAllCount();
        } catch (Exception e) {
            e.printStackTrace();
        }

        JSONObject jsonObject = new JSONObject();
        jsonObject.put("total",count);
        jsonObject.put("rows",l);
        return JSONObject.toJSONString(jsonObject);
    }


    @RequestMapping("/update/{roleId}.htm")
    public String update(@PathVariable String roleId , ModelMap modelMap)
    {

        try {

        List privilegs = privilegeService.getAllPrivilege();
        modelMap.put("privilegs",privilegs);
        Role  role = null;

            role = roleSevice . queryById(Long.valueOf( roleId));
            modelMap.put("role",role);
        return "system/editrole";

        } catch (Exception e) {
            e.printStackTrace();
        }
        return "system/editrole";
    }
}
