package com.wp.project.tinyWebsite.memberCenter.controller;

import java.util.Map;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.wp.common.controller.BaseController;
import com.wp.common.page.PageView;
import com.wp.common.utils.HttpUtils;
import com.wp.project.tinyWebsite.base.service.IWebBaseService;
import com.wp.project.tinyWebsite.memberCenter.service.IWebMFinishOrderService;

/**
 * 
 * ClassName: BaseController
 * 
 * @Description: 首页等基本信息控制
 * @author daiwk
 * @date 2016年1月18日
 */
@Controller
@RequestMapping("/Center/MemberFinishOrder")
public class MemberFinishOrderController extends BaseController {
	@Autowired
	private IWebMFinishOrderService iWebMFinishOrderService;

	@RequestMapping("/ListAll.htmls")
	public String ListAll(HttpServletRequest request, PageView pageView) {
		Map seTicket =  (Map) request.getSession().getAttribute("seTicket");
		String template = (String) seTicket.get("template");
	 	Map<String,Object> record = HttpUtils.getRequestMap(request);
	 	String OPEN_ID = seTicket.get("userId").toString();
		pageView.setPageSize(5);
		record.put("OPEN_ID", OPEN_ID);
		List list = iWebMFinishOrderService.getOrder(record, pageView);
		request.setAttribute("record", list);
		request.setAttribute("map", record);
		return "template/"+template+"/MemberCenter/FinishOrder";
	}

	@RequestMapping("/List.htmls")
	public String List(HttpServletRequest request, PageView pageView) {
		Map seTicket =  (Map) request.getSession().getAttribute("seTicket");
		String template = (String) seTicket.get("template");
	 	Map<String,Object> record = HttpUtils.getRequestMap(request);
	 	String OPEN_ID = seTicket.get("userId").toString();
		pageView.setPageSize(5);
		// iWebMFinishOrderService.queryPage(pageView, record);
		record.put("OPEN_ID", OPEN_ID);
		List list = iWebMFinishOrderService.getOrderByType(record, pageView);
		request.setAttribute("list", list);
		request.setAttribute("record", record);
		return "template/"+template+"/MemberCenter/FinishOrder";
	}
}
