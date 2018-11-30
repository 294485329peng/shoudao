package com.wp.project.businessManagement.UserInfo.controller;

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
import com.wp.common.utils.IsNullOrEmpty;
import com.wp.common.utils.StringUtils;
import com.wp.project.background.MaterialLibrary.service.IMaterialLibrary;
import com.wp.project.background.WXReply.service.IAttentionReplyService;
import com.wp.project.background.WXReply.service.IAutoReplyService;
import com.wp.project.businessManagement.UserInfo.service.IUserInfoService;

@Controller  
@RequestMapping("/userInfo")
public class UserInfoController extends BaseController{
	@Autowired
	private IUserInfoService userInfoService;
	
	@RequestMapping("/forUserInfo")  
    public String forAttentionReply(HttpServletRequest request,Model model){
		Map loginGZH = (Map) request.getSession().getAttribute(LOGIN_IN_GZH_SESSION);
		String GZH_ID = (String) loginGZH.get("GZH_ID");
		Map record = userInfoService.get(GZH_ID);
		request.setAttribute("record", record);
        return "client/userInfo/forUserInfo";  
    }
	@RequestMapping("/insert")
	@ResponseBody
    public RetObj insert(HttpServletRequest request){ 
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		try {
			if(IsNullOrEmpty.isNullOrEmpty(record.get("GZH_ID"))){
				Map loginGZH = (Map) request.getSession().getAttribute(LOGIN_IN_GZH_SESSION);
				String GZH_ID = (String) loginGZH.get("GZH_ID");
				record.put("GZH_ID", GZH_ID);
				userInfoService.insert(record);
			}else{
				userInfoService.update(record);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return new RetObj(false,"操作失败！");
		}
		
		
        return new RetObj(true,"操作成功！",record);  
    }
	
	@RequestMapping("/update")
	@ResponseBody
    public RetObj update(HttpServletRequest request,Model model){  
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		try{
			userInfoService.update(record);
		}catch(Exception e){
			e.printStackTrace();
			return new RetObj(false,"修改失败！");
		}
		
        return new RetObj(true,"修改成功！");  
    }
	@RequestMapping("/getServicePhone")
	@ResponseBody
    public RetObj getServicePhone(HttpServletRequest request){ 
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		try {
			Map loginGZH = (Map) request.getSession().getAttribute(LOGIN_IN_GZH_SESSION);
			String GZH_ID = (String) loginGZH.get("GZH_ID");
			record = userInfoService.get(GZH_ID);
		} catch (Exception e) {
			e.printStackTrace();
			return new RetObj(false,"操作失败！");
		}
		
		
        return new RetObj(true,"操作成功！",record);  
    }
}
