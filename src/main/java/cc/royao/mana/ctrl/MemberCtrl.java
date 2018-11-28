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
import cc.royao.mana.auth.model.Manager;

import cc.royao.common.Constants;

/**
 * 
 * ClassName: MemberCtrl 
 * @Description: 用户管理
 * @author Liu Pinghui
 * @date 2016年1月20日
 */
@Controller
@RequestMapping("/member")
public class MemberCtrl {

	Logger logger = Logger.getLogger(this.getClass());
	
	/**
	 * 
	 * @Description: 用户列表
	 * @param @param map
	 * @param @param mapVo
	 * @param @param pageNo
	 * @param @return   
	 * @return String  
	 * @throws
	 * @author Liu Pinghui
	 * @date 2016年1月20日
	 */
	@RequestMapping("/list.htm")
	public String list(ModelMap map, MapVo mapVo, Integer pageNo){
		
		return "member/list";
	}
	
	/**
	 * 
	 * @Description: 用户列表
	 * @param @param map
	 * @param @param mapVo
	 * @param @param pageNo
	 * @param @return   
	 * @return String  
	 * @throws
	 * @author Liu Pinghui
	 * @date 2016年1月20日
	 */
	@ResponseBody
	@RequestMapping("/list.ajax")
	public String listajax(HttpServletRequest request){
		
		RequestContent content = new RequestContent();
		MapVo mapVo = new MapVo();
		mapVo.setMap(JSON.parseObject(request.getParameter("map")));
		content.setBody(mapVo.getMap());
		
		try {
			ResponseContent responseContent = HttpUtil.getInputStreamByPost("/member/p_list.htm",content, "utf-8");
			
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
	 * @Description: 请求用户详细信息
	 * @param @param map
	 * @param @param id
	 * @param @return   
	 * @return String  
	 * @throws
	 * @author Liu Pinghui
	 * @date 2016年1月20日
	 */
	@RequestMapping("/detail/{id}.htm")
	public String detail(ModelMap map, @PathVariable Long id){
		
		RequestContent content = new RequestContent();
		HashMap<String, Object> hmap = new HashMap<String, Object>();
		hmap.put("memberId", id);
		content.setBody(hmap);
		
		try {
			ResponseContent responseContent = HttpUtil.getInputStreamByPost("/member/p_detail.htm",content, "utf-8");
			
			if(null != responseContent.getBody()){
				JSONObject json = (JSONObject) responseContent.getBody();
				if(json != null){
					map.put("member", json);
				}else{
					map.put("member", null);
				}
				
			}
			
			//获取用户的备注信息
			responseContent = HttpUtil.getInputStreamByPost("/memberremark/list.htm",content, "utf-8");
			
			if(null != responseContent.getBody()){
				List<JSONObject> list = (List<JSONObject>) responseContent.getBody();
				if(list != null){
					map.put("remarkList", list);
				}else{
					map.put("remarkList", null);
				}
				
			}
			
			
		} catch (Exception e) {
			logger.info("获取用户详情错误/n",e);
		}
		
		return "member/detail";
	}
	
	/**
	 * 
	 * @Description: 更新荣耀达人状态
	 * @param @param id
	 * @param @param topManState
	 * @param @return   
	 * @return ResponseJson  
	 * @throws
	 * @author Liu Pinghui
	 * @date 2016年1月21日
	 */
	@ResponseBody
	@RequestMapping("/updateTopManState.ajax")
	public ResponseJson updateTopManState(Long id,String topManState){
		
		RequestContent content = new RequestContent();
		HashMap<String, Object> hmap = new HashMap<String, Object>();
		hmap.put("id", id);
		hmap.put("topManState", topManState);
		content.setBody(hmap);
		
		try {
			ResponseContent responseContent = HttpUtil.getInputStreamByPost("/member/p_updateTopManState.htm",content, "utf-8");
			
			if(null != responseContent.getBody()){
				JSONObject json = (JSONObject) responseContent.getBody();
				if(json != null){
					if(json.get("result").equals(true)){
						return ResponseJson.body(true, "操作成功！");
					}
				}
				
			}
		} catch (Exception e) {
			logger.info("修改荣耀达人状态错误/n",e);
		}
		return ResponseJson.body(false, "操作失败！");
	}
	
	@RequestMapping("/remark/{memberId}.htm")
	public String remark(ModelMap map,@PathVariable Long memberId){
		
		map.put("memberId", memberId);
		
		return "member/remark";
	}
	
	/**
	 * 
	 * @Description: 给用户添加备注
	 * @param @param id
	 * @param @param topManState
	 * @param @return   
	 * @return ResponseJson  
	 * @throws
	 * @author Liu Pinghui
	 * @date 2016年1月21日
	 */
	@ResponseBody
	@RequestMapping("/remark.ajax")
	public ResponseJson remark(HttpServletRequest request, Long memberId,String remark){
		
		Object obj = request.getSession().getAttribute(Constants.SESSION_USERINFO);
		
		Manager manager = null;
		if(obj != null){
			manager = (Manager) obj;
		}else{
			return ResponseJson.body(false, "login");
		}
		
		RequestContent content = new RequestContent();
		HashMap<String, Object> hmap = new HashMap<String, Object>();
		hmap.put("managerId", manager.getMamangerId());
		hmap.put("manager", manager.getManagerName());
		hmap.put("memberId", memberId);
		hmap.put("content", remark);
		content.setBody(hmap);
		
		try {
			ResponseContent responseContent = HttpUtil.getInputStreamByPost("/memberremark/remark.htm",content, "utf-8");
			
			if(null != responseContent.getBody()){
				JSONObject json = (JSONObject) responseContent.getBody();
				if(json != null){
					if(json.get("result").equals(true)){
						return ResponseJson.body(true, "操作成功！");
					}
				}
				
			}
		} catch (Exception e) {
			logger.info("修改荣耀达人状态错误/n",e);
		}
		return ResponseJson.body(false, "操作失败！");
	}
	
	/**
	 * 
	 * @Description: 删除备注
	 * @param @param request
	 * @param @param memberId
	 * @param @param remark
	 * @param @return   
	 * @return ResponseJson  
	 * @throws
	 * @author Liu Pinghui
	 * @date 2016年1月21日
	 */
	@ResponseBody
	@RequestMapping("/delremark.ajax")
	public ResponseJson delremark(HttpServletRequest request, Long id){
		
		RequestContent content = new RequestContent();
		HashMap<String, Object> hmap = new HashMap<String, Object>();
		hmap.put("id", id);
		content.setBody(hmap);
		
		try {
			ResponseContent responseContent = HttpUtil.getInputStreamByPost("/memberremark/delete.htm",content, "utf-8");
			
			if(null != responseContent.getBody()){
				JSONObject json = (JSONObject) responseContent.getBody();
				if(json != null){
					if(json.get("result").equals(true)){
						return ResponseJson.body(true, "操作成功！");
					}
				}
				
			}
		} catch (Exception e) {
			logger.info("删除备注错误/n",e);
		}
		return ResponseJson.body(false, "操作失败！");
	}
	
	
}
