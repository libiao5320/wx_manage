package cc.royao.mana.ctrl;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import cc.royao.commons.formbean.MapVo;
import cc.royao.commons.httpClient.HttpUtil;
import cc.royao.commons.httpClient.RequestContent;
import cc.royao.commons.httpClient.ResponseContent;
/**
 * 其他设置与储存设置
 * @author oubinbin
 *
 */
@Controller
@RequestMapping("/SettingsCtrl")
public class SettingsCtrl{
	Logger logger = Logger.getLogger(this.getClass());
	/**
	 * 到储存设置页面
	 * @param modelMap
	 * @return
	 */
	@RequestMapping("/storageSetting.htm")
	public String storageSetting(ModelMap modelMap){
		String urlPaht = "/settingsCenter/queryStorageSetting.htm";
		  HashMap<String , Object> hashMap = new HashMap<String, Object>();
			MapVo mapVo = new MapVo();
			mapVo.setMap(hashMap);
			RequestContent content = new RequestContent();
			content.setBody(mapVo.getMap());
		
	        try {
	            ResponseContent responseContent = HttpUtil.getInputStreamByPost(urlPaht, content, "utf-8");
	            if(null != responseContent.getBody()){
	            	Map map = (Map) responseContent.getBody();
	                modelMap.put("result",(JSONArray) map.get("dsystemSets"));
	                modelMap.put("vips",map.get("vips"));
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
		return "commonSettings/storageSetting";
	}
	/**
	 * 到其他设置页面
	 * @param modelMap
	 * @return
	 */
	@RequestMapping("/queryotherSetting.htm")
	public String otherSetting(ModelMap modelMap){
		String urlPaht = "/settingsCenter/queryotherSetting.htm";
		  HashMap<String , Object> hashMap = new HashMap<String, Object>();
			MapVo mapVo = new MapVo();
			mapVo.setMap(hashMap);
			RequestContent content = new RequestContent();
			content.setBody(mapVo.getMap());
		
	        try {
	            ResponseContent responseContent = HttpUtil.getInputStreamByPost(urlPaht, content, "utf-8");
	            if(null != responseContent.getBody()){
	                JSONArray result = (JSONArray) responseContent.getBody();
	                modelMap.put("result",result);
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
		return "commonSettings/otherSetting";
	}
	/**
	 *  修改设置信息
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/updateSetting.ajax")
	public String updateSetting(HttpServletRequest request, HttpServletResponse response){
		String urlPaht = "/settingsCenter/updateSetting.htm";
		
		RequestContent content = new RequestContent();
		content.setBody(JSON.parseObject(request.getParameter("map")));
		try {
			ResponseContent responseContent = HttpUtil.getInputStreamByPost(urlPaht,content, "utf-8");
			
			if(null != responseContent.getBody()){
				Map<String,Object> json = (Map<String,Object>) responseContent.getBody();
				return JSONObject.toJSONString(json);
			}else{
				Map<String,Object> json = new HashMap<String, Object>();
				json.put("message", "更新设置信息失败");
				return JSONObject.toJSONString(json);
			}
		} catch (Exception e) {
			logger.info("更新设置信息失败", e);
			Map<String,Object> json = new HashMap<String, Object>();
			json.put("message", "更新设置信息失败");
			return JSONObject.toJSONString(json);
		}
    }
}

