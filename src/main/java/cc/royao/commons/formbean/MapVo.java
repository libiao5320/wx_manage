package cc.royao.commons.formbean;

import java.io.Serializable;
import java.util.Map;

/**
 * Created by libia on 2016/1/4.
 */
public class MapVo implements Serializable {

    private Map<String ,Object> map = null;

    public Map<String, Object> getMap() {
        return map;
    }

    public void setMap(Map<String, Object> map) {
        this.map = map;
    }
}
