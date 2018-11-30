package com.wp.project.tinyWebsite.activities.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.wp.common.controller.BaseController;
import com.wp.common.page.PageView;
import com.wp.common.utils.HttpUtils;
import com.wp.project.tinyWebsite.activities.service.ITinyActivityService;
import com.wp.project.tinyWebsite.base.service.IWebBaseService;
import com.wp.project.tinyWebsite.goods.service.IGoodsService;
@Controller  
@RequestMapping("/TWeb/act")
public class TinyActivitiesController extends BaseController{
	@Autowired
	private IGoodsService goodsService;
	@Autowired
	private ITinyActivityService tinyActivityService;
	@RequestMapping("/list.htmls") 
	public String forHome(HttpServletRequest request,PageView pageView){
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		Map seTicket =  (Map) request.getSession().getAttribute("seTicket");
		record.put("GZH_ID", seTicket.get("gzhId"));
		String template = (String) seTicket.get("template");
		pageView = tinyActivityService.queryPage(pageView, record);
		request.setAttribute("pageView", pageView);
		request.setAttribute("record", record);
		return "template/"+template+"/activity/activityList";
	}
	@RequestMapping("/forActivity") 
	public String forActivity(HttpServletRequest request,String ACTIVITY_ID){
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		Map seTicket =  (Map) request.getSession().getAttribute("seTicket");
		String template = (String) seTicket.get("template");
		record = tinyActivityService.get(ACTIVITY_ID);
		if("1".equals(record.get("RESPONSE").toString())){
			Map goods = new HashMap();
			goods.put("GOODS_ID", record.get("RESPONSE_ID"));
			goods = goodsService.getGoods(goods);
			List goodsList = goodsService.query(goods);
			request.setAttribute("goods", goods);
			request.setAttribute("goodsList", goodsList);
			return "template/"+template+"/goods/goodsDetail";
		}
		request.setAttribute("record", record);
		return "template/"+template+"/activity/forActivity";
	}
}
