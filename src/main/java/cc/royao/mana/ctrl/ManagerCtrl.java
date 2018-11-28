package cc.royao.mana.ctrl;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import cc.royao.commons.formbean.MapVo;
import cc.royao.mana.auth.model.Manager;
import cc.royao.mana.auth.model.Privilege;
import cc.royao.mana.auth.model.Role;
import cc.royao.mana.auth.service.manager.ManagerService;
import cc.royao.mana.auth.service.role.RoleSevice;

import cc.royao.common.Constants;
import cc.royao.common.PrivateTypeEnum;
import cc.royao.common.StatusEnum;

import org.apache.commons.codec.digest.Md5Crypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import cc.royao.utils.CookieUtil;
import cc.royao.utils.DateUtil;
import cc.royao.utils.PageUtil;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.sql.SQLException;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * Created by libia on 2016/1/19.
 */

@Controller
@RequestMapping("/mana")
public class ManagerCtrl extends BaseCtrl {

	public static Integer maxAge = 60 * 60 * 24 * 7; // 单位：秒

	private Manager manager;

	public void setManager(Manager manager) {
		this.manager = manager;
	}

	@Autowired
	private ManagerService managerService;

	@Autowired
	private RoleSevice roleSevice;

	@RequestMapping(value = "/login.htm")
	public String Login(@ModelAttribute ModelMap modelMap ,@RequestParam String managerLoginName,
			@RequestParam String managerLoginPwd, HttpServletResponse response,
			HttpServletRequest request) {
		try {
			String ip = getIp(request);

//			Manager manager = managerService.managerLogin(managerLoginName,
//					managerLoginPwd, ip);
//
//
//			if (null != manager) {
//				request.getSession().setAttribute(Constants.SESSION_USERINFO,
//						manager);
//				generateManagerPrivilegeExpress(request);
//				String rememberMe = request.getParameter("rememberMe");
//				if ("1".equals(rememberMe)) {
//					CookieUtil.saveCookie(managerLoginName, managerLoginPwd,
//							response); // 之前的老方法
//				} else {
//					CookieUtil.clearCookie(response);
//				}
				return "redirect:/index.htm";
//			} else {
//				modelMap.put("error", "用户名或密码错误");
//			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		Map<String, Cookie> cookieMap = CookieUtil.ReadCookieMap(request);
		if (cookieMap.containsKey("userInfo")) {
			Cookie cookie = (Cookie) cookieMap.get("userInfo");
			if (!cookie.getValue().equals("")) {
				JSONObject userInfo = JSONObject.parseObject(cookie.getValue());

				modelMap.put("managerLoginName", userInfo.get("managerLoginName"));
				modelMap.put("managerLoginName", userInfo.get("managerLoginName"));
				modelMap.put("rememberMe", userInfo.get("rememberMe"));

			}
		}

		return "manager/login";
	}

	@RequestMapping("/logout.htm")
	public String logout(HttpServletRequest request,
			HttpServletResponse response, ModelMap map) {
		request.getSession().removeAttribute(Constants.SESSION_USERINFO);
		// CookieUtil.clearCookie(response);
		Map<String, Cookie> cookieMap = CookieUtil.ReadCookieMap(request);
		if (cookieMap.containsKey("userInfo")) {
			Cookie cookie = (Cookie) cookieMap.get("userInfo");
			if (!cookie.getValue().equals("")) {
				JSONObject userInfo = JSONObject.parseObject(cookie.getValue());

				map.put("managerLoginName", userInfo.get("managerLoginName"));
				map.put("managerLoginName", userInfo.get("managerLoginName"));
				map.put("rememberMe", userInfo.get("rememberMe"));

			}
		}
		return "redirect:/login.htm";
	}

	private void generateManagerPrivilegeExpress(HttpServletRequest request) {
		StringBuffer privilegeBuffer = new StringBuffer("");
		Manager manager = (Manager) request.getSession().getAttribute(
				Constants.SESSION_USERINFO);

		Set<String> privilegeSet = new HashSet();

		if (null != manager.getRole() && manager.getRole().size() > 0) {
			List<Role> roles = manager.getRole();
			for (int i = 0; i < roles.size(); i++) {
				Role role = roles.get(i);
				if (null != role.getPrivileges()
						&& role.getPrivileges().size() > 0) {

					List<Privilege> privilegeList = role.getPrivileges();

					for (int j = 0; j < privilegeList.size(); j++) {

						Privilege privilege = privilegeList.get(j);

						if (privilege.getPrivilegeType() == PrivateTypeEnum.MENU
								&& privilege.getMenuId() != null) {

							privilegeBuffer.append("[" + privilege.getMenuId()
									+ "]");

						}

					}
				}

			}

		}

		request.getSession().setAttribute(Constants.SESSION_PRIVILEGEINFO,
				privilegeBuffer);

	}

	@RequestMapping("/list.htm")
	public String list(MapVo map) {

		return "system/adminmanage";

	}

	@ResponseBody
	@RequestMapping(value = "/list.ajax", produces = { "application/json;charset=UTF-8" })
	public String listAllPriviage(HttpServletRequest request) {

		MapVo mapVo = new MapVo();
		mapVo.setMap(JSON.parseObject(request.getParameter("map")));
		Map params = mapVo.getMap();

		Integer page = null == params.get("pageNo") ? 0 : Integer.valueOf(""
				+ params.get("pageNo"));
		Integer pageSize = null == params.get("pageSize") ? 0 : Integer
				.valueOf("" + params.get("pageSize"));

		params.put("begin", PageUtil.getPageRange(page)[0]);
		params.put("end", PageUtil.getPageRange(page)[1]);

		List l = null;
		Long count = 0l;
		try {
			l = managerService.getAllManage(params);
			count = managerService.queryAllCount();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		JSONObject jsonObject = new JSONObject();
		jsonObject.put("total", count);
		jsonObject.put("rows", l);
		return JSONObject.toJSONString(jsonObject);
	}

	@RequestMapping("/initAdd.htm")
	public String initAdd(ModelMap modelMap) {

		List roles = null;
		try {
			roles = roleSevice.getAllRole();
		} catch (Exception e) {
			e.printStackTrace();
		}
		modelMap.put("roles", roles);
		return "system/addadmin";

	}

	@RequestMapping("/add.htm")
	public String add(MapVo mapVo) {
		Map map = mapVo.getMap();

		Manager manager = new Manager();

		String roles = "";
		if (null != map.get("loginName"))
			manager.setManagerLoginName((String) map.get("loginName"));
		if (null != map.get("loginPwd"))
			manager.setManagerLoginPwd((String) map.get("loginPwd"));
		if (null != map.get("name"))
			manager.setManagerName((String) map.get("name"));
		if (null != map.get("phone"))
			manager.setManagerPhone((String) map.get("phone"));
		if (null != map.get("qq"))
			manager.setManagerQQ((String) map.get("qq"));
		if (null != map.get("mail"))
			manager.setManagerMail((String) map.get("mail"));

		if (null != map.get("remark"))
			manager.setManagerRemark((String) map.get("remark"));

		if (null != map.get("role"))
			roles = (String) map.get("role");

		manager.setManagerCt(DateUtil.format("yyyy-MM-dd"));
		manager.setManagerStatue(StatusEnum.N);

		boolean flag = false;
		try {

			managerService.addManager(manager, roles);
			// flag = roleSevice.addRole(role, privileges);
		} catch (Exception e) {
			e.printStackTrace();
		}
		if (flag)
			return "forward:/manager/list.htm";
		else
			return "forward:/manager/list.htm";

	}

	@ResponseBody
	@RequestMapping(value = "/delete/{roleId}.htm")
	public String delete(@PathVariable String managerId) {
		boolean flag = false;
		if (null != managerId) {
			try {
				flag = managerService.deleteManager(Long.valueOf(managerId));
			} catch (Exception e) {
				e.printStackTrace();
			}

		}

		JSONObject jsonObject = new JSONObject();
		jsonObject.put("flag", flag);
		return jsonObject.toString();
	}

	@RequestMapping(value = "/update.htm")
	public String update(HttpServletRequest request, MapVo mapVo) {

		Map map = mapVo.getMap();
		boolean flag = false;
		if (null != map.get("managerId")) {
			Manager manager = null;
			try {
				manager = managerService.queryById(Long.valueOf((String) map
						.get("managerId")));

				String roles = "";
				if (null != map.get("loginName"))
					manager.setManagerLoginName((String) map.get("loginName"));
				if (null != map.get("loginPwd"))
					manager.setManagerLoginPwd((String) map.get("loginPwd"));
				if (null != map.get("name"))
					manager.setManagerName((String) map.get("name"));
				if (null != map.get("phone"))
					manager.setManagerPhone((String) map.get("phone"));
				if (null != map.get("qq"))
					manager.setManagerQQ((String) map.get("qq"));
				if (null != map.get("mail"))
					manager.setManagerMail((String) map.get("mail"));

				if (null != map.get("remark"))
					manager.setManagerRemark((String) map.get("remark"));

				if (null != map.get("role"))
					roles = (String) map.get("role");

				// manager.setManagerCt(DateUtil.format("yyyy-MM-dd"));
				if (null != map.get("managerStatue")){
					if(map.get("managerStatue").equals("Y"))
						manager.setManagerStatue(StatusEnum.Y);
					if(map.get("managerStatue").equals("N"))
						manager.setManagerStatue(StatusEnum.N);
					if(map.get("managerStatue").equals("D"))
						manager.setManagerStatue(StatusEnum.D);
				}

				managerService.updateManager(manager, roles);
				// flag = roleSevice.addRole(role, privileges);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		if (flag)
			return "forward:/manager/list.htm";
		else
			return "forward:/manager/list.htm";

	}

	@RequestMapping("/update/{managerId}.htm")
	public String update(@PathVariable String managerId, ModelMap modelMap) {

		try {

			List roles = roleSevice.getAllRole();
			modelMap.put("roles", roles);
			Manager manager = null;

			manager = managerService.queryById(Long.valueOf(managerId));
			modelMap.put("manager", manager);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return "system/editadmin";
	}

	@RequestMapping("/noprivilege.htm")
	public String noPrivilege(HttpServletResponse response,
			HttpServletRequest request) {

		return "noprivilege";
	}
}
