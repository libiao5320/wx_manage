package cc.royao.mana.exception;

/**
 * Created by libia on 2016/2/3.
 */
public class SystemException extends RuntimeException {

    private static final long serialVersionUID = 1L;

    public SystemException() {
        // TODO Auto-generated constructor stub
    }

    public SystemException(String message) {
        super(message);
        // TODO Auto-generated constructor stub
    }

    public SystemException(Throwable cause) {
        super(cause);
        // TODO Auto-generated constructor stub
    }

    public SystemException(String message, Throwable cause) {
        super(message, cause);
        // TODO Auto-generated constructor stub
    }
}
