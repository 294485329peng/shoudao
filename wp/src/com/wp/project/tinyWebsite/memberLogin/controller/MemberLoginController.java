package com.wp.project.tinyWebsite.memberLogin.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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
@RequestMapping("/TWebLogin/Member")
public class MemberLoginController extends BaseController{
	@Autowired
	private IMemberLoginService memberLoginService;
	/*@Autowired
	private IBaseService baseService;*/
	
	@RequestMapping("/login.htmls") 
	public String login(HttpSession session){
		Map seTicket =  (Map) session.getAttribute("seTicket");
		String template = (String) seTicket.get("template");
		return "template/"+template+"/login/login";
	}
	@RequestMapping("/register.htmls") 
	public String register(HttpServletRequest request){
		Map seTicket =  (Map) request.getSession().getAttribute("seTicket");
		String template = (String) seTicket.get("template");
		return "template/"+template+"/login/register";
	}
	@RequestMapping("/loginCheck.htmls")
	@ResponseBody
	public RetObj loginCheck(HttpServletRequest request, HttpServletResponse response, String userId,String password) {
		
		//先注销
		HttpSession session = request.getSession();
		/*ServletContext application =session.getServletContext(); */
		Map seTicket = (Map) session.getAttribute("seTicket");
		Map tWebMemberMap = new HashMap();
		try {
			tWebMemberMap = memberLoginService.checkLogin(userId, password);
			
			if (tWebMemberMap == null) {
				return new RetObj(false, "用户不存在！");
			}else{
				/**保存用户session信息*/
				//账号登录信息
				if(! IsNullOrEmpty.isNullOrEmpty(tWebMemberMap.get("msg")) ){
					return new RetObj(false,tWebMemberMap.get("msg").toString());
				}
				seTicket.put("userId", tWebMemberMap.get("customer"));
				session.setAttribute("seTicket", seTicket);
	        }
			
		} catch (Exception e) { 
			e.printStackTrace(); 
			if(logger.isDebugEnabled()){
				logger.error(e.getMessage());
			}
			return new RetObj(false, "抱歉，服务异常，稍后再试！");
		} 
		tWebMemberMap.put("url", "/MemberCenter/memberInfo.htmls");
		return new RetObj(true,"登录成功！即将跳转...",tWebMemberMap);
	}
	@RequestMapping("/addMember.htmls")
	@ResponseBody
	public RetObj addMember(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> record = HttpUtils.getRequestMap(request);
		HttpSession session = request.getSession();
		Map seTicket = (Map) session.getAttribute("seTicket");
		try {
		Map user = memberLoginService.get(record.get("LOGIN_NAME").toString());
		if(IsNullOrEmpty.isNullOrEmpty(user)){
			record.put("GZH_ID", seTicket.get("gzhId"));
			record = memberLoginService.insert_map(record);
		}else{
			return new RetObj(false, "账户名已被使用！");
		}
		
		} catch (Exception e) { 
			e.printStackTrace();
			return new RetObj(false, "抱歉，服务异常，稍后再试！"); 
		}
		
		seTicket.put("userId", record.get("OPEN_ID"));
		session.setAttribute("seTicket", seTicket);
		record.put("url", "/MemberCenter/memberInfo.htmls");
		return new RetObj(true,"注册成功！即将跳转...",record);
	}
	@RequestMapping("/updateMemberInfo.htmls")
	@ResponseBody
	public RetObj updateMemberInfo(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> record = HttpUtils.getRequestMap(request);
		HttpSession session = request.getSession();
		Map seTicket = (Map) session.getAttribute("seTicket");
		String OPEN_ID = seTicket.get("userId").toString();
		record.put("OPEN_ID", OPEN_ID);
		try {
		int i = memberLoginService.update(record);
		if(i>0){
			return new RetObj(true, "更新成功！");
		}else{
			return new RetObj(false, "更新失败！");
		}
		} catch (Exception e) { 
			e.printStackTrace();
			return new RetObj(false, "抱歉，服务异常，稍后再试！"); 
		}
		
	}
	@RequestMapping("/updatePassWord.htmls")
	@ResponseBody
	public RetObj updatePassWord(HttpServletRequest request) {
		Map<String, Object> record = HttpUtils.getRequestMap(request);
		HttpSession session = request.getSession();
		Map seTicket = (Map) session.getAttribute("seTicket");
		String OPEN_ID = seTicket.get("userId").toString();
		record.put("OPEN_ID", OPEN_ID);
		try {
		int i = memberLoginService.updatePassWord(record);
		if(i>0 && i<50){
			return new RetObj(true, "更新成功！");
		}else if(i == 100){
			return new RetObj(false, "初始密码错误！");
		}else{
			return new RetObj(false, "更新失败！");
		}
		} catch (Exception e) { 
			e.printStackTrace();
			return new RetObj(false, "抱歉，服务异常，稍后再试！"); 
		}
		
	}
}
