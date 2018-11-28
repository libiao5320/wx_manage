package cc.royao.common;

/**
 * Created by libia on 2016/1/22.
 */
public enum GoodTmpTypeEnum {


    know {
        public String getName (){

            return "客户须知";
        }
    },
    right {
        public String getName (){

            return "客户权益";
        }
    },
    introduce {
        public String getName (){

            return "产品介绍";
        }
    }
}
