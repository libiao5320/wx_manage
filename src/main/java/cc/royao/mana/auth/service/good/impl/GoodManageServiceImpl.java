package cc.royao.mana.auth.service.good.impl;

import cc.royao.mana.auth.mapper.good.GoodManageMapper;
import cc.royao.mana.auth.service.good.GoodManageService;
import cc.royao.mana.model.GoodTmp;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cc.royao.utils.DateUtil;

import java.util.List;

/**
 * Created by libia on 2016/1/22.
 */
@Service("goodManageService")
public class GoodManageServiceImpl implements GoodManageService {
    @Autowired
    private GoodManageMapper goodManageMapper;


    public GoodTmp add(GoodTmp goodTmp) throws Exception {


        goodTmp.setGoodTmpCt(DateUtil.format("yyyy-MM-dd HH:mm:dd"));

        if( goodManageMapper.add(goodTmp) > 0)
            return goodTmp;
        return null;

    }

    public List queryGoodTmpByType(String type) throws Exception {
        return goodManageMapper.queryGoodTmpByType(type);
    }

    public GoodTmp choseGoodTmpContent(Long tmpId) throws Exception {
        return goodManageMapper.choseGoodTmpContent(tmpId);
    }

	public GoodTmp updateGoodTmp(GoodTmp goodTmp) throws Exception {
		goodTmp.setGoodTmpCt(DateUtil.format("yyyy-MM-dd HH:mm:dd"));

        if( goodManageMapper.updateGoodTmp(goodTmp) > 0)
            return goodTmp;
        return null;
	}

}
