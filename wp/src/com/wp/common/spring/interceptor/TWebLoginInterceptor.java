package com.wp.common.spring.interceptor;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.wp.common.controller.BaseController;

public class TWebLoginInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
//		HandlerMethod method = (HandlerMethod) handler;
//		Access access = method.getMethodAnnotation(Access.class);
//		if (access != null) {
//			String role = access.role();
//			System.out.println(role + "  fffffffffffffffffffffffffffffffffffffffffff");
//		}

		// method.getMethodAnnotation(annotationType)
		// System.out.println(method.);
		// MethodNameResolver methodNameResolver = new
		// InternalPathMethodNameResolver();
		// System.out.println("methodName="+methodNameResolver.getHandlerMethodName(request));
		
		/*String reTicket = request.getParameter("ticket");
		String userId = request.getParameter("id");
		if(null == request.getSession().getAttribute("seTicket")){
			Map seTicket = new HashMap();
			if(null == reTicket || "".equals(reTicket)){
				return false;
			}
			seTicket.put("gzhId", reTicket);
			if(null != userId &&  !"".equals(userId)){
				seTicket.put("userId", userId);	
			}
			request.getSession().setAttribute("seTicket", seTicket);
		}else if(null != reTicket &&  !"".equals(reTicket)){
			Map seTicket = (Map) request.getSession().getAttribute("seTicket");
			
			if(!seTicket.get("gzhId").equals(reTicket)){
				seTicket.put("gzhId", reTicket);
				
			}
			if(!seTicket.get("userId").equals(userId)){
				seTicket.put("userId", userId);
				
			}
			request.getSession().setAttribute("seTicket", seTicket);
		}*/
		
		String path = request.getContextPath();
		//String ctxPath = (String) request.getSession().getServletContext().getAttribute("ctx");
		String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
		String[] safeFilters = new String[] { "/TWeb/Member/login", "/TWeb/Member/loginCheck", "/TWeb/Member/sessionTimeOut","/TWeb/Member/logout","/MemberCenter/memberInfo"};
		String[] noFilters = new String[] { "/TWeb/Member/login", "/TWeb/Member/loginCheck", "/TWeb/Member/sessionTimeOut","/TWeb/Member/logout","/MemberCenter/memberInfo"};
		String uri = request.getRequestURI();
		boolean pass = false;
		for (int i = 0; i < noFilters.length; i++) {
			if (uri.startsWith(path + noFilters[i])) {
				pass = true;
				break;
			}
		}
		if (pass) {
			return true;
		} else {
			if (request.getSession().getAttribute(BaseController.LOGIN_IN_TWEB_MEMBER_SESSION) != null) {
				return true;
			} else {
				response.sendRedirect(basePath + "sessionTimeOut.do");
				return false;
			}
		}
		//return true;
	}

}
