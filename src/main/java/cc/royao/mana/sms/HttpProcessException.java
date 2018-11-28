package cc.royao.mana.sms;

/**
 * 
 * @author jk
 * @Description
 * @date 2016年1月30日
 */

public class HttpProcessException extends Exception {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public HttpProcessException(Exception e) {
		super(e);
	}

	/**
	 * @param string
	 */
	public HttpProcessException(String msg) {
		super(msg);
	}

	/**
	 * @param message
	 * @param e
	 */
	public HttpProcessException(String message, Exception e) {
		super(message, e);
	}

}
