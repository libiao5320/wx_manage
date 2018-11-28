package cc.royao.mana.ctrl;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import cc.royao.commons.formbean.MapVo;
import cc.royao.commons.httpClient.HttpUtil;
import cc.royao.commons.httpClient.RequestContent;
import cc.royao.commons.httpClient.ResponseContent;
import java.sql.Date;

@Controller
@RequestMapping("/class")
public class PGoodsClassCtrl {
	Logger logger = Logger.getLogger(this.getClass());
	
	@ResponseBody
	@RequestMapping (value = "/queryGoodsClass.ajax", produces = {"application/json;charset=UTF-8"})
    public String listAjax(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap)
    {
		String urlPath = "/groupbuy/pclass_list.htm";
		
		MapVo mapVo = new MapVo();
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
	


}
