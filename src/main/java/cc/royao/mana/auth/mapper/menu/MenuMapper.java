package cc.royao.mana.auth.mapper.menu;

import cc.royao.mana.auth.model.Menu;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

/**
 * Created by libia on 2016/1/20.
 */
public interface MenuMapper {
        public List getTopMenu();
        public List getAllMenu();
        public List getAllMenuWithPageCondition(Map params) ;
        public Long queryCount() ;


        public Long addMenu(Menu menu) throws SQLException;
        public Long deleteMenu(Long menuId) throws SQLException;
        public Long updateMenu(Menu menu) throws SQLException;
        public Menu queryById(Long menuId) throws SQLException;

        public Long getMaxSortByParentId(Long parentId);
        public Menu getPrevious(Menu menu);
        public Menu getNext(Menu menu);
        public List findChildMenu(Long menuId);
        public int updateSort(Menu menu);
}
