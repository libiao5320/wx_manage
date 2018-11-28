package cc.royao.mana.ctrl;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
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
import cc.royao.mana.auth.model.Manager;

import cc.royao.common.Constants;
/**
 * @author wangya
 *
 */

@Controller
@RequestMapping("/dorder")
public class DorderCtrl {

	//未付余额管理页面
	@RequestMapping("/dorder.htm")
	public String index(){
		System.out.println("------------------------");
		return "order/dorder";
	}
	
	
	/**
	 * 未付余额管理
	 * @param limit	每页数据
	 * @param offset 页码
	 *@param  typeName 	产品名称
	 * @param typeValue	退款状态
	 * @return
	 */
	
	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping("/list1.ajax")
	public ResponseEntity<Map<String,Object>> getlist1(int limit,int offset,
			String typeName,String typeValue,
			String orderState){
		//用方法参数接收参数
		System.out.println("取页码："+limit+"=========="+offset);
		RequestContent content = new RequestContent();
		Map<String, Object> hmap = new HashMap<String, Object>();
		if(offset == 0){
			offset = 1;
		}
		hmap.put("page",offset);
		hmap.put("size", limit);
		hmap.put(typeName, typeValue);
		hmap.put("orderState", orderState);
		//hmap.put("typeValue", typeValue);
		content.setBody(hmap);
		
		try {
			ResponseContent res = HttpUtil.getInputStreamByPost("/order/p_plist.htm",content, "utf-8");
			if(null != res.getBody()){
				System.out.println("Center根据条件放回的参数："+res.getBody());
				
				Map<String,Object> map = (Map<String, Object>) res.getBody();
				
				return new ResponseEntity<Map<String,Object>>(map,HttpStatus.OK);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	

	/**
	 * 退款申请管理
	 */
	@RequestMapping("/dorder1.htm")
	public String index1(HttpServletRequest request, ModelMap model){
		if(request.getParameter("status") != null){
			String status = request.getParameter("status");
			model.addAttribute("indexStatus", status);
			return "order/dorderDetail";
		}
		model.addAttribute("indexStatus", "false");
		return "order/dorderDetail";
	}

	
	/**
	 * ajax获取退款申请列表
	 */
	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping("/list.ajax")
	public String getlist(HttpServletRequest request,HttpServletResponse response){
		Logger logger = Logger.getLogger(this.getClass());
		RequestContent requestContent = new RequestContent();
		requestContent.setBody(JSON.parseObject(request.getParameter("map")));
		ResponseContent responseContent = null;
		
		try {
			responseContent = HttpUtil.getInputStreamByPost("/order/p_plist1.htm",requestContent, "utf-8");
			if(responseContent.getBody() != null){
				Map<String,Object> json = (Map<String,Object>) responseContent.getBody();
				return JSONObject.toJSONString(json);
			}else{
				return "没有数据";
			}
		} catch (Exception e) {
			logger.info("请求退款列表失败", e);
			return "网络忙，请稍后再试";
		}
	}


		/**
		* 退款申请管理详情页面
		* 
		*/

	
		@SuppressWarnings("unchecked")
		//处理退款请求跳转页面
		@RequestMapping("/pc_detail/{orderId}.htm")
		public String pc_detail(ModelMap modelMap,
				@PathVariable Long orderId,
				HttpServletResponse response, HttpServletRequest request){
			//通过对象接受参数
			RequestContent requestContent = new RequestContent();
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("orderId", orderId);
			requestContent.setBody(map);
			ResponseContent responseContent = null;
			
			try {
				responseContent = HttpUtil.getInputStreamByPost("/order/detail.htm", requestContent, "utf-8");
				
				if(responseContent.getBody() != null){
					Map<String,Object> resultMap = (Map<String,Object>) responseContent.getBody();
					/*modelMap.put("order", resultMap.get("order"));
					modelMap.put("refund", resultMap.get("refund"));
					modelMap.put("storePhone", resultMap.get("storePhone"));*/
					modelMap.addAttribute("jsonData", resultMap);
				}
			} catch (Exception e) {
				System.out.println("网络忙，请稍后再试");
			}
			return "order/detail";
		}
		
		/**
		 * 保存处理退款请求
		 * @param modelMap
		 * @param response
		 * @param request
		 * @return
		 */
		@ResponseBody
		@RequestMapping("/updateState.ajax")
		public String updateState(HttpServletResponse response, HttpServletRequest request){
			RequestContent requestContent = new RequestContent();
			Map map = new HashMap();
			map.put("map", JSON.parseObject(request.getParameter("map")));
			Manager manager = (Manager) request.getSession().getAttribute(Constants.SESSION_USERINFO);
			map.put("managerName", manager.getManagerName());
			
			requestContent.setBody(map);
			ResponseContent responseContent = null;
			
			try {
				responseContent = HttpUtil.getInputStreamByPost("/order/p_update.htm", requestContent, "utf-8");
				
				if(responseContent.getBody() != null){
					Map<String,Object> json = (Map<String,Object>) responseContent.getBody();
					return JSONObject.toJSONString(json);
				}else{
					return "没有数据";
				}
			} catch (Exception e) {
				return "网络忙，请稍后再试";
			}
		}
		
		@ResponseBody
		@RequestMapping("/updateRemark.ajax")
		public String updateRemark(HttpServletResponse response, HttpServletRequest request){
			RequestContent requestContent = new RequestContent();
			requestContent.setBody(JSON.parseObject(request.getParameter("map")));
			ResponseContent responseContent = null;
			
			try {
				responseContent = HttpUtil.getInputStreamByPost("/order/p_updateRemark.htm", requestContent, "utf-8");
				
				if(responseContent.getBody() != null){
					Map<String,Object> json = (Map<String,Object>) responseContent.getBody();
					return JSONObject.toJSONString(json);
				}else{
					return "没有数据";
				}
			} catch (Exception e) {
				return "网络忙，请稍后再试";
			}
		}

}
