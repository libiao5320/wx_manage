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

import cc.royao.commons.ResponseJson;
import cc.royao.commons.formbean.MapVo;
import cc.royao.commons.httpClient.HttpUtil;
import cc.royao.commons.httpClient.RequestContent;
import cc.royao.commons.httpClient.ResponseContent;
import cc.royao.utils.AdminConfig;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
/**
 * 产品分类设置
 * Administrator oubinbin
 *
 */

@Controller
@RequestMapping("/GroupbuyClassCtrl")
public class GroupbuyClassCtrl {
	Logger logger = Logger.getLogger(this.getClass());
	/***
	 * 跳到产品分类页面
	 * @param mapVo
	 * @param map
	 * @return
	 */
	@RequestMapping("/goodsClassPage.htm")
	public String goodsClassPage(MapVo mapVo,ModelMap map){
		
		return "commonSettings/goodsClass";
	}
	/**
	 * 所有产品分类
	 * @param map
	 * @param mapVo
	 * @param pageNo
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/queryAllGoodsClass.ajax")
public String queryAllGoodsClass(HttpServletRequest request){
		
		RequestContent content = new RequestContent();
		MapVo mapVo = new MapVo();
		mapVo.setMap(JSON.parseObject(request.getParameter("map")));
		content.setBody(mapVo.getMap());
		
		try {
			ResponseContent responseContent = HttpUtil.getInputStreamByPost("/groupbuy/p_queryAllGoodsClass.htm",content, "utf-8");
			
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
	/***
	 * 跳到产品一级分类添加页面
	 * @param mapVo
	 * @param map
	 * @return
	 */
	@RequestMapping("/addFristClassPage.htm")
	public String addFristClassPage(MapVo mapVo,ModelMap map){
		return "commonSettings/addFirstClass";
	}
	/***
	 * 跳到产品让二级分类添加页面
	 * @param mapVo
	 * @param map
	 * @return
	 */
	@RequestMapping("/addSecondClassPage.htm")
	public String addSecondClassPage(MapVo mapVo,ModelMap modelMap){
		String urlPaht = "/groupbuy/p_queryFristClass.htm";
		RequestContent content = new RequestContent();
		Map<String, Object> map = new HashMap<String, Object>();
		content.setBody(map);
		try {
			ResponseContent responseContent = HttpUtil.getInputStreamByPost(urlPaht, content, "utf-8");

			if(null != responseContent.getBody()){
				Map<String,Object> json = (Map<String,Object>) responseContent.getBody();
				modelMap.put("goodsClass",json);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "commonSettings/addSecondClass";
	}
	/**
	 * 保存产品分类
	 * @param mapVo
	 * @param pageNo
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/saveGoodsClass.ajax")
	public String saveGoodsClass(HttpServletRequest request, ModelMap modelMap,String remark){
		String urlPaht = "/groupbuy/p_saveGoodsClass.htm";
		
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
				json.put("message", "添加产品类别信息失败");
				return JSONObject.toJSONString(json);
			}
		} catch (Exception e) {
			logger.info("添加产品类别信息失败", e);
			Map<String,Object> json = new HashMap<String, Object>();
			json.put("state", -1);
			json.put("message", "添加产品类别信息失败");
			return JSONObject.toJSONString(json);
		}
    }
	/**
	 * 
	 * @param map
	 * @param id
	 * @return
	 */
	@RequestMapping("/goUpdatePage/{id}.htm")
	public String goUpdatePage(ModelMap modelMap, @PathVariable Long id){
		String urlPaht = "/groupbuy/p_queryGoodsClassById.htm";
		
		RequestContent content = new RequestContent();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		content.setBody(map);
		try {
			ResponseContent responseContent = HttpUtil.getInputStreamByPost(urlPaht, content, "utf-8");

			if(null != responseContent.getBody()){
				Map<String,Object> json = (Map<String,Object>) responseContent.getBody();
				modelMap.put("goodsClass",json);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "commonSettings/updateGoodsClass";
	}

	/**
	 *  修改产品类别信息
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/updateGoodsClass.ajax")
	public String updateGoodsClass(HttpServletRequest request, HttpServletResponse response){
		String urlPaht = "/groupbuy/p_updateGoodsClass.htm";
		
		RequestContent content = new RequestContent();
		content.setBody(JSON.parseObject(request.getParameter("map")));
	
		try {
			ResponseContent responseContent = HttpUtil.getInputStreamByPost(urlPaht,content, "utf-8");
			
			if(null != responseContent.getBody()){
				Map<String,Object> json = (Map<String,Object>) responseContent.getBody();
				return JSONObject.toJSONString(json);
			}else{
				Map<String,Object> json = new HashMap<String, Object>();
				json.put("message", "更新产品类别信息失败");
				return JSONObject.toJSONString(json);
			}
		} catch (Exception e) {
			logger.info("更新产品类别信息失败", e);
			Map<String,Object> json = new HashMap<String, Object>();
			json.put("message", "更新产品类别信息失败");
			return JSONObject.toJSONString(json);
		}
    }
	/**
	 *  删除产品类别信息
	 * @param request
	 * @return
	 */	@ResponseBody
	@RequestMapping("/deleteGoodsClass.ajax")
	public ResponseJson deleteGoodsClass(Long id){
		
		HashMap<String , Object> hashMap = new HashMap<String, Object>();
		hashMap.put("id", id);
		MapVo mapVo = new MapVo();
		mapVo.setMap(hashMap);
		RequestContent content = new RequestContent();
		content.setBody(mapVo.getMap());
		
		try{
			ResponseContent responseContent = HttpUtil.getInputStreamByPost("/groupbuy/p_deleteGoodsClass.htm",content, "utf-8");
			
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
		 *  上传图标文件
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

		@ResponseBody
		@RequestMapping("/queryMaxGoodsClass.ajax")
		public String queryMaxGoodsClass(HttpServletRequest request){
			
			RequestContent content = new RequestContent();
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("classParentId", request.getParameter("classParentId"));
			content.setBody(map);
			
			try {
				ResponseContent responseContent = HttpUtil.getInputStreamByPost("/groupbuy/p_queryMaxGoodsClass.htm",content, "utf-8");
				
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
