package cc.royao.mana.ctrl;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import cc.royao.commons.formbean.MapVo;
import cc.royao.mana.auth.model.Privilege;
import cc.royao.mana.auth.service.menu.MenuService;
import cc.royao.mana.auth.service.privilege.PrivilegeService;
import cc.royao.common.PrivateTypeEnum;
import cc.royao.common.StatusEnum;
import cc.royao.common.YN;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import cc.royao.utils.DateUtil;
import cc.royao.utils.PageUtil;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * Created by libia on 2016/2/17.
 */


@Controller
@RequestMapping("/priviage")
public class PriviageCtrl {

        @Autowired
        private PrivilegeService privilegeService ;

        @Autowired
        private MenuService menuService ;


        @RequestMapping("/list.htm")
        public String list( MapVo map ) {

            return  "system/priviagemanage";

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

            List l = privilegeService.getAllPrivilege(params);
            Long count  = privilegeService.queryAllCount();
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("total",count);
            jsonObject.put("rows",l);
            return JSONObject.toJSONString(jsonObject);
        }

        @RequestMapping("/initAdd.htm")
        public String initAdd( ModelMap modelMap)
        {


            List menuList = menuService.getAllMenu();
            modelMap.put("menuList",menuList);
            return "system/addprivilege";


        }



        @RequestMapping( value = "/add.htm" )
        public String add( HttpServletRequest request  , MapVo mapVo )
        {

            Map map  = mapVo.getMap();

            Privilege privilege = new Privilege() ;


            if( null !=  map.get("privilegeName"))
            privilege.setPrivilegeName((String) map.get("privilegeName"));
            if( null != map.get("key"))
            privilege.setPrivilegeKey((String) map.get("key"));
            if( null != map.get("remark"))
            privilege.setPrivilegeRemark((String) map.get("remark"));
            if( null != map.get("type")) {
                if( "MENU".equals( map.get("type")) )
                {
                    privilege.setPrivilegeType(PrivateTypeEnum.MENU);
                    if( null !=   map.get("menu"))
                    privilege.setMenuId(Long.valueOf((String) map.get("menu")));
                }
                else
                {
                    privilege.setPrivilegeType(PrivateTypeEnum.URL);
                    if ( null !=  map.get("url")) {
                        privilege.setPrivilegeUrl((String) map.get("url"));
                    }
                }
            }
            privilege.setPrivilegeCt(DateUtil.format("yyyy-MM-dd"));

            privilege.setPrivilegeStatus(StatusEnum.N);

            boolean flag = privilegeService.addPrivilege(privilege);
            if ( flag )
                return "forward:/priviage/list.htm";
            else
                return "forward:/priviage/list.htm";

        }


    @RequestMapping( value = "/update.htm" )
    public String update( HttpServletRequest request  , MapVo mapVo )
    {

        Map<?,?> map  = mapVo.getMap();

        boolean flag = false;
        if ( null !=  map.get("privilegeId")) {

            Privilege privilege = new Privilege();

            if (null != map.get("privilegeId"))
            	privilege.setPrivilegeId(Long.parseLong(map.get("privilegeId").toString()));
            if (null != map.get("privilegeName"))
                privilege.setPrivilegeName((String) map.get("privilegeName"));
            if (null != map.get("privilegeKey"))
                privilege.setPrivilegeKey((String) map.get("privilegeKey"));
            if (null != map.get("privilegeRemark"))
                privilege.setPrivilegeRemark((String) map.get("privilegeRemark"));
            if (null != map.get("privilegeType")) {
                if ("MENU".equals(map.get("privilegeType"))) {

                    privilege.setPrivilegeType(PrivateTypeEnum.MENU);
                    privilege.setPrivilegeUrl("");
                    if (null != map.get("menuId"))
                        privilege.setMenuId(Long.valueOf((String) map.get("menuId")));
                } else {
                    privilege.setPrivilegeType(PrivateTypeEnum.URL);
                    privilege.setMenuId(-1l);
                    if (null != map.get("privilegeUrl")) {
                        privilege.setPrivilegeUrl((String) map.get("privilegeUrl"));
                    }
                }
            }
            
//          privilege.setPrivilegeCt(DateUtil.format("yyyy-MM-dd"));
            
            if (null != map.get("privilegeStatus")){
            	if(map.get("privilegeStatus").equals("N"))
            		privilege.setPrivilegeStatus(StatusEnum.N);
            	if(map.get("privilegeStatus").equals("Y"))
            		privilege.setPrivilegeStatus(StatusEnum.Y);
            }

            flag = privilegeService.updatePrivilege(privilege);
        }
        if ( flag )
            return "forward:/priviage/list.htm";
        else
            return "forward:/priviage/list.htm";

    }


        @ResponseBody
        @RequestMapping(value ="/delete/{privilegeId}.htm")
        public String delete(@PathVariable String privilegeId)
        {
            boolean flag =false;
            if( null != privilegeId) {
                flag = privilegeService.deletePrivilege(Long.valueOf(privilegeId));

            }

            JSONObject  jsonObject = new JSONObject() ;
            jsonObject .put( "flag" , flag);
            return jsonObject.toString();
        }



        @RequestMapping("/update/{privilegeId}.htm")
        public String update(@PathVariable String privilegeId , ModelMap modelMap)
        {

            List menuList = menuService.getAllMenu();
            modelMap.put("menuList",menuList);
            if( null != privilegeId) {
                Privilege privilege = privilegeService.queryById(Long.valueOf(privilegeId));
                modelMap.put("privilege",privilege);
            }
            return "system/editprivilege";
        }



}
