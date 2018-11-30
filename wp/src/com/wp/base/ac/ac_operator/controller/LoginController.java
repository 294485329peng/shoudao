/**   
 * @Title: LoginControler.java
 * @Package org.wp.yee.ac.ac_operator.controler
 * @Description: TODO(用一句话描述该文件做什么)
 * @author daiwk   2013-5-21 下午1:53:20
 */
package com.wp.base.ac.ac_operator.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wp.base.ac.ac_function.service.IAcFunctionService;
import com.wp.base.ac.ac_home_module.service.IAcHomeModuleService;
import com.wp.base.ac.ac_menu.service.IAcMenuService;
import com.wp.base.ac.ac_operator.service.IAcOperatorService;
import com.wp.base.om.om_employee.service.IOmEmployeeService;
import com.wp.common.RetObj;
import com.wp.common.cSession.CSession;
import com.wp.common.cSession.SessionUser;
import com.wp.common.consts.CommonConsts;
import com.wp.common.consts.GlobMessageKeys;
import com.wp.common.controller.BaseController;
import com.wp.common.utils.StringUtils;
import com.wp.project.businessManagement.Subscription.service.ISubscriptionService;

/**
 * @ClassName: LoginControler
 * @Description: 控制登录相关
 * @author daiwk 2015年8月21日18:33:44
 */
@Controller
public class LoginController extends BaseController {
	@Autowired
	private IAcOperatorService acOperatorService;
	@Autowired
	private IOmEmployeeService omEmployeeService;
	
	@Autowired
	private IAcMenuService acMenuService;
	@Autowired
	private IAcFunctionService acFunctionService;
	@Autowired
	private IAcHomeModuleService acHomeModuleService;
	
	@Autowired
	private ISubscriptionService subscriptionService;
	
	@RequestMapping("/loginCheck")
	@ResponseBody
	public RetObj loginCheck(HttpServletRequest request, HttpServletResponse response, String userId,String password) {
		
		//先注销
		HttpSession session=request.getSession();
		/*ServletContext application =session.getServletContext(); */
		Map acOperatorMap=null;
		try {
			acOperatorMap = acOperatorService.checkLogin(userId, password);
			 
			if (acOperatorMap == null) {
				return new RetObj(false,GlobMessageKeys.LOGIN_WRONG_INFO, request);
	        }else if(!CommonConsts.OPERATOR_STATUS_NORMAL.equals(acOperatorMap.get("STATUS"))){//判断只有在岗的用户才可以登录
	        	return new RetObj(false,GlobMessageKeys.LOGIN_NO_PERMISSION, request);
			}else{
				/**保存用户session信息*/
				//账号登录信息
				CSession cs = new CSession();
				session.setAttribute(LOGIN_IN_OPERATOR_SESSION, acOperatorMap);
				cs.setOperatorId(acOperatorMap.get("OPERATOR_ID").toString());
				//要从后台获得数据。。。
				String OPERATOR_ID = acOperatorMap.get("OPERATOR_ID").toString();
				Map gzhMap = subscriptionService.getGzhOpera(OPERATOR_ID);
				//if(gzhMap != null && gzhMap.get("GZH_ID") != null && gzhMap.get("GZH_AUTH_STATUS").equals("1")){
				if(gzhMap != null && gzhMap.get("GZH_ID") != null){
					//session.setAttribute(LOGIN_IN_GZH_SESSION,paramMap);
					//session.setAttribute("GZH_ID",gzhMap.get("GZH_ID").toString());
					//session.setAttribute("GZH_APPID", gzhMap.get("GZH_APPID").toString());
					
					//session.setAttribute("GZH_APPSECRET", gzhMap.get("GZH_APPSECRET").toString());
					//cs.setGzhAppSecret(gzhMap.get("GZH_APPSECRET").toString());
					//session.setAttribute("C_SESSION",paramMap);
					
					session.setAttribute(LOGIN_IN_GZH_SESSION, gzhMap);
					cs.setGzhAppId(gzhMap.get("GZH_APPID").toString());
					cs.setGzhId(gzhMap.get("GZH_ID").toString());
					session.setAttribute("C_SESSION",cs);
					
				}else{
					cs.setGzhAppId(null); 
					cs.setGzhAppSecret(null);
					cs.setGzhId(null);
					session.setAttribute("C_SESSION",cs);
					//session.setAttribute("C_SESSION",paramMap);
				}
				 
				
//				//对应EMP信息
//				Map paramMap = new HashMap();
//				String operatorId = acOperatorMap.get("OPERATOR_ID").toString();
//				paramMap.put("OPERATOR_ID", operatorId);
//				
//				List employeeMapList = omEmployeeService.query(paramMap);
//				if(!CollectionUtils.isEmpty(employeeMapList)) {
//					session.setAttribute(LOGIN_IN_EMP_SESSION, employeeMapList.get(0));
//				}
//				//拥有的资源
//				List permittedFuncionts = acFunctionService.queryPermitted(paramMap);
//				session.setAttribute(LOGIN_IN_OPERATOR_RESOURCES_SESSION, permittedFuncionts);
		        	
	        }
		} catch (Exception e) { 
			e.printStackTrace(); 
			if(logger.isDebugEnabled()){
				logger.error(e.getMessage());
			}
			return new RetObj(false,GlobMessageKeys.LOGIN_SYS_ERR, request);
		} 
		
		return new RetObj(true);
	}
	
	private void reloadSession(HttpServletRequest request) {
		HttpSession session=request.getSession();
		//账号登录信息
		Map acOperatorMap = (Map)session.getAttribute(LOGIN_IN_OPERATOR_SESSION);
		//对应EMP信息
		Map paramMap = new HashMap();
		String operatorId = acOperatorMap.get("OPERATOR_ID").toString();
		paramMap.put("OPERATOR_ID", operatorId);
		
		List employeeMapList = omEmployeeService.query(paramMap);
		if(!CollectionUtils.isEmpty(employeeMapList)) {
			session.setAttribute(LOGIN_IN_EMP_SESSION, employeeMapList.get(0));
		}
		//拥有的资源
		List permittedFuncionts = acFunctionService.queryPermitted(paramMap);
		session.setAttribute(LOGIN_IN_OPERATOR_RESOURCES_SESSION, permittedFuncionts);
	}
	
	@RequestMapping("/login")
	public String login(HttpSession session) {
		SessionUser.clearSessionUser();
		if(session!=null) {
			session.removeAttribute(LOGIN_IN_OPERATOR_SESSION);
			session.removeAttribute(LOGIN_IN_EMP_SESSION);
			session.removeAttribute(LOGIN_IN_OPERATOR_RESOURCES_SESSION);
			session.removeAttribute("C_SESSION");
			session.removeAttribute(LOGIN_IN_GZH_SESSION); 
			session.invalidate();
		}
		return "login";
	}
	
	@RequestMapping("/main")
	public String main(HttpServletRequest request) {
		reloadSession(request);
		return "main";
	}
	
	@RequestMapping("/top")
	public String top(HttpServletRequest request) {
		Map paramMap = new HashMap();
		paramMap.put("MENU_LEVEL", "1");

		String operatorId = getOperatorIdFromRequest(request);
		paramMap.put("OPERATOR_ID", operatorId);
		//此处应有APP_ID获取，设为查询参数
		
		List<Map> topMenuList = acMenuService.queryPermitted(paramMap);
		request.setAttribute("topMenuList", topMenuList);
		return "top";
	}
	@RequestMapping("/left")
	public String left(HttpServletRequest request,String pId,String pName) {
		Map paramMap = new HashMap();
		paramMap.put("PARENT_ID", pId);
		String operatorId = getOperatorIdFromRequest(request);
		paramMap.put("OPERATOR_ID", operatorId);
		//此处应有APP_ID获取，设为查询参数
		if(!StringUtils.isEmpty(pId)) {
			List<Map> leftMenuList = acMenuService.queryPermitted(paramMap);
			request.setAttribute("leftMenuList", leftMenuList);
			request.setAttribute("pName", pName);
		}else {
			paramMap.put("PARENT_ID", "60b851b6-7527-4494-9674-e638168e7e6a");
			pName = "用户管理";
			List<Map> leftMenuList = acMenuService.queryPermitted(paramMap);
			request.setAttribute("leftMenuList", leftMenuList);
			request.setAttribute("pName", pName);
			//request.setAttribute("pName", "首页");
		}
		
		return "left";
	}
	@RequestMapping("/welcome")
	public String welcome() {
		return "welcome";
	}
	@RequestMapping("/notFound")
	public String notFound() {
		return "not_found";
	}
	@RequestMapping("/home")
	public String home(HttpServletRequest request) {
		/*if(SessionUser.getSessionUserMap() == null){
			System.out.println("1111");
		}else{
			
			System.out.println(SessionUser.getSessionUserMap().get("OPERATOR_ID"));
		}*/
		/*if(SessionUser.getSessionUser() == null){
			System.out.println("null");
		}else{
			System.out.println(SessionUser.getSessionGzhId());
		}*/
		//System.out.println(SessionUser.getSessionOperatorId());
		Map loginGZH = (Map) request.getSession().getAttribute(LOGIN_IN_GZH_SESSION);
		if(loginGZH == null ||  "0".equals(loginGZH.get("GZH_AUTH_STATUS").toString())){
			return "client/Subscription/forAddSubscription";
		}
		String ADMIN_ID = loginGZH.get("ADMIN_ID").toString();
		Map record =  subscriptionService.get(ADMIN_ID);
		request.setAttribute("record", record);
		return "Copyhome";
	}
	/*@RequestMapping("/home")
	public String home(HttpServletRequest request) {
		String operatorId = getOperatorIdFromRequest(request);
		Map paramMap = new HashMap();
		paramMap.put("OPERATOR_ID", operatorId);

		//1、获取自定义列表
		List<Map> operHomeModuleViewList = acHomeModuleService.queryOperHomeModule(paramMap);
		List<Map> allPermHomeModuleViewList = new ArrayList<Map>();
		if(CollectionUtils.isEmpty(operHomeModuleViewList)) {
			operHomeModuleViewList =  acHomeModuleService.queryOperRoleHomeModule(paramMap);
			allPermHomeModuleViewList = new ArrayList<Map>(operHomeModuleViewList);
			//Collections.copy(allPermHomeModuleViewList, operHomeModuleViewList);
			for(Map record:allPermHomeModuleViewList) {
				record.put("CHECKED", "true");
			}
		}else {
			allPermHomeModuleViewList = acHomeModuleService.queryOperRoleHomeModule(paramMap);
			for(Map recorda:allPermHomeModuleViewList) {
				for(Map recordo:operHomeModuleViewList) {
					if(recordo.get("HOME_MODULE_ID").equals(recorda.get("HOME_MODULE_ID"))) {
						recorda.put("CHECKED", "true");
						break;
					}
				}
				
			}
		}
		request.setAttribute("operHomeModuleViewList", operHomeModuleViewList);
		request.setAttribute("allPermHomeModuleViewList", allPermHomeModuleViewList);
		//2、编辑时 获取权限列表   已设置check
		
		return "home";
	}*/
	@RequestMapping("/right")
	public String right() {
		return "right";
	}
	@RequestMapping("/index")
	public String index() {
		return "index";
	}
	@RequestMapping("/footer")
	public String footer() {
		return "footer";
	}
	@RequestMapping("/sessionTimeOut")
	public String sessionTimeOut(HttpServletRequest request) {
		return "sessionTimeOut";
	}
	@RequestMapping("/noPermission")
	public String noPermission(HttpServletRequest request) {
		return "noPermission";
	}
}
