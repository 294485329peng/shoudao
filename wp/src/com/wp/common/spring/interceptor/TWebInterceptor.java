package com.wp.common.spring.interceptor;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.wp.common.controller.BaseController;
import com.wp.common.utils.IsNullOrEmpty;
import com.wp.project.businessManagement.Subscription.service.ISubscriptionService;
import com.wp.project.businessManagement.Subscription.service.SubscriptionServiceImpl;
import com.wp.project.tinyWebsite.memberLogin.service.MemberLoginServiceImpl;

public class TWebInterceptor extends HandlerInterceptorAdapter {
	@Autowired
	private SubscriptionServiceImpl subscriptionService;
	@Autowired
	private MemberLoginServiceImpl memberLoginService;
	
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		
		
		String path = request.getContextPath();
		String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
		
		String customer = request.getParameter("customer");
		String store = request.getParameter("store");
		
		Map seTicket = (Map) request.getSession().getAttribute("seTicket");
		
		if(IsNullOrEmpty.isNullOrEmpty(seTicket)){
			Map tempMap = new HashMap<>();
			if(null == store || "".equals(store)){
				response.sendRedirect(basePath + "notFound.do");
				return false;
			}else{
				String GZH_ID = request.getParameter("store");
				Map storeMap = subscriptionService.getWXGzh(GZH_ID);
				if(null == storeMap){
					response.sendRedirect(basePath + "notFound.do");
					return false;
				}
				tempMap.put("gzhId", store);
				tempMap.put("template", storeMap.get("TEMPLATE"));
			}
			
			if(null != customer &&  !"".equals(customer)){
				Map userMap = new HashMap<>();
				userMap.put("OPEN_ID", customer);
				userMap.put("GZH_ID", store);
				Map map = memberLoginService.getByOpenIdGzh(userMap);
				if(null != map){
					tempMap.put("userId", customer);
				}
			}
			if(!IsNullOrEmpty.isNullOrEmpty(tempMap)){
				seTicket = tempMap;
				request.getSession().setAttribute("seTicket", seTicket);
			}
			
		}else {
			if(null != store &&  !"".equals(store)){
				if(store.equals(seTicket.get("gzhId").toString())){
					if(IsNullOrEmpty.isNullOrEmpty(seTicket.get("template"))){
						String GZH_ID = request.getParameter("store");
						Map smap = subscriptionService.getWXGzh(GZH_ID);
						seTicket.put("template", smap.get("TEMPLATE"));
						if(IsNullOrEmpty.isNullOrEmpty(smap)){
							request.getSession().removeAttribute("seTicket");
							response.sendRedirect(basePath + "notFound.do");
							return false;
						}
					}
				}else{
					String GZH_ID = request.getParameter("store");
					Map smap = subscriptionService.getWXGzh(GZH_ID);
					if(IsNullOrEmpty.isNullOrEmpty(smap)){
						request.getSession().removeAttribute("seTicket");
						response.sendRedirect(basePath + "notFound.do");
						return false;
					}
					seTicket.put("gzhId", GZH_ID);
					seTicket.put("template", smap.get("TEMPLATE"));
				}
				
			}
			
			if(null != customer &&  !"".equals(customer)){
				if(IsNullOrEmpty.isNullOrEmpty(seTicket.get("customer")) || !customer.equals(seTicket.get("customer").toString())){
					Map userMap = new HashMap<>();
					userMap.put("OPEN_ID", customer);
					userMap.put("GZH_ID", store);
					Map map = memberLoginService.getByOpenIdGzh(userMap);
					if(null == map){
						seTicket.put("userId", "");
						
					}
					seTicket.put("userId", customer);
				}
			}
			
			request.getSession().setAttribute("seTicket", seTicket);
		}
		
		
		//String ctxPath = (String) request.getSession().getServletContext().getAttribute("ctx");
		
		String[] safeFilters = new String[] { "/MemberCenter", "/Center/MemberFinishOrder", "/TWeb/order","/TWeb/cart/memberShopCart","/TWebLogin/Administrators"};
		//String[] normalFilters = new String[] { "/TWeb/Member/login", "/TWeb/Member/loginCheck", "/TWeb/Member/sessionTimeOut","/TWeb/Member/logout","/MemberCenter/memberInfo"};
		String uri = request.getRequestURI();
		boolean pass = true;
		for (int i = 0; i < safeFilters.length; i++) {
			if (uri.startsWith(path + safeFilters[i])) {
				pass = false;
				break;
			}
		}
		if (pass) {
			return true;
		} else {
			if (null != seTicket.get("userId") && !"".equals(seTicket.get("userId"))) {
				//String OPEN_ID = seTicket.get("userId").toString();
				return true;
			} else {
				response.sendRedirect(basePath + "TWebLogin/Member/login.htmls");
				return false;
			}
		}
		//return true;
	}
}
