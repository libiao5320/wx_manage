package cc.royao.mana.ctrl;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import cc.royao.commons.ResponseJson;
import cc.royao.commons.httpClient.HttpUtil;
import cc.royao.commons.httpClient.RequestContent;
import cc.royao.commons.httpClient.ResponseContent;


@Controller
@RequestMapping("/order")
public class OrderCtrl {
	
		
		@RequestMapping("/index.htm")
		public String index(){
			return "order/orderManager";
		}
		
		
		/**
		 * @param limit	每页数据
		 * @param offset 页码
		 * @param typeName 类型
		 * @param typeValue 值
		 * @param timeName 时间类型
		 * @param endTime 结束时间
		 * @param orderState 订单状态
		 * @param orderBy 排序类型
		 * @param startTime 开始时间
		 * @return
		 */
		@SuppressWarnings("unchecked")
		@ResponseBody
		@RequestMapping("/list.ajax")
		public ResponseEntity<Map<String,Object>> getlist(int limit,int offset,
				String typeName,String typeValue,String timeName,String endTime,
				String orderState,String orderBy,String startTime){
			System.out.println("取页码："+limit+"=========="+offset);
			RequestContent content = new RequestContent();
			Map<String, Object> hmap = new HashMap<String, Object>();
			if(offset == 0){
				offset = 1;
			}
			hmap.put("page",offset);
			hmap.put("size", limit);
			hmap.put("typeName", typeName);
			hmap.put("typeValue",typeValue );
			hmap.put("timeName", timeName);
			hmap.put("endTime", endTime);
			hmap.put("orderState", orderState);
			hmap.put("orderBy", orderBy);
			hmap.put("startTime", startTime);
			content.setBody(hmap);
			
			try {
				ResponseContent res = HttpUtil.getInputStreamByPost("/order/p_list.htm",content, "utf-8");
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
		
		
		
		
		@RequestMapping("/pc_detail/{id}.htm")
		public String details(@PathVariable String id,ModelMap model){
			RequestContent content = new RequestContent();
			Map<String, Object> hmap = new HashMap<String, Object>();
			hmap.put("id", id);
			content.setBody(hmap);
			try {
				ResponseContent res = HttpUtil.getInputStreamByPost("/order/p_detail.htm",content, "utf-8");
				if(null != res.getBody()){
					System.out.println("Center端返回数据："+res.getBody());
					model.addAttribute("res", res.getBody());
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			return "order/orderDetail";
		}
		
		
		@RequestMapping("/eva_index.htm")
		public String eva_index(){
			return "order/evaluate";
		}
		
		
		/**
		 * 订单评价列表
		 * @param limit
		 * @param offset
		 * @param typeName
		 * @param typeValue
		 * @param orderState
		 * @param startTime
		 * @param endTime
		 * @return
		 */
		@SuppressWarnings("unchecked")
		@ResponseBody
		@RequestMapping("/evaluate.ajax")
		public ResponseEntity<Map<String,Object>> evaluate(int limit,int offset,String typeName,String typeValue,String orderState,String startTime,String endTime,String orderBy){
			System.out.println(limit  +"---------------" + offset);
			RequestContent content = new RequestContent();
			Map<String, Object> hmap = new HashMap<String, Object>();
			if(offset == 0){
				offset = 1;
			}
			hmap.put("page",offset);
			hmap.put("size", limit);
			hmap.put("typeName", typeName);
			hmap.put("typeValue", typeValue);
			hmap.put("orderState", orderState);
			hmap.put("startTime", startTime);
			hmap.put("endTime", endTime);
			hmap.put("orderBy", orderBy);
			content.setBody(hmap);
			try {
				ResponseContent res = HttpUtil.getInputStreamByPost("/order/p_evaluate.htm",content, "utf-8");
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
		 * 订单评价拒绝操作
		 * @param id
		 * @return
		 */
		@ResponseBody
		@RequestMapping("/update_show/{id}/{show}.ajax")
		public Object update_show(@PathVariable String id,@PathVariable String show){
			RequestContent content = new RequestContent();
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("id", id);
			map.put("show", show);
			content.setBody(map);
			try {
				ResponseContent res = HttpUtil.getInputStreamByPost("/order/p_updateShow.htm",content, "utf-8");
				if(null != res.getBody()){
					Map<?,?> rs = (Map<?, ?>) res.getBody();
					if("SUCCESS".equals(rs.get("returnMsg").toString())){
						return ResponseJson.body(true,"操作成功！");
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			return ResponseJson.body(false,"操作失败！");
		}
		
		
		
		@RequestMapping("/savings_index.htm")
		public String savingsindex(){
			return "order/savings";
		}
		
		
		@SuppressWarnings("unchecked")
		@ResponseBody
		@RequestMapping("/savings.ajax")
		public ResponseEntity<Map<String,Object>> savings(int limit,int offset,String typeName,String typeValue,String orderBy){
			System.out.println(limit  +"---------------" + offset);
			RequestContent content = new RequestContent();
			Map<String, Object> hmap = new HashMap<String, Object>();
			if(offset == 0){
				offset = 1;
			}
			hmap.put("page",offset);
			hmap.put("size", limit);
			hmap.put("typeName", typeName);
			hmap.put("typeValue", typeValue);
			hmap.put("orderBy", orderBy);
			content.setBody(hmap);
			
			try {
				ResponseContent res = HttpUtil.getInputStreamByPost("/order/p_savings.htm",content, "utf-8");
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
		
		
		
		
		
		
		/***/
		@SuppressWarnings("unchecked")
		@RequestMapping("/savings/detail/{id}.htm")
		public String detail(@PathVariable String id,ModelMap model){
			
			RequestContent content = new RequestContent();
			Map<String, Object> hmap = new HashMap<String, Object>();
			hmap.put("id", id);
			content.setBody(hmap);
			try {
				ResponseContent res = HttpUtil.getInputStreamByPost("/order/p_user.htm",content, "utf-8");
				if(null != res.getBody()){
					System.out.println("Center根据条件放回的参数："+res.getBody());
					
					Map<String,Object> map = (Map<String, Object>) res.getBody();
					String msg = map.get("returnMsg").toString();
					if("SUCCESS".equals(msg)){
						Map<String,Object> user = (Map<String, Object>) map.get("user");
						model.addAttribute("name", user.get("memberName"));
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			model.addAttribute("id", id);
			
			return "order/savings_detail";
		}
		
		
		/**
		 * 
		 * @param limit
		 * @param offset
		 * @param id
		 * @param orderBy
		 * @return
		 */
		@SuppressWarnings("unchecked")
		@ResponseBody
		@RequestMapping("/savings/detail.ajax")
		public ResponseEntity<Map<String,Object>> savingsdetail(int limit,int offset,String id,String orderBy){
			System.out.println(limit  +"---------------" + offset);
			RequestContent content = new RequestContent();
			Map<String, Object> hmap = new HashMap<String, Object>();
			if(offset == 0){
				offset = 1;
			}
			hmap.put("page",offset);
			hmap.put("size", limit);
			hmap.put("id", id);
			hmap.put("orderBy", orderBy);
			content.setBody(hmap);
			
			try {
				ResponseContent res = HttpUtil.getInputStreamByPost("/order/p_savings/detail.htm",content, "utf-8");
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
		
		
		@ResponseBody
		@RequestMapping("/update_order.ajax")
		public Object updateOrder(String id,String remark){
			RequestContent content = new RequestContent();
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("id",id);
			map.put("remark",remark);
			content.setBody(map);
			
			try {
				ResponseContent res = HttpUtil.getInputStreamByPost("/order/p_update_order.htm",content, "utf-8");
				if(null != res.getBody()){
					System.out.println("Center返回数据："+res.getBody());
					JSONObject   JSON = (JSONObject) res.getBody();
					String msg = JSON.getString("returnMsg");
					if("SUCCESS".equals(msg)){
						return ResponseJson.body(true, "操作成功");
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			return ResponseJson.body(false, "操作失败");
		}
}
