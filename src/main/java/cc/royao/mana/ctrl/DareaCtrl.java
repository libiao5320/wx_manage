package cc.royao.mana.ctrl;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cc.royao.commons.ResponseJson;
import cc.royao.commons.httpClient.HttpUtil;
import cc.royao.commons.httpClient.RequestContent;
import cc.royao.commons.httpClient.ResponseContent;


@Controller
@RequestMapping("/query")
public class DareaCtrl {
	
		Logger logger = Logger.getLogger(this.getClass());
	
	
		@ResponseBody
		@RequestMapping("/area.ajax")
		public Object area(int id){
			RequestContent content = new RequestContent();
			Map<String, Object> hmap = new HashMap<String, Object>();
			hmap.put("id", id);
			content.setBody(hmap);
			
			try {
				ResponseContent res = HttpUtil.getInputStreamByPost("/area/area.htm",content, "utf-8");
				if(null != res.getBody()){
					logger.info("Center端返回的数据："+res.getBody());
					return ResponseJson.body(true,"",res.getBody());
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
			return null;
		}
}
