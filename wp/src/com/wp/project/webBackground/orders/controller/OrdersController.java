package com.wp.project.webBackground.orders.controller;

import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wp.common.RetObj;
import com.wp.common.controller.BaseController;
import com.wp.common.page.PageView;
import com.wp.common.utils.HttpUtils;
import com.wp.common.utils.StringUtils;
import com.wp.project.tinyWebsite.base.service.IWebBaseService;
import com.wp.project.webBackground.goods.service.IGoodsClassService;
import com.wp.project.webBackground.goods.service.IGoodsService;
import com.wp.project.webBackground.orders.service.IOrderService;

/**
 * 
 * ClassName: ordersController
 * @Description: 订单控制
 * @author daiwk
 * @date 2016年1月27日
 */
@Controller  
@RequestMapping("/orders")
public class OrdersController extends BaseController{
	@Autowired
	private IOrderService orderService;
	@Autowired
	private IGoodsService goodsService;
	@Autowired
	private IGoodsClassService goodsClassService;
	
	@RequestMapping("/customerOrder") 
	public String customerOrder(HttpServletRequest request,PageView pageView){
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		Map loginGZH = (Map) request.getSession().getAttribute(LOGIN_IN_GZH_SESSION);
		record.put("GZH_ID", (String) loginGZH.get("GZH_ID"));
		pageView = orderService.queryPage(pageView, record);
		request.setAttribute("pageView", pageView);
		request.setAttribute("record", record);
		return "client/webBackground/orderController/customerOrder";
	}
	@RequestMapping("/orderDeal") 
	public String orderDeal(HttpServletRequest request,PageView pageView){
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		Map loginGZH = (Map) request.getSession().getAttribute(LOGIN_IN_GZH_SESSION);
		record.put("GZH_ID", (String) loginGZH.get("GZH_ID"));
		record = orderService.getOrder(pageView, record);
		pageView = (PageView) record.get("pageView");
		request.setAttribute("record", record);
		request.setAttribute("pageView", pageView);
		return "client/webBackground/orderController/orderDeal";
	}
	@RequestMapping("/orderDetail") 
	public String orderDetail(HttpServletRequest request,PageView pageView){
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		Map loginGZH = (Map) request.getSession().getAttribute(LOGIN_IN_GZH_SESSION);
		record.put("GZH_ID", (String) loginGZH.get("GZH_ID"));
		record = orderService.getOrder(pageView, record);
		pageView = (PageView) record.get("pageView");
		request.setAttribute("record", record);
		request.setAttribute("pageView", pageView);
		return "client/webBackground/orderController/orderDetail";
	}
	@RequestMapping("/update")
	@ResponseBody
	public RetObj update(HttpServletRequest request) {
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		try {
			record = orderService.update_Map(record);
			return new RetObj(true,"添加成功！",record);
		} catch (Exception e) {
			e.printStackTrace();
			if(logger.isDebugEnabled()){
				logger.error(e.getMessage());
			}
			return new RetObj(false,request);
		}
	}
	@RequestMapping("/selectDealType") 
	public String selectDealType(HttpServletRequest request,PageView pageView){
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		Map loginGZH = (Map) request.getSession().getAttribute(LOGIN_IN_GZH_SESSION);
		record.put("GZH_ID", (String) loginGZH.get("GZH_ID"));
		pageView = orderService.dealTypequeryPage(pageView, record);
		request.setAttribute("pageView", pageView);
		request.setAttribute("record", record);
		return "client/webBackground/orderController/customerOrder";
	}
	@RequestMapping("/betweenTime") 
	public String betweenTime(HttpServletRequest request,PageView pageView){
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		Map loginGZH = (Map) request.getSession().getAttribute(LOGIN_IN_GZH_SESSION);
		record.put("GZH_ID", (String) loginGZH.get("GZH_ID"));
		String START_TIME = (String) record.get("startDate")+" 00:00:00.000";
		String END_TIME = (String) record.get("endDate")+" 23:59:59.999";
		record.put("START_TIME",START_TIME);
		record.put("END_TIME",END_TIME);
		pageView = orderService.betweenTimepequeryPage(pageView, record);
		request.setAttribute("pageView", pageView);
		request.setAttribute("record", record);
		return "client/webBackground/orderController/customerOrder";
	}
	@RequestMapping("/forAddActivity") 
	public String forAddActivity(HttpServletRequest request,PageView pageView){
		return "client/webBackground/homeController/forAddActivity";
	}
}
