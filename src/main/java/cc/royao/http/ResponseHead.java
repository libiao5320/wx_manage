package cc.royao.http;

import java.io.Serializable;

/**
 * Created by libia on 2015/12/31.
 */
public class ResponseHead implements Serializable {

    private static final long serialVersionUID = 4216148168455362981L;
    private String transactionId;    //tokey
    private String resultCode;        //请求是否成功
    private String description;        //响应描述
    private String responseTime;    //响应时间

    public ResponseHead() {
    }

    public String getTransactionId() {
        return this.transactionId;
    }

    public void setTransactionId(String transactionId) {
        this.transactionId = transactionId;
    }

    public String getResultCode() {
        return this.resultCode;
    }

    public void setResultCode(String resultCode) {
        this.resultCode = resultCode;
    }

    public String getDescription() {
        return this.description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getResponseTime() {
        return this.responseTime;
    }

    public void setResponseTime(String responseTime) {
        this.responseTime = responseTime;
    }


}
