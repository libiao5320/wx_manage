package cc.royao.commons.httpClient;

import java.io.Serializable;

/**
 * Created by libia on 2015/12/31.
 */
public class ResponseContent implements Serializable {

    private static final long serialVersionUID = -7871783226735556338L;
    private ResponseHead head;
    private Object body;

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
