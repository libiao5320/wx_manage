package cc.royao.mana.ctrl;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;

import cc.royao.common.Constants;
import cc.royao.commons.httpClient.HttpUtil;
import cc.royao.commons.httpClient.RequestContent;
import cc.royao.commons.httpClient.ResponseContent;
import cc.royao.mana.auth.model.Manager;
import cc.royao.utils.AdminConfig;


/**
 * 充值卡管理  
 * @author L
 *
 */

@Controller
@RequestMapping("/rechargeCard")
public class RechargeCardCtrl {
	@RequestMapping("/index.htm")
	public String index(){
		return "rechargeCard/index";
	}
	

	/**
	 * ajax获取充值卡列表
	 */
	@ResponseBody
	@RequestMapping(value = "/list.ajax", produces = {"application/json;charset=UTF-8"})
	public String list(HttpServletResponse response, HttpServletRequest request){
		Logger logger = Logger.getLogger(this.getClass());
		
		String urlPath = "/rechargeCard/index.htm";
		RequestContent requestContent = new RequestContent();
		requestContent.setBody(JSON.parseObject(request.getParameter("map")));
		ResponseContent responseContent = null;
		
		try {
			responseContent = HttpUtil.getInputStreamByPost(urlPath, requestContent, "utf-8");
			if(responseContent.getBody() != null){
				Map<String,Object> json = (Map<String,Object>) responseContent.getBody();
				return JSONObject.toJSONString(json);
			}else{
				return "没有数据";
			}
		} catch (Exception e) {
			logger.info("请求充值卡列表失败", e);
			return "网络忙，请稍后再试";
		}
	}
	
	/**
	 * 生成充值卡页面
	 */
	@RequestMapping("/createPage.htm")
	public String createPage(){
		return "rechargeCard/createPage";
	}
	
	/**
	 * 注销充值卡
	 */
	@ResponseBody
	@RequestMapping("/delete.ajax")
	public String handleComplain(HttpServletResponse response, HttpServletRequest request){
		Logger logger = Logger.getLogger(this.getClass());
		
		String urlPath = "/rechargeCard/delete.htm";
		RequestContent requestContent = new RequestContent();
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("id", request.getParameter("id"));
		requestContent.setBody(map);
		ResponseContent responseContent = null;
		
		try {
			responseContent = HttpUtil.getInputStreamByPost(urlPath, requestContent, "utf-8");

 			if(responseContent.getBody() != null){
				Map<String,Object> json = (Map<String,Object>) responseContent.getBody();
				return JSONObject.toJSONString(json);
			}else{
				Map<String,Object> json = new HashMap<String, Object>();
				json.put("state", -1);
				json.put("message", "注销失败");
				return JSONObject.toJSONString(json);
			}

		} catch (Exception e) {
			logger.info("注销失败", e);
			Map<String,Object> json = new HashMap<String, Object>();
			json.put("state", -1);
			json.put("message", "注销失败");
			return JSONObject.toJSONString(json);
		}
	}
	
	/**
	 * 生成充值卡
	 */
	@ResponseBody
	@RequestMapping(value = "/create.ajax", produces = {"application/json;charset=UTF-8"})
	public String create(HttpServletResponse response, HttpServletRequest request){
		
		String urlPath = "/rechargeCard/create.htm";
		RequestContent requestContent = new RequestContent();
		Manager manager = (Manager) request.getSession().getAttribute(Constants.SESSION_USERINFO);
		Map<String,Object> params = new HashMap<String,Object>();
		params.put("map", JSON.parseObject(request.getParameter("map")));
		params.put("managerName", manager.getManagerName());
		String url = AdminConfig.rechargeCardUrl;
		params.put("url", url);
		
		requestContent.setBody(params);
		ResponseContent responseContent = null;
		
		try {
			responseContent = HttpUtil.getInputStreamByPost(urlPath, requestContent, "utf-8");
			if(responseContent.getBody() != null){
				Map<String,Object> json = (Map<String,Object>) responseContent.getBody();
				return JSONObject.toJSONString(json);
			}else{
				Map<String,Object> json = new HashMap<String, Object>();
				json.put("state", -1);
				json.put("message", "生成充值卡失败");
				return JSONObject.toJSONString(json);
			}
		} catch (Exception e) {
			Map<String,Object> json = new HashMap<String, Object>();
			json.put("state", -1);
			json.put("message", "生成充值卡失败");
			return JSONObject.toJSONString(json);
		}
	}
}
