package cc.royao.http;

import java.util.Map;

/**
 * Created by libia on 2016/1/15.
 */
public class RequestContent {



    private static final long serialVersionUID = -6178593495285048752L;

    private RequestHead head;

    private Map<String, String> body;

    public RequestHead getHead() {
        return head;
    }

    public void setHead(RequestHead head) {
        this.head = head;
    }

    public Map<String, String> getBody() {
        return body;
    }

    public void setBody(Map<String, String> body) {
        this.body = body;
    }


}
