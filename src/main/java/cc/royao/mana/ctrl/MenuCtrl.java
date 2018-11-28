package cc.royao.mana.ctrl;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;

import cc.royao.commons.formbean.MapVo;
import cc.royao.mana.auth.model.Menu;
import cc.royao.mana.auth.service.menu.MenuService;
import cc.royao.mana.auth.support.MenuManageContainer;
import cc.royao.common.Constants;
import cc.royao.common.YN;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cc.royao.utils.PageUtil;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by libia on 2016/2/19.
 */


@Controller
@RequestMapping ("/menu")
public class MenuCtrl  {


    @Autowired
    private MenuService menuService  ;




    @RequestMapping("/list.htm")
    public String list( MapVo map ) {

        return  "system/menumanage";

    }

    @RequestMapping("/initAdd.htm")
    public String initAdd( ModelMap modelMap)
    {


        List topMenus = menuService.getTopMenu();
        modelMap.put("topMenus",topMenus);
        return "system/addmenu";


    }

    @RequestMapping( value = "/add.htm" )
    public String add( HttpServletRequest request  , MapVo mapVo )
    {

        Map map  = mapVo.getMap();

        Menu menu = new Menu() ;


        Long parent = 0l;
        if( null !=  map.get("menuName"))
            menu.setMenuName((String) map.get("menuName"));
        if( null != map.get("menuUrl"))
            menu.setMenuUrl((String) map.get("menuUrl"));
        if( null !=  map.get("menuParent")) {

            parent = Long.valueOf( ""+ map.get("menuParent") );
            menu.setMenuParent(parent);
        }

        if( parent == -1 )
        {
            menu.setMenuLevel(1l);
        }
        else
        {
            menu.setMenuLevel(2l);
        }
        
        Long sort = menuService.getMaxSortByParentId(parent);
        if(sort !=null){
        	menu.setMenuSort(sort + 1);
        }else{
        	menu.setMenuSort(1l);
        }
        menu.setMenuDisplay(YN.Y);


        boolean flag = false;
        try {
            flag = menuService.addMenu(menu);

            if( flag )
            {
                List l =  menuService.getTopMenu();
                ServletContext context = request.getSession().getServletContext();
                context.removeAttribute(Constants.SERVLETCONTEXT_MENU);
                context.setAttribute(Constants.SERVLETCONTEXT_MENU , l);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        if ( flag )
            return "/menu/list.htm";
        else
            return "/menu/list.htm";

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
            l = menuService.getAllMenu(params);
            count = menuService.queryAllCount();
        } catch (Exception e) {
            e.printStackTrace();
        }

        JSONObject jsonObject = new JSONObject();
        jsonObject.put("total",count);
        jsonObject.put("rows",l);
        return JSONObject.toJSONString(jsonObject);
    }

    @ResponseBody
    @RequestMapping(value ="/delete/{menuId}.htm")
    public String delete(@PathVariable String menuId , HttpServletRequest  request) {
        boolean flag = false;
        if (null != menuId) {
            try {
                flag = menuService.deleteMenu(Long.valueOf(menuId));
            } catch (Exception e) {
                e.printStackTrace();
            }

        }

        if( flag )
        {
            List l =  menuService.getTopMenu();
            ServletContext context = request.getSession().getServletContext();
            context.removeAttribute(Constants.SERVLETCONTEXT_MENU);
            context.setAttribute(Constants.SERVLETCONTEXT_MENU , l);
        }
        JSONObject  jsonObject = new JSONObject() ;
        jsonObject .put( "flag" , flag);
        return jsonObject.toString();
    }


    @RequestMapping("/update/{menuId}.htm")
    public String update(@PathVariable String menuId , ModelMap modelMap)
    {

        try {

            List topMenus = menuService.getTopMenu();
            modelMap.put("topMenus",topMenus);
            Menu  menu = null;

            menu = menuService . queryById(Long.valueOf( menuId));
            modelMap.put("menu",menu);


        } catch (Exception e) {
            e.printStackTrace();
        }
        return "system/editmenu";
    }


    @RequestMapping( value = "/update.htm" )
    public String update( HttpServletRequest request  , MapVo mapVo )
    {

        Map map  = mapVo.getMap();
        boolean flag = false;
        if ( null !=  map.get("menuId")) {
            Menu menu = null;
                try {
                    menu = menuService.queryById(Long.valueOf((String) map.get("menuId")));


                    Long parent = 0l;
                    if (null != map.get("menuName"))
                        menu.setMenuName((String) map.get("menuName"));
                    if (null != map.get("menuUrl"))
                        menu.setMenuUrl((String) map.get("menuUrl"));
                    if (null != map.get("menuParent")) {

                        parent = Long.valueOf("" + map.get("menuParent"));
                    }
                    
                    if(menu.getMenuParent() != parent){
                    	menu.setMenuParent(parent);
                    	if (parent == -1) {
                    		menu.setMenuLevel(1l);
                    	} else {
                    		menu.setMenuLevel(2l);
                    	}
                    	Long sort = menuService.getMaxSortByParentId(parent);
                        if(sort !=null){
                        	menu.setMenuSort(sort + 1);
                        }else{
                        	menu.setMenuSort(1l);
                        }
                    }

                    if( null != map.get("menuDisplay")){
                    	if(map.get("menuDisplay").equals("Y"))
                    		menu.setMenuDisplay(YN.Y);
                    	if(map.get("menuDisplay").equals("N"))
                    		menu.setMenuDisplay(YN.N);
                    }

                    flag = menuService.updateMenu(menu);

                    if (flag) {
                        List l =  menuService.getTopMenu();
                        ServletContext context = request.getSession().getServletContext();
                        context.removeAttribute(Constants.SERVLETCONTEXT_MENU);
                        context.setAttribute(Constants.SERVLETCONTEXT_MENU , l);
                    }
                }
             catch (Exception e) {
                e.printStackTrace();
             }
        }
        if ( flag )
            return "/menu/list.htm";
        else
            return "/menu/list.htm";

    }

    @RequestMapping("/sortFirstMenu.htm")
    public String sortFirstMenu() {
        return  "system/sortFirstMenu";
    }
    
    @RequestMapping("/sortSecondMenu.htm")
    public String sortSecondMenu(ModelMap model) {
    	List<Menu> menus = menuService.getTopMenu();
    	model.put("menus", menus);
        return  "system/sortSecondMenu";
    }

    /**
     * 顶级菜单列表
     */
    @ResponseBody
    @RequestMapping( value = "/getTopMenu.ajax"  , produces = {"application/json;charset=UTF-8"})
    public String getTopMenu(HttpServletRequest request)
    {
    	JSONObject jsonObject = new JSONObject();
        
        try {
        	 List<Menu> l = menuService.getTopMenu();
             jsonObject.put("rows",l);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return JSONObject.toJSONString(jsonObject);
    }
    
    /**
     * 二级菜单列表
     */
    @ResponseBody
    @RequestMapping( value = "/getChildMenu/{menuId}.ajax"  , produces = {"application/json;charset=UTF-8"})
    public String getChildMenu(HttpServletRequest request, @PathVariable String menuId)
    {
    	JSONObject jsonObject = new JSONObject();
        
        try {
        	 List<Menu> l = menuService.findChildMenu(Long.valueOf(menuId));
             jsonObject.put("rows",l);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return JSONObject.toJSONString(jsonObject);
    }
    
    /**
     * 菜单上移
     */
    @ResponseBody
    @RequestMapping( value = "/upMenu.ajax"  , produces = {"application/json;charset=UTF-8"})
    public String upMenu(HttpServletRequest request)
    {
    	JSONObject jsonObject = new JSONObject();
        
        try {
        	 Menu menu = menuService.queryById(Long.valueOf(request.getParameter("menuId")));
        	 Menu previous = menuService.getPrevious(menu);
        	 if(previous != null){
        		 Long tempSort = menu.getMenuSort();
        		 menu.setMenuSort(previous.getMenuSort());
        		 previous.setMenuSort(tempSort);
        		 
        		 menuService.updateSort(menu);
        		 menuService.updateSort(previous);
        		 
        		 //重新加载菜单
        		 List l =  menuService.getTopMenu();
                 ServletContext context = request.getSession().getServletContext();
                 context.removeAttribute(Constants.SERVLETCONTEXT_MENU);
                 context.setAttribute(Constants.SERVLETCONTEXT_MENU , l);
        		 
        		 jsonObject.put("state", 1);
        	 }else{
        		 jsonObject.put("state", -1);
             	 jsonObject.put("message", "已经是第一个");
        	 }
        } catch (Exception e) {
        	jsonObject.put("state", -1);
        	jsonObject.put("message", "上移失败");
        }
        return JSONObject.toJSONString(jsonObject);
    }
    
    /**
     * 菜单下移
     */
    @ResponseBody
    @RequestMapping( value = "/downMenu.ajax"  , produces = {"application/json;charset=UTF-8"})
    public String downMenu(HttpServletRequest request)
    {
    	JSONObject jsonObject = new JSONObject();
        
        try {
        	 Menu menu = menuService.queryById(Long.valueOf(request.getParameter("menuId")));
        	 Menu next = menuService.getNext(menu);
        	 if(next != null){
        		 Long tempSort = menu.getMenuSort();
        		 menu.setMenuSort(next.getMenuSort());
        		 next.setMenuSort(tempSort);
        		 
        		 menuService.updateSort(menu);
        		 menuService.updateSort(next);
        		 
        		//重新加载菜单
        		 List l =  menuService.getTopMenu();
                 ServletContext context = request.getSession().getServletContext();
                 context.removeAttribute(Constants.SERVLETCONTEXT_MENU);
                 context.setAttribute(Constants.SERVLETCONTEXT_MENU , l);
        		 
        		 jsonObject.put("state", 1);
        	 }else{
        		 jsonObject.put("state", -1);
             	 jsonObject.put("message", "已经是最后一个");
        	 }
        } catch (Exception e) {
        	jsonObject.put("state", -1);
        	jsonObject.put("message", "下移失败");
        }
        return JSONObject.toJSONString(jsonObject);
    }
}
