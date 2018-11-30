package com.wp.project.background.MassFunction.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;  
import javax.servlet.http.HttpServletRequest;   

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;  
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;  
import org.springframework.web.bind.annotation.RequestMapping;  
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wp.common.RetObj;
import com.wp.common.controller.BaseController;
import com.wp.common.page.PageView;
import com.wp.common.utils.DateUtils;
import com.wp.common.utils.HttpUtils;
import com.wp.common.utils.StringUtils;
import com.wp.project.background.MassFunction.service.IMassFunctionService;
import com.wp.project.background.MaterialLibrary.service.IMaterialLibrary;
import com.wp.project.background.PicUpload.service.IPicUploadService;

@Controller  
@RequestMapping("/massfunction") 
public class MassFunctionController extends BaseController{
	@Autowired
	private IMaterialLibrary materialLibrary;
	@Autowired 
	private IMassFunctionService massFunctionService;
	@Autowired
	private IPicUploadService picUploadService;
	
	@RequestMapping("/forMassFunction")  
    public String forShowAddMessage(HttpServletRequest request,String IT_TYPE){
		Map<String, Object> record = HttpUtils.getRequestMap(request);
		Map loginGZH = (Map) request.getSession().getAttribute(LOGIN_IN_GZH_SESSION);
		record.put("GZH_ID", loginGZH.get("GZH_ID").toString());
		String GZH_AUTH_TYPE = loginGZH.get("GZH_AUTH_TYPE").toString();
		request.setAttribute("GZH_AUTH_TYPE", GZH_AUTH_TYPE);
		if("10".equals(GZH_AUTH_TYPE) || "20".equals(GZH_AUTH_TYPE)){
			record.put("NUMBER", "100"); //返回100 表示是未认证
			request.setAttribute("record", record);
			return "client/massfunction/forMassFunction";
		}
		record.put("GZH_AUTH_TYPE", loginGZH.get("GZH_AUTH_TYPE").toString());
		List list = massFunctionService.isMassMessage(record);
		if("21".equals(GZH_AUTH_TYPE)){
			record.put("NUMBER", 24-list.size());
		}else{
			record.put("NUMBER", 1-list.size());
		}
		request.setAttribute("record", record);
        return "client/massfunction/forMassFunction";  
    }
	/* 
	 * 选择图文信息 
	 * 
	 */
	@RequestMapping("/selectITFream")
	public String selectITFream(HttpServletRequest request, PageView pageView) {
		Map<String, Object> record = HttpUtils.getRequestMap(request);
		Map loginGZH = (Map) request.getSession().getAttribute(LOGIN_IN_GZH_SESSION);
		String GZH_ID = (String) loginGZH.get("GZH_ID");
		record.put("GZH_ID", GZH_ID);
		pageView.setPageSize(6);
		try {
			pageView = materialLibrary.queryPage(pageView, record);

		} catch (Exception e) {
			e.printStackTrace();
		}
		request.setAttribute("pageView", pageView);
		request.setAttribute("record", record);
		return "client/massfunction/selectITFream";
	}
	@RequestMapping("/selectIT")
	public String selectIT(HttpServletRequest request, PageView pageView) {
		Map<String, Object> record = HttpUtils.getRequestMap(request);
		Map loginGZH = (Map) request.getSession().getAttribute(LOGIN_IN_GZH_SESSION);
		String GZH_ID = (String) loginGZH.get("GZH_ID");
		record.put("GZH_ID", GZH_ID);
		pageView.setPageSize(6);
		try {
			pageView = materialLibrary.queryPage(pageView, record);

		} catch (Exception e) {
			e.printStackTrace();
		}
		request.setAttribute("pageView", pageView);
		request.setAttribute("record", record);
		//return "client/massfunction/selectITFream";
		return "client/massfunction/selectIT";
	}
	@RequestMapping("/getMassByMassId")
	public String getMassByMassId(HttpServletRequest request, String MASS_ID) {
		Map<String, Object> record = HttpUtils.getRequestMap(request);
		record = materialLibrary.get(MASS_ID);
		request.setAttribute("record", record);
		return "client/massfunction/selectIT";
	}
	@RequestMapping("/addHyperlink")
	public String addHyperlink(HttpServletRequest request, PageView pageView) {
		/*Map<String,Object> record = HttpUtils.getRequestMap(request);
		Map loginGZH = (Map) request.getSession().getAttribute(LOGIN_IN_GZH_SESSION);
		String GZH_ID = (String) loginGZH.get("GZH_ID");
		pageView = materialLibrary.queryPage(pageView, record);
		request.setAttribute("pageView", pageView);
		request.setAttribute("record", record);*/
		return "client/massfunction/addHyperlink";
	}
	@RequestMapping("/massMessage")
	@ResponseBody
    public RetObj massMessage(HttpServletRequest request,Model model){  
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		Map loginGZH = (Map) request.getSession().getAttribute(LOGIN_IN_GZH_SESSION);
		String GZH_ID = (String) loginGZH.get("GZH_ID");
		record.put("GZH_ID", GZH_ID);
		if(record.get("TYPE") == "2"){
			Map<String,Object> pic_map = picUploadService.getPicById(record.get("PIC_ID").toString());
			record.put("PIC_MEDIA_ID", pic_map.get("MEDIA_ID").toString());
		}
		record = massFunctionService.insert_map(record);
		if(record == null){
			return new RetObj(false);
		}
		//String json = JSONArray.fromObject(list).toString();
        return new RetObj(true,request);  
    }
}
