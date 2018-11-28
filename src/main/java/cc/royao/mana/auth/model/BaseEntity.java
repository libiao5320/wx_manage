package cc.royao.mana.auth.model;

import java.io.Serializable;

/**
 * Created by ntz on 2015/11/18.
 */
public class BaseEntity implements Serializable {

    //分页对象
    protected  PageObject pageInfo;

    public PageObject getPageInfo() {
        return pageInfo;
    }

    public void setPageInfo(PageObject pageInfo) {
        this.pageInfo = pageInfo;
    }
}
