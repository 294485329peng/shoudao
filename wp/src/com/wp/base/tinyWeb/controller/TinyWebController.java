package com.wp.base.tinyWeb.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;  
import javax.servlet.http.HttpServletRequest;   

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;  
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;  
import org.springframework.web.bind.annotation.RequestMapping;  
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wp.base.gzh.service.IGzhBsService;
import com.wp.base.tinyWeb.service.ITinyWebService;
import com.wp.common.RetObj;
import com.wp.common.controller.BaseController;
import com.wp.common.page.PageView;
import com.wp.common.utils.DateUtils;
import com.wp.common.utils.HttpUtils;
import com.wp.common.utils.IsNullOrEmpty;
import com.wp.common.utils.StringUtils;
import com.wp.project.background.MaterialLibrary.service.IMaterialLibrary;
import com.wp.project.webBackground.goods.service.IGoodsService;

@Controller  
@RequestMapping("/tinyWeb") 
public class TinyWebController extends BaseController{
	@Autowired
	private ITinyWebService tinyWerbService;
	@RequestMapping("/tinyWebList") 
    public String gzhList(HttpServletRequest request,PageView pageView){ 
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		pageView = tinyWerbService.queryPage(pageView, record);
		request.setAttribute("pageView", pageView);
		request.setAttribute("record", record);
        return "base/template/forTemplateList";  
    }
	@RequestMapping("/insert")
	@ResponseBody
	public RetObj insert(HttpServletRequest request) {
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		String TEMPLATE_ID = (String) record.get("TEMPLATE_ID");
		int i = 0;
		try {
			if(null == TEMPLATE_ID || "" == TEMPLATE_ID){
				i = tinyWerbService.insert(record);
			}else{
				i = tinyWerbService.update(record);
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
	@RequestMapping("/addTemplate")
	public String addTemplate(HttpServletRequest request) {
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		String TEMPLATE_ID = (String) record.get("TEMPLATE_ID");
		if(IsNullOrEmpty.isNullOrEmpty(TEMPLATE_ID)){
			return "base/template/addTemplate";
		}
		record = tinyWerbService.get(TEMPLATE_ID);
		request.setAttribute("record", record);
		return "base/template/addTemplate";
		
	}
	@RequestMapping("/delete")
	@ResponseBody
	public RetObj delete(HttpServletRequest request) {
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		
		try {
			String BT_ID = record.get("BT_ID").toString();
			int i = tinyWerbService.delete(BT_ID);
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
	@RequestMapping("/updateGzhTemp")
	@ResponseBody
	public RetObj updateGzhTemp(HttpServletRequest request) {
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		try {
			int i = tinyWerbService.updateGzhTemp(record);
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
	@RequestMapping("/forSelectQueryPage")
	public String forSelectQueryPage(HttpServletRequest request,PageView pageView) {
		pageView.setPageSize(10);
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		
		pageView = tinyWerbService.queryPage(pageView, record);
		request.setAttribute("record", record);
		request.setAttribute("pageView", pageView);
		return "base/template/selectTemplate";
	}
}
