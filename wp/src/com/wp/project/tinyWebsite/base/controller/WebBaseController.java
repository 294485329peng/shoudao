package com.wp.project.tinyWebsite.base.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wp.common.RetObj;
import com.wp.common.controller.BaseController;
import com.wp.common.page.PageView;
import com.wp.common.utils.HttpUtils;
import com.wp.project.businessManagement.UserInfo.service.IUserInfoService;
import com.wp.project.tinyWebsite.base.service.IWebBaseService;

/**
 * 
 * ClassName: BaseController
 * @Description: 首页等基本信息控制
 * @author daiwk
 * @date 2016年1月18日
 */
@Controller  
@RequestMapping("/TWeb/bs")
public class WebBaseController extends BaseController{
	@Autowired
	private IWebBaseService webBaseService;
	@Autowired
	private IUserInfoService userInfoService;
	
	@RequestMapping("/home.htmls") 
	public String forHome(HttpServletRequest request){
		Map<String, Object> record = HttpUtils.getRequestMap(request);
		Map seTicket =  (Map) request.getSession().getAttribute("seTicket");
		String GZH_ID = (String) seTicket.get("gzhId");
		String template = (String) seTicket.get("template");
		Map map = webBaseService.get(GZH_ID);
		map.put("GZH_ID", GZH_ID);
		request.setAttribute("record",map);
		return "template/"+template+"/home";
	}
	@RequestMapping("/getServicePhone.htmls")
	@ResponseBody
    public RetObj getServicePhone(HttpServletRequest request){ 
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		try {
			Map seTicket =  (Map) request.getSession().getAttribute("seTicket");
			String GZH_ID = (String) seTicket.get("gzhId");
			record = userInfoService.get(GZH_ID);
		} catch (Exception e) {
			e.printStackTrace();
			return new RetObj(false,"操作失败！");
		}
		
		
        return new RetObj(true,"操作成功！",record);  
    }
}
