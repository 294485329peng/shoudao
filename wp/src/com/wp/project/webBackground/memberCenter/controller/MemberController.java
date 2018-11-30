package com.wp.project.webBackground.memberCenter.controller;

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
import com.wp.project.webBackground.memberCenter.service.IMemberBCService;
import com.wp.project.webBackground.orders.service.IOrderService;

/**
 * 
 * ClassName: GoodsController
 * @Description: 后台管理
 * @author daiwk
 * @date 2016年1月27日
 */
@Controller  
@RequestMapping("/memberBC")
public class MemberController extends BaseController{
	@Autowired
	private IMemberBCService memberBCService;
	@Autowired
	private IOrderService orderService;
	
	@RequestMapping("/memberList") 
	public String memberList(HttpServletRequest request,PageView pageView){
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		Map loginGZH = (Map) request.getSession().getAttribute(LOGIN_IN_GZH_SESSION);
		record.put("GZH_ID", (String) loginGZH.get("GZH_ID"));
		try {
			pageView = memberBCService.queryPage(pageView, record);
		} catch (Exception e) {
			e.printStackTrace();
		}
		request.setAttribute("pageView", pageView);
		request.setAttribute("record", record);
		return "client/webBackground/memberController/memberList";
	}
	@RequestMapping("/memberDetail") 
	public String memberDetail(HttpServletRequest request,String OPEN_ID,String MEMBER_ID,PageView pageView){
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		record = memberBCService.get(OPEN_ID);
		request.setAttribute("record", record);
		pageView.setPageSize(6);
		pageView = orderService.memberQueryPage(pageView, record);
		request.setAttribute("pageView", pageView);
		return "client/webBackground/memberController/memberDetail";
	}
	@RequestMapping("/addMember") 
	public String addMember(HttpServletRequest request,PageView pageView){
		return "client/webBackground/memberController/addMember";
	}
	@RequestMapping("/insertMember")
	@ResponseBody
	public RetObj insertMember(HttpServletRequest request) {
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		Map loginGZH = (Map) request.getSession().getAttribute(LOGIN_IN_GZH_SESSION);
		record.put("GZH_ID", (String) loginGZH.get("GZH_ID"));
		try {
			int i = memberBCService.insert(record);
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
			int i = memberBCService.update(record);
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
	public RetObj deleteMember(HttpServletRequest request,String OPEN_ID,String MEMBER_ID) {
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		
		try {
			//String OPEN_ID = record.get("OPEN_ID").toString();
			int i = memberBCService.delete(OPEN_ID);
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
	
	@RequestMapping("/chongzhi") 
	public String chongzhi(HttpServletRequest request){
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		request.setAttribute("record", record);
		return "client/webBackground/memberController/chongzhi";
	}
	@RequestMapping("/xiaofei") 
	public String xiaofei(HttpServletRequest request){
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		request.setAttribute("record", record);
		return "client/webBackground/memberController/xiaofei";
	}
	@RequestMapping("/insterChongzhiMoney")
	@ResponseBody
	public RetObj insterChongzhiMoney(HttpServletRequest request) {
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		
		try {
			//String OPEN_ID = record.get("OPEN_ID").toString();
			record = memberBCService.chongzhi(record);
			if(null != record){
				return new RetObj(true,"操作成功！",record);
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
	@RequestMapping("/insterXiaofeiMoney")
	@ResponseBody
	public RetObj insterXiaofeiMoney(HttpServletRequest request) {
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		
		try {
			//String OPEN_ID = record.get("OPEN_ID").toString();
			record = memberBCService.xiaofei(record);
			if(null != record){
				if(!IsNullOrEmpty.isNullOrEmpty(record.get("msg"))){
					return new RetObj(false,"操作失败！",record);
				}
				return new RetObj(true,"操作成功！",record);
				
			}else {
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
	@RequestMapping("/moneyRecord") 
	public String moneyRecord(HttpServletRequest request,PageView pageView){
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		
		try {
			pageView = memberBCService.moneyRecordqueryPage(pageView, record);
		} catch (Exception e) {
			e.printStackTrace();
		}
		request.setAttribute("pageView", pageView);
		request.setAttribute("record", record);
		return "client/webBackground/memberController/moneyRecord";
	}
	
}
