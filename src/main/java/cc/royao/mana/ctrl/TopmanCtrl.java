package cc.royao.mana.ctrl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

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

/**
 * 
 * ClassName: TopmanCtrl 
 * @Description: 荣耀达人管理
 * @author Liu Pinghui
 * @date 2016年1月21日
 */
@Controller
@RequestMapping("/topman")
public class TopmanCtrl {

	Logger logger = Logger.getLogger(this.getClass());
	
	/**
	 * 
	 * @Description: 荣耀达人审核列表
	 * @param @param mapVo
	 * @param @param map
	 * @param @return   
	 * @return String  
	 * @throws
	 * @author Liu Pinghui
	 * @date 2016年1月22日
	 */
	@RequestMapping("/list.htm")
	public String list(HttpServletRequest request, ModelMap model){
		try{
			if(request.getParameter("status") != null){
				String status = request.getParameter("status");
				model.addAttribute("indexStatus", status);
				return "topman/list";
			}
		}catch(Exception e){
			logger.info("荣耀达人审核列表",e);
		}
		model.addAttribute("indexStatus", "false");
		return "topman/list";
	}
	/**
	 * 
	 * @Description: 请求荣耀达人列表数据
	 * @param @param mapVo
	 * @param @param map
	 * @param @return   
	 * @return String  
	 * @throws
	 * @author Liu Pinghui
	 * @date 2016年1月22日
	 */
	@ResponseBody
	@RequestMapping("/list.ajax")
	public String listajax(HttpServletRequest request){
		
		RequestContent content = new RequestContent();
		MapVo mapVo = new MapVo();
		mapVo.setMap(JSON.parseObject(request.getParameter("map")));
		content.setBody(mapVo.getMap());
		
		try {
			ResponseContent responseContent = HttpUtil.getInputStreamByPost("/topman/list.htm",content, "utf-8");
			
			if(null != responseContent.getBody()){
				Map<String,Object> json = (Map<String,Object>) responseContent.getBody();
				return JSONObject.toJSONString(json);
			}else{
				return "没有数据";
			}
		} catch (Exception e) {
			logger.info("Json转错误/n",e);
		}
		
		return "网络忙，稍后再试";
	}
	
	/**
	 * 
	 * @Description: 请求荣耀达人申请详情
	 * @param @param map
	 * @param @param id
	 * @param @return   
	 * @return String  
	 * @throws
	 * @author Liu Pinghui
	 * @date 2016年1月22日
	 */
	@RequestMapping("/detail/{id}.htm")
	public String detail(ModelMap map, @PathVariable Long id){
		
		RequestContent content = new RequestContent();
		HashMap<String, Object> hmap = new HashMap<String, Object>();
		hmap.put("id", id);
		content.setBody(hmap);
		
		try {
			ResponseContent responseContent = HttpUtil.getInputStreamByPost("/topman/detail.htm",content, "utf-8");
			
			if(null != responseContent.getBody()){
				JSONObject json = (JSONObject) responseContent.getBody();
				if(json != null){
					map.put("topman", json);
				}else{
					map.put("topman", null);
				}
				
			}
		} catch (Exception e) {
			logger.info("Json转错误/n",e);
		}
		
		return "topman/detail";
	}
	/**
	 * 
	 * @Description: 跳转审核界面
	 * @param @param map
	 * @param @param id
	 * @param @return   
	 * @return String  
	 * @throws
	 * @author Liu Pinghui
	 * @date 2016年1月22日
	 */
	@RequestMapping("/examine/{id}.htm")
	public String examine(ModelMap map, @PathVariable Long id){
		
		map.put("id", id);
		
		return "topman/examine";
	}
	/**
	 * 
	 * @Description: 管理员审核
	 * @param @param mapVo
	 * @param @return   
	 * @return ResponseJson  
	 * @throws
	 * @author Liu Pinghui
	 * @date 2016年1月22日
	 */
	@ResponseBody
	@RequestMapping("/examine.ajax")
	public ResponseJson examine(MapVo map){
		
		RequestContent content = new RequestContent();
		content.setBody(map.getMap());
		
		try {
			ResponseContent responseContent = HttpUtil.getInputStreamByPost("/topman/examine.htm",content, "utf-8");
			
			if(null != responseContent.getBody()){
				JSONObject json = (JSONObject) responseContent.getBody();
				if(json != null && json.get("result").equals(true)){
					return ResponseJson.body(true, "操作成功！");
				}else{
					return ResponseJson.body(false, "操作失败！");
				}
				
			}
		} catch (Exception e) {
			logger.info("Json转错误/n",e);
		}
		
		return ResponseJson.body(false,"操作失败！");
	}
}
