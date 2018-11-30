package com.wp.project.webBackground.template.controller;

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
import com.wp.project.webBackground.base.service.IWebBaseAcService;
import com.wp.project.webBackground.base.service.IWebBaseNavService;
import com.wp.project.webBackground.goods.service.IGoodsClassService;
import com.wp.project.webBackground.goods.service.IGoodsService;
import com.wp.project.webBackground.template.service.IWebTemplateService;
import com.wp.project.webBackground.activities.service.IActivityService;

/**
 * 
 * @Description: 模板
 * @author daiwk
 * @date 2016年1月18日
 */
@Controller  
@RequestMapping("/WebTemplate")
public class WebTemplate extends BaseController{
	@Autowired
	private IWebTemplateService webTemplateService;;
	
	@RequestMapping("/temList") 
	public String temList(HttpServletRequest request,PageView pageView){
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		try {
			pageView = webTemplateService.queryPage(pageView, record);
		} catch (Exception e) {
			e.printStackTrace();
		}
		request.setAttribute("pageView", pageView);
		request.setAttribute("record", record);
		return "client/webBackground/webTemplate/template";
	}
	@RequestMapping("/insert")
	@ResponseBody
	public RetObj insert(HttpServletRequest request) {
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		try {
			int i = webTemplateService.insert(record);
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
	@RequestMapping("/update")
	@ResponseBody
	public RetObj update(HttpServletRequest request) {
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		try {
			
			int i = webTemplateService.update(record);
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
	public RetObj deleteHomeAc(HttpServletRequest request) {
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		
		try {
			String WAP_ID = record.get("WAP_ID").toString();
			int i = webTemplateService.delete(WAP_ID);
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
