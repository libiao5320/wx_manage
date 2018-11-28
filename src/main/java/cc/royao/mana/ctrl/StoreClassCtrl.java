package cc.royao.mana.ctrl;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
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
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

import cc.royao.commons.httpClient.HttpUtil;
import cc.royao.commons.httpClient.RequestContent;
import cc.royao.commons.httpClient.ResponseContent;
import cc.royao.utils.AdminConfig;

@Controller
@RequestMapping("/storeClass")
public class StoreClassCtrl {
	
	Logger logger = Logger.getLogger(this.getClass());
	
	@RequestMapping("/storeClassPage.htm")
	public String storeClassPage(){
		
		return "store/class/storeClass";
	}

	@ResponseBody
	@RequestMapping("/queryAllStoreClass.ajax")
	public String queryAllStoreClass(HttpServletRequest request){
		
		RequestContent content = new RequestContent();
		content.setBody(JSON.parseObject(request.getParameter("map")));
		
		try {
			ResponseContent responseContent = HttpUtil.getInputStreamByPost("/groupbuy/pclass_listWithPage.htm",content, "utf-8");
			
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
	
	@RequestMapping("/addClass.htm")
	public String addClass(){
		
		return "store/class/addClass";
	}
	
	@ResponseBody
	@RequestMapping("/saveClass.ajax")
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
	
	@RequestMapping("/edit/{id}.htm")
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
		String uploadPath = AdminConfig.publicUploadPath;
		modelMap.put("img_url", uploadPath);
		
		return "store/class/editClass";
	}
	
	@ResponseBody
    @RequestMapping(value = "/uploadImage.ajax")
    public String uploadImage(HttpServletRequest request, HttpServletResponse response){
    	MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		String fileName = "";
		String uploadPath = AdminConfig.publicUploadPath;
		String path = request.getSession().getServletContext().getRealPath("/")+uploadPath;
		File uploadPathFile = new File(path);
		
		if (!uploadPathFile.exists()) {
		   uploadPathFile.mkdir();
		}
		List<Map> list = new ArrayList<Map>();
		List<MultipartFile> files = multipartRequest.getFiles("fileinfo");
		for(int i=0;i<files.size();i++){
			MultipartFile mulfile = files.get(i);
			fileName = mulfile.getOriginalFilename();
			fileName = handlerFileName(fileName);
			File file = new File(path + fileName);
			
			try {
				mulfile.transferTo(file);
			} catch (IOException e) {
				e.printStackTrace();
			}
			Map<String, String> map = new HashMap<String, String>();
			map.put("imagePath", fileName);
			map.put("url", uploadPath);
			list.add(map);
		}
		multipartRequest = null;
		return JSONArray.toJSONString(list);
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
