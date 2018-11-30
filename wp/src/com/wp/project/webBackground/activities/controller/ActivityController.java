package com.wp.project.webBackground.activities.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wp.common.RetObj;
import com.wp.common.controller.BaseController;
import com.wp.common.page.PageView;
import com.wp.common.utils.DateUtils;
import com.wp.common.utils.HttpUtils;
import com.wp.common.utils.StringUtils;
import com.wp.project.tinyWebsite.base.service.IWebBaseService;
import com.wp.project.webBackground.activities.service.IActivityService;
import com.wp.project.webBackground.goods.service.IGoodsClassService;
import com.wp.project.webBackground.goods.service.IGoodsService;

/**
 * 
 * ClassName: ActivityController
 * @Description: 后台活动控制
 * @author daiwk
 * @date 2016年1月28日
 */
@Controller  
@RequestMapping("/acBC")
public class ActivityController extends BaseController{
	@Autowired
	private IActivityService activityService;
	@Autowired
	private IGoodsService goodsService;
	@Autowired
	private IGoodsClassService goodsClassService;
	
	@RequestMapping("/activityList") 
	public String activityList(HttpServletRequest request,PageView pageView){
		//request.getSession().removeAttribute("C_SESSION");
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		Map loginGZH = (Map) request.getSession().getAttribute(LOGIN_IN_GZH_SESSION);
		record.put("GZH_ID", (String) loginGZH.get("GZH_ID"));
		try {
			pageView = activityService.queryPage(pageView, record);
		} catch (Exception e) {
			e.printStackTrace();
		}
		request.setAttribute("pageView", pageView);
		request.setAttribute("record", record);
		return "client/webBackground/activityController/activityList";
	}
	@RequestMapping("/addActivity") 
	public String addActivity(HttpServletRequest request,PageView pageView){
		return "client/webBackground/activityController/addActivity";
	}
	@RequestMapping("/forUpdateActivity") 
	public String forUpdateActivity(HttpServletRequest request,String ACTIVITY_ID){
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		record = activityService.get(ACTIVITY_ID);
		String CONTENT = (String) record.get("CONTENT");
		record.put("CONTENT", CONTENT);
		request.setAttribute("record", record);
		return "client/webBackground/activityController/forUpdateActivity";
	}
	@RequestMapping("/getActivityById")
	@ResponseBody
	public RetObj getActivityById(HttpServletRequest request,String ACTIVITY_ID) {
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		
		try {
			record = activityService.get(ACTIVITY_ID);
			if(record == null ){
				return new RetObj(false,"详细内容读取失败，请返回重试！");
			}else{
				return new RetObj(true,request,record);
			}
		} catch (Exception e) {
			e.printStackTrace();
			if(logger.isDebugEnabled()){
				logger.error(e.getMessage());
			}
			return new RetObj(false,"详细内容读取失败，请返回重试！");
		}
	}
	@RequestMapping("/insertActivity")
	@ResponseBody
	public RetObj insertActivity(HttpServletRequest request) {
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		Map loginGZH = (Map) request.getSession().getAttribute(LOGIN_IN_GZH_SESSION);
		String GZH_ID = (String) loginGZH.get("GZH_ID");
		record.put("GZH_ID", GZH_ID);
		try {
			if(record.get("ACTIVITY_ID") == "" || record.get("ACTIVITY_ID") == null){
				record = activityService.insert_map(record);
				if(record !=  null){
					return new RetObj(true,"活动添加成功！",record);
				}else{
					return new RetObj(false,"活动添加失败，请稍后再试！",record);
				}
			}else{
				record = activityService.update_Map(record);
				if(record !=  null){
					return new RetObj(true,"活动更新成功！",record);
				}else{
					return new RetObj(false,"活动更新失败，请稍后再试！",record);
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
			if(record.get("ACTIVITY_ID") == "" || record.get("ACTIVITY_ID") == null){
				return new RetObj(false,"活动更新失败，请稍后再试！");
			}
			record = activityService.update_Map(record);
			if(record !=  null){
				return new RetObj(true,"活动更新成功！",record);
			}else{
				return new RetObj(false,"活动更新失败，请稍后再试！",record);
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
			String ACTIVITY_ID = record.get("ACTIVITY_ID").toString();
			int i = activityService.delete(ACTIVITY_ID);
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
	@RequestMapping("/updatePublish")
	@ResponseBody
	public RetObj updatePublish(HttpServletRequest request,String ACTIVITY_ID) {
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		record.put("ACTIVITY_ID", ACTIVITY_ID);
		try {
			
			int i = activityService.update(record);
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
			}else if("1".equals(RESPONSE)){
				return "error";
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
