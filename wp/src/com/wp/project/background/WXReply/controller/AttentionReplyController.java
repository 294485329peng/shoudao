package com.wp.project.background.WXReply.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;  
import javax.servlet.http.HttpServletRequest;   

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;  
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;  
import org.springframework.web.bind.annotation.RequestMapping;  
import org.springframework.web.bind.annotation.ResponseBody;

import com.wp.common.RetObj;
import com.wp.common.controller.BaseController;
import com.wp.common.page.PageView;
import com.wp.common.utils.DateUtils;
import com.wp.common.utils.HttpUtils;
import com.wp.common.utils.StringUtils;
import com.wp.project.background.MaterialLibrary.service.IMaterialLibrary;
import com.wp.project.background.WXReply.service.IAttentionReplyService;
import com.wp.project.background.WXReply.service.IAutoReplyService;

@Controller  
@RequestMapping("/attentionReply")
public class AttentionReplyController extends BaseController{
	@Autowired
	private IMaterialLibrary materialLibrary;
	@Autowired
	private IAttentionReplyService attentionReplyService;
	@RequestMapping("/forAttentionReply")  
    public String forAttentionReply(HttpServletRequest request,Model model){
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		Map loginGZH = (Map) request.getSession().getAttribute(LOGIN_IN_GZH_SESSION);
		String GZH_ID = (String) loginGZH.get("GZH_ID");
		try{
		record = attentionReplyService.get(GZH_ID);
		
		}catch(Exception e) {
			e.printStackTrace();
			attentionReplyService.delete(GZH_ID);
			Map<String,Object> exception = new HashMap<String, Object>();
			exception.put("flag", true);
			exception.put("instruction", "关注回复出现异常，已经自动删除，请重新打开发布，如还有异常请联系管理员！");
			request.setAttribute("exception", exception);
		}
		request.setAttribute("record", record);
		request.setAttribute("record", record);
	        return "client/WXReply/attentionReply/forAttentionReply";  
    }
	@RequestMapping("/save")
	@ResponseBody
    public RetObj save(HttpServletRequest request,Model model){  
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		Map loginGZH = (Map) request.getSession().getAttribute(LOGIN_IN_GZH_SESSION);
		String GZH_ID = (String) loginGZH.get("GZH_ID");
		record.put("GZH_ID", GZH_ID);
		attentionReplyService.insert(record);
		//String json = JSONArray.fromObject(list).toString();
        return new RetObj(true,request);  
    }
	@RequestMapping("/update")
	@ResponseBody
    public RetObj update(HttpServletRequest request,Model model){  
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		attentionReplyService.update(record);
		//String json = JSONArray.fromObject(list).toString();
        return new RetObj(true,request);  
    }
	@RequestMapping("/selectIT")
	public String selectIT(HttpServletRequest request, PageView pageView) {
		Map<String, Object> record = HttpUtils.getRequestMap(request);
		Map loginGZH = (Map) request.getSession().getAttribute(LOGIN_IN_GZH_SESSION);
		String GZH_ID = (String) loginGZH.get("GZH_ID");
		record.put("GZH_ID", GZH_ID);
		pageView.setPageSize(6);
		try {
			pageView = materialLibrary.queryPage(pageView, record);

		} catch (Exception e) {
			e.printStackTrace();
		}
		request.setAttribute("pageView", pageView);
		request.setAttribute("record", record);
		//return "client/massfunction/selectITFream";
		return "client/WXReply/attentionReply/selectIT";
	}
}
