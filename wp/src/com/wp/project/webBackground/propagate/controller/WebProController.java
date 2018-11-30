package com.wp.project.webBackground.propagate.controller;

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
import com.wp.project.webBackground.propagate.service.IWebProService;

@Controller
@RequestMapping("/webPro")
public class WebProController extends BaseController {
	@Autowired
	private IWebProService iWebProService;
	
	@RequestMapping("/proList") 
	public String proList(HttpServletRequest request,PageView pageView){
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		Map loginGZH = (Map) request.getSession().getAttribute(LOGIN_IN_GZH_SESSION);
		record.put("GZH_ID", (String) loginGZH.get("GZH_ID"));
		try {
			pageView = iWebProService.queryPage(pageView, record);
		} catch (Exception e) {
			e.printStackTrace();
		}
		request.setAttribute("pageView", pageView);
		request.setAttribute("record", record);
		return "client/webBackground/webProController/ProList";
	}
	@RequestMapping("/addPro") 
	public String addPro(HttpServletRequest request){
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		Map loginGZH = (Map) request.getSession().getAttribute(LOGIN_IN_GZH_SESSION);
		record.put("GZH_ID", (String) loginGZH.get("GZH_ID"));
		try {
			if(null == record.get("PRO_ID") || "" == (String)record.get("PRO_ID")){
				return "client/webBackground/webProController/addPro";
			}
			record = iWebProService.get(record.get("PRO_ID").toString());
			String url = "http://www.wxplatform.top/wp/TWeb/webPros/propagate.htmls?store="+loginGZH.get("GZH_ID").toString()+"&PRO_ID=" + record.get("PRO_ID").toString();
			record.put("PRO_URL", url);
			request.setAttribute("record", record);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "client/webBackground/webProController/addPro";
	}
	@RequestMapping("/insertPro")
	@ResponseBody
	public RetObj insertPro(HttpServletRequest request) {
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		Map loginGZH = (Map) request.getSession().getAttribute(LOGIN_IN_GZH_SESSION);
		record.put("GZH_ID", (String) loginGZH.get("GZH_ID"));
		try {
			if(null == record.get("PRO_ID") || "" == (String)record.get("PRO_ID")){
				record = iWebProService.insert_map(record);
				if(record !=  null){
					String url = "http://www.wxplatform.top/wp/TWeb/webPros/propagate.htmls?store="+loginGZH.get("GZH_ID").toString()+"&PRO_ID=" + record.get("PRO_ID").toString();
					record.put("PRO_URL", url);
					return new RetObj(true,"添加成功！",record);
				}else{
					return new RetObj(false,"添加失败，请稍后再试！",record);
				}
			}else{
				int i = iWebProService.update(record);
				String url = "http://www.wxplatform.top/wp/TWeb/webPros/propagate.htmls?store="+loginGZH.get("GZH_ID").toString()+"&PRO_ID=" + record.get("PRO_ID").toString();
				record.put("PRO_URL", url);
				if(i >  0){
					return new RetObj(true,"更新成功！",record);
				}else{
					return new RetObj(false,"更新失败，请稍后再试！",record);
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
	@RequestMapping("/deletePro")
	@ResponseBody
	public RetObj deletePro(HttpServletRequest request) {
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		
		try {
			String PRO_ID = (String)record.get("PRO_ID");
			int i = iWebProService.delete(PRO_ID);
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
