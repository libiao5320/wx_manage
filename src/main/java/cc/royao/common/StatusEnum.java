package cc.royao.common;

/**
 * Created by libia on 2016/1/18.
 */
public enum StatusEnum {


    Y {
        public String getName (){

            return "正常";
        }
    },
    N {
        public String getName (){

            return "异常";
        }
    },
    D {
        public String getName (){

            return "删除";
        }
    }
}
