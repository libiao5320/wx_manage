package cc.royao.mana.auth.service.good;

import cc.royao.mana.model.GoodTmp;

import java.util.List;

/**
 * Created by libia on 2016/1/22.
 */
public interface GoodManageService {

        public GoodTmp add(GoodTmp goodTmp) throws Exception;
        public List queryGoodTmpByType(String type) throws Exception;
        public GoodTmp choseGoodTmpContent(Long tmpId) throws Exception;
        public GoodTmp updateGoodTmp(GoodTmp goodTmp) throws Exception;

}
