package com.wp.project.webBackground.goods.controller;

import java.util.ArrayList;
import java.util.HashMap;
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
import com.wp.common.utils.CheckString;
import com.wp.common.utils.HttpUtils;
import com.wp.common.utils.StringUtils;
import com.wp.project.webBackground.goods.service.IGoodsClassService;
import com.wp.project.webBackground.goods.service.IGoodsService;

/**
 * 
 * ClassName: GoodsController
 * @Description: 商品后台管理
 * @author daiwk
 * @date 2016年1月27日
 */
@Controller  
@RequestMapping("/goodsBC")
public class GoodsController extends BaseController{
	@Autowired
	private IGoodsService goodsService;
	@Autowired
	private IGoodsClassService goodsClassService;
	@RequestMapping("/goodsList") 
	public String goodsList(HttpServletRequest request,PageView pageView){
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		Map loginGZH = (Map) request.getSession().getAttribute(LOGIN_IN_GZH_SESSION);
		record.put("GZH_ID", (String) loginGZH.get("GZH_ID"));
		List classList = null;
		try {
			classList = goodsClassService.query(record);
			request.setAttribute("classList", classList);
			pageView = goodsService.queryPageRank(pageView, record);
		} catch (Exception e) {
			if(logger.isDebugEnabled()){
				logger.error(e.getMessage());
			}
			e.printStackTrace();
		}
		request.setAttribute("record", record);
		request.setAttribute("pageView", pageView);
		return "client/webBackground/goodsController/goodsList";
	}
	@RequestMapping("/goodsListByClass") 
	public String goodsListByClass(HttpServletRequest request,PageView pageView){
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		Map loginGZH = (Map) request.getSession().getAttribute(LOGIN_IN_GZH_SESSION);
		record.put("GZH_ID", (String) loginGZH.get("GZH_ID"));
		List classList = null;
		try {
			classList = goodsClassService.query(record);
			request.setAttribute("classList", classList);
			pageView = goodsService.queryPageClass(pageView, record);
		} catch (Exception e) {
			if(logger.isDebugEnabled()){
				logger.error(e.getMessage());
			}
			e.printStackTrace();
		}
		request.setAttribute("record", record);
		request.setAttribute("pageView", pageView);
		return "client/webBackground/goodsController/goodsList";
	}
	@RequestMapping("/addGoods") 
	public String addGoods(HttpServletRequest request){
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		Map loginGZH = (Map) request.getSession().getAttribute(LOGIN_IN_GZH_SESSION);
		record.put("GZH_ID", (String) loginGZH.get("GZH_ID"));
		List classList = goodsClassService.query(record);
		record.put("ListSize", 0);
		request.setAttribute("classList", classList);
		request.setAttribute("record", record);
		return "client/webBackground/goodsController/addGoods";
	}
	@RequestMapping("/forUpdateGoods") 
	public String forUpdateGoods(HttpServletRequest request,String GOODS_ID){
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		Map loginGZH = (Map) request.getSession().getAttribute(LOGIN_IN_GZH_SESSION);
		record.put("GZH_ID", (String) loginGZH.get("GZH_ID"));
		List classList = goodsClassService.query(record);
		List goodsDetailList = goodsService.queryGoodsDetailMainList(GOODS_ID);
		System.out.println(goodsDetailList.size());
		record = goodsService.getGoods(GOODS_ID);
		record.put("ListSize", goodsDetailList.size());
		request.setAttribute("record", record);
		request.setAttribute("classList", classList);
		request.setAttribute("goodsDetailList", goodsDetailList);
		return "client/webBackground/goodsController/addGoods";
	}
	@RequestMapping("/insertGoods")
	@ResponseBody
	public RetObj insertGoods(HttpServletRequest request) {
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		Map loginGZH = (Map) request.getSession().getAttribute(LOGIN_IN_GZH_SESSION);
		record.put("GZH_ID", (String) loginGZH.get("GZH_ID"));
		try {
			String GOODS_ID =  record.get("GOODS_ID").toString();
			if(null == record.get("GOODS_ID").toString() || "" == record.get("GOODS_ID").toString()){
					return new RetObj(false,"添加失败，请添加一个商品规格！");
			}
			Map goodsMap = goodsService.getGoods(GOODS_ID);
			if(null == goodsMap){
				record = goodsService.insertGoods(record);
				if(null == record){
					return new RetObj(false,"添加失败，请稍后再试！");
				}
				return new RetObj(true,"添加成功！",record);
			}else{
				int i = goodsService.updateGoods(record);
				if(i == 0){
					return new RetObj(false,"添加失败，请稍后再试！");
				}
				return new RetObj(true,"添加成功！",record);
			}
			
			
			
		} catch (Exception e) {
			e.printStackTrace();
			if(logger.isDebugEnabled()){
				logger.error(e.getMessage());
			}
			return new RetObj(false,request);
		}
	}
	@RequestMapping("/updateGoods")
	@ResponseBody
	public RetObj updateGoods(HttpServletRequest request) {
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		try {
			
			int i = goodsService.updateGoods(record);
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
	@RequestMapping("/deleteGoods")
	@ResponseBody
	public RetObj deleteGoods(HttpServletRequest request) {
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		
		try {
			String GOODS_ID = record.get("GOODS_ID").toString();
			int i = goodsService.deleteGoods(GOODS_ID);
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
	@RequestMapping("/addSpecification") 
	public String addSpecification(HttpServletRequest request){
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		
		if(null == record.get("MAIN_SPECIFICATION_ID") || "" == record.get("MAIN_SPECIFICATION_ID")){
			record.put("ListSize", "0");
				Map checkGoods =  goodsService.getGoods(record.get("GOODS_ID").toString());
				if(null != checkGoods){
					record.put("IS_USE", "yse");
				}
			request.setAttribute("record", record);
			return "client/webBackground/goodsController/addSpecification";
		}
		String trId = record.get("trId").toString();
		String GOODS_ID = record.get("GOODS_ID").toString();
		String MAIN_SPECIFICATION_ID = record.get("MAIN_SPECIFICATION_ID").toString();
		record = goodsService.queryGoodsDetail(MAIN_SPECIFICATION_ID);
		List  list = (List) record.get("childGoodsDetialList");
		record.put("ListSize", list.size());
		record.put("GOODS_ID", GOODS_ID);
		record.put("trId", trId);
		record.put("MAIN_SPECIFICATION_ID", MAIN_SPECIFICATION_ID);
		request.setAttribute("record", record);
		return "client/webBackground/goodsController/addSpecification";
	}
	@RequestMapping("/insertGoodsDetail")
	@ResponseBody
	public RetObj insertGoodsDetail(HttpServletRequest request) {
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		Map loginGZH = (Map) request.getSession().getAttribute(LOGIN_IN_GZH_SESSION);
		record.put("GZH_ID", (String) loginGZH.get("GZH_ID"));
		try {
			if(null  == record.get("GOODS_ID") || "" == record.get("GOODS_ID")){
				record.put("GOODS_ID", StringUtils.uniqueKey36());
			}
			int i = 0;
			CheckString checkString = new CheckString(); 
		
			if(null == record.get("MAIN_SPECIFICATION_ID") || "" == record.get("MAIN_SPECIFICATION_ID")){
				record = goodsService.insertGoodsDetail(record);
				if(null == record){
					return new RetObj(false,request);
				}
			}else{
				i = goodsService.batchUpdateGoodsDetail(record);
				if(i == 0){
					return new RetObj(false,request);
				}
			}
			
				return new RetObj(true,request,record);
			
		} catch (Exception e) {
			e.printStackTrace();
			if(logger.isDebugEnabled()){
				logger.error(e.getMessage());
			}
			return new RetObj(false,request);
		}
	}
	@RequestMapping("/deleteGoodsDetailByMainId")
	@ResponseBody
	public RetObj deleteGoodsDetailByMainId(HttpServletRequest request,String MAIN_SPECIFICATION_ID) {
		try {
			
			int i = goodsService.deleteGoodsDetailByMainId(MAIN_SPECIFICATION_ID);
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
	public RetObj updatePublish(HttpServletRequest request,String GOODS_ID) {
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		record.put("GOODS_ID", GOODS_ID);
		try {
			
			int i = goodsService.updateGoods(record);
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
