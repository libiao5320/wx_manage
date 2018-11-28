package cc.royao.mana.auth.mapper.good;

import cc.royao.mana.model.GoodTmp;

import java.sql.SQLException;
import java.util.List;

/**
 * Created by libia on 2016/1/22.
 */
public interface GoodManageMapper {

    public int add(GoodTmp goodTmp) throws SQLException;
    public List queryGoodTmpByType(String type) throws SQLException;
    public GoodTmp choseGoodTmpContent(Long tmpId) throws SQLException;
	public int updateGoodTmp(GoodTmp goodTmp);
}
