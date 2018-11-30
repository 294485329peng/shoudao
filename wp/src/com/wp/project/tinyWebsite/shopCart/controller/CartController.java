package com.wp.project.tinyWebsite.shopCart.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
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
import com.wp.project.tinyWebsite.shopCart.service.IShopCartService;

/**
 * 
 * ClassName: BaseController
 * @Description: 首页等基本信息控制
 * @author daiwk
 * @date 2016年1月18日
 */
@Controller  
@RequestMapping("/TWeb/cart")
public class CartController extends BaseController{
	@Autowired
	private IShopCartService shopCartService;
	
	@RequestMapping("/memberShopCart.htmls") 
	public String memberShopCart(HttpServletRequest request){
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		Map seTicket =  (Map) request.getSession().getAttribute("seTicket");
		String template = (String) seTicket.get("template");
		record.put("GZH_ID",seTicket.get("gzhId"));
	 	record.put("OPEN_ID", seTicket.get("userId"));
	 	List scList = shopCartService.query(record);
	 	request.setAttribute("scList", scList);
		return "template/"+template+"/shopCart/cart";
	}
	@RequestMapping(value="/insterTemp.htmls",produces="application/json")
	@ResponseBody
	public  RetObj insterTemp(HttpServletRequest request) {
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		Map seTicket =  (Map) request.getSession().getAttribute("seTicket");
		record.put("GZH_ID",seTicket.get("gzhId"));
		if(IsNullOrEmpty.isNullOrEmpty(seTicket.get("userId"))){
			return new RetObj(false,"请先从个人中心登录");
		}
	 	record.put("OPEN_ID", seTicket.get("userId"));
		try{
			int count = shopCartService.insert(record);
			
			if(count > 0){
				if(count == 6){
					return new RetObj(false,"购物车已满，请下单后再购买！");
				}else if(count == 2){
					return new RetObj(true,"单品购物车更新成功！",count);
				}
				return new RetObj(true,"添加成功！",count);
			}else{
				return new RetObj(false,"添加商品至购物车异常！");
			}
		} catch (Exception e) {
			e.printStackTrace();
			if(logger.isDebugEnabled()){
				logger.error(e.getMessage());
			}
			return new RetObj(false,"服务异常！");
		}
	}
	@RequestMapping(value="/deleteSC.htmls",produces="application/json",method=RequestMethod.POST)
	@ResponseBody
	public RetObj deleteSC(HttpServletRequest request,@RequestBody Map record) {
		Map seTicket =  (Map) request.getSession().getAttribute("seTicket");	
		
	 	//record.put("OPEN_ID",map.get("userId"));
		try{
			if(IsNullOrEmpty.isNullOrEmpty(seTicket.get("userId"))){
				return new RetObj(false,"请先从个人中心登录!");
			}
			int count = shopCartService.batchDelete(record);
			
			if(count > 0){
					return new RetObj(true,request,count);
			}else{
				return new RetObj(false,"操作失败！");
			}
		} catch (Exception e) {
			e.printStackTrace();
			if(logger.isDebugEnabled()){
				logger.error(e.getMessage());
			}
			return new RetObj(false,"服务异常！");
		}
	}
}
