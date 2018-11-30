package com.wp.project.webBackground.homeButton.controller;

import java.util.HashMap;
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
import com.wp.project.webBackground.homeButton.service.IHmBtService;

/**
 * 
 * ClassName: BaseController
 * @Description: 首页等基本信息控制
 * @author daiwk
 * @date 2016年1月18日
 */
@Controller  
@RequestMapping("/HmBt")
public class HmBtController extends BaseController{
	@Autowired
	private IHmBtService hmBtService;
	
	@RequestMapping("/hmButtonList") 
	public String hmButtonList(HttpServletRequest request,PageView pageView){
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		Map loginGZH = (Map) request.getSession().getAttribute(LOGIN_IN_GZH_SESSION);
		record.put("GZH_ID", (String) loginGZH.get("GZH_ID"));
		
		pageView = hmBtService.queryPage(pageView, record);
		
		request.setAttribute("record", record);
		request.setAttribute("pageView", pageView);
		return "client/webBackground/hmButtonController/hmButtonList";
	}
	@RequestMapping("/insert")
	@ResponseBody
	public RetObj insert(HttpServletRequest request) {
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		Map loginGZH = (Map) request.getSession().getAttribute(LOGIN_IN_GZH_SESSION);
		String GZH_ID = (String) loginGZH.get("GZH_ID");
		record.put("GZH_ID", GZH_ID);
		int i = 0;
		try {
			if(IsNullOrEmpty.isNullOrEmpty(record.get("BT_ID"))){
				i = hmBtService.insert(record);
			}else{
				i = hmBtService.update(record);
			}
			if(i!=0){
				return new RetObj(true,"操作成功！",record);
			}else{
				return new RetObj(false,"添加失败，请稍后再试！");
			}
		} catch (Exception e) {
			e.printStackTrace();
			if(logger.isDebugEnabled()){
				logger.error(e.getMessage());
			}
			return new RetObj(false,request);
		}
	}
	@RequestMapping("/addHmButton")
	public String addHmButton(HttpServletRequest request) {
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		Map loginGZH = (Map) request.getSession().getAttribute(LOGIN_IN_GZH_SESSION);
		
		String BT_ID = (String) record.get("BT_ID");
		record = hmBtService.get(BT_ID);
		if(null == record){
			record = new HashMap();
			record.put("GZH_ID", (String) loginGZH.get("GZH_ID"));
		}
		record.put("GZH_ID", (String) loginGZH.get("GZH_ID"));
		request.setAttribute("record", record);
		return "client/webBackground/hmButtonController/addButton";
		
	}
	@RequestMapping("/update")
	@ResponseBody
	public RetObj update(HttpServletRequest request) {
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		Map loginGZH = (Map) request.getSession().getAttribute(LOGIN_IN_GZH_SESSION);
		String GZH_ID = (String) loginGZH.get("GZH_ID");
		record.put("GZH_ID", GZH_ID);
		try {
			
			int i = hmBtService.update(record);
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
	@RequestMapping("/delete")
	@ResponseBody
	public RetObj delete(HttpServletRequest request) {
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		
		try {
			String BT_ID = record.get("BT_ID").toString();
			int i = hmBtService.delete(BT_ID);
			if(i!=0){
				return new RetObj(true,"操作成功！");
			}else{
				return new RetObj(false,"操作失败,请稍后再试！");
			}
		} catch (Exception e) {
			e.printStackTrace();
			if(logger.isDebugEnabled()){
				logger.error(e.getMessage());
			}
			return new RetObj(false,"操作失败,请稍后再试！");
		}
	}
}
