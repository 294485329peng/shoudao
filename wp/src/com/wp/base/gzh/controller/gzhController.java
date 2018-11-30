package com.wp.base.gzh.controller;

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
import com.wp.common.RetObj;
import com.wp.common.controller.BaseController;
import com.wp.common.page.PageView;
import com.wp.common.utils.DateUtils;
import com.wp.common.utils.HttpUtils;
import com.wp.common.utils.StringUtils;
import com.wp.project.background.MaterialLibrary.service.IMaterialLibrary;
import com.wp.project.webBackground.goods.service.IGoodsService;

@Controller  
@RequestMapping("/gzhBs") 
public class gzhController extends BaseController{
	@Autowired
	private IGzhBsService gzhBsdsService;
	@RequestMapping("/gzhList") 
    public String gzhList(HttpServletRequest request,PageView pageView){ 
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		pageView = gzhBsdsService.queryPage(pageView, record);
		request.setAttribute("pageView", pageView);
		request.setAttribute("record", record);
        return "base/gzh/gzhList";  
    }
	@RequestMapping("/gzhDetail")
	public String gzhDetail(HttpServletRequest request) {
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		String TEMPLATE_ID = (String) record.get("TEMPLATE_ID");
		record = gzhBsdsService.get(TEMPLATE_ID);
		request.setAttribute("record", record);
		return "base/gzh/gzhDetail";
		
	}
	@RequestMapping("/insert")
	@ResponseBody
	public RetObj insert(HttpServletRequest request) {
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		String TEMPLATE_ID = (String) record.get("TEMPLATE_ID");
		int i = 0;
		try {
			if(null == TEMPLATE_ID || "" == TEMPLATE_ID){
				i = gzhBsdsService.insert(record);
			}else{
				i = gzhBsdsService.update(record);
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
	@RequestMapping("/delete")
	@ResponseBody
	public RetObj delete(HttpServletRequest request) {
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		
		try {
			String BT_ID = record.get("BT_ID").toString();
			int i = gzhBsdsService.delete(BT_ID);
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
