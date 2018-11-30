package com.wp.common.Filter;

import java.io.IOException;
import java.util.Map;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.wp.common.cSession.CSession;
import com.wp.common.cSession.SessionUser;


public class SessionFilter implements Filter {
	private String encoding;

	public SessionFilter() {
	}

	public void init(FilterConfig filterconfig) throws ServletException {
		encoding = "utf-8";
	}

	public void doFilter(ServletRequest servletrequest,
			ServletResponse servletresponse, FilterChain filterchain)
			throws IOException, ServletException {
		servletrequest.setCharacterEncoding(encoding);
		servletresponse.setCharacterEncoding(encoding);
		HttpServletRequest req = (HttpServletRequest) servletrequest;
		HttpSession session = req.getSession();
		HttpServletResponse resp = (HttpServletResponse) servletresponse;
		/*Map cs = null;
		cs = (Map) req.getSession(true).getAttribute("C_SESSION");*/
		/*if(req.getSession(true).getAttribute("C_SESSION") == null){
			SessionUser.clearSessionUser();
		}else{
			System.out.println(req.getSession(true).getAttribute("C_SESSION"));*/
			CSession cs = (CSession) req.getSession(true).getAttribute("C_SESSION"); 
			/*Map operator = (Map) req.getSession(true).getAttribute("LOGIN_IN_OPERATOR_SESSION"); 
	        //System.out.println(cs);
			if(null != operator){
				SessionUser.setSessionUserMap(operator);
			}*/
			
	        SessionUser.setSessionUser(cs);
		//}
		 

		filterchain.doFilter(servletrequest, servletresponse);
	}

	public void destroy() {
	}
}
