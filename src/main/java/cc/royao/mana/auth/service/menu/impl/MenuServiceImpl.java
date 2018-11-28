package cc.royao.mana.auth.service.menu.impl;

import cc.royao.mana.auth.mapper.menu.MenuMapper;
import cc.royao.mana.auth.model.Menu;
import cc.royao.mana.auth.service.menu.MenuService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * Created by libia on 2016/1/20.
 */
@Service("menuService")
public class MenuServiceImpl implements MenuService {

    @Autowired
    private MenuMapper menuMapper;

    public List getTopMenu() {
        return menuMapper.getTopMenu();
    }

    public List getAllMenu() {
        return menuMapper.getAllMenu();
    }

    public List getAllMenu(Map params) {
        return menuMapper.getAllMenuWithPageCondition(params);
    }
    public Long queryAllCount(){

        return menuMapper.queryCount();
    }

    public boolean addMenu(Menu menu) throws Exception {
        return menuMapper.addMenu(menu) > 0;
    }

    public boolean deleteMenu(Long menuId) throws Exception {
        return menuMapper.deleteMenu(menuId) > 0;
    }

    public boolean updateMenu(Menu menu) throws Exception {
        return menuMapper.updateMenu(menu) > 0;
    }

    public Menu queryById(Long menuId) throws Exception {
        return menuMapper.queryById(menuId);
    }

	public Long getMaxSortByParentId(Long parentId) {
		return menuMapper.getMaxSortByParentId(parentId);
	}

	public Menu getPrevious(Menu menu) {
		return menuMapper.getPrevious(menu);
	}

	public Menu getNext(Menu menu) {
		return menuMapper.getNext(menu);
	}

	public int updateSort(Menu menu) {
		return menuMapper.updateSort(menu);
	}

	public List findChildMenu(Long menuId) {
		return menuMapper.findChildMenu(menuId);
	}

}
