package cc.royao.mana.ctrl;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;

import cc.royao.commons.ResponseJson;
import cc.royao.commons.formbean.MapVo;
import cc.royao.commons.httpClient.HttpUtil;
import cc.royao.commons.httpClient.RequestContent;
import cc.royao.commons.httpClient.ResponseContent;
import cc.royao.utils.AdminConfig;
/**
 * 微信首页设置
 * @author oubinbin
 *
 */
@Controller
@RequestMapping("/WXBannerCtrl")
public class WXBannerCtrl {

	Logger logger = Logger.getLogger(this.getClass());
	/***
	 * 跳到微信首页页面
	 * @param mapVo
	 * @param map
	 * @return
	 */
	@RequestMapping("/wxBannerPage.htm")
	public String wxBannerPage(MapVo mapVo,ModelMap map){
		
		return "commonSettings/wxBanner";
	}
	/**
	 * 查所有微信首页banner信息
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/queryAllWXBanner.ajax")
	public String queryAllWXBanner(HttpServletRequest request){
		
		RequestContent content = new RequestContent();
		MapVo mapVo = new MapVo();
		mapVo.setMap(JSON.parseObject(request.getParameter("map")));
		content.setBody(mapVo.getMap());
		
		try {
			ResponseContent responseContent = HttpUtil.getInputStreamByPost("/WXbanner/queryWXBanner.htm",content, "utf-8");
			
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
//	/**
//	 * 上传活动报名图片
//	 * @param mapVo
//	 * @param pageNo
//	 * @return
//	 */
//	@ResponseBody
//	@RequestMapping("/uploadImg.ajax")
//	public String uploadImg(HttpServletRequest request, ModelMap modelMap,String remark){
//		String urlPaht = "/WXbanner/uploadImg.htm";
//		
//		RequestContent content = new RequestContent();
//		content.setBody(JSON.parseObject(request.getParameter("map")));
//	
//		try {
//			ResponseContent responseContent = HttpUtil.getInputStreamByPost(urlPaht,content, "utf-8");
//			
//			if(null != responseContent.getBody()){
//				Map<String,Object> map = (Map<String,Object>) responseContent.getBody();
//				return JSONObject.toJSONString(map);
//			}else{
//				Map<String,Object> json = new HashMap<String, Object>();
//				json.put("state", -1);
//				json.put("message", "上传活动报名图片失败");
//				return JSONObject.toJSONString(json);
//			}
//		} catch (Exception e) {
//			logger.info("上传活动报名图片失败", e);
//			Map<String,Object> json = new HashMap<String, Object>();
//			json.put("state", -1);
//			json.put("message", "上传活动报名图片失败");
//			return JSONObject.toJSONString(json);
//		}
//    }
	/***
	 * 跳到微信首页添加页面(查询一级地区到添加页面)
	 * @param mapVo
	 * @param map
	 * @return
	 */
	@RequestMapping("/addWXBannerPage.htm")
	public String addWXBannerPage(MapVo mapVo,ModelMap modelMap){
		String urlPaht ="/WXbanner/queryDataToAddPage.htm";
		RequestContent content = new RequestContent();
		Map<String, Object> map = new HashMap<String, Object>();
		content.setBody(map);
		try {
			ResponseContent responseContent = HttpUtil.getInputStreamByPost(urlPaht, content, "utf-8");

			if(null != responseContent.getBody()){
				Map<String,Object> json = (Map<String,Object>) responseContent.getBody();
				modelMap.put("oneClassArea",json);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "commonSettings/addWXBanner";
	}
//	/***
//	 * 跳到产品让二级分类添加页面
//	 * @param mapVo
//	 * @param map
//	 * @return
//	 */
//	@RequestMapping("/addSecondClassPage.htm")
//	public String addSecondClassPage(MapVo mapVo,ModelMap modelMap){
//		String urlPaht = "/WXbanner/queryFristClass.htm";
//		RequestContent content = new RequestContent();
//		Map map = new HashMap<String, Object>();
//		content.setBody(map);
//		try {
//			ResponseContent responseContent = HttpUtil.getInputStreamByPost(urlPaht, content, "utf-8");
//
//			if(null != responseContent.getBody()){
//				Map<String,Object> json = (Map<String,Object>) responseContent.getBody();
//				modelMap.put("wxBanner",json);
//			}
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		
//		return "commonSettings/addSecondClass";
//	}
	/**
	 * 保存微信首页信息
	 * @param mapVo
	 * @param pageNo
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/saveWXBanner.ajax")
	public String saveGoodsClass(HttpServletRequest request, ModelMap modelMap,String remark){
		String urlPaht = "/WXbanner/saveWXBanner.htm";
		
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
				json.put("message", "添加微信首页信息失败");
				return JSONObject.toJSONString(json);
			}
		} catch (Exception e) {
			logger.info("添加微信首页信息失败", e);
			Map<String,Object> json = new HashMap<String, Object>();
			json.put("state", -1);
			json.put("message", "添加微信首页信息失败");
			return JSONObject.toJSONString(json);
		}
    }
	/**
	 *带数据到修改页面 (查询一级地区到添加页面)
	 * @param map
	 * @param id
	 * @return
	 */
	@RequestMapping("/goWXBannerPage/{id}.htm")
	public String goUpdatePage(ModelMap modelMap, @PathVariable Long id){
		String urlPaht = "/WXbanner/queryWXBannerById.htm";
		
		RequestContent content = new RequestContent();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		content.setBody(map);
		try {
			ResponseContent responseContent = HttpUtil.getInputStreamByPost(urlPaht, content, "utf-8");

			if(null != responseContent.getBody()){
				Map<String,Object> json = (Map<String,Object>) responseContent.getBody();
				modelMap.put("json",json);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "commonSettings/updateWXBanner";
	}

	/**
	 *  修改微信首页信息
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/updateWXBanner.ajax")
	public String updateWXBanner(HttpServletRequest request, HttpServletResponse response){
		String urlPaht = "/WXbanner/updateWXBanner.htm";
		
		RequestContent content = new RequestContent();
		content.setBody(JSON.parseObject(request.getParameter("map")));
	
		try {
			ResponseContent responseContent = HttpUtil.getInputStreamByPost(urlPaht,content, "utf-8");
			
			if(null != responseContent.getBody()){
				Map<String,Object> json = (Map<String,Object>) responseContent.getBody();
				return JSONObject.toJSONString(json);
			}else{
				Map<String,Object> json = new HashMap<String, Object>();
				json.put("message", "更新微信首页信息失败");
				return JSONObject.toJSONString(json);
			}
		} catch (Exception e) {
			logger.info("更新微信首页信息失败", e);
			Map<String,Object> json = new HashMap<String, Object>();
			json.put("message", "更新微信首页信息失败");
			return JSONObject.toJSONString(json);
		}
    }
	/**
	 *  删除微信首页信息
	 * @param request
	 * @return
	 */	@ResponseBody
	@RequestMapping("/deleteWXBanner.ajax")
	public ResponseJson deleteWXBanner(Long id){
		
		HashMap<String , Object> hashMap = new HashMap<String, Object>();
		hashMap.put("id", id);
		MapVo mapVo = new MapVo();
		mapVo.setMap(hashMap);
		RequestContent content = new RequestContent();
		content.setBody(mapVo.getMap());
		
		try{
			ResponseContent responseContent = HttpUtil.getInputStreamByPost("/WXbanner/deleteWXBanner.htm",content, "utf-8");
			
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
	 
	 /**
		 *  上传活动报名图片
		 */
		@ResponseBody
		@RequestMapping(value = "/uploadImg.ajax")
		public String uploadGoodImg (HttpServletRequest request , HttpServletResponse response)
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
			String uploadPath = AdminConfig.publicUploadPath;
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

			realPath = "{\"imagePath\":\""+fileName+"\"}";

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
