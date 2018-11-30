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
import com.wp.common.consts.CommonConsts;
import com.wp.common.consts.GlobMessageKeys;
import com.wp.common.controller.BaseController;
import com.wp.common.utils.HttpUtils;
import com.wp.common.utils.StringUtils;
import com.wp.project.businessManagement.Subscription.service.ISubscriptionService;

/**
 * @ClassName: LoginControler
 * @Description: 控制登录相关
 * @author daiwk 2015年8月21日18:33:44
 */
@Controller
public class RegisterController extends BaseController {
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
	
	@RequestMapping("/registerCheck")
	@ResponseBody
	public RetObj registerCheck(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> record = HttpUtils.getRequestMap(request);
		//先注销
		Map errorRecord = new HashMap();
		try {
			int i = omEmployeeService.register(record);
			if (i == -254) {
				errorRecord.put("errorInfo", "-254");
				return new RetObj(false,"用户名已经注册！", errorRecord);
			}else if(i == 1){
		        return new RetObj(true);
	        }else{
	        	errorRecord.put("errorInfo", "0");
	        	return new RetObj(false,"注册信息出错，请修正信息", errorRecord);
	        }
		} catch (Exception e) { 
			e.printStackTrace(); 
			if(logger.isDebugEnabled()){
				logger.error(e.getMessage());
			}
			return new RetObj(false,"出现异常，请稍后再试！", request);
		} 
	}
	@RequestMapping("/register")
	public String register(HttpSession session) {
		if(session!=null) {
			session.removeAttribute(LOGIN_IN_OPERATOR_SESSION);
			session.removeAttribute(LOGIN_IN_EMP_SESSION);
			session.removeAttribute(LOGIN_IN_OPERATOR_RESOURCES_SESSION);
			//session.removeAttribute(LOGIN_IN_GZH_SESSION); 以后要用这个不用下面那个
			session.removeAttribute("GZH_ID");
			session.removeAttribute("GZH_APPID");
			session.removeAttribute("GZH_APPSECRET");
		}
		return "register";
	}
	
}
