package cc.royao.mana.ctrl;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import cc.royao.commons.ResponseJson;
import cc.royao.commons.formbean.MapVo;
import cc.royao.commons.httpClient.HttpUtil;
import cc.royao.commons.httpClient.RequestContent;
import cc.royao.commons.httpClient.ResponseContent;
import cc.royao.mana.auth.model.Manager;
import cc.royao.mana.auth.service.manager.ManagerService;

import cc.royao.common.Constants;
import cc.royao.utils.PageUtil;
import cc.royao.utils.SmsHelper;

@Controller
@RequestMapping("/kiting")
public class KitingCtrl {

	Logger logger = Logger.getLogger(this.getClass());

	@Autowired
	private ManagerService managerService;
	
	@RequestMapping("/list.htm")
	public String list(HttpServletRequest request, ModelMap model){
		if(request.getParameter("status") != null){
			String status = request.getParameter("status");
			model.addAttribute("indexStatus", status);
			return "kiting/list";
		}
		model.addAttribute("indexStatus", "false");
		return "kiting/list";
	}
	
	/**
	 * 
	 * @Description: 分页请求列表数据
	 * @param @param request
	 * @param @return   
	 * @return String  
	 * @throws
	 * @author Liu Pinghui
	 * @date 2016年1月23日
	 */
	@ResponseBody
	@RequestMapping("/query.ajax")
	public String listajax(HttpServletRequest request){
		
		RequestContent content = new RequestContent();
		MapVo mapVo = new MapVo();
		mapVo.setMap(JSON.parseObject(request.getParameter("map")));
		content.setBody(mapVo.getMap());
		
		try {
			ResponseContent responseContent = HttpUtil.getInputStreamByPost("/kiting/p_list.htm",content, "utf-8");
			
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
	
	/**
	 * 
	 * @Description: 处理提现
	 * @param @param map
	 * @param @param id
	 * @param @return   
	 * @return String  
	 * @throws
	 * @author Liu Pinghui
	 * @date 2016年1月23日
	 */
	@RequestMapping("/detail/{id}.htm")
	public String detail(ModelMap map, @PathVariable Long id){
		
		RequestContent content = new RequestContent();
		HashMap< String, Object> hmap = new HashMap<String, Object>();
		hmap.put("id", id);
		content.setBody(hmap);
		
		try {
			ResponseContent responseContent = HttpUtil.getInputStreamByPost("/kiting/p_detail.htm",content, "utf-8");
			
			if(null != responseContent.getBody()){
				JSONObject json = (JSONObject) responseContent.getBody();
				map.put("kiting", json);
			}else{
				map.put("kiting", null);
			}
		} catch (Exception e) {
			logger.info("Json转错误/n",e);
		}
		
		return "kiting/detail";
	}

	/**
	 * 
	 * @Description: 处理提现
	 * @param @return   
	 * @return ResponseJson  
	 * @throws
	 * @author Liu Pinghui
	 * @date 2016年1月23日
	 */
	@ResponseBody
	@RequestMapping("/dispose.ajax")
	public ResponseJson dispose(HttpServletRequest request,MapVo mapVo){
		
		Object obj = request.getSession().getAttribute(Constants.SESSION_USERINFO);
		
		Manager manager = null;
		if(obj != null){
			manager = (Manager) obj;
		}else{
			return ResponseJson.body(false, "login");
		}
		
		mapVo.getMap().put("managerName", manager.getManagerLoginName());
		RequestContent content = new RequestContent();
		content.setBody(mapVo.getMap());
		
		try {
			ResponseContent responseContent = HttpUtil.getInputStreamByPost("/kiting/p_dispose.htm",content, "utf-8");
			
			if(null != responseContent.getBody()){
				JSONObject json = (JSONObject) responseContent.getBody();
				if(json != null){
					
					if(json.get("status").equals("HANDLE_OK")){//提现成功
						String phone = json.get("phone")+"";
						String msg = "您的融耀健康帐户提现已成功处理，金额"+json.get("actualMoneyDollar")+"元。";

						SmsHelper.getInstance().sendSms(phone, msg);
					}
					
					return ResponseJson.body(true, "操作成功！", json);
				}else{
					return ResponseJson.body(false, "操作失败！");
				}
			}
		} catch (Exception e) {
			logger.info("Json转错误/n",e);
		}
		
		return ResponseJson.body(false, "网络忙，请稍后重试！");
	}
	
	/**
	 * 
	 * @Description: 跳转到提现明细
	 * @param @param map
	 * @param @param id
	 * @param @return   
	 * @return String  
	 * @throws
	 * @author Liu Pinghui
	 * @date 2016年1月25日
	 */
	@RequestMapping("/detaillist/{id}.htm")
	public String detaillist(ModelMap map,@PathVariable Long id){
		
		RequestContent content = new RequestContent();
		HashMap< String, Object> hmap = new HashMap<String, Object>();
		hmap.put("id", id);
		content.setBody(hmap);
		
		try {
			ResponseContent responseContent = HttpUtil.getInputStreamByPost("/kiting/p_detail.htm",content, "utf-8");
			
			if(null != responseContent.getBody()){
				JSONObject json = (JSONObject) responseContent.getBody();
				map.put("kiting", json);
			}else{
				map.put("kiting", null);
			}
		} catch (Exception e) {
			logger.info("Json转错误/n",e);
		}
		
		return "kiting/detaillist";
	}


	@RequestMapping ("/storeclearmana.htm")
	public String storeClearing(){


		return  "finance/storeclearmana";
	}

	@ResponseBody
	@RequestMapping ("/storeClearList.ajax")
	public String storeClearList( HttpServletRequest request ){
		String url = "/kiting/p_storeClearList.htm";
		RequestContent content = new RequestContent();

		JSONObject json  = null;



		Map params = JSON.parseObject(request.getParameter("map"));



		Integer page = null ==  params.get("pageNo") ? 0 : Integer.valueOf(""+params.get("pageNo"));
		Integer pageSize = null ==  params.get("pageSize") ? 0 : Integer.valueOf(""+params.get("pageSize"));

		params.put("pageNo" , PageUtil.getPageRange(page)[0]);
		params.put("pageSize", PageUtil.getPageRange(page)[1]);

		content.setBody(params);

		try {
			ResponseContent responseContent = HttpUtil.getInputStreamByPost(url,content, "utf-8");

			if(null != responseContent.getBody()) {
				json = (JSONObject) responseContent.getBody();
			}
			else {
				json = new JSONObject();
				json.put("total" , 0 );
				json.put("rows" , new ArrayList() );
			}

		} catch (Exception e) {
			logger.info("Json转错误/n",e);
		}

		return JSONObject.toJSONString(json);
	}

	@RequestMapping ("/storeClearDetail/{storeId}/{cycleTime}/{storeName}.htm")
	public String storeClearDetail( @PathVariable String storeId , @PathVariable String cycleTime , @PathVariable String storeName ,ModelMap modelMap ){
			modelMap.put("storeId", storeId);
			modelMap.put("cycleTime", cycleTime);
			modelMap.put("storeName", storeName);
			return "finance/storecleardetail";
	}

	@ResponseBody
	@RequestMapping ("/storeClearDetail.ajax")
	public String storeClearDetailList( HttpServletRequest request ){
		String url = "/kiting/p_storeClearDetail.htm";
		RequestContent content = new RequestContent();

		JSONObject json  = null;



		Map params = JSON.parseObject(request.getParameter("map"));

		Integer page = null ==  params.get("pageNo") ? 0 : Integer.valueOf(""+params.get("pageNo"));
		Integer pageSize = null ==  params.get("pageSize") ? 0 : Integer.valueOf(""+params.get("pageSize"));

		params.put("pageNo" , PageUtil.getPageRange(page)[0]);
		params.put("pageSize",PageUtil.getPageRange(page)[1] );

		content.setBody(params);

		try {
			ResponseContent responseContent = HttpUtil.getInputStreamByPost(url,content, "utf-8");

			if(null != responseContent.getBody()) {
				json = (JSONObject) responseContent.getBody();
			}
			else {
				json = new JSONObject();
				json.put("total" , 0 );
				json.put("rows" , new ArrayList() );
			}

		} catch (Exception e) {
			logger.info("Json转错误/n",e);
		}


		return JSONObject.toJSONString(json);
	}


	@ResponseBody
	@RequestMapping ("/genClear.ajax")
	public String genClear ( HttpServletRequest  request )
	{
		String url = "/clear/p_genClear.htm";
		RequestContent content = new RequestContent();

		JSONObject json  = null;

		Map params = JSON.parseObject(request.getParameter("map"));
		Manager manager = (Manager) request.getSession().getAttribute(Constants.SESSION_USERINFO);
		params.put("clearUser" , manager.getMamangerId());
		content.setBody(params);

		try {
			ResponseContent responseContent = HttpUtil.getInputStreamByPost(url,content, "utf-8");

			if(null != responseContent.getBody()) {
				json = (JSONObject) responseContent.getBody();
			}
			else {
				json.put("total" , 0 );
				json.put("rows" , new ArrayList() );

			}

		} catch (Exception e) {
			logger.info("Json转错误/n",e);
		}

		return JSONObject.toJSONString(json);

	}


	@RequestMapping ("/storeClearTicketMana.htm")
	public String storeClearTicketMana(HttpServletRequest request, ModelMap model){
		if(request.getParameter("state") != null){
			Integer state = Integer.valueOf(request.getParameter("state"));
			model.addAttribute("indexState", state);
			return  "finance/storeclearticketmana";
		}
		model.addAttribute("indexState", "false");
		return  "finance/storeclearticketmana";
	}

	@ResponseBody
	@RequestMapping ("/storeClearTicketMana.ajax")
	public String storeClearTicketManaAjax( HttpServletRequest  request){


		String url = "/clear/p_storeClearTicket.htm";
		RequestContent content = new RequestContent();

		JSONObject json  = null;



		Map params = JSON.parseObject(request.getParameter("map"));

		Integer page = null ==  params.get("pageNo") ? 0 : Integer.valueOf(""+params.get("pageNo"));
		Integer pageSize = null ==  params.get("pageSize") ? 0 : Integer.valueOf(""+params.get("pageSize"));



		params.put("pageNo" , PageUtil.getPageRange(page)[0]);
		params.put("pageSize",PageUtil.getPageRange(page)[1] );
		content.setBody(params);

		try {
			ResponseContent responseContent = HttpUtil.getInputStreamByPost(url,content, "utf-8");

			if(null != responseContent.getBody()) {
				json = (JSONObject) responseContent.getBody();
			}
			else {
				json = new JSONObject();
				json.put("flag" , false);

			}

		} catch (Exception e) {
			logger.info("Json转错误/n",e);
		}



		return JSONObject.toJSONString(json);

	}





	@RequestMapping ("/dealClearTicket/{clearId}.htm")
	public String dealClearTicket(@PathVariable String clearId , ModelMap modelMap){


		String url = "/clear/p_dealClearTicket.htm";
		RequestContent content = new RequestContent();

		JSONObject json  = null;
		Map params = new HashMap();
		content.setBody(params);
		params.put("clearId", clearId);




		try {
			ResponseContent responseContent = HttpUtil.getInputStreamByPost(url,content, "utf-8");
			JSONObject result = (JSONObject) responseContent.getBody();

			String clearName = managerService.queryById(Long.valueOf(result.getLong("clearUser"))).getManagerName();
			modelMap.put("clearName",clearName);
			modelMap.put("result",result);
		} catch (Exception e) {
			logger.info("Json转错误/n",e);
		}
		return "finance/dealclearticket";

	}

	@ResponseBody
	@RequestMapping ("/dealClearTicketOrderList.ajax")
	public String dealClearTicketOrderList(HttpServletRequest  request){


		String url = "/clear/p_dealClearTicketOrderList.htm";
		RequestContent content = new RequestContent();

		JSONObject json  = null;

		Map params = JSON.parseObject(request.getParameter("map"));



		Integer page = null ==  params.get("pageNo") ? 0 : Integer.valueOf(""+params.get("pageNo"));
		Integer pageSize = null ==  params.get("pageSize") ? 0 : Integer.valueOf(""+params.get("pageSize"));

		params.put("pageNo" , PageUtil.getPageRange(page)[0]);
		params.put("pageSize", PageUtil.getPageRange(page)[1]);

		content.setBody(params);

		try {
			ResponseContent responseContent = HttpUtil.getInputStreamByPost(url,content, "utf-8");

			if(null != responseContent.getBody()) {
				json = (JSONObject) responseContent.getBody();
			}
			else {
				json = new JSONObject();
				json.put("total" , 0 );
				json.put("rows" , new ArrayList() );
			}

		} catch (Exception e) {
			logger.info("Json转错误/n",e);
		}


		return JSONObject.toJSONString(json);

	}

	@ResponseBody
	@RequestMapping("/saveDealClear.ajax")
	public String saveDealClear(HttpServletRequest  request)
	{
		String url = "/clear/p_saveDealClear.htm";
		RequestContent content = new RequestContent();

		JSONObject json  = null;

		Map params = JSON.parseObject(request.getParameter("map"));

		content.setBody(params);

		try {
			ResponseContent responseContent = HttpUtil.getInputStreamByPost(url,content, "utf-8");

			if(null != responseContent.getBody()) {
				json = (JSONObject) responseContent.getBody();
			}
			else {
				json.put("total" , 0 );
				json.put("rows" , new ArrayList() );

			}

		} catch (Exception e) {
			logger.info("Json转错误/n",e);
		}



		return JSONObject.toJSONString(json);

	}

	/**
	 * 生成给定账单月份内所有商家的结算单
	 */
	@ResponseBody
	@RequestMapping ("/createAllClear.ajax")
	public String createAllClear ( HttpServletRequest  request )
	{
		String url = "/clear/p_createAllClear.htm";
		RequestContent content = new RequestContent();

		JSONObject json  = null;

		Map params = JSON.parseObject(request.getParameter("map"));
		Manager manager = (Manager) request.getSession().getAttribute(Constants.SESSION_USERINFO);
		params.put("clearUser" , manager.getMamangerId());
		content.setBody(params);

		try {
			ResponseContent responseContent = HttpUtil.getInputStreamByPost(url,content, "utf-8");

			if(null != responseContent.getBody()) {
				json = (JSONObject) responseContent.getBody();
			}

		} catch (Exception e) {
			logger.info("Json转错误/n",e);
		}

		return JSONObject.toJSONString(json);

	}


}
