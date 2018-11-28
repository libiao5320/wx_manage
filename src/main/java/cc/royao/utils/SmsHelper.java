package cc.royao.utils;

import java.io.UnsupportedEncodingException;
import java.nio.charset.Charset;
import java.util.HashMap;
import java.util.Map;

import org.apache.log4j.Logger;

import cc.royao.mana.sms.HttpClientUtil;
import cc.royao.mana.sms.HttpHeader;
import cc.royao.mana.sms.HttpProcessException;
import cc.royao.mana.sms.SmsConfig;

public class SmsHelper {

	private Logger loger = Logger.getLogger(this.getClass());
	static {

		HttpHeader
				.custom()
				.userAgent(
						"Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/32.0.1700.107 Safari/537.36");
	}
	private static SmsHelper singletonInstance = new SmsHelper();
	public SmsHelper() {
	}

	public static SmsHelper getInstance() {
		if (singletonInstance == null) {
			singletonInstance = new SmsHelper();
		}
		return singletonInstance;
	}

	private static String MSGHEADER = "【贝多】";

	public String sendSms(String phone, String content) {
		String resp = null;
		
		try {
			Map<String, Object> parasMap = new HashMap<String, Object>();
			parasMap.put("cdkey", SmsConfig.SMS_EMAY_CDKEY);
			parasMap.put("password", SmsConfig.SMS_EMAY_PWD);
			parasMap.put("phone", phone);
			parasMap.put("message", java.net.URLDecoder.decode(MSGHEADER + content,"utf-8"));
			resp = HttpClientUtil.post(SmsConfig.SMS_EMAY_URL, parasMap,
					HttpHeader.custom().build(), Charset.defaultCharset()
							.name());
			return resp;
		} catch (HttpProcessException e) {
			e.printStackTrace();

		} catch (UnsupportedEncodingException e){
			e.printStackTrace();
		}
		return resp;
	}

	public static void main(String[] args) throws HttpProcessException {
		SmsHelper.getInstance().sendSms("13873183787", "验证码为1234");
	}

}
