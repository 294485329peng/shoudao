package com.wp.project.webBackground.base.controller;

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
import com.wp.project.webBackground.base.service.IWebBaseNavService;
import com.wp.project.webBackground.goods.service.IGoodsClassService;
import com.wp.project.webBackground.goods.service.IGoodsService;
import com.wp.project.webBackground.activities.service.IActivityService;

/**
 * 
 * ClassName: BaseController
 * @Description: 首页等基本信息控制
 * @author daiwk
 * @date 2016年1月18日
 */
@Controller  
@RequestMapping("/webBgNav")
public class WebBgNavController extends BaseController{
	@Autowired
	private IActivityService activityService;
	@Autowired
	private IWebBaseNavService webBaseNavService;
	@Autowired
	private IGoodsService goodsService;
	@Autowired
	private IGoodsClassService goodsClassService;
	
	@RequestMapping("/navPic") 
	public String navPic(HttpServletRequest request,PageView pageView){
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		Map loginGZH = (Map) request.getSession().getAttribute(LOGIN_IN_GZH_SESSION);
		record.put("GZH_ID", (String) loginGZH.get("GZH_ID"));
		try {
			pageView = webBaseNavService.queryPage(pageView, record);
		} catch (Exception e) {
			e.printStackTrace();
		}
		request.setAttribute("pageView", pageView);
		request.setAttribute("record", record);
		return "client/webBackground/homeController/navPic";
	}
	@RequestMapping("/forUpdateNav") 
	public String forUpdateNav(HttpServletRequest request,String NAV_ID){
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		record = webBaseNavService.get(NAV_ID);
		request.setAttribute("record", record);
		return "client/webBackground/homeController/forUpdateNav";
	}
	@RequestMapping("/forAddNav") 
	public String forAddNav(HttpServletRequest request,PageView pageView){
		return "client/webBackground/homeController/forAddNav";
	}
	@RequestMapping("/insertNav")
	@ResponseBody
	public RetObj insertNav(HttpServletRequest request) {
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		Map loginGZH = (Map) request.getSession().getAttribute(LOGIN_IN_GZH_SESSION);
		record.put("GZH_ID", (String) loginGZH.get("GZH_ID"));
		try {
			int i = webBaseNavService.insert(record);
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
			
			int i = webBaseNavService.update(record);
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
	@RequestMapping("/updatePublish")
	@ResponseBody
	public RetObj updatePublish(HttpServletRequest request,String Nav_ID) {
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		record.put("Nav_ID", Nav_ID);
		try {
			
			int i = webBaseNavService.update(record);
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
	public RetObj deleteNav(HttpServletRequest request) {
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		
		try {
			String NAV_ID = record.get("NAV_ID").toString();
			int i = webBaseNavService.delete(NAV_ID);
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
	@RequestMapping("/selectResponse") 
	public String selectResponse(HttpServletRequest request,PageView pageView,String RESPONSE){
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		Map loginGZH = (Map) request.getSession().getAttribute(LOGIN_IN_GZH_SESSION);
		record.put("GZH_ID", (String) loginGZH.get("GZH_ID"));
		List classList = null;
		try {
			if("1".equals(RESPONSE)){
				pageView.setPageSize(6);
				pageView = goodsService.queryPageRank(pageView, record);
				classList = goodsClassService.query(record);
				request.setAttribute("classList", classList);
				request.setAttribute("pageView", pageView);
				request.setAttribute("record", record);
				return "client/webBackground/goodsController/selectGoods";
			}else{
				pageView.setPageSize(6);
				pageView = activityService.queryPage(pageView, record);
				request.setAttribute("pageView", pageView);
				request.setAttribute("record", record);
				return "client/webBackground/activityController/SelectActive";
			}
		
			
		} catch (Exception e) {
			e.printStackTrace();
			if(logger.isDebugEnabled()){
				logger.error(e.getMessage());
			}
		}
		return "error";
	}
}
