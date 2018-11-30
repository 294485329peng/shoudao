package com.wp.project.tinyWebsite.goods.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wp.common.RetObj;
import com.wp.common.controller.BaseController;
import com.wp.common.page.PageView;
import com.wp.common.utils.HttpUtils;
import com.wp.common.utils.IsNullOrEmpty;
import com.wp.project.tinyWebsite.base.service.IWebBaseService;
import com.wp.project.tinyWebsite.goods.service.IGoodsService;
import com.wp.project.webBackground.goods.service.IGoodsClassService;

/**
 * 
 * ClassName: BaseController
 * @Description: 首页等基本信息控制
 * @author daiwk
 * @date 2016年1月18日
 */
@Controller  
@RequestMapping("/TWeb/goods")
public class Goods extends BaseController{
	@Autowired
	private IGoodsService goodsService;
	@Autowired
	private IGoodsClassService goodsClassService;
	@RequestMapping("/goodsList.htmls") 
	public String forGoodsList(HttpServletRequest request,PageView pageView){
		Map seTicket =  (Map) request.getSession().getAttribute("seTicket");
		String template = (String) seTicket.get("template");
	 	Map<String,Object> record = HttpUtils.getRequestMap(request);
	 	record.put("GZH_ID",seTicket.get("gzhId"));
	 	if(IsNullOrEmpty.isNullOrEmpty(record.get("CLASSIFY"))){
			record.put("CLASSIFY", null);
		}
		pageView.setPageSize(6);
		pageView = goodsService.queryPage(pageView, record);
		List<Map> classList = goodsClassService.query(record);
		int i = pageView.getRecords().size();
		if(! IsNullOrEmpty.isNullOrEmpty(record.get("CLASSIFY"))){
			for(Map map : classList) {
				if(record.get("CLASSIFY").equals(map.get("GOODS_CLASSIFY_ID"))){
					record.put("CLASSIFY_NAME", map.get("CLASSIFY_NAME"));
				}
					
			}
		}
		
		request.setAttribute("record", record);
		request.setAttribute("pageView", pageView);
		request.setAttribute("classList", classList);
		return "template/"+template+"/goods/goodsList";
	}
	
	@RequestMapping(value="/queryGoodsList.htmls",produces="application/json")
	@ResponseBody
	public  RetObj queryGoodsList(HttpServletRequest request,PageView pageView) {
		Map seTicket =  (Map) request.getSession().getAttribute("seTicket");
		String template = (String) seTicket.get("template");
	 	Map<String,Object> record = HttpUtils.getRequestMap(request);
	 	record.put("GZH_ID",seTicket.get("gzhId"));
	 	if(IsNullOrEmpty.isNullOrEmpty(record.get("CLASSIFY"))){
			record.put("CLASSIFY", null);
		}
		pageView.setPageSize(6);
		try {
			pageView = goodsService.queryPage(pageView, record);
			//System.out.println(pageView.getRecords().size());
			return new RetObj(true,request,pageView);
			
		} catch (Exception e) {
			e.printStackTrace();
			if(logger.isDebugEnabled()){
				logger.error(e.getMessage());
			}
			return new RetObj(false,request);
		}
	}
	@RequestMapping("/goodsDetail.htmls") 
	public String forGoodsDetail(HttpServletRequest request,String GOODS_ID){
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		Map seTicket =  (Map) request.getSession().getAttribute("seTicket");
		String template = (String) seTicket.get("template");
		Map goods = goodsService.getGoods(record);
		List goodsList = goodsService.query(record);
		request.setAttribute("goods", goods);
		request.setAttribute("goodsList", goodsList);
		return "template/"+template+"/goods/goodsDetail";
	}
}
