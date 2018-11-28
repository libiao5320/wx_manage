package cc.royao.http;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.serializer.SerializerFeature;
import cc.royao.mana.auth.model.BaseEntity;
import org.springframework.util.ObjectUtils;
import org.springframework.util.StringUtils;
import cc.royao.utils.DateUtil;

import java.util.List;

/**
 * Created by libia on 2016/1/15.
 */
public class ResponseHandler {

    private static final String SUCCESSCODE = "200";
    private static final String FAILCODE = "500";


    private static final String SUCCESS = "SUCCESS"; // 接口请求成功

    private static final String INVALID_REQUEST = "INVALID_REQUEST"; // 无效的接口请求

    public static ResponseContent makeResponse(Object result, boolean flag) throws Exception {

        ResponseContent responseContent = new ResponseContent();
        ResponseHead responseHead = new ResponseHead();

        JSON json = null;
        if (result instanceof List) {
            json = JSONArray.parseArray(JSONArray.toJSONStringWithDateFormat(result, "yyyy-MM-dd HH:mm:ss", SerializerFeature.DisableCircularReferenceDetect));
        } else if (result instanceof BaseEntity) {
            json = JSON.parseObject(JSONObject.toJSONStringWithDateFormat(result, "yyyy-MM-dd HH:mm:ss", SerializerFeature.DisableCircularReferenceDetect));
        } else if(result instanceof String || result instanceof Boolean || result instanceof Integer || result instanceof Double || result instanceof Float || result instanceof Long) {

            String jsonStr = "{result:"+result+"}";
            json =  JSONObject.parseObject(jsonStr);


        } else {
            json = JSON.parseObject(JSONObject.toJSONStringWithDateFormat(result,"yyyy-MM-dd HH:mm:ss",SerializerFeature.DisableCircularReferenceDetect));
        }

//        if (result != null) {
            responseContent.setBody(json);
//        } else {
//            throw new Exception("接口返回报错");
//        }

        if (flag) {
            responseHead.setResultCode(SUCCESSCODE);
            responseHead.setDescription(SUCCESS);
        } else {
            responseHead.setResultCode(FAILCODE);
            responseHead.setDescription(INVALID_REQUEST);
        }



        responseHead.setResponseTime(DateUtil.format("yyyyMMddHHmmss", DateUtil.current()));
        responseContent.setHead(responseHead);

        return responseContent;

    }
}


