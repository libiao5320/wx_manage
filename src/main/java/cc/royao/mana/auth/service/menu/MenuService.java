package cc.royao.mana.auth.service.menu;

import cc.royao.mana.auth.model.Menu;

import java.util.List;
import java.util.Map;

/**
 * Created by libia on 2016/1/20.
 */
public interface MenuService {


    public List getTopMenu();
    public List getAllMenu();
    public List getAllMenu(Map params);
    public Long queryAllCount();

    public boolean addMenu(Menu menu) throws Exception;
    public boolean deleteMenu(Long menuId) throws Exception;
    public boolean updateMenu(Menu menu) throws Exception;
    public Menu queryById(Long menuId) throws Exception;

    public Long getMaxSortByParentId(Long parentId);
    public Menu getPrevious(Menu menu);
    public Menu getNext(Menu menu);
    public List findChildMenu(Long menuId);
    public int updateSort(Menu menu);
}
