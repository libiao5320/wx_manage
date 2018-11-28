package cc.royao.http;

/**
 * Created by libia on 2016/1/15.
 */
public class ResponseContent {

    private static final long serialVersionUID = -7871783226735556338L;
    private ResponseHead head;    //消息头
    private Object body;    //请求结果集

    public ResponseContent() {
    }

    public ResponseHead getHead() {
        return this.head;
    }

    public void setHead(ResponseHead head) {
        this.head = head;
    }

    public Object getBody() {
        return this.body;
    }

    public void setBody(Object body) {
        this.body = body;
    }
}


