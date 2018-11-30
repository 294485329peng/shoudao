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
import com.wp.project.webBackground.base.service.IWebBaseAcService;
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
@RequestMapping("/webBgAc")
public class WebBgAcController extends BaseController{
	@Autowired
	private IActivityService activityService;
	@Autowired
	private IWebBaseAcService webBaseAcService;
	@Autowired
	private IGoodsService goodsService;
	@Autowired
	private IGoodsClassService goodsClassService;
	
	@RequestMapping("/homeAc") 
	public String homeAC(HttpServletRequest request,PageView pageView){
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		Map loginGZH = (Map) request.getSession().getAttribute(LOGIN_IN_GZH_SESSION);
		record.put("GZH_ID", (String) loginGZH.get("GZH_ID"));
		try {
			pageView = webBaseAcService.queryPage(pageView, record);
		} catch (Exception e) {
			e.printStackTrace();
		}
		request.setAttribute("pageView", pageView);
		request.setAttribute("record", record);
		return "client/webBackground/homeController/homeAc";
	}
	@RequestMapping("/forAddHomeAc") 
	public String forAddHomeAc(HttpServletRequest request,PageView pageView){
		return "client/webBackground/homeController/forAddHomeAc";
	}
	@RequestMapping("/forUpdateHomeAc") 
	public String forUpdateHomeAc(HttpServletRequest request,String HAC_ID){
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		record = webBaseAcService.get(HAC_ID);
		request.setAttribute("record", record);
		return "client/webBackground/homeController/forUpdateHomeAc";
	}
	@RequestMapping("/insertHomeAc")
	@ResponseBody
	public RetObj insertHomeAc(HttpServletRequest request) {
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		Map loginGZH = (Map) request.getSession().getAttribute(LOGIN_IN_GZH_SESSION);
		String GZH_ID = (String) loginGZH.get("GZH_ID");
		record.put("GZH_ID", GZH_ID);
		try {
			int i = webBaseAcService.insert(record);
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
			
			int i = webBaseAcService.update(record);
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
	public RetObj updatePublish(HttpServletRequest request,String HAC_ID) {
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		record.put("HAC_ID", HAC_ID);
		try {
			
			int i = webBaseAcService.update(record);
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
			String HAC_ID = record.get("HAC_ID").toString();
			int i = webBaseAcService.delete(HAC_ID);
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
		String GZH_ID = (String) loginGZH.get("GZH_ID");
		record.put("GZH_ID", GZH_ID);
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
