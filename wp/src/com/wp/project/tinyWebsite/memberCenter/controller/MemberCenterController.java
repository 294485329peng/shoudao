package com.wp.project.tinyWebsite.memberCenter.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wp.common.RetObj;
import com.wp.common.controller.BaseController;
import com.wp.common.page.PageView;
import com.wp.common.utils.HttpUtils;
import com.wp.common.utils.IsNullOrEmpty;
import com.wp.project.tinyWebsite.base.controller.WebBaseController;
import com.wp.project.tinyWebsite.base.service.IWebBaseService;
import com.wp.project.tinyWebsite.memberCenter.service.IWebMcenterService;
import com.wp.project.webBackground.memberCard.service.IMemberCardService;
import com.wp.project.webBackground.memberCenter.service.IMemberBCService;

/**
 * 
 * ClassName: BaseController
 * 
 * @Description: 首页等基本信息控制
 * @author daiwk
 * @date 2016年1月18日
 */
@Controller
@RequestMapping("/MemberCenter")
public class MemberCenterController extends BaseController {
	@Autowired
	private IWebMcenterService iWebMcenterService;
	@Autowired
	private IMemberCardService memberCardService;
	@Autowired
	private IMemberBCService memberBCService;

	@RequestMapping("/memberInfo.htmls")
	public String memberInfo(HttpServletRequest request, PageView pageView) {
		Map seTicket =  (Map) request.getSession().getAttribute("seTicket");
		String template = (String) seTicket.get("template");
	 	Map<String,Object> record = HttpUtils.getRequestMap(request);
	 	String OPEN_ID = seTicket.get("userId").toString();
	 	String GZH_ID = (String) seTicket.get("gzhId");
	 	record = iWebMcenterService.get(OPEN_ID);
	 	Map<String,Object> cardPic =  memberCardService.getPic(GZH_ID);
		if(IsNullOrEmpty.isNullOrEmpty(record)){
			return "tinyWebsite/login/login";
		}
		request.setAttribute("record",record);
		request.setAttribute("cardPic",cardPic);
		return "template/"+template+"/MemberCenter/memberInfo";
	}
	@RequestMapping("/memberDetail.htmls")
	public String memberDetail(HttpServletRequest request, PageView pageView) {
		Map seTicket =  (Map) request.getSession().getAttribute("seTicket");
		String template = (String) seTicket.get("template");
		String GZH_ID = (String) seTicket.get("gzhId");
	 	Map<String,Object> record = HttpUtils.getRequestMap(request);
	 	String OPEN_ID = seTicket.get("userId").toString();
	 	
		record = iWebMcenterService.get(OPEN_ID);
		if(IsNullOrEmpty.isNullOrEmpty(record)){
			return "tinyWebsite/login/login";
		}
		request.setAttribute("record",record);
		return "template/"+template+"/MemberCenter/memberDetail";
	}
	@RequestMapping("/dianmian.htmls") 
	public String dianmian(HttpServletRequest request){
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		Map seTicket =  (Map) request.getSession().getAttribute("seTicket");
		String template = (String) seTicket.get("template");
		
		String GZH_ID = seTicket.get("gzhId").toString();
		record = memberCardService.get(GZH_ID);
		request.setAttribute("record", record);
		return "template/"+template+"/MemberCenter/dianmian";
	}
	@RequestMapping("/tequan.htmls") 
	public String tequan(HttpServletRequest request){
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		Map seTicket =  (Map) request.getSession().getAttribute("seTicket");
		String template = (String) seTicket.get("template");
		
		String GZH_ID = seTicket.get("gzhId").toString();
		record = memberCardService.get(GZH_ID);
		request.setAttribute("record", record);
		return "template/"+template+"/MemberCenter/tequan";
	}
	@RequestMapping("/xiaofeijilu.htmls") 
	public String xiaofeijilu(HttpServletRequest request,PageView pageView){
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		Map seTicket =  (Map) request.getSession().getAttribute("seTicket");
		String template = (String) seTicket.get("template");
		record.put("OPEN_ID", seTicket.get("userId").toString());
		try {
			pageView = memberBCService.moneyRecordqueryPage(pageView, record);
		} catch (Exception e) {
			e.printStackTrace();
		}
		request.setAttribute("pageView", pageView);
		request.setAttribute("record", record);
		return "template/"+template+"/MemberCenter/xiaofeijilu";
	}
	@RequestMapping("/updatePassWord.htmls")
	public String updatePassWord(HttpServletRequest request) {
		Map seTicket =  (Map) request.getSession().getAttribute("seTicket");
		String template = (String) seTicket.get("template");
	 	
		return "template/"+template+"/MemberCenter/xiugaimima";
	}
	@RequestMapping("/meber.htmls")
	public String meber(HttpServletRequest request) {
		Map seTicket =  (Map) request.getSession().getAttribute("seTicket");
		String template = (String) seTicket.get("template");
		return "template/"+template+"/MemberList/meber";
	}
	@RequestMapping("/outLogin.htmls") 
	@ResponseBody
	public RetObj outLogin(HttpServletRequest request,HttpSession session){
		Map seTicket =  (Map) request.getSession().getAttribute("seTicket");
		String template = (String) seTicket.get("template");
		if(session!=null) {
			
			seTicket.remove("userId");
			
			session.setAttribute("seTicket", seTicket);
		}
		return new RetObj(true);
	}
}
