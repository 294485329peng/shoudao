package com.wp.project.background.userManagement.controller;

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
import com.wp.project.background.userManagement.service.IUserManagementService;
import com.wp.project.businessManagement.Subscription.service.ISubscriptionService;

@Controller  
@RequestMapping("/userManagement")
public class UserManagementController extends BaseController {
	@Autowired
	private IUserManagementService userManagement;
	@RequestMapping("/forListUser")  
    public String forListUser(HttpServletRequest request,PageView pageView){
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		Map loginGZH = (Map) request.getSession().getAttribute(LOGIN_IN_GZH_SESSION);
		String GZH_ID = (String) loginGZH.get("GZH_ID");
		record.put("SUBSCRIBE", "1");
		record.put("GZH_ID", GZH_ID);
		try {
			pageView = userManagement.queryPage(pageView, record);
		} catch (Exception e) {
			e.printStackTrace();
		}
		request.setAttribute("pageView", pageView);
		request.setAttribute("record", record);
        return "client/userManagement/forListUser";  
    }
	/*@RequestMapping("/save")
	@ResponseBody
    public RetObj save(HttpServletRequest request,Model model){  
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		@SuppressWarnings("rawtypes")
		Map operatorMap=(Map)request.getSession().getAttribute(LOGIN_IN_OPERATOR_SESSION);
		if(operatorMap!=null){
			String OPERATOR_ID = (String)operatorMap.get("OPERATOR_ID");
			record.put("OPERATOR_ID", OPERATOR_ID);
			subscriptionService.insert(record);
		}else{
			return new RetObj(false,"用户不存在,操作失败!");
		}		
		//String json = JSONArray.fromObject(list).toString();
        return new RetObj(true,request);  
    }*/
	@RequestMapping("/update")
	@ResponseBody
    public RetObj update(HttpServletRequest request,Model model){  
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		//String json = JSONArray.fromObject(list).toString();
        return new RetObj(true,request);  
    }
}
