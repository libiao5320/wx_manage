package cc.royao.mana.model;

import cc.royao.common.GoodTmpTypeEnum;

import java.io.Serializable;

/**
 * Created by libia on 2016/1/22.
 */
public class GoodTmp implements Serializable {

        private Long goodTmpId;
        private String goodTmpName;
        private String goodTmpCt;
        private String goodTmpContent;
        private Long goodTmpCm;
        private GoodTmpTypeEnum goodTmpType;


    public Long getGoodTmpId() {
        return goodTmpId;
    }

    public void setGoodTmpId(Long goodTmpId) {
        this.goodTmpId = goodTmpId;
    }

    public String getGoodTmpName() {
        return goodTmpName;
    }

    public void setGoodTmpName(String goodTmpName) {
        this.goodTmpName = goodTmpName;
    }

    public String getGoodTmpCt() {
        return goodTmpCt;
    }

    public void setGoodTmpCt(String goodTmpCt) {
        this.goodTmpCt = goodTmpCt;
    }

    public String getGoodTmpContent() {
        return goodTmpContent;
    }

    public void setGoodTmpContent(String goodTmpContent) {
        this.goodTmpContent = goodTmpContent;
    }

    public Long getGoodTmpCm() {
        return goodTmpCm;
    }

    public void setGoodTmpCm(Long goodTmpCm) {
        this.goodTmpCm = goodTmpCm;
    }

    public GoodTmpTypeEnum getGoodTmpType() {
        return goodTmpType;
    }

    public void setGoodTmpType(GoodTmpTypeEnum goodTmpType) {
        this.goodTmpType = goodTmpType;
    }
}
