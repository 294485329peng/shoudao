package com.wp.project.tinyWebsite.propagete.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.wp.common.controller.BaseController;
import com.wp.common.page.PageView;
import com.wp.common.utils.HttpUtils;
import com.wp.common.utils.IsNullOrEmpty;
import com.wp.project.tinyWebsite.propagete.service.IWebProsService;
import com.wp.project.webBackground.propagate.service.IWebProService;

@Controller
@RequestMapping("/TWeb/webPros")
public class WebProsController extends BaseController {
	@Autowired
	private IWebProsService iWebProsService;
	@RequestMapping("/propagate.htmls")
	public String memberInfo(HttpServletRequest request, PageView pageView) {
		Map<String, Object> record = HttpUtils.getRequestMap(request);
		Map seTicket =  (Map) request.getSession().getAttribute("seTicket");
		String template = (String) seTicket.get("template");
		if(IsNullOrEmpty.isNullOrEmpty(record.get("PRO_ID"))){
			return "not_found";
		}
		Map map = iWebProsService.get(record.get("PRO_ID").toString());
		request.setAttribute("record",map);
		return "template/"+template+"/propagate/propogate";
	}
}
