
package com.wp.common.utils;

import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

/**
 * @ClassName: HttpUtils
 * @Description: 和requst response session等对象相关的工具类
 * @author: wp
 * @date: 2015年8月28日下午4:32:51
 */
public class HttpUtils {
	/**
	 * 
	 * @Title: getRequestMap
	 * @author：wp 
	 * @date：2015年8月28日下午4:37:08
	 * @Description: 获取简单表单对象，转化为map
	 * @param request
	 * @return
	 */
	public static Map<String,Object> getRequestMap(HttpServletRequest request){
		Map<String,Object> requestMap = new HashMap<String,Object>();
		Enumeration<String> enu = request.getParameterNames();
		while(enu.hasMoreElements()){
		       String key=enu.nextElement().toString();
		       String value=request.getParameter(key);
		       requestMap.put(key, value);
		}
		return requestMap;
	}
}
