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
@RequestMapping("/TWebLogin/Administrators")
public class AdministratorsController extends BaseController{
	@Autowired
	private IMemberLoginService memberLoginService;
	
	
	@RequestMapping("/MemberList.htmls") 
	public String MemberList(HttpSession session){
		Map seTicket =  (Map) session.getAttribute("seTicket");
		String template = (String) seTicket.get("template");
		return "template/"+template+"/MemberList/memberList";
	}
	
}
