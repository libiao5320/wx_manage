package cc.royao.utils;

import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;

import com.alibaba.fastjson.JSONObject;
import cc.royao.mana.auth.model.Manager;
import cc.royao.mana.auth.model.Privilege;
import cc.royao.mana.auth.model.Role;
import cc.royao.mana.auth.service.manager.ManagerService;
import cc.royao.mana.auth.service.manager.impl.ManagerServiceImpl;
import com.sun.org.apache.xerces.internal.impl.dv.util.Base64;

import cc.royao.common.Constants;
import cc.royao.common.PrivateTypeEnum;

public class CookieUtil {
	@Autowired
	private ManagerService managerService;

	// 保存cookie时的cookieName
	private static String cookieDomainName = "userInfo";
	// 加密cookie时的网站自定码
	private static String webKey = "rongyao";
	// 设置cookie有效期是一个星期，根据需要自定义
	private static Integer cookieMaxAge = 60 * 60 * 24 * 7 * 1;

	public static void saveCookie(String managerLoginName,
			String managerLoginPwd, HttpServletResponse response) {

		JSONObject userinfo = new JSONObject();
		userinfo.put("managerLoginName", managerLoginName);
		userinfo.put("managerLoginPwd", managerLoginPwd);
		userinfo.put("rememberMe", 1);
		Cookie cookie = new Cookie("userInfo",
				JSONObject.toJSONString(userinfo));
		if (cookieMaxAge > 0) {
			cookie.setMaxAge(cookieMaxAge);
		}

		// cookie有效路径是网站根目录

		cookie.setPath("/");

		// 向客户端写入

		response.addCookie(cookie);

	}

	// 读取Cookie,自动完成登陆操作----------------------------------------------------------------

	// 在Filter程序中调用该方法,见AutoLogonFilter.java

	public static Manager readCookieAndLogon(HttpServletRequest request,
			HttpServletResponse response, ManagerService managerService)
			throws Exception {

		// 根据cookieName取cookieValue
		Cookie cookies[] = request.getCookies();
		String cookieValue = null;
		if (cookies != null) {
			for (int i = 0; i < cookies.length; i++) {
				if (cookieDomainName.equals(cookies[i].getName())) {
					cookieValue = cookies[i].getValue();
					break;
				}

			}

		}
		// 如果cookieValue为空,返回,
		if (cookieValue == null) {
			return null;
		}
		// 如果cookieValue不为空,才执行下面的代码
		// 先得到的CookieValue进行Base64解码
		String cookieValueAfterDecode = new String(Base64.decode(cookieValue),
				"utf-8");
		// 对解码后的值进行分拆,得到一个数组,如果数组长度不为3,就是非法登陆
		String cookieValues[] = cookieValueAfterDecode.split(":");
		if (cookieValues.length != 3) {
			return null;
		}
		// 判断是否在有效期内,过期就删除Cookie
		long validTimeInCookie = new Long(cookieValues[1]);
		if (validTimeInCookie < System.currentTimeMillis()) {
			// 删除Cookie
			clearCookie(response);
			return null;
		}
		// 取出cookie中的用户名,并到数据库中检查这个用户名,
		String managerId = cookieValues[0];

		// 根据用户名到数据库中检查用户是否存在
		long id = -1;
		if (isInteger(managerId)) {
			id = Long.parseLong(managerId);
		}
		Manager manager = managerService.queryById(id);

		// 如果user返回不为空,就取出密码,使用用户名+密码+有效时间+ webSiteKey进行MD5加密
		if (manager != null) {
			String md5ValueInCookie = cookieValues[2];
			String md5ValueFromUser = getMD5(manager.getManagerLoginName()
					+ ":" + manager.getManagerLoginPwd() + ":"
					+ validTimeInCookie + ":" + webKey);
			// 将结果与Cookie中的MD5码相比较,如果相同,写入Session,自动登陆成功,并继续用户请求
			if (md5ValueFromUser.equals(md5ValueInCookie)) {
				request.getSession().setAttribute(Constants.SESSION_USERINFO,
						manager);
				generateManagerPrivilegeExpress(request);
				return manager;
			} else {
				return null;
			}

		} else {
			return null;
		}
	}

	// 用户注销时,清除Cookie,在需要时可随时调用-----------------------------------------------------
	public static void clearCookie(HttpServletResponse response) {
		Cookie cookie = new Cookie(cookieDomainName, null);
		cookie.setMaxAge(0);
		cookie.setPath("/");
		response.addCookie(cookie);
	}

	// 获取Cookie组合字符串的MD5码的字符串----------------------------------------------------------------
	public static String getMD5(String value) {
		String result = null;
		try {
			byte[] valueByte = value.getBytes();
			MessageDigest md = MessageDigest.getInstance("MD5");
			md.update(valueByte);
			result = toHex(md.digest());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	// 将传递进来的字节数组转换成十六进制的字符串形式并返回
	private static String toHex(byte[] buffer) {
		StringBuffer sb = new StringBuffer(buffer.length * 2);
		for (int i = 0; i < buffer.length; i++) {
			sb.append(Character.forDigit((buffer[i] & 0xf0) >> 4, 16));
			sb.append(Character.forDigit(buffer[i] & 0x0f, 16));
		}
		return sb.toString();
	}

	/**
	 * 判断字符串是否是整数
	 */
	public static boolean isInteger(String value) {
		try {
			Integer.parseInt(value);
			return true;
		} catch (NumberFormatException e) {
			return false;
		}
	}

	private static void generateManagerPrivilegeExpress(
			HttpServletRequest request) {
		StringBuffer privilegeBuffer = new StringBuffer("");
		Manager manager = (Manager) request.getSession().getAttribute(
				Constants.SESSION_USERINFO);

		Set<String> privilegeSet = new HashSet();

		if (null != manager.getRole() && manager.getRole().size() > 0) {
			List<Role> roles = manager.getRole();
			for (int i = 0; i < roles.size(); i++) {
				Role role = roles.get(i);
				if (null != role.getPrivileges()
						&& role.getPrivileges().size() > 0) {

					List<Privilege> privilegeList = role.getPrivileges();

					for (int j = 0; j < privilegeList.size(); j++) {

						Privilege privilege = privilegeList.get(j);

						if (privilege.getPrivilegeType() == PrivateTypeEnum.MENU
								&& privilege.getMenuId() != null) {

							privilegeBuffer.append("[" + privilege.getMenuId()
									+ "]");

						}

					}
				}

			}

		}

		request.getSession().setAttribute(Constants.SESSION_PRIVILEGEINFO,
				privilegeBuffer);

	}

	/**
	 * 
	 * @Description: 将cookie封装到Map里面（非接口方法）
	 * @param @param request
	 * @param @return
	 * @return Map<String,Cookie>
	 * @throws
	 * @author Liu Pinghui
	 * @date 2016年3月12日
	 */
	public static Map<String, Cookie> ReadCookieMap(HttpServletRequest request) {
		Map<String, Cookie> cookieMap = new HashMap<String, Cookie>();
		Cookie[] cookies = request.getCookies();
		if (null != cookies) {
			for (Cookie cookie : cookies) {
				cookieMap.put(cookie.getName(), cookie);
			}
		}
		return cookieMap;
	}
}
