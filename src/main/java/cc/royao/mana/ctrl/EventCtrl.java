package cc.royao.mana.ctrl;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
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

import cc.royao.common.Constants;
import cc.royao.commons.formbean.MapVo;
import cc.royao.commons.httpClient.HttpUtil;
import cc.royao.commons.httpClient.RequestContent;
import cc.royao.commons.httpClient.ResponseContent;
import cc.royao.mana.auth.model.Manager;
import cc.royao.utils.AdminConfig;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

/**
 * 
 * ClassName: EventCtrl 
 * @Description: 活动管理
 * @author Liu Li
 * @date 2016年1月20日
 */
@Controller
@RequestMapping("/event")
public class EventCtrl {
	Logger logger = Logger.getLogger(this.getClass());
	
	@RequestMapping ("/index.htm")
    public String index()
    {
		return "event/index";
    }
	
	@RequestMapping ("/map.htm")
    public String map()
    {
		return "event/map";
    }
	
	@RequestMapping ("/create.htm")
    public String create()
    {
		return "event/create";
    }
	
	@RequestMapping ("/examine.htm")
    public String examine(HttpServletRequest request, ModelMap model)
    {
		if(request.getParameter("status") != null){
			String status = request.getParameter("status");
			model.addAttribute("indexStatus", status);
			return "event/examine";
		}
		model.addAttribute("indexStatus", "false");
		return "event/examine";
    }
	
	@RequestMapping ("/edit/{id}.htm")
    public String edit(ModelMap modelMap,@PathVariable Long id)
    {
		String urlPaht = "/event/p_detail.htm";
		
		RequestContent content = new RequestContent();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		content.setBody(map);
		try {
			ResponseContent responseContent = HttpUtil.getInputStreamByPost(urlPaht, content, "utf-8");

			if(null != responseContent.getBody()){
				JSONObject result = (JSONObject) responseContent.getBody();
				modelMap.put("event",result);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "event/edit";
    }
	
	/**
	 * ajax获取活动列表
	 * @param response
	 * @param request
	 * @return
	 * @author Liu Li
	 * @date 2016年1月20日
	 */
	@ResponseBody
	@RequestMapping ("/query.ajax")
    public String listajax(HttpServletRequest request, HttpServletResponse response)
    {
		String urlPaht = "/event/p_query.htm";
		
		RequestContent content = new RequestContent();
		content.setBody(JSON.parseObject(request.getParameter("map")));
	
		try {
			ResponseContent responseContent = HttpUtil.getInputStreamByPost(urlPaht,content, "utf-8");
			
			if(null != responseContent.getBody()){
				Map<String,Object> json = (Map<String,Object>) responseContent.getBody();
				return JSONObject.toJSONString(json);
			}else{
				Map<String,Object> json = new HashMap<String, Object>();
				json.put("state", -1);
				json.put("message", "已经没有更多了");
				return JSONObject.toJSONString(json);
			}
		} catch (Exception e) {
			logger.info("请求活动列表失败", e);
			Map<String,Object> json = new HashMap<String, Object>();
			json.put("state", -1);
			json.put("message", "请求活动列表失败");
			return JSONObject.toJSONString(json);
		}
    }
	
	/**
	 * 通过id删除活动
	 * @param response
	 * @param request
	 * @return
	 * @author Liu Li
	 * @date 2016年1月20日
	 */
	@ResponseBody
	@RequestMapping ("/deleteEventById.ajax")
    public String deleteEventById(HttpServletRequest request, HttpServletResponse response)
    {
		String urlPaht = "/event/p_deleteEventById.htm";
		
		MapVo mapVo = new MapVo();
		long id = Long.parseLong(request.getParameter("id"));
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("id", id);
		mapVo.setMap(map);
		
		RequestContent content = new RequestContent();
		content.setBody(mapVo.getMap());
	
		try {
			ResponseContent responseContent = HttpUtil.getInputStreamByPost(urlPaht,content, "utf-8");
			
			if(null != responseContent.getBody()){
				Map<String,Object> json = (Map<String,Object>) responseContent.getBody();
				return JSONObject.toJSONString(json);
			}else{
				Map<String,Object> json = new HashMap<String, Object>();
				json.put("state", -1);
				json.put("message", "删除活动失败");
				return JSONObject.toJSONString(json);
			}
		} catch (Exception e) {
			logger.info("删除活动失败", e);
			Map<String,Object> json = new HashMap<String, Object>();
			json.put("state", -1);
			json.put("message", "删除活动失败");
			return JSONObject.toJSONString(json);
		}
    }
	
	/**
	 * 更新活动
	 * @param response
	 * @param request
	 * @return
	 * @author Liu Li
	 * @date 2016年1月22日
	 */
	@ResponseBody
	@RequestMapping ("/updateEventById.ajax")
    public String updateEventById(HttpServletRequest request, HttpServletResponse response)
    {
		String urlPaht = "/event/p_updateEventById.htm";
		
		RequestContent content = new RequestContent();
		Map<String, Object> map = new HashMap<String, Object>();
		Manager manager = (Manager) request.getSession().getAttribute(Constants.SESSION_USERINFO);
		map.put("updateBy", manager.getMamangerId());
		map.putAll(JSON.parseObject(request.getParameter("map")));
		content.setBody(map);
	
		try {
			ResponseContent responseContent = HttpUtil.getInputStreamByPost(urlPaht,content, "utf-8");
			
			if(null != responseContent.getBody()){
				Map<String,Object> json = (Map<String,Object>) responseContent.getBody();
				return JSONObject.toJSONString(json);
			}else{
				Map<String,Object> json = new HashMap<String, Object>();
				json.put("state", -1);
				json.put("message", "更新活动失败");
				return JSONObject.toJSONString(json);
			}
		} catch (Exception e) {
			logger.info("更新活动失败", e);
			Map<String,Object> json = new HashMap<String, Object>();
			json.put("state", -1);
			json.put("message", "更新活动失败");
			return JSONObject.toJSONString(json);
		}
    }
	
	/**
	 * 更新活动
	 * @param response
	 * @param request
	 * @return
	 * @author Liu Li
	 * @date 2016年1月22日
	 */
	@ResponseBody
	@RequestMapping ("/saveEvent.ajax")
    public String insertEvent(HttpServletRequest request, HttpServletResponse response)
    {
		String urlPaht = "/event/p_saveEvent.htm";
		
		RequestContent content = new RequestContent();
		Map<String, Object> map = new HashMap<String, Object>();
		Manager manager = (Manager) request.getSession().getAttribute(Constants.SESSION_USERINFO);
		map.put("updateBy", manager.getMamangerId());
		map.put("createBy", manager.getMamangerId());
		map.putAll(JSON.parseObject(request.getParameter("map")));
		content.setBody(map);
		
		try {
			ResponseContent responseContent = HttpUtil.getInputStreamByPost(urlPaht,content, "utf-8");
			
			if(null != responseContent.getBody()){
				Map<String,Object> json = (Map<String,Object>) responseContent.getBody();
				return JSONObject.toJSONString(json);
			}else{
				Map<String,Object> json = new HashMap<String, Object>();
				json.put("state", -1);
				json.put("message", "添加活动失败");
				return JSONObject.toJSONString(json);
			}
		} catch (Exception e) {
			logger.info("添加活动失败", e);
			Map<String,Object> json = new HashMap<String, Object>();
			json.put("state", -1);
			json.put("message", "添加活动失败");
			return JSONObject.toJSONString(json);
		}
    }
	
	@ResponseBody
	@RequestMapping ("/autoStoreName.ajax")
    public String autoStoreName(HttpServletRequest request, HttpServletResponse response)
    {
		String urlPaht = "/event/p_getStoreListByName.htm";
		
		RequestContent content = new RequestContent();
		content.setBody(JSON.parseObject(request.getParameter("map")));
		JSONObject result = null;
		try {
			ResponseContent responseContent = HttpUtil.getInputStreamByPost(urlPaht, content, "utf-8");

			if(null != responseContent.getBody()){
				result = (JSONObject) responseContent.getBody();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return JSONObject.toJSONString(result);
    }
	
	@RequestMapping(value = "/readImage.htm")
	public void readImage(HttpServletRequest request, HttpServletResponse response){
		String imagePath = request.getSession().getServletContext().getRealPath("/")+AdminConfig.eventUploadPath+request.getParameter("imagePath");
		try{
			File file = new File(imagePath);
			if (file.exists()) {
				DataOutputStream temps = new DataOutputStream(response
						.getOutputStream());

				DataInputStream in = new DataInputStream(
						new FileInputStream(imagePath));
				byte[] b = new byte[2048];
				while ((in.read(b)) != -1) {
					temps.write(b);

				}
				temps.flush();
				in.close();
				temps.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@ResponseBody
	@RequestMapping(value = "/uploadImg.htm")
	public String uploadGoodImg (HttpServletRequest request , HttpServletResponse response)
	{
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		String fileName = "";
		String uploadPath = AdminConfig.goodsUploadPath;
		String path =request.getSession().getServletContext().getRealPath("/")+uploadPath;
		File uploadPathFile = new File(path);
		if (!uploadPathFile.exists()) {
		   uploadPathFile.mkdir();
		}
		List<Map> list = new ArrayList<Map>();
		List<MultipartFile> files = multipartRequest.getFiles("img");
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
			Map map = new HashMap<String, String>();
			map.put("imagePath", fileName);
			list.add(map);
		}
		multipartRequest = null;
		return JSONArray.toJSONString(list);

	}
	
	@ResponseBody
	@RequestMapping ("/validateStore.htm")
    public String validateStore(HttpServletRequest request)
    {
		String flag = "false";
		String urlPaht = "/event/p_getStoreByName.htm";
		
		RequestContent content = new RequestContent();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("storeName", request.getParameter("store_name"));
		content.setBody(map);
		try {
			ResponseContent responseContent = HttpUtil.getInputStreamByPost(urlPaht, content, "utf-8");

			if(null != responseContent.getBody()){
				Map result = (Map) responseContent.getBody();
				Long count = Long.parseLong("" +result.get("count"));
				if(count > 0){
					flag = "true";
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return flag;
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
