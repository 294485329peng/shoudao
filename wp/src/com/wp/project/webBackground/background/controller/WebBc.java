package com.wp.project.webBackground.background.controller;

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
import com.wp.project.webBackground.background.service.IWebBcService;

/**
 * 
 * ClassName: BaseController
 * @Description: 首页等基本信息控制
 * @author daiwk
 * @date 2016年1月18日
 */
@Controller  
@RequestMapping("/WebBc")
public class WebBc extends BaseController{
	@Autowired
	private IWebBcService webBcService;
	
	@RequestMapping("/showInfo") 
	public String showInfo(HttpServletRequest request,PageView pageView){
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		Map loginGZH = (Map) request.getSession().getAttribute(LOGIN_IN_GZH_SESSION);
		String GZH_ID = (String) loginGZH.get("GZH_ID");;
		record.put("GZH_ID", GZH_ID);
		/*try {
			record = webBcService.get(GZH_ID);
		} catch (Exception e) {
			e.printStackTrace();
		}*/
		request.setAttribute("record", record);
		return "client/webBackground/webBc/background";
	}
	@RequestMapping("/insert")
	@ResponseBody
	public RetObj insert(HttpServletRequest request) {
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		String GZH_ID = (String) record.get("GZH_ID");
		int i = 0;
		try {
			if(null == GZH_ID || "" == GZH_ID){
				Map loginGZH = (Map) request.getSession().getAttribute(LOGIN_IN_GZH_SESSION);
				GZH_ID = (String) loginGZH.get("GZH_ID");
				record.put("GZH_ID", GZH_ID);
				i = webBcService.insert(record);
			}else{
				i = webBcService.update(record);
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
	@RequestMapping("/update")
	@ResponseBody
	public RetObj update(HttpServletRequest request) {
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		Map loginGZH = (Map) request.getSession().getAttribute(LOGIN_IN_GZH_SESSION);
		String GZH_ID = (String) loginGZH.get("GZH_ID");
		record.put("GZH_ID", GZH_ID);
		try {
			
			int i = webBcService.update(record);
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
