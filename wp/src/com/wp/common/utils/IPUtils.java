package com.wp.common.utils;


import javax.servlet.http.HttpServletRequest;

public class IPUtils {

	/**
	 * 
	 *@Description: 获得ip地址
	 *@author wp   2012-9-12 上午9:13:44
	 *@return
	 */
	public static String getIpAddr(HttpServletRequest request){
			String ip = request.getHeader("x-forwarded-for");
			if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {         
				ip = request.getHeader("WL-Proxy-Client-IP");          
		    } 
		        
	        if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {         
	            ip = request.getHeader("Proxy-Client-IP");         
	        }   
	        
	        if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {         
	        	 ip = request.getRemoteAddr();        
	        }         
	       return ip;     
	}

}
