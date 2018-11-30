package com.wp.project.webBackground.memberCard.controller;

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
import com.wp.project.webBackground.memberCard.service.IMemberCardService;
import com.wp.project.webBackground.memberCenter.service.IMemberBCService;
import com.wp.project.webBackground.orders.service.IOrderService;

/**
 * 
 * ClassName: GoodsController
 * @Description: 会员卡管理
 * @author daiwk
 * @date 2016年1月27日
 */
@Controller  
@RequestMapping("/memberCard")
public class MemberCardController extends BaseController{
	@Autowired
	private IMemberCardService memberCardService;
	@Autowired
	private IOrderService orderService;
	
	@RequestMapping("/cardInfo") 
	public String memberList(HttpServletRequest request){
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		Map loginGZH = (Map) request.getSession().getAttribute(LOGIN_IN_GZH_SESSION);
		String GZH_ID = (String) loginGZH.get("GZH_ID");
		record = memberCardService.get(GZH_ID);
		request.setAttribute("record", record);
		return "client/webBackground/memberCard/card";
	}
	
	@RequestMapping("/insert")
	@ResponseBody
	public RetObj insert(HttpServletRequest request) {
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		Map loginGZH = (Map) request.getSession().getAttribute(LOGIN_IN_GZH_SESSION);
		record.put("GZH_ID", (String) loginGZH.get("GZH_ID"));
		try {
			if(IsNullOrEmpty.isNullOrEmpty(record.get("CARD_ID"))){
				int i = memberCardService.insert(record);
				if(i!=0){
					return new RetObj(true,"操作成功！",record);
				}else{
					return new RetObj(false,"添加失败，请稍后再试！");
				}
			}else{
				int i = memberCardService.update(record);
				if(i!=0){
					return new RetObj(true,"操作成功！",record);
				}else{
					return new RetObj(false,"添加失败，请稍后再试！");
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			if(logger.isDebugEnabled()){
				logger.error(e.getMessage());
			}
			return new RetObj(false,request);
		}
	}
	@RequestMapping("/update")
	@ResponseBody
	public RetObj update(HttpServletRequest request) {
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		try {
			int i = memberCardService.update(record);
			if(i!=0){
				return new RetObj(true,"操作成功！");
			}else{
				return new RetObj(false,"操作失败！");
			}
		} catch (Exception e) {
			e.printStackTrace();
			if(logger.isDebugEnabled()){
				logger.error(e.getMessage());
			}
			return new RetObj(false,request);
		}
	}
}
