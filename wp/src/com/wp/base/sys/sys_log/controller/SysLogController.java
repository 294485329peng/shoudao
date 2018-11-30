
package com.wp.base.sys.sys_log.controller;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wp.base.sys.sys_log.service.ISysLogService;
import com.wp.common.RetObj;
import com.wp.common.controller.BaseController;
import com.wp.common.page.PageView;
import com.wp.common.utils.HttpUtils;
import com.wp.common.utils.StringUtils;

/** 
 * @ClassName: SysLogController.java
 * @Description: 
 * @author daiwk 
 * @version 2015年10月19日 下午2:44:06 
 */
@Controller
@RequestMapping("/sysLog")
public class SysLogController extends BaseController{

	@Autowired
	private ISysLogService logService;
	
	@RequestMapping("/forQueryPage")
	public String forQueryPage(HttpServletRequest request,PageView pageView) {
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		// 对应查询的mybatis的xml中的id必须以queryPage结尾，查询中加入select top 100
		// percent，结束时并按某个字段排序，否则不能进行分页
		try {
			pageView = logService.queryPage(pageView, record);
		} catch (Exception e) {
			e.printStackTrace();
		}
		request.setAttribute("pageView", pageView);
		request.setAttribute("record", record);
		return "base/sys/sys_log/sys_log_forQueryPage";
	}

}
