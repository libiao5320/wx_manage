package cc.royao.mana.auth.model;

import cc.royao.common.YN;

import java.io.Serializable;
import java.util.List;

/**
 * Created by libia on 2016/1/20.
 */
public class Menu implements Serializable {


        private Long menuId;
        private Long modelId;
        private String menuName;
        private Long menuParent;
        private Long menuLevel;
        private String menuIcon;
        private YN menuDisplay;
        private String menuUrl;
        private String menuPraentName;
        private Long menuSort;

		private List childMenu ;

	public Long getMenuSort() {
		return menuSort;
	}
	
	public void setMenuSort(Long menuSort) {
		this.menuSort = menuSort;
	}

    public Long getMenuId() {
        return menuId;
    }

    public void setMenuId(Long menuId) {
        this.menuId = menuId;
    }

    public Long getModelId() {
        return modelId;
    }

    public void setModelId(Long modelId) {
        this.modelId = modelId;
    }

    public String getMenuName() {
        return menuName;
    }

    public void setMenuName(String menuName) {
        this.menuName = menuName;
    }

    public Long getMenuParent() {
        return menuParent;
    }

    public void setMenuParent(Long menuParent) {
        this.menuParent = menuParent;
    }

    public Long getMenuLevel() {
        return menuLevel;
    }

    public void setMenuLevel(Long menuLevel) {
        this.menuLevel = menuLevel;
    }

    public String getMenuIcon() {
        return menuIcon;
    }

    public void setMenuIcon(String menuIcon) {
        this.menuIcon = menuIcon;
    }

    public YN getMenuDisplay() {
        return menuDisplay;
    }

    public void setMenuDisplay(YN menuDisplay) {
        this.menuDisplay = menuDisplay;
    }

    public String getMenuUrl() {
        return menuUrl;
    }

    public void setMenuUrl(String menuUrl) {
        this.menuUrl = menuUrl;
    }

    public List getChildMenu() {
        return childMenu;
    }

    public void setChildMenu(List childMenu) {
        this.childMenu = childMenu;
    }

    public String getMenuPraentName() {
        return menuPraentName;
    }

    public void setMenuPraentName(String menuPraentName) {
        this.menuPraentName = menuPraentName;
    }
}
