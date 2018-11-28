package cc.royao.mana.ctrl;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import cc.royao.commons.ResponseJson;
import cc.royao.commons.formbean.MapVo;
import cc.royao.commons.httpClient.HttpUtil;
import cc.royao.commons.httpClient.RequestContent;
import cc.royao.commons.httpClient.ResponseContent;

import java.sql.Date;

/**
 * 专业等级设置
 */

@Controller
@RequestMapping("/majorGrade")
public class MajorGradeCtrl {
	Logger logger = Logger.getLogger(this.getClass());
	
	@RequestMapping("/index.htm")
	public String goodsClassPage(MapVo mapVo,ModelMap map){
		
		return "majorGrade/index";
	}
	
	@ResponseBody
	@RequestMapping (value = "/list.ajax", produces = {"application/json;charset=UTF-8"})
    public String list(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap)
    {
		String urlPath = "/groupbuy/p_list.htm";
		
		MapVo mapVo = new MapVo();
		mapVo.setMap(JSON.parseObject(request.getParameter("map")));
		
		RequestContent content = new RequestContent();
		content.setBody(mapVo.getMap());
	
		try {
			ResponseContent responseContent = HttpUtil.getInputStreamByPost(urlPath,content, "utf-8");
			
			if(null != responseContent.getBody()){
				Map<String,Object> json = (Map<String,Object>) responseContent.getBody();
				return JSONObject.toJSONString(json);
			}else{
				return "没有数据";
			}
		} catch (Exception e) {
			logger.info("请求专业等级列表失败", e);
			return "网络忙，请稍后再试";
		}
    }
	
	@RequestMapping("/addMajorPage.htm")
	public String addMajorPage(){
		return "majorGrade/addMajor";
	}

	@RequestMapping("/addGradePage.htm")
	public String addGradePage(ModelMap modelMap){
		String urlPath = "/groupbuy/p_queryMajor.htm";
		RequestContent content = new RequestContent();
		Map map = new HashMap<String, Object>();
		content.setBody(map);
		try {
			ResponseContent responseContent = HttpUtil.getInputStreamByPost(urlPath, content, "utf-8");

			if(null != responseContent.getBody()){
				Map<String,Object> json = (Map<String,Object>) responseContent.getBody();
				modelMap.put("result",json);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "majorGrade/addGrade";
	}
	
	/**
	 * 保存专业等级
	 */
	@ResponseBody
	@RequestMapping("/saveMajorGrade.ajax")
	public String saveMajorGrade(HttpServletRequest request){
		String urlPaht = "/groupbuy/p_saveMajorGrade.htm";
		
		RequestContent content = new RequestContent();
		content.setBody(JSON.parseObject(request.getParameter("map")));
	
		try {
			ResponseContent responseContent = HttpUtil.getInputStreamByPost(urlPaht,content, "utf-8");
			
			if(null != responseContent.getBody()){
				Map<String,Object> map = (Map<String,Object>) responseContent.getBody();
				return JSONObject.toJSONString(map);
			}else{
				Map<String,Object> json = new HashMap<String, Object>();
				json.put("state", -1);
				json.put("message", "添加专业等级信息失败");
				return JSONObject.toJSONString(json);
			}
		} catch (Exception e) {
			logger.info("添加专业等级信息失败", e);
			Map<String,Object> json = new HashMap<String, Object>();
			json.put("state", -1);
			json.put("message", "添加专业等级信息失败");
			return JSONObject.toJSONString(json);
		}
    }
	
	@RequestMapping("/editPage/{id}/{grade}.htm")
	public String goUpdatePage(ModelMap modelMap, @PathVariable Long id, @PathVariable String grade){
		
		String urlPaht = "/groupbuy/p_queryMajorGradeById.htm";
		
		RequestContent content = new RequestContent();
		Map map = new HashMap<String, Object>();
		map.put("id", id);
		content.setBody(map);
		try {
			ResponseContent responseContent = HttpUtil.getInputStreamByPost(urlPaht, content, "utf-8");

			if(null != responseContent.getBody()){
				Map<String,Object> json = (Map<String,Object>) responseContent.getBody();
				modelMap.put("result",json);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		if("".equals(grade)){
			return "majorGrade/editMajor";
		}else{
			return "majorGrade/editGrade";
		}
	}
	
	/**
	 *  修改专业等级信息
	 */
	@ResponseBody
	@RequestMapping("/updateMajorGrade.ajax")
	public String updateMajorGrade(HttpServletRequest request, HttpServletResponse response){
		String urlPaht = "/groupbuy/p_updateMajorGrade.htm";
		
		RequestContent content = new RequestContent();
		content.setBody(JSON.parseObject(request.getParameter("map")));
	
		try {
			ResponseContent responseContent = HttpUtil.getInputStreamByPost(urlPaht,content, "utf-8");
			
			if(null != responseContent.getBody()){
				Map<String,Object> json = (Map<String,Object>) responseContent.getBody();
				return JSONObject.toJSONString(json);
			}else{
				Map<String,Object> json = new HashMap<String, Object>();
				json.put("message", "更新专业等级信息失败");
				return JSONObject.toJSONString(json);
			}
		} catch (Exception e) {
			logger.info("更新专业等级信息失败", e);
			Map<String,Object> json = new HashMap<String, Object>();
			json.put("message", "更新专业等级信息失败");
			return JSONObject.toJSONString(json);
		}
    }
	
	/**
	 *  删除专业等级信息
	 */	@ResponseBody
	@RequestMapping("/deleteMajorGrade.ajax")
	public ResponseJson deleteMajorGrade(Long id){
		
		HashMap<String , Object> hashMap = new HashMap<String, Object>();
		hashMap.put("id", id);
		MapVo mapVo = new MapVo();
		mapVo.setMap(hashMap);
		RequestContent content = new RequestContent();
		content.setBody(mapVo.getMap());
		
		try{
			ResponseContent responseContent = HttpUtil.getInputStreamByPost("/groupbuy/p_deleteMajorGrade.htm",content, "utf-8");
			
			if(null != responseContent.getBody()){
				JSONObject json = (JSONObject) responseContent.getBody();
				if(StringUtils.isNotBlank(json.get("result")+"")){
					if(json.get("result").equals(true)){
						return ResponseJson.body(true, "success");
					}else {
						return ResponseJson.body(false, "error");
					}
				}
			}
		}catch (Exception e) {
			logger.info("删除失败",e);
		}
		return ResponseJson.body(false,"删除失败");
	}
}
