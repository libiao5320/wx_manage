package cc.royao.mana.ctrl;

import java.util.HashMap;
import java.util.List;
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
import cc.royao.commons.formbean.MapVo;
import cc.royao.commons.httpClient.HttpUtil;
import cc.royao.commons.httpClient.RequestContent;
import cc.royao.commons.httpClient.ResponseContent;
import cc.royao.mana.auth.model.Manager;

import cc.royao.common.Constants;

/**
 * 
 * ClassName: EventCtrl 
 * @Description: 红包管理
 * @author Liu Li
 * @date 2016年1月23日
 */
@Controller
@RequestMapping("/redpackets")
public class RedpacketsCtrl {
	Logger logger = Logger.getLogger(this.getClass());
	
	@RequestMapping ("/index.htm")
    public String index()
    {
		return "redpackets/index";
    }
	
	@RequestMapping ("/create.htm")
    public String create(ModelMap modelMap)
    {
		String urlPaht = "/redpackets/p_queryAllStorePassed.htm";
		
		RequestContent content = new RequestContent();
		Map<String, Object> map = new HashMap<String, Object>();
		content.setBody(map);
		try {
			ResponseContent responseContent = HttpUtil.getInputStreamByPost(urlPaht, content, "utf-8");
			
			if(null != responseContent.getBody()){
				List<?> list = (List<?>) responseContent.getBody();
				modelMap.put("storeList",list);
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.info("请求失败", e);
		}
		return "redpackets/create";
    }
	
	@RequestMapping ("/detail/{id}.htm")
    public String detail(ModelMap modelMap,@PathVariable Long id)
    {
		modelMap.put("id", id);
		return "redpackets/detail";
    }
	
	@RequestMapping ("/edit/{id}.htm")
    public String edit(ModelMap modelMap,@PathVariable Long id)
    {
		String urlPaht = "/redpackets/p_detail.htm";
		
		RequestContent content = new RequestContent();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		content.setBody(map);
		try {
			ResponseContent responseContent = HttpUtil.getInputStreamByPost(urlPaht, content, "utf-8");

			if(null != responseContent.getBody()){
				JSONObject result = (JSONObject) responseContent.getBody();
				modelMap.put("redpackets",result.get("redpackets"));
				modelMap.put("store", result.get("store"));
				modelMap.put("storeList", result.get("storeList"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redpackets/edit";
    }
	
	/**
	 * ajax获取红包列表
	 * @param response
	 * @param request
	 * @return
	 * @author Liu Li
	 * @date 2016年1月20日
	 */
	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping ("/query.ajax")
    public String listajax(HttpServletRequest request, HttpServletResponse response)
    {
		String urlPaht = "/redpackets/p_query.htm";
		
		RequestContent content = new RequestContent();
		content.setBody(JSON.parseObject(request.getParameter("map")));
	
		try {
			ResponseContent responseContent = HttpUtil.getInputStreamByPost(urlPaht,content, "utf-8");
			
			if(null != responseContent.getBody()){
				Map<String,Object> json = (Map<String,Object>) responseContent.getBody();
				return JSONObject.toJSONString(json);
			}else{
				Map<String,Object> json = new HashMap<String, Object>();
				json.put("state", -1);
				json.put("message", "已经没有更多了");
				return JSONObject.toJSONString(json);
			}
		} catch (Exception e) {
			logger.info("请求红包列表失败", e);
			Map<String,Object> json = new HashMap<String, Object>();
			json.put("state", -1);
			json.put("message", "请求红包列表失败");
			return JSONObject.toJSONString(json);
		}
    }
	
	/**
	 * 通过id删除红包
	 * @param response
	 * @param request
	 * @return
	 * @author Liu Li
	 * @date 2016年1月23日
	 */
	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping ("/deleteRedpacketsById.ajax")
    public String deleteRedpacketsById(HttpServletRequest request, HttpServletResponse response)
    {
		String urlPaht = "/redpackets/p_deleteRedpacketsById.htm";
		
		MapVo mapVo = new MapVo();
		long id = Long.parseLong(request.getParameter("id"));
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("id", id);
		mapVo.setMap(map);
		
		RequestContent content = new RequestContent();
		content.setBody(mapVo.getMap());
	
		try {
			ResponseContent responseContent = HttpUtil.getInputStreamByPost(urlPaht,content, "utf-8");
			
			if(null != responseContent.getBody()){
				Map<String,Object> json = (Map<String,Object>) responseContent.getBody();
				return JSONObject.toJSONString(json);
			}else{
				Map<String,Object> json = new HashMap<String, Object>();
				json.put("state", -1);
				json.put("message", "删除红包失败");
				return JSONObject.toJSONString(json);
			}
		} catch (Exception e) {
			logger.info("删除红包失败", e);
			Map<String,Object> json = new HashMap<String, Object>();
			json.put("state", -1);
			json.put("message", "删除红包失败");
			return JSONObject.toJSONString(json);
		}
    }
	
	/**
	 * 更新红包
	 * @param response
	 * @param request
	 * @return
	 * @author Liu Li
	 * @date 2016年1月22日
	 */
	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping ("/updateRedpacketsById.ajax")
    public String updateRedpacketsById(HttpServletRequest request, HttpServletResponse response)
    {
		String urlPaht = "/redpackets/p_updateRedpacketsById.htm";
		
		RequestContent content = new RequestContent();
		Map map = new HashMap<String, Object>();
		Manager manager = (Manager) request.getSession().getAttribute(Constants.SESSION_USERINFO);
		map.put("updateBy", manager.getMamangerId());
		map.putAll(JSON.parseObject(request.getParameter("map")));
		content.setBody(map);
	
		try {
			ResponseContent responseContent = HttpUtil.getInputStreamByPost(urlPaht,content, "utf-8");
			
			if(null != responseContent.getBody()){
				Map<String,Object> json = (Map<String,Object>) responseContent.getBody();
				return JSONObject.toJSONString(json);
			}else{
				Map<String,Object> json = new HashMap<String, Object>();
				json.put("state", -1);
				json.put("message", "更新红包失败");
				return JSONObject.toJSONString(json);
			}
		} catch (Exception e) {
			logger.info("更新红包失败", e);
			Map<String,Object> json = new HashMap<String, Object>();
			json.put("state", -1);
			json.put("message", "更新红包失败");
			return JSONObject.toJSONString(json);
		}
    }
	
	/**
	 * 更新红包
	 * @param response
	 * @param request
	 * @return
	 * @author Liu Li
	 * @date 2016年1月22日
	 */
	@ResponseBody
	@RequestMapping ("/saveRedpackets.ajax")
    public String saveRedpackets(HttpServletRequest request, HttpServletResponse response)
    {
		String urlPaht = "/redpackets/p_saveRedpackets.htm";
		
		RequestContent content = new RequestContent();
		Map map = new HashMap<String, Object>();
		Manager manager = (Manager) request.getSession().getAttribute(Constants.SESSION_USERINFO);
		map.put("updateBy", manager.getMamangerId());
		map.put("createBy", manager.getMamangerId());
		map.putAll(JSON.parseObject(request.getParameter("map")));
		content.setBody(map);
		
		try {
			ResponseContent responseContent = HttpUtil.getInputStreamByPost(urlPaht,content, "utf-8");
			
			if(null != responseContent.getBody()){
				@SuppressWarnings("unchecked")
				Map<String,Object> json = (Map<String,Object>) responseContent.getBody();
				return JSONObject.toJSONString(json);
			}else{
				Map<String,Object> json = new HashMap<String, Object>();
				json.put("state", -1);
				json.put("message", "添加红包失败");
				return JSONObject.toJSONString(json);
			}
		} catch (Exception e) {
			logger.info("添加红包失败", e);
			Map<String,Object> json = new HashMap<String, Object>();
			json.put("state", -1);
			json.put("message", "添加红包失败");
			return JSONObject.toJSONString(json);
		}
    }
	
	/**
	 * ajax获取红包领取列表
	 * @param response
	 * @param request
	 * @return
	 * @author Liu Li
	 * @date 2016年1月25日
	 */
	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping ("/detailList.ajax")
    public String detailajaxList(HttpServletRequest request, HttpServletResponse response)
    {
		String urlPaht = "/redpackets/p_detailList.htm";
		
		RequestContent content = new RequestContent();
		content.setBody(JSON.parseObject(request.getParameter("map")));
	
		try {
			ResponseContent responseContent = HttpUtil.getInputStreamByPost(urlPaht,content, "utf-8");
			
			if(null != responseContent.getBody()){
				Map<String,Object> json = (Map<String,Object>) responseContent.getBody();
				return JSONObject.toJSONString(json);
			}else{
				Map<String,Object> json = new HashMap<String, Object>();
				json.put("state", -1);
				json.put("message", "已经没有更多了");
				return JSONObject.toJSONString(json);
			}
		} catch (Exception e) {
			logger.info("请求红包领取列表失败", e);
			Map<String,Object> json = new HashMap<String, Object>();
			json.put("state", -1);
			json.put("message", "请求红包领取列表失败");
			return JSONObject.toJSONString(json);
		}
    }
}
