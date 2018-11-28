package cc.royao.mana.ctrl;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import cc.royao.commons.httpClient.HttpUtil;
import cc.royao.commons.httpClient.RequestContent;
import cc.royao.commons.httpClient.ResponseContent;


/**
 * 订单管理  
 * @author L
 *
 */

@Controller
@RequestMapping("/complain")
public class ComplainCtrl {
	@RequestMapping("/index.htm")
	public String index(HttpServletRequest request, ModelMap model){
		if(request.getParameter("status") != null){
			String status = request.getParameter("status");
			model.addAttribute("indexStatus", status);
			return "complain/index";
		}
		model.addAttribute("indexStatus", "false");
		return "complain/index";
	}
	

	/**
	 * ajax获取订单投诉列表
	 */
	@ResponseBody
	@RequestMapping(value = "/list.ajax", produces = {"application/json;charset=UTF-8"})
	public String list(HttpServletResponse response, HttpServletRequest request){
		Logger logger = Logger.getLogger(this.getClass());
		
		String urlPath = "/complain/index.htm";
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
			logger.info("请求投诉列表失败", e);
			return "网络忙，请稍后再试";
		}
	}
	
	/**
	 * 处理订单投诉详情页面
	 */
	@RequestMapping("/handleComplain/{id}.htm")
	public String handleComplain(@PathVariable String id, ModelMap modelMap){
		Logger logger = Logger.getLogger(this.getClass());
		
		String urlPath = "/complain/detail.htm";
		RequestContent requestContent = new RequestContent();
		Map map = new HashMap();
		map.put("id", id);
		requestContent.setBody(map);
		ResponseContent responseContent = null;
		
		try {
			responseContent = HttpUtil.getInputStreamByPost(urlPath, requestContent, "utf-8");
			if(responseContent.getBody() != null){
				Map<String,Object> resultMap = (Map<String,Object>) responseContent.getBody();
				modelMap.put("complain", resultMap.get("complain"));
				modelMap.put("order", resultMap.get("order"));
				modelMap.put("store", resultMap.get("store"));
			}
		} catch (Exception e) {
			logger.info("请求商品列表失败", e);
		}
		return "complain/handleComplain";
	}
	
	/**
	 * 更新订单投诉信息
	 */
	@ResponseBody
	@RequestMapping("/update.ajax")
	public String update(HttpServletResponse response, HttpServletRequest request){
		Logger logger = Logger.getLogger(this.getClass());
		
		String urlPath = "/complain/update.htm";
		RequestContent requestContent = new RequestContent();
		requestContent.setBody(JSON.parseObject(request.getParameter("map")));
		ResponseContent responseContent = null;
		
		try {
			responseContent = HttpUtil.getInputStreamByPost(urlPath, requestContent, "utf-8");

 			if(responseContent.getBody() != null){
				Map<String,Object> json = (Map<String,Object>) responseContent.getBody();
				return JSONObject.toJSONString(json);
			}else{
				Map<String,Object> json = new HashMap<String, Object>();
				json.put("state", -1);
				json.put("message", "更新失败");
				return JSONObject.toJSONString(json);
			}

		} catch (Exception e) {
			logger.info("更新失败", e);
			Map<String,Object> json = new HashMap<String, Object>();
			json.put("state", -1);
			json.put("message", "更新失败");
			return JSONObject.toJSONString(json);
		}
	}
}
