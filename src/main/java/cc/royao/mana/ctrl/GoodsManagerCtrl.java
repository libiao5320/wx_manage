package cc.royao.mana.ctrl;

import java.io.*;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cc.royao.common.Constants;
import cc.royao.commons.formbean.MapVo;
import cc.royao.commons.httpClient.HttpUtil;
import cc.royao.commons.httpClient.RequestContent;
import cc.royao.commons.httpClient.ResponseContent;
import cc.royao.mana.auth.model.Manager;
import cc.royao.mana.auth.service.good.GoodManageService;
import cc.royao.mana.exception.BusinessException;
import cc.royao.mana.model.GoodTmp;
import cc.royao.utils.AdminConfig;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Controller
@RequestMapping("/goods")
public class GoodsManagerCtrl {
	
	Logger logger = Logger.getLogger(this.getClass());

	@Autowired
	private GoodManageService goodManageService ;
	
	@RequestMapping("/goodslist.htm")
	public String list(HttpServletRequest request , HttpServletResponse response , ModelMap modelMap)
    {
		return "goods/goodslist";
    }
	
	@ResponseBody
	@RequestMapping ("/query.ajax")
    public String listAjax(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap)
    {
		String urlPath = "/goods/p_listQuery.htm";
		
		MapVo mapVo = new MapVo();
		//Map map = new HashMap<String, Integer>();
		//System.out.println( request.getParameter("goodsState"));
		//map.put("pageNo", request.getParameter("pageNo"));
		//map.put("goodsState", request.getParameter("goodsState"));
		mapVo.setMap(JSON.parseObject(request.getParameter("map")));
		RequestContent content = new RequestContent();
		content.setBody(mapVo.getMap());
	
		try {
			ResponseContent responseContent = HttpUtil.getInputStreamByPost(urlPath,content, "utf-8");
			
			if(null != responseContent.getBody()){
				Map<String,Object> json = (Map<String,Object>) responseContent.getBody();
				return JSONObject.toJSONString(json);
			}else{
				return "没有数据";
			}
		} catch (Exception e) {
			logger.info("请求商品列表失败", e);
			return "网络忙，请稍后再试";
		}
    }

	@ResponseBody
	@RequestMapping ("/deleteGoodsById.ajax")
    public String deleteGoods(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap)
    {
		String urlPath = "/goods/p_deleteGoods.htm";
		
		Map<String, Object> param = new HashMap<String, Object>();
		System.out.println( request.getParameter("id"));
		param.put("id", request.getParameter("id"));
		RequestContent content = new RequestContent();
		content.setBody(param);
	
		try {
			ResponseContent responseContent = HttpUtil.getInputStreamByPost(urlPath,content, "utf-8");
			
			if(null != responseContent.getBody()){
				Map<String,Object> json = (Map<String,Object>) responseContent.getBody();
				return JSONObject.toJSONString(json);
			}else{
				return "数据出错";
			}
		} catch (Exception e) {
			logger.info("删除产品失败", e);
			return "网络忙，请稍后再试";
		}
    }
	
	@RequestMapping("/addGoodPage.htm")
	public String addGoodPage(ModelMap modelMap)
	{
		String urlPath = "/goods/p_getAddGoodsParam.htm";
		RequestContent content = new RequestContent();
		try {
			ResponseContent responseContent = HttpUtil.getInputStreamByPost(urlPath,content, "utf-8");

			if(null != responseContent.getBody()){
				Map<String,Object> json = (Map<String,Object>) responseContent.getBody();
				modelMap.put("result",json);
			}else{

			}
		} catch (Exception e) {
			logger.info("请求商品列表失败", e);
			return "网络忙，请稍后再试";
		}
		return "goods/addgood";
	}


	@ResponseBody
	@RequestMapping ("/addGood.htm")
	public String addGood( HttpServletRequest request  , HttpServletResponse response , MapVo mapVo ,String specStr , String imgs,ModelMap modelMap ) throws IOException, BusinessException {
		String urlPath = "/goods/p_addGood.htm";
		RequestContent content = new RequestContent();
		try {
			request.setCharacterEncoding("utf-8");
//			Regexp regexp =  new Regexp("\\[.*\\]+");
			String [] arr = specStr.split("[\\[*\\]]+");
			imgs = (String) mapVo.getMap().get("goodsImages");

//		imgs.split("[\\[\\*\\]]+")
			String [] imgArr = imgs.split("[\\[\\*\\]]+");
			List specList  =  new ArrayList();
			List imgList = new ArrayList();
			for( int i =  0  ;  i< arr.length ;i++ )
			{
				if(null != arr[i] && !"".equals(arr[i]))
					specList.add(arr[i]);
			}

			for( int i =  0  ;  i< imgArr.length ;i++ )
			{
			if(null != imgArr[i] && !"".equals(imgArr[i]))
				imgList.add(imgArr[i]);
			}

			Map<String, Object> params = new HashMap<String, Object>();


			params.put("goodInfo", mapVo.getMap());
			params.put("specList",specList);
			params.put("imgList",imgList);
			
			Map<String, Object> goodParam = mapVo.getMap();
			Map<String, Object> goodSet = new HashMap<String, Object>();
			goodSet.put("beginTime", goodParam.get("beginTime"));
			goodSet.put("endTime", goodParam.get("endTime"));
			goodSet.put("periodOfValidity", goodParam.get("periodOfValidity"));
			goodSet.put("technicianId", goodParam.get("technicianId"));
			
			params.put("goodSet", goodSet);

			content.setBody(params);


			ResponseContent responseContent = HttpUtil.getInputStreamByPost(urlPath, content, "utf-8");
			if( null != responseContent.getHead() && !responseContent.getHead().getResultCode().equals("200"))
			{
				throw new BusinessException("创建产品失败:" + responseContent.getHead().getDescription());
			}
		}catch(Exception e){
			e.printStackTrace();
			throw new BusinessException("创建产品失败");
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("state", 1);
		return JSON.toJSONString(map);
	}


	@ResponseBody
	@RequestMapping ( value = "/loadGoodTmp.htm")
	public String loadGoodTmp ( String type ){


		List tmpList = null;
		try {
			tmpList = goodManageService.queryGoodTmpByType(type);


		} catch (Exception e) {
			e.printStackTrace();
		}


		return JSONObject.toJSONString(tmpList);
	}

	@ResponseBody
	@RequestMapping ( value = "/choseTmp.htm")
	public String choseTmp ( String tmpId  ){


		String tmpContent = null;
		try {
			GoodTmp goodTmp = goodManageService.choseGoodTmpContent(Long.valueOf(tmpId));
			tmpContent = goodTmp.getGoodTmpContent();

		} catch (Exception e) {
			e.printStackTrace();
		}


		return tmpContent;
	}


	@RequestMapping(value = "/readGoodImage.htm")
	public void readImage(HttpServletRequest request, HttpServletResponse response){
		String imagePath = request.getSession().getServletContext().getRealPath("/")+AdminConfig.goodsUploadPath+request.getParameter("imagePath");
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
	@RequestMapping (value = "/saveGoodTmp.htm")
	public String saveGoodTmp(GoodTmp goodTmp , HttpServletRequest request)
	{

		Manager manager  = (Manager) request.getSession().getAttribute(Constants.SESSION_USERINFO);

		goodTmp.setGoodTmpCm(manager.getMamangerId());

		try {
			goodTmp  = goodManageService.add(goodTmp);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return JSONObject.toJSONString(goodTmp);
	}
	
	
	@ResponseBody
	@RequestMapping (value = "/updateGoodTmp.htm")
	public String updateGoodTmp(GoodTmp goodTmp , HttpServletRequest request)
	{

		Manager manager  = (Manager) request.getSession().getAttribute(Constants.SESSION_USERINFO);

		goodTmp.setGoodTmpCm(manager.getMamangerId());

		try {
			goodTmp  = goodManageService.updateGoodTmp(goodTmp);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return JSONObject.toJSONString(goodTmp);
	}

	@ResponseBody
	@RequestMapping(value = "/uploadGoodImg.htm")
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
		String uploadPath = AdminConfig.goodsUploadPath;
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
		String uploadPath = AdminConfig.goodsUploadPath;
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
		realPath = url + "/imgView/readGoodImage.htm?imagePath="+fileName;

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



	@RequestMapping("/editGood/{id}.htm")
	public String editGood(ModelMap modelMap,@PathVariable Long id)
	{
		String urlPath = "/goods/p_getGoodsDetail.htm";
		RequestContent content = new RequestContent();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		content.setBody(map);
		try {
			ResponseContent responseContent = HttpUtil.getInputStreamByPost(urlPath,content, "utf-8");

			if(null != responseContent.getBody()){
				Map<String,Object> json = (Map<String,Object>) responseContent.getBody();
				modelMap.put("result",json);
			}else{

			}
		} catch (Exception e) {
			logger.info("请求商品列表失败", e);
			return "网络忙，请稍后再试";
		}
		return "goods/editgood";
	}
	
	@ResponseBody
	@RequestMapping ("/edit.htm")
	public String editGood( HttpServletRequest request  , HttpServletResponse response , MapVo mapVo ,String specStr ) throws Exception
	{



		String urlPath = "/goods/p_editGood.htm";
		RequestContent content = new RequestContent();

		try {
			request.setCharacterEncoding("utf-8");


//			Regexp regexp =  new Regexp("\\[.*\\]+");
			String imgs = (String) mapVo.getMap().get("goodsImages");
			String [] imgArr = imgs.split("[\\[.*\\]]+");

			String arr = specStr.substring(specStr.indexOf("[")+1,specStr.indexOf("]"));
			List specList  =  new ArrayList();
			specList.add(arr);
			List imgList = new ArrayList();
			/*for( int i =  0  ;  i< arr.length ;i++ )
			{
				if(null != arr[i] && !"".equals(arr[i])){
					specList.add(arr[i]);
					break;
				}
			}*/
			for( int i =  0  ;  i< imgArr.length ;i++ )
			{
				if(null != imgArr[i] && !"".equals(imgArr[i]) && imgArr[i].indexOf("=") > -1){
					imgList.add(imgArr[i].split("=")[1] + "." + imgArr[i+1]);
				}
			}

			Map<String, Object> params = new HashMap<String, Object>();

			params.put("goodInfo", mapVo.getMap());
			params.put("specList",specList);
			params.put("imgList",imgList);

			Map<String, Object> goodParam = mapVo.getMap();
			Map<String, Object> goodSet = new HashMap<String, Object>();
			goodSet.put("setId", goodParam.get("setId"));
			goodSet.put("beginTime", goodParam.get("beginTime"));
			goodSet.put("endTime", goodParam.get("endTime"));
			goodSet.put("periodOfValidity", goodParam.get("periodOfValidity"));
			goodSet.put("technicianId", goodParam.get("technicianId"));
			
			params.put("goodSet", goodSet);

			content.setBody(params);
			ResponseContent responseContent = HttpUtil.getInputStreamByPost(urlPath, content, "utf-8");
			if( null != responseContent.getHead() && !responseContent.getHead().getResultCode().equals("200"))
			{
				throw new BusinessException("更新产品失败:" + responseContent.getHead().getDescription());
			}
		} catch (Exception e) {
			logger.info("更新产品失败", e);
			throw new BusinessException("更新产品失败");
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("state", 1);
		return JSON.toJSONString(map);
	}

}
