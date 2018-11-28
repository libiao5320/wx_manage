package cc.royao.commons.httpClient;

import java.io.Serializable;
import java.util.Map;

import cc.royao.utils.DateUtil;

/**
 * Created by libia on 2015/12/31.
 */
public class RequestContent implements Serializable {


    private static final long serialVersionUID = -6178593495285048752L;


    public RequestContent(){
        RequestHead head = new RequestHead();
        head.setRequestTime(DateUtil.formatDate(DateUtil.current()));
        this.head = head;
    }

    private RequestHead head;

    private Map<String, Object> body;

    public RequestHead getHead() {
        return head;
    }

    public void setHead(RequestHead head) {
        this.head = head;
    }

    public Map<String, Object> getBody() {
        return body;
    }

    public void setBody(Map<String, Object> body) {
        this.body = body;
    }
}
