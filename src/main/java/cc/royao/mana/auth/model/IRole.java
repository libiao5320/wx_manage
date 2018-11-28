package cc.royao.mana.auth.model;

import java.util.List;

/**
 * Created by libia on 2016/1/15.
 */
public interface IRole {




        public boolean hasRight(int rightId) throws Exception;
        public List getAllRight() throws Exception;


}
