package com.wp.project.tinyWebsite.order.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wp.common.RetObj;
import com.wp.common.consts.CommonConsts;
import com.wp.common.consts.GlobMessageKeys;
import com.wp.common.controller.BaseController;
import com.wp.common.page.PageView;
import com.wp.common.utils.HttpUtils;
import com.wp.project.tinyWebsite.base.service.IWebBaseService;
import com.wp.project.tinyWebsite.memberLogin.service.IMemberLoginService;
import com.wp.project.tinyWebsite.order.service.ITinyOrderService;
import com.wp.project.tinyWebsite.shopCart.service.IShopCartService;

/**
 * 
 * ClassName: BaseController
 * @Description: 首页等基本信息控制
 * @author daiwk
 * @date 2016年1月18日
 */
@Controller  
@RequestMapping("/TWeb/order")
public class TinyOrderController extends BaseController{
	@Autowired
	private ITinyOrderService tinyOrderService;

	@RequestMapping(value="/addOrder.htmls",produces="application/json",method=RequestMethod.POST)
	@ResponseBody
	public RetObj addOrder(HttpServletRequest request,@RequestBody Map orderMap) {
		try{
		Map<String,Object> record = orderMap;
		Map seTicket =  (Map) request.getSession().getAttribute("seTicket");
		record.put("GZH_ID",seTicket.get("gzhId"));
	 	record.put("OPEN_ID",seTicket.get("userId"));
			record = tinyOrderService.insert_map(record);
			return new RetObj(true,"操作成功！",record);
		} catch (Exception e) {
			e.printStackTrace();
			if(logger.isDebugEnabled()){
				logger.error(e.getMessage());
			}
			return new RetObj(false,"服务异常！");
		}
	}
	@RequestMapping("/tinyOrderForm.htmls") 
	public String forGoodsDetail(HttpServletRequest request,String ORDER_ID){
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		Map seTicket =  (Map) request.getSession().getAttribute("seTicket");
		String template = (String) seTicket.get("template");
		record = tinyOrderService.get(ORDER_ID);
		request.setAttribute("record", record);
		return "template/"+template+"/order/orderForm";
	}
	@RequestMapping(value="/updateOrder.htmls")
	@ResponseBody
	public RetObj updateOrder(HttpServletRequest request) {
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		try{
			String ORDER_ID = (String) record.get("ORDER_ID");
			Map order = tinyOrderService.get(ORDER_ID);
			if(null == order){
				return new RetObj(false,"订单失效！");
			}
			if("30".equals(order.get("DEAL_TYPE").toString()) || "0".equals(order.get("DEAL_TYPE").toString()) ){
				int i = tinyOrderService.update(record);
				return new RetObj(true,"操作成功！",record);
			}else{
				return new RetObj(false,"请勿重复操作！");
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
			if(logger.isDebugEnabled()){
				logger.error(e.getMessage());
			}
			return new RetObj(false,"服务异常！");
		}
	}
	@RequestMapping("/orderDetail.htmls")
	public String orderDetail(HttpServletRequest request, PageView pageView) {
		Map<String, Object> record = HttpUtils.getRequestMap(request);
		Map seTicket =  (Map) request.getSession().getAttribute("seTicket");
		String template = (String) seTicket.get("template");
		String ORDER_ID = (String) record.get("id");
		Map map=tinyOrderService.getGoods(ORDER_ID);
		request.setAttribute("record",record);
		request.setAttribute("good",map);
		return "template/"+template+"/order/orderDetail";
	}
	@RequestMapping("/enterOrder")
	@ResponseBody
	public RetObj enterOrder(HttpServletRequest request, Model model) {
		Map<String, Object> record = HttpUtils.getRequestMap(request);
		try {
			String ORDER_ID = (String) record.get("ORDER_ID");
			tinyOrderService.enterOrder(ORDER_ID);
			return new RetObj(true,"成功完成交易");
		} catch (Exception e) {
			if (logger.isDebugEnabled()) {
				logger.error(e.getMessage());
			}
			return new RetObj(false,"服务异常");

		}
	}
	@RequestMapping("/cancelOrder")
	@ResponseBody
	public RetObj cancelOrder(HttpServletRequest request, Model model) {
		Map<String, Object> record = HttpUtils.getRequestMap(request);
		try {
			String ORDER_ID = (String) record.get("ORDER_ID");
			tinyOrderService.cancelOrder(ORDER_ID);
			return new RetObj(true,"成功提交取消申请！");
		} catch (Exception e) {
			if (logger.isDebugEnabled()) {
				logger.error(e.getMessage());
			}
			return new RetObj(false,"服务异常");

		}
	}
}
