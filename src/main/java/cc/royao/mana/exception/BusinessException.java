package cc.royao.mana.exception;

/**
 * Created by libia on 2016/2/3.
 */
public class BusinessException extends Exception {

    private static final long serialVersionUID = 1L;

    public BusinessException() {
        // TODO Auto-generated constructor stub
    }

    public BusinessException(String message) {
        super(message);
        // TODO Auto-generated constructor stub
    }

    public BusinessException(Throwable cause) {
        super(cause);
        // TODO Auto-generated constructor stub
    }

    public BusinessException(String message, Throwable cause) {
        super(message, cause);
        // TODO Auto-generated constructor stub
    }
}
