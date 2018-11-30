package com.wp.project.businessManagement.Subscription.controller;

import java.util.Map;

import javax.annotation.Resource;  
import javax.servlet.http.HttpServletRequest;   

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;  
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;  
import org.springframework.web.bind.annotation.RequestMapping;  
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wp.common.RetObj;
import com.wp.common.controller.BaseController;
import com.wp.common.page.PageView;
import com.wp.common.utils.DateUtils;
import com.wp.common.utils.HttpUtils;
import com.wp.common.utils.StringUtils;
import com.wp.project.background.Authorize.service.IAuthorizeService;
import com.wp.project.background.MaterialLibrary.service.IMaterialLibrary;
import com.wp.project.background.WXReply.service.IAttentionReplyService;
import com.wp.project.background.WXReply.service.IAutoReplyService;
import com.wp.project.businessManagement.Subscription.service.ISubscriptionService;
import com.wp.project.weixin.gzhMessage.bean.GzhMessage;
import com.wp.project.weixin.gzhMessage.service.GzhMessageService;

@Controller  
@RequestMapping("/subscription")
public class SubscriptionController extends BaseController {
	@Autowired
	private ISubscriptionService subscriptionService;
	@Autowired
	private GzhMessageService gzhMessageService;
	@Autowired
	private IAuthorizeService authorizeService;
	
	@RequestMapping("/forAddSubscription")
	public String forAttentionReply(HttpServletRequest request){
		/*Map record=authorizeService.getUrlData();
		request.setAttribute("record",record);*/
		return "client/Subscription/forAddSubscription"; 
	}
	@RequestMapping("/forGetWXGzhMessage")  
    public String forGetWXGzhMessage(HttpServletRequest request){
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		Map loginGZH = (Map) request.getSession().getAttribute(LOGIN_IN_GZH_SESSION);
		String GZH_ID = (String) loginGZH.get("GZH_ID");
		record = subscriptionService.getWXGzh(GZH_ID);
		request.setAttribute("record", record);
        return "client/Subscription/forGetWXGzhMessage";  
    }
	@RequestMapping("/save")
	@ResponseBody
    public RetObj save(HttpServletRequest request){  
		//Map<String,Object> record = HttpUtils.getRequestMap(request);
		//String fff= (String)request.getSession().getAttribute("GZH_ID");
		try{
			//if (null == request.getSession().getAttribute("GZH_ID")) {
				Map record=authorizeService.getUrlData();
				if(null == record){
					return new RetObj(false,"操作异常，请稍后再试!"); 
				}
				return new RetObj(true,request,record);
			/*}else {
				return new RetObj(false,"公众号已经存在，请勿重复添加!");
			}*/
			
			/*@SuppressWarnings("rawtypes")
			Map operatorMap=(Map)request.getSession().getAttribute(LOGIN_IN_OPERATOR_SESSION);
			String OPERATOR_ID = (String)operatorMap.get("OPERATOR_ID");
			Map gzhOperaMap = subscriptionService.getGzhOpera(OPERATOR_ID);
			String GZH_ID = record.get("GZH_ID").toString();
			Map wxGzhMap = subscriptionService.getWXGzh(GZH_ID);
			if(wxGzhMap != null){
				
			}
			if(gzhOperaMap!=null){
				return new RetObj(false,"您已绑定过公众号，请勿重复操作!");
			}*/
			/*record.put("OPERATOR_ID", OPERATOR_ID);
			subscriptionService.insertGzhOperaAndWXGzh(record);*/
	         
		} catch (Exception e) {
			e.printStackTrace();
			//throw new RuntimeException(); 
			return new RetObj(false,"操作异常，请稍后再试!"); 
		}
		 
    }
	@RequestMapping("/update")
	@ResponseBody
    public RetObj update(HttpServletRequest request,Model model){  
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		//String json = JSONArray.fromObject(list).toString();
        return new RetObj(true,request);  
    }
	@RequestMapping("/bonding")
	@ResponseBody
    public RetObj bonding(HttpServletRequest request,String GZH_ID,String GZH_PASSWORD){  
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		Map<String,Object> checkMap;
		//String json = JSONArray.fromObject(list).toString();
		try{
			Map operatorMap=(Map)request.getSession().getAttribute(LOGIN_IN_OPERATOR_SESSION);
			String OPERATOR_ID = (String)operatorMap.get("OPERATOR_ID");
			Map gzhOperaMap = subscriptionService.getGzhOpera(OPERATOR_ID);
			if(gzhOperaMap!=null){
				return new RetObj(false,"您已绑定过公众号，请勿重复操作!");
			}
			checkMap = subscriptionService.checkLogin(GZH_ID, GZH_PASSWORD);
			if(checkMap == null){
				return new RetObj(false,"账户或密码错误，绑定失败！"); 
			}
			record.put("OPERATOR_ID", OPERATOR_ID);
			subscriptionService.insertGzhOpera(record);
			return new RetObj(true,"绑定成功");  
		} catch (Exception e) {
			e.printStackTrace();
			//throw new RuntimeException(); 
			return new RetObj(false,"操作异常，请稍后再试!"); 
		}
    }
	@RequestMapping("/delete")
	@ResponseBody
    public RetObj delete(HttpServletRequest request){  
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		//String json = JSONArray.fromObject(list).toString();
        return new RetObj(true,request);  
    }
}
