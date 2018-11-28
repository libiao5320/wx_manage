package cc.royao.mana.ctrl;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.alibaba.fastjson.JSONObject;

import cc.royao.commons.ResponseJson;
import cc.royao.commons.httpClient.HttpUtil;
import cc.royao.commons.httpClient.RequestContent;
import cc.royao.commons.httpClient.ResponseContent;
import cc.royao.utils.AdminConfig;
import cc.royao.utils.MapUtil;


@Controller
@RequestMapping("/store")
public class StoreCtrl {
		
		Logger logger = Logger.getLogger(this.getClass());
			
		@RequestMapping("/index.htm")
		public String index(){
			return "store/index";
		}
		
		
		@RequestMapping("/auditIndex.htm")
		public String atudIndex(HttpServletRequest request, ModelMap model){
			if(request.getParameter("state") != null){
				Integer state = Integer.valueOf(request.getParameter("state"));
				model.addAttribute("indexState", state);
				return "/store/auditIndex";
			}
			model.addAttribute("indexState", "false");
			return "/store/auditIndex";
		}
		
		@SuppressWarnings("unchecked")
		@RequestMapping("/edit.htm")
		public String edit(Long storeId,ModelMap model){
			RequestContent content = new RequestContent();
			Map<String, Object> hmap = new HashMap<String, Object>();
			hmap.put("storeId", storeId);
			content.setBody(hmap);
			
			try {
				ResponseContent res = HttpUtil.getInputStreamByPost("/store/p_add.htm",content, "utf-8");
				if(null != res.getBody()){
					logger.info("Center端返回的数据："+res.getBody());
					Map<String,Object> map = (Map<String, Object>) res.getBody();
					model.addAttribute("Map", map);
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
			if(null != storeId){
				return "store/edit";
			}
			return "store/add";
		}

		@SuppressWarnings("unchecked")
		@ResponseBody
		@RequestMapping("/index.ajax")
		public ResponseEntity<Map<String,Object>> aJaxIndex(int limit,int offset,String typeName,String typeValue,String orderBy){
			RequestContent content = new RequestContent();
			Map<String, Object> hmap = new HashMap<String, Object>();
			if(offset == 0){
				offset = 1;
			}
			hmap.put("page",offset);
			hmap.put("size", limit);
			hmap.put("typeName", typeName);
			hmap.put("typeValue",typeValue );
			hmap.put("orderBy", orderBy);
			content.setBody(hmap);
			
			try {
				ResponseContent res = HttpUtil.getInputStreamByPost("/store/p_index.htm",content, "utf-8");
				if(null != res.getBody()){
					Map<String,Object> map = (Map<String, Object>) res.getBody();
					
					return new ResponseEntity<Map<String,Object>>(map,HttpStatus.OK);
				}
			}catch(Exception e){
				e.printStackTrace();
			}
			return null;
		}
		
		
		
		@SuppressWarnings({ "rawtypes", "unchecked" })
		@ResponseBody
		@RequestMapping("/save.ajax")
		public Object save(HttpServletRequest request){
			RequestContent content = new RequestContent();
			Map properties = request.getParameterMap();
			
			Map<String,Object> map = MapUtil.MapFormat(properties);
			content.setBody(map);
			
			try {
				ResponseContent res = HttpUtil.getInputStreamByPost("/store/p_save.htm",content, "utf-8");
				if(null != res.getBody()){
					Map<String,Object> maps = (Map<String, Object>) res.getBody();
					String msg = maps.get("msg").toString();
					if("SUCCESS".equals(msg)){
						return ResponseJson.body(true, "商家信息添加成功！");
					}
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
			return ResponseJson.body(false, "商家信息添加失败！");
		}
		
		
		
		@ResponseBody
		@RequestMapping("/delete/{id}.ajax")
		public Object delete(@PathVariable Long id, HttpServletRequest request){
			RequestContent content = new RequestContent();
			Map<String,Object> map = new HashMap<String, Object>();
			String type = request.getParameter("type");
			String label = "删除";
			if("normal".equals(type)){
				label = "恢复";
			}
			map.put("id", id);
			map.put("status", type);
			content.setBody(map);

			try {
				ResponseContent res = HttpUtil.getInputStreamByPost("/store/p_updateStatus.htm",content, "utf-8");
				if(null != res.getBody()){
					@SuppressWarnings("unchecked")
					Map<String,Object> maps = (Map<String, Object>) res.getBody();
					String msg = maps.get("msg").toString();
					if("SUCCESS".equals(msg)){
						return ResponseJson.body(true, "商家信息" + label + "成功！");
					}
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
			return ResponseJson.body(false, "商家信息" + label + "失败！");
		}
		
		@ResponseBody
		@RequestMapping("/normal/{id}.ajax")
		public Object normal(@PathVariable Long id){
			RequestContent content = new RequestContent();
			Map<String,Object> map = new HashMap<String, Object>();
			map.put("id", id);
			map.put("status", "normal");
			content.setBody(map);
			
			try {
				ResponseContent res = HttpUtil.getInputStreamByPost("/store/p_updateStatus.htm",content, "utf-8");
				if(null != res.getBody()){
					@SuppressWarnings("unchecked")
					Map<String,Object> maps = (Map<String, Object>) res.getBody();
					String msg = maps.get("msg").toString();
					if("SUCCESS".equals(msg)){
						return ResponseJson.body(true, "商家信息恢复成功！");
					}
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
			return ResponseJson.body(false, "商家信息恢复失败！");
		}
		
		
		@SuppressWarnings("unchecked")
		@ResponseBody
		@RequestMapping("/auditIndex.ajax")
		public ResponseEntity<Map<String,Object>> auditIndex(int limit,int offset,String state){
			RequestContent content = new RequestContent();
			Map<String, Object> hmap = new HashMap<String, Object>();
			if(offset == 0){
				offset = 1;
			}
			hmap.put("page",offset);
			hmap.put("size", limit);
			hmap.put("state", state);
			content.setBody(hmap);
			
			try {
				ResponseContent res = HttpUtil.getInputStreamByPost("/store/p_queryAll.htm",content, "utf-8");
				if(null != res.getBody()){
					System.out.println("Center端返回的数据为："+res.getBody());
					
					Map<String,Object> map = (Map<String, Object>) res.getBody();
					
					return new ResponseEntity<Map<String,Object>>(map,HttpStatus.OK);
				}
			}catch(Exception e){
				e.printStackTrace();
			}
			return null;
		}
		
		
		
		/**
		 * 
		 * @param id
		 * @return
		 */
		@ResponseBody
		@RequestMapping("/audit.ajax")
		public Object audit(Long id,String state){
			RequestContent content = new RequestContent();
			Map<String,Object> map = new HashMap<String, Object>();
			map.put("id", id);
			map.put("state",state);
			content.setBody(map);

			try {
				ResponseContent res = HttpUtil.getInputStreamByPost("/store/p_audit.htm",content, "utf-8");
				if(null != res.getBody()){
					@SuppressWarnings("unchecked")
					Map<String,Object> maps = (Map<String, Object>) res.getBody();
					String msg = maps.get("msg").toString();
					if("SUCCESS".equals(msg)){
						return ResponseJson.body(true, "操作成功！");
					}
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
			return ResponseJson.body(false, "操作失败！");
		}
		
		
		
		
		
		
		
		/**
		 * 上传图片
		 * @param request
		 * @param response
		 * @return
		 */
		@ResponseBody
		@RequestMapping("/uploadImg.ajax")
		public Object uploadGoodImg (HttpServletRequest request , HttpServletResponse response)
		{
			Map<String, Object> map = new HashMap<String, Object>();
			MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
			String fileName = "";
			String uploadPath = AdminConfig.storeUploadPath;
			String path =request.getSession().getServletContext().getRealPath("/")+uploadPath;
			File uploadPathFile = new File(path);
			if (!uploadPathFile.exists()) {
			   uploadPathFile.mkdir();
			}
			List<MultipartFile> files = multipartRequest.getFiles("uploadFile");
			for(int i=0;i<files.size();i++){
				MultipartFile mulfile = files.get(i);
				fileName = mulfile.getOriginalFilename();
				fileName = MapUtil.handlerFileName(fileName);
				File file = new File(path + fileName);
				try {
					mulfile.transferTo(file);
				} catch (IOException e) {
					e.printStackTrace();
				}
				map.put("imagePath", fileName);
				map.put("url",uploadPath+fileName);
			}
			return ResponseJson.body(true, "",map);
		}
		
		
		@RequestMapping("/map.htm")
		public String map(){
			return "store/map";
		}
		
		
		@ResponseBody
		@RequestMapping("/validateRegistor.ajax")
		public String validateRegistor(String phone){
			RequestContent content = new RequestContent();
			Map<String, Object> hmap = new HashMap<String, Object>();
			hmap.put("phone", phone);
			content.setBody(hmap);
			Map<String,Object> json = new HashMap<String, Object>();
			try {
				ResponseContent res = HttpUtil.getInputStreamByPost("/store/p_validateRegistor.htm",content, "utf-8");
				if(null != res.getBody()){
					System.out.println("Center端返回的数据为："+res.getBody());
					
					Map<String,Object> map = (Map<String, Object>) res.getBody();
					if("1".equals(map.get("state")+"")){
						json.put("state", 1);
					}else{
						json.put("state", -1);
					}
				}
			}catch(Exception e){
				e.printStackTrace();
			}
			return JSONObject.toJSONString(json);
		}
}
