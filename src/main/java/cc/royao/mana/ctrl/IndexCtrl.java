package cc.royao.mana.ctrl;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cc.royao.utils.CookieUtil;

import com.alibaba.fastjson.JSONObject;
import cc.royao.commons.httpClient.HttpUtil;
import cc.royao.commons.httpClient.RequestContent;
import cc.royao.commons.httpClient.ResponseContent;

@Controller
public class IndexCtrl {
	Logger logger = Logger.getLogger(this.getClass());
	
	@RequestMapping("/index.htm")
	public String index()
    {
		return "index";
    }

	@RequestMapping("/login.htm")
	public String loginPage(HttpServletResponse response,
			HttpServletRequest request, ModelMap map) {
		Map<String, Cookie> cookieMap = CookieUtil.ReadCookieMap(request);
		if (cookieMap.containsKey("userInfo")) {
			Cookie cookie = (Cookie) cookieMap.get("userInfo");
			if (!cookie.getValue().equals("")) {
				JSONObject userInfo = JSONObject.parseObject(cookie.getValue());

				map.put("managerLoginName", userInfo.get("managerLoginName"));
				map.put("managerLoginName", userInfo.get("managerLoginName"));
				map.put("rememberMe", userInfo.get("rememberMe"));

			}
		}

		return "manager/login";
	}
	
	/**
	 * ajax获取首页数据
	 */
	@ResponseBody
	@RequestMapping(value = "/indexQuery.ajax", produces = {"application/json;charset=UTF-8"})
	public String list(HttpServletResponse response, HttpServletRequest request){
		Logger logger = Logger.getLogger(this.getClass());
		
		String urlPath = "/p_index/indexQuery.htm";
		RequestContent requestContent = new RequestContent();
		ResponseContent responseContent = null;
		
		try {
			responseContent = HttpUtil.getInputStreamByPost(urlPath, requestContent, "utf-8");
			if(responseContent.getBody() != null){
				@SuppressWarnings("unchecked")
				Map<String,Object> json = (Map<String,Object>) responseContent.getBody();
				return JSONObject.toJSONString(json);
			}else{
				return "没有数据";
			}
		} catch (Exception e) {
			logger.info("请求首页数据失败", e);
			return "网络忙，请稍后再试";
		}
	}
}
