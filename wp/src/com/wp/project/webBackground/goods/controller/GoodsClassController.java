package com.wp.project.webBackground.goods.controller;

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
import com.wp.project.webBackground.goods.service.IGoodsClassService;

/**
 * 
 * ClassName: GoodsController
 * @Description: 商品后台管理
 * @author daiwk
 * @date 2016年1月27日
 */
@Controller  
@RequestMapping("/goodsClassBC")
public class GoodsClassController extends BaseController{
	@Autowired
	private IGoodsClassService goodsClassService;
	
	@RequestMapping("/goodsClass") 
	public String goodsClass(HttpServletRequest request,PageView pageView){
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		Map loginGZH = (Map) request.getSession().getAttribute(LOGIN_IN_GZH_SESSION);
		record.put("GZH_ID", (String) loginGZH.get("GZH_ID"));
		try {
			pageView = goodsClassService.queryPageClass(pageView, record);
		} catch (Exception e) {
			if(logger.isDebugEnabled()){
				logger.error(e.getMessage());
			}
			e.printStackTrace();
		}
		request.setAttribute("pageView", pageView);
		request.setAttribute("record", record);
		return "client/webBackground/goodsController/goodsClass";
	}
	@RequestMapping("/addGoodsClass") 
	public String addGoodsClass(HttpServletRequest request,PageView pageView){
		return "client/webBackground/goodsController/addGoodsClass";
	}
	@RequestMapping("/forUpdateGoodsClass") 
	public String forUpdateGoodsClass(HttpServletRequest request,String GOODS_CLASSIFY_ID){
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		record = goodsClassService.getClass(GOODS_CLASSIFY_ID);
		/*String deta = (String) record.get("CONTENT");
		record.put("CONTENT", CONTENT);*/
		request.setAttribute("record", record);
		return "client/webBackground/goodsController/addGoodsClass";
	}
	@RequestMapping("/insertGoodsClass")
	@ResponseBody
	public RetObj insertGoodsClass(HttpServletRequest request) {
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		Map loginGZH = (Map) request.getSession().getAttribute(LOGIN_IN_GZH_SESSION);
		record.put("GZH_ID", (String) loginGZH.get("GZH_ID"));
		try {
			record = goodsClassService.insertClass(record);
			if(record!=null){
				return new RetObj(true,"活动添加成功！",record);
			}else{
				return new RetObj(false,"活动添加失败，请稍后再试！");
			}
		} catch (Exception e) {
			e.printStackTrace();
			if(logger.isDebugEnabled()){
				logger.error(e.getMessage());
			}
			return new RetObj(false,request);
		}
	}
	@RequestMapping("/updateClass")
	@ResponseBody
	public RetObj updateClass(HttpServletRequest request) {
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		try {
			
			int i = goodsClassService.updateClass(record);
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
	@RequestMapping("/deleteClass")
	@ResponseBody
	public RetObj deleteClass(HttpServletRequest request) {
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		
		try {
			String GOODS_CLASSIFY_ID = record.get("GOODS_CLASSIFY_ID").toString();
			int i = goodsClassService.deleteClass(GOODS_CLASSIFY_ID);
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
	/*@RequestMapping("/updatePublish")
	@ResponseBody
	public RetObj updateClassPublish(HttpServletRequest request,String ACTIVITY_ID) {
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		record.put("ACTIVITY_ID", ACTIVITY_ID);
		try {
			
			int i = goodsClassService.updateClass(record);
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
	}*/
}
