package com.wp.project.tinyWebsite.administrator.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wp.base.ac.ac_operator.service.IAcOperatorService;
import com.wp.common.RetObj;
import com.wp.common.consts.CommonConsts;
import com.wp.common.consts.GlobMessageKeys;
import com.wp.common.controller.BaseController;
import com.wp.common.page.PageView;
import com.wp.common.utils.HttpUtils;
import com.wp.common.utils.IsNullOrEmpty;
import com.wp.project.tinyWebsite.base.service.IWebBaseService;
import com.wp.project.tinyWebsite.memberLogin.service.IMemberLoginService;

/**
 * 
 * ClassName: BaseController
 * @Description: 首页等基本信息控制
 * @author daiwk
 * @date 2016年1月18日
 */
@Controller  
@RequestMapping("/TWebLogin/AdministratorsLogin")
public class AdministratorsLoginController extends BaseController{
	@Autowired
	private IMemberLoginService memberLoginService;
	@Autowired
	private IAcOperatorService acOperatorService;
	
	@RequestMapping("/login.htmls") 
	public String login(HttpSession session){
		Map seTicket =  (Map) session.getAttribute("seTicket");
		String template = (String) seTicket.get("template");
		return "template/"+template+"/administrators/login";
	}
	@RequestMapping("/loginCheck.htmls")
	@ResponseBody
	public RetObj loginCheck(HttpServletRequest request, HttpServletResponse response, String userId,String password) {
		
		//先注销
		HttpSession session = request.getSession();
		/*ServletContext application =session.getServletContext(); */
		Map seTicket = (Map) session.getAttribute("seTicket");
		Map acOperatorMap=null;
		try {
			acOperatorMap = acOperatorService.checkLogin(userId, password);;
			
			if (acOperatorMap == null) {
				return new RetObj(false, "用户不存在或密码错误！");
			}else{
				seTicket.put("userId", acOperatorMap.get("OPERATOR_ID"));
				session.setAttribute("seTicket", seTicket);
	        }
			
		} catch (Exception e) { 
			e.printStackTrace(); 
			if(logger.isDebugEnabled()){
				logger.error(e.getMessage());
			}
			return new RetObj(false, "抱歉，服务异常，稍后再试！");
		} 
		acOperatorMap.put("url", "/TWebLogin/Administrators/MemberList.htmls");
		return new RetObj(true,"登录成功！即将跳转...",acOperatorMap);
	}
	
}
