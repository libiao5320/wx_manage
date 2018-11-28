package cc.royao.mana.ctrl;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
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

import cc.royao.utils.AdminConfig;
import cc.royao.utils.Config;
import cc.royao.utils.MapUtil;

import com.alibaba.fastjson.JSON;

import cc.royao.commons.ResponseJson;
import cc.royao.commons.formbean.MapVo;
import cc.royao.commons.httpClient.HttpUtil;
import cc.royao.commons.httpClient.RequestContent;
import cc.royao.commons.httpClient.ResponseContent;


@Controller
@RequestMapping("/techie")
public class DtechieCtrl {
		
		Logger logger = Logger.getLogger(this.getClass());
	
	
		@RequestMapping("/index.htm")
		public String index(){
			return "techie/index";
		}
		
		
		
		@RequestMapping("/list.htm")
		public String list(ModelMap modelMap){
			String urlPath = "/groupbuy/p_queryMajor.htm";
			RequestContent content = new RequestContent();
			content.setBody(new HashMap<String, Object>());
			try {
				ResponseContent responseContent = HttpUtil.getInputStreamByPost(urlPath,content, "utf-8");

				if(null != responseContent.getBody()){
					Map<String,Object> json = (Map<String,Object>) responseContent.getBody();
					modelMap.put("result",json);
				}else{
					modelMap.put("result",null);
				}
			} catch (Exception e) {
				return "网络忙，请稍后再试";
			}
			return "techie/list";
		}
		
		@RequestMapping("/examine.htm")
		public String examine(){
			return "techie/examine";
		}
		
		@RequestMapping("/bank.htm")
		public String bank(){
			return "techie/bank";
		}
		
		@RequestMapping("/editTechie/{techieId}.htm")
		public String edit(ModelMap modelMap,@PathVariable Long techieId){
			String urlPath = "/techie/p_getAddParams.htm";
			RequestContent content = new RequestContent();
			Map map = new HashMap<String, Object>();
			map.put("techieId", techieId);
			content.setBody(map);
			try {
				ResponseContent responseContent = HttpUtil.getInputStreamByPost(urlPath,content, "utf-8");

				if(null != responseContent.getBody()){
					Map<String,Object> json = (Map<String,Object>) responseContent.getBody();
					modelMap.put("result",json);
				}else{
					modelMap.put("result",null);
				}
			} catch (Exception e) {
				return "网络忙，请稍后再试";
			}
			modelMap.put("imgUrl", Config.get("techieUrl"));//"http://222.240.156.10:10090/AppAPI/uploads"
			return "techie/edit";
		}
		
		@RequestMapping("/editTechieBank/{id}.htm")
		public String editTechieBank(ModelMap modelMap,@PathVariable Long id){
			String urlPath = "/techie/p_getAddParamsBank.htm";
			RequestContent content = new RequestContent();
			Map map = new HashMap<String, Object>();
			map.put("id", id);
			content.setBody(map);
			try {
				ResponseContent responseContent = HttpUtil.getInputStreamByPost(urlPath,content, "utf-8");

				if(null != responseContent.getBody()){
					Map<String,Object> json = (Map<String,Object>) responseContent.getBody();
					modelMap.put("result",json);
				}else{
					modelMap.put("result",null);
				}
			} catch (Exception e) {
				return "网络忙，请稍后再试";
			}
			modelMap.put("imgUrl", Config.get("techieUrl"));//"http://222.240.156.10:10090/AppAPI/uploads"
			return "techie/editBank";
		}
		
		@RequestMapping("/edit/{id}.htm")
		public String edit(@PathVariable Long id,ModelMap model,HttpServletRequest request){
			RequestContent content = new RequestContent();
			Map<String, Object> hmap = new HashMap<String, Object>();
			hmap.put("id", id);
			content.setBody(hmap);
			try {
				ResponseContent res = HttpUtil.getInputStreamByPost("/techie/p_getById.htm",content, "utf-8");
				if(null != res.getBody()){
					logger.info("Center返回的数据："+res.getBody());
					model.addAttribute("techie", res.getBody());
				}
					
				res = HttpUtil.getInputStreamByPost("/techie/p_getCountWjsAmountById.htm",content, "utf-8");
				if(null != res.getBody()){
					Map<String, Object> map = (Map<String, Object>) res.getBody();
					model.addAttribute("wjsAmount", map.get("result"));
				}

			} catch (IOException e) {
				e.printStackTrace();
			}
			return "techie/rewardIndex";
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
				ResponseContent res = HttpUtil.getInputStreamByPost("/techie/p_index.htm",content, "utf-8");
				logger.info("Center端返回的数据为："+res.getBody());
				
				Map<String,Object> map = (Map<String, Object>) res.getBody();
				
				return new ResponseEntity<Map<String,Object>>(map,HttpStatus.OK);
			} catch (IOException e) {
				e.printStackTrace();
			}
			return null;
		}
		
		
		@ResponseBody
		@RequestMapping("/listWithPageCondition.ajax")
		public String listWithPageCondition(HttpServletRequest request, HttpServletResponse response){
			String urlPaht = "/techie/p_listWithPageCondition.htm";
			
			RequestContent content = new RequestContent();
			content.setBody(JSON.parseObject(request.getParameter("map")));
		
			try {
				ResponseContent responseContent = HttpUtil.getInputStreamByPost(urlPaht,content, "utf-8");
				
				if(null != responseContent.getBody()){
					Map<String,Object> json = (Map<String,Object>) responseContent.getBody();
					return com.alibaba.fastjson.JSONObject.toJSONString(json);
				}else{
					Map<String,Object> json = new HashMap<String, Object>();
					json.put("state", -1);
					json.put("message", "已经没有更多了");
					return com.alibaba.fastjson.JSONObject.toJSONString(json);
				}
			} catch (Exception e) {
				logger.info("请求列表失败", e);
				Map<String,Object> json = new HashMap<String, Object>();
				json.put("state", -1);
				json.put("message", "请求列表失败");
				return com.alibaba.fastjson.JSONObject.toJSONString(json);
			}
		}
		
		@ResponseBody
		@RequestMapping("/bankListWithPageCondition.ajax")
		public String bankListWithPageCondition(HttpServletRequest request, HttpServletResponse response){
			String urlPaht = "/techie/p_bankListWithPageCondition.htm";
			
			RequestContent content = new RequestContent();
			content.setBody(JSON.parseObject(request.getParameter("map")));
		
			try {
				ResponseContent responseContent = HttpUtil.getInputStreamByPost(urlPaht,content, "utf-8");
				
				if(null != responseContent.getBody()){
					Map<String,Object> json = (Map<String,Object>) responseContent.getBody();
					return com.alibaba.fastjson.JSONObject.toJSONString(json);
				}else{
					Map<String,Object> json = new HashMap<String, Object>();
					json.put("state", -1);
					json.put("message", "已经没有更多了");
					return com.alibaba.fastjson.JSONObject.toJSONString(json);
				}
			} catch (Exception e) {
				logger.info("请求列表失败", e);
				Map<String,Object> json = new HashMap<String, Object>();
				json.put("state", -1);
				json.put("message", "请求列表失败");
				return com.alibaba.fastjson.JSONObject.toJSONString(json);
			}
		}
		
		@ResponseBody
		@RequestMapping("/updateTechieBank.htm")
		public String updateTechieBank(HttpServletRequest request,HttpServletRequest response) throws IOException{
			String urlPath = "/techie/p_upateTechieBank.htm";
			RequestContent content = new RequestContent();
			Map<String, Object> map = new HashMap<String, Object>();
			map.putAll(JSON.parseObject(request.getParameter("map")));
			content.setBody(map);
			try{
				ResponseContent responseContent = HttpUtil.getInputStreamByPost(urlPath,content, "utf-8");
				
				if(null != responseContent.getBody()){
					Map<String,Object> json = (Map<String,Object>) responseContent.getBody();
					return com.alibaba.fastjson.JSONObject.toJSONString(json);
				}else{
					Map<String,Object> json = new HashMap<String, Object>();
					json.put("state", -1);
					json.put("message", "更新健康师账户失败");
					return com.alibaba.fastjson.JSONObject.toJSONString(json);
				}
			} catch (Exception e) {
				logger.info("更新活动失败", e);
				Map<String,Object> json = new HashMap<String, Object>();
				json.put("state", -1);
				json.put("message", "更新活动失败");
				return com.alibaba.fastjson.JSONObject.toJSONString(json);
			}
		}
		
		@SuppressWarnings("rawtypes")
		@ResponseBody
		@RequestMapping("/reward.ajax")
		public ResponseEntity<Map<String,Object>> rewardAjax(HttpServletRequest request){
			RequestContent content = new RequestContent();
			Map properties = request.getParameterMap();
			
			Map<String,Object> map = MapUtil.MapFormat(properties);
			content.setBody(map);
			
			try{
				ResponseContent res = HttpUtil.getInputStreamByPost("/techie/p_reward.htm",content, "utf-8");
				if(null != res.getBody()){
					logger.info("Center端返回数据："+res.getBody());
					@SuppressWarnings("unchecked")
					Map<String,Object> maps = (Map<String, Object>) res.getBody();
					
					return new ResponseEntity<Map<String,Object>>(maps,HttpStatus.OK);
				}
			}catch(Exception e){
				e.printStackTrace();
			}
			return null;
		}
		
		/**
		 * 结算
		 * @param id
		 * @return
		 */
		@ResponseBody
		@RequestMapping("/clearing.ajax")
		public Object clearing(Long id,String money,HttpServletRequest request){
			
			if(StringUtils.isEmpty(money)){
				return ResponseJson.body(false, "金额错误！");
			}
			
			RequestContent content = new RequestContent();
			Map<String, Object> hmap = new HashMap<String, Object>();
			hmap.put("id", id);
			hmap.put("money", money);
			Object   json = request.getSession().getAttribute("userinfo");
			JSONObject _json = JSONObject.fromObject(json);
			hmap.put("admin", _json.getString("managerName"));
			content.setBody(hmap);
			
			try {
				ResponseContent res = HttpUtil.getInputStreamByPost("/techie/p_clearing.htm",content, "utf-8");
				if(null != res.getBody()){
					logger.info("Center端返回的数据为："+res.getBody());
					@SuppressWarnings("unchecked")
					Map<String,Object> map = (Map<String, Object>) res.getBody();
					String msg = map.get("msg").toString();
					if("SUCCESS".equals(msg)){
						return ResponseJson.body(true, "操作成功！");
					}else if("MONEY_IS_ZERO".equals(msg)){
						return ResponseJson.body(false, "结算资金为0元，不能进行结算！");
					}
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
			return ResponseJson.body(false, "操作失败！");
		}
		
		
		/***
		 * 进入结算清单页面
		 * @return
		 */
		@RequestMapping("/clearingIndex.htm")
		public String indexClearing(){
			return "techie/clearing";
		}
		
		
		/**
		 * 健康师结算清单列表
		 * @param request
		 * @param response
		 * @return
		 */
		@SuppressWarnings("rawtypes")
		@ResponseBody
		@RequestMapping("/clearingIndex.ajax")
		public ResponseEntity<Map<String,Object>> clearingIndexaJax(HttpServletRequest request){
			RequestContent content = new RequestContent();
			Map properties = request.getParameterMap();
			
			Map<String,Object> map = MapUtil.MapFormat(properties);
			content.setBody(map);
			
			try{
				ResponseContent res = HttpUtil.getInputStreamByPost("/techie/p_clearingIndex.htm",content, "utf-8");
				if(null != res.getBody()){
					logger.info("Center端返回数据："+res.getBody());
					@SuppressWarnings("unchecked")
					Map<String,Object> maps = (Map<String, Object>) res.getBody();
					
					return new ResponseEntity<Map<String,Object>>(maps,HttpStatus.OK);
				}
			}catch(Exception e){
				e.printStackTrace();
			}
			return null;
		}
		
		
		@ResponseBody
		@RequestMapping ("/deleteTechieById.ajax")
	    public String deleteTechieById(HttpServletRequest request, HttpServletResponse response)
	    {
			String urlPaht = "/techie/p_deleteTechieById.htm";
			
			MapVo mapVo = new MapVo();
			long id = Long.parseLong(request.getParameter("id"));
			Map<String,Object> map = new HashMap<String, Object>();
			map.put("techieId", id);
			mapVo.setMap(map);
			
			RequestContent content = new RequestContent();
			content.setBody(mapVo.getMap());
		
			try {
				ResponseContent responseContent = HttpUtil.getInputStreamByPost(urlPaht,content, "utf-8");
				
				if(null != responseContent.getBody()){
					Map<String,Object> json = (Map<String,Object>) responseContent.getBody();
					return com.alibaba.fastjson.JSONObject.toJSONString(json);
				}else{
					Map<String,Object> json = new HashMap<String, Object>();
					json.put("state", -1);
					json.put("message", "删除失败");
					return com.alibaba.fastjson.JSONObject.toJSONString(json);
				}
			} catch (Exception e) {
				logger.info("删除失败", e);
				Map<String,Object> json = new HashMap<String, Object>();
				json.put("state", -1);
				json.put("message", "删除失败");
				return com.alibaba.fastjson.JSONObject.toJSONString(json);
			}
	    }
		
		
		@ResponseBody
		@RequestMapping ("/examineTechieById.ajax")
	    public String examineTechieById(HttpServletRequest request, HttpServletResponse response)
	    {
			String urlPaht = "/techie/p_examineTechieById.htm";
			
			RequestContent content = new RequestContent();
			content.setBody(JSON.parseObject(request.getParameter("map")));
		
			try {
				ResponseContent responseContent = HttpUtil.getInputStreamByPost(urlPaht,content, "utf-8");
				
				if(null != responseContent.getBody()){
					Map<String,Object> json = (Map<String,Object>) responseContent.getBody();
					return com.alibaba.fastjson.JSONObject.toJSONString(json);
				}else{
					Map<String,Object> json = new HashMap<String, Object>();
					json.put("state", -1);
					json.put("message", "更新失败");
					return com.alibaba.fastjson.JSONObject.toJSONString(json);
				}
			} catch (Exception e) {
				logger.info("更新失败", e);
				Map<String,Object> json = new HashMap<String, Object>();
				json.put("state", -1);
				json.put("message", "更新失败");
				return com.alibaba.fastjson.JSONObject.toJSONString(json);
			}
	    }
		
		/**
		 * 添加健康师页面
		 */
		@RequestMapping("/addPage.htm")
		public String addPage(ModelMap modelMap){
			String urlPath = "/techie/p_getAddParams.htm";
			RequestContent content = new RequestContent();
			try {
				ResponseContent responseContent = HttpUtil.getInputStreamByPost(urlPath,content, "utf-8");

				if(null != responseContent.getBody()){
					Map<String,Object> json = (Map<String,Object>) responseContent.getBody();
					modelMap.put("result",json);
				}else{
					modelMap.put("result",null);
				}
			} catch (Exception e) {
				return "网络忙，请稍后再试";
			}
			return "techie/add";
		}
		
		/**
		 * 添加健康师
		 */
		@ResponseBody
		@RequestMapping ("/add.ajax")
	    public String add(HttpServletRequest request, HttpServletResponse response)
	    {
			String urlPaht = "/techie/p_add.htm";
			
			RequestContent content = new RequestContent();
			Map properties = request.getParameterMap();
			Map<String,Object> map = MapUtil.MapFormat(properties);
			content.setBody(map);
		
			try {
				ResponseContent responseContent = HttpUtil.getInputStreamByPost(urlPaht,content, "utf-8");
				
				if(null != responseContent.getBody()){
					Map<String,Object> json = (Map<String,Object>) responseContent.getBody();
					return com.alibaba.fastjson.JSONObject.toJSONString(json);
				}else{
					Map<String,Object> json = new HashMap<String, Object>();
					json.put("state", -1);
					json.put("message", "添加失败");
					return com.alibaba.fastjson.JSONObject.toJSONString(json);
				}
			} catch (Exception e) {
				logger.info("添加失败", e);
				Map<String,Object> json = new HashMap<String, Object>();
				json.put("state", -1);
				json.put("message", "添加失败");
				return com.alibaba.fastjson.JSONObject.toJSONString(json);
			}
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
			String uploadPath = AdminConfig.techieUploadPath;
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
				map.put("url","/imgView/readTechieImage.htm?imagePath=");
			}
			return ResponseJson.body(true, "" ,map);
		}
		
		
		@ResponseBody
		@RequestMapping(value = "/uploadTmpImg.htm")
		public String uploadTmpImg (HttpServletRequest request , HttpServletResponse response)
		{

			MultipartHttpServletRequest multipartRequest=null ;
			try {
				request.setCharacterEncoding("utf-8");

			 multipartRequest = (MultipartHttpServletRequest) request;

			multipartRequest.setCharacterEncoding("utf-8");
			}
			catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			}
			String fileName = "";
			String uploadPath = AdminConfig.techieUploadPath;
			String path =request.getSession().getServletContext().getRealPath("/")+uploadPath;
			  File uploadPathFile = new File(path);
			  if (!uploadPathFile.exists()) {
			   uploadPathFile.mkdir();
			  }
			String realPath = "";
			for (Iterator it = multipartRequest.getFileNames(); it.hasNext();) {
				String key = (String) it.next();
				MultipartFile mulfile = multipartRequest.getFile(key);
				fileName = mulfile.getOriginalFilename();

				try {
					fileName = new String(fileName.getBytes("iso-8859-1"), "UTF-8");
				} catch (UnsupportedEncodingException e) {
					e.printStackTrace();
				}

				fileName = handlerFileName(fileName);
				File file = new File(path + fileName);
				try {
					mulfile.transferTo(file);
				} catch (IOException e) {
					e.printStackTrace();
				}
			}


			multipartRequest = null;

			String url = request.getScheme() +"://" + request.getServerName()  
	                        + ":" +request.getServerPort();
			realPath = url + "/imgView/readTechieImage.htm?imagePath="+fileName;

			return realPath;

		}
		
		//文件名称处理
		private String handlerFileName(String fileName) {
			//处理名称start
			fileName = (new Date()).getTime()+"_"+fileName;
	//时间戳+文件名，防止覆盖重名文件
			String pre = StringUtils.substringBeforeLast(fileName, ".");
			String end = StringUtils.substringAfterLast(fileName, ".");
			fileName = pre+"."+end;//用MD5编码文件名，解析附件名称
			//处理名称end
			return fileName;
		}
}
