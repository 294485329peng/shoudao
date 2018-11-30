package com.wp.project.background.menu.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;  
import javax.servlet.http.HttpServletRequest;   
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;  
import org.springframework.ui.Model;  
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.RequestMapping;  
import org.springframework.web.bind.annotation.ResponseBody;

import com.wp.common.RetObj;
import com.wp.common.controller.BaseController;
import com.wp.common.page.PageView;
import com.wp.common.utils.DateUtils;
import com.wp.common.utils.HttpUtils;
import com.wp.common.utils.StringUtils;
import com.wp.project.background.MaterialLibrary.service.IMaterialLibrary;
import com.wp.project.background.menu.service.IZdycdService;


@Controller  
@RequestMapping("/zdycd") 
public class ZdycdController extends BaseController{
	@Autowired
	private IZdycdService zdycdService;
	@Autowired
	private IMaterialLibrary materialLibrary;
	
	@RequestMapping("/home")  
    public String toAdmin(HttpServletRequest request,Model model){  
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		Map loginGZH = (Map) request.getSession().getAttribute(LOGIN_IN_GZH_SESSION);
		String GZH_ID = (String) loginGZH.get("GZH_ID");
		record.put("GZH_ID", GZH_ID);
		List<Map> list = zdycdService.query(record);
		if(3 < list.size()){
			Map<String,Object> exception = new HashMap<String, Object>();
			exception.put("flag", true);
			exception.put("instruction", "自定义菜单出现异常，请删除全部重新发布，如还有异常请联系管理员！");
			request.setAttribute("exception", exception);
		}
		//request.setAttribute("intaa", 1);
        return "client/zdycd/zdycd";  
    } 
	@RequestMapping("/addMenu")  
    public String toBcHome(HttpServletRequest request,Model model){  
		Map<String,Object> record = HttpUtils.getRequestMap(request);
    	request.setAttribute("record", record);
        return "client/zdycd/addMenu";  
    }
	@RequestMapping("/queryAdminMenu")
	@ResponseBody
    public RetObj queryAdminMenu(HttpServletRequest request,Model model){  
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		Map loginGZH = (Map) request.getSession().getAttribute(LOGIN_IN_GZH_SESSION);
		String GZH_ID = (String) loginGZH.get("GZH_ID");
		record.put("GZH_ID", GZH_ID);
		List<Map> list = zdycdService.query(record);
		 
		//String json = JSONArray.fromObject(list).toString();
        return new RetObj(true,request,list);  
    }
	@RequestMapping("/queryChildMenu")
	@ResponseBody
    public RetObj queryChildMenu(HttpServletRequest request,Model model){  
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		List<Map> list = zdycdService.queryChildMenu(record);
		//String json = JSONArray.fromObject(list).toString();
        return new RetObj(true,request,list);  
    }
	@RequestMapping("/xydz")  
    public String toXydz(HttpServletRequest request,String cfdz){  
    	Map<String,Object> record = HttpUtils.getRequestMap(request);
		request.setAttribute("record", record);
    	if(record.get("CFDZ").equals("1")){
    		return "client/zdycd/cfMessage";
    	}else if(record.get("CFDZ").equals("2")){
    		return "client/zdycd/cfImageText";
    	}else if(record.get("CFDZ").equals("3")){
    		return "client/zdycd/cfkeyword";
    	}
    	record.put("ERROR", "ERROR");
        return "error";  
    }
	@RequestMapping("/getByITID")  
	@ResponseBody
    public RetObj getByITID(HttpServletRequest request,Model model){  
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		String IT_ID = (String) record.get("IT_ID");
		try {			
			record = zdycdService.get(IT_ID);
			return new RetObj(true,request,record);
		} catch (Exception e) {
			if(logger.isDebugEnabled()){
				logger.error(e.getMessage());
			}
			return new RetObj(false,request);
		}  
    }
	@RequestMapping("/deleteMenu")  
	@ResponseBody
    public RetObj deleteMenu(HttpServletRequest request,Model model){  
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		String MENU_ID = (String) record.get("MENU_ID");
		try {			
			zdycdService.deleteChildMenu(MENU_ID);
			return new RetObj(true,request);
		} catch (Exception e) {
			if(logger.isDebugEnabled()){
				logger.error(e.getMessage());
			}
			return new RetObj(false,request);
		}  
    }
	@RequestMapping("/deleteAllMenu")  
	@ResponseBody
    public RetObj deleteAllMenu(HttpServletRequest request,Model model){  
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		Map loginGZH = (Map) request.getSession().getAttribute(LOGIN_IN_GZH_SESSION);
		String GZH_ID = (String) loginGZH.get("GZH_ID");
		try {			
			zdycdService.deleteAllAdminMenu(GZH_ID);
			zdycdService.deleteAllChildMenu(GZH_ID);
			return new RetObj(true,request);
		} catch (Exception e) {
			if(logger.isDebugEnabled()){
				logger.error(e.getMessage());
			}
			return new RetObj(false,request);
		}  
    }
	@RequestMapping("/deleteMenuByGroupId")  
	@ResponseBody
    public RetObj deleteMenuByGroupId(HttpServletRequest request,Model model){  
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		String SCD_MENU_GROUP_ID = (String) record.get("SCD_MENU_GROUP_ID");
		String MENU_ID = (String) record.get("MENU_ID");
		try {
			zdycdService.deleteAdminMenu(MENU_ID);
			zdycdService.deleteMenuByGroupId(SCD_MENU_GROUP_ID);
			return new RetObj(true,request);
		} catch (Exception e) {
			if(logger.isDebugEnabled()){
				logger.error(e.getMessage());
			}
			return new RetObj(false,request);
		}  
    }
	@RequestMapping("/newMainAddMessage")
	public String newMainAddMessage(HttpServletRequest request) {
		return "client/meteriallibrary/newMainAddMessage";
	}
	@RequestMapping("/selectIT")  
    public String selectIT(HttpServletRequest request,PageView pageView){ 
		Map loginGZH = (Map) request.getSession().getAttribute(LOGIN_IN_GZH_SESSION);
		String GZH_ID = (String) loginGZH.get("GZH_ID");
    	Map<String,Object> record = HttpUtils.getRequestMap(request);
    	record.put("GZH_ID", GZH_ID);
		pageView.setPageSize(6);
		try {
			pageView = materialLibrary.queryPage(pageView, record);

		} catch (Exception e) {
			e.printStackTrace();
		}
		request.setAttribute("pageView", pageView);
		request.setAttribute("record", record);
        return "client/zdycd/selectIT";  
    }
	@RequestMapping("/saveAdminMenu")
	@ResponseBody
	public RetObj saveAdminMenu(HttpServletRequest request) {
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		Map loginGZH = (Map) request.getSession().getAttribute(LOGIN_IN_GZH_SESSION);
		String GZH_ID = (String) loginGZH.get("GZH_ID");
		record.put("GZH_ID", GZH_ID);
		try {			
			record = zdycdService.insert_adminMenu(record);
			return new RetObj(true,request,record);
		} catch (Exception e) {
			if(logger.isDebugEnabled()){
				logger.error(e.getMessage());
			}
			return new RetObj(false,request);
		}
	
	}
	@RequestMapping("/saveChildMenu")
	@ResponseBody
	public RetObj saveChildMenu(HttpServletRequest request) {
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		Map loginGZH = (Map) request.getSession().getAttribute(LOGIN_IN_GZH_SESSION);
		String GZH_ID = (String) loginGZH.get("GZH_ID");
		record.put("GZH_ID", GZH_ID);
		try {			
			record = zdycdService.insert_childMenu(record);
			return new RetObj(true,request,record);
		} catch (Exception e) {
			if(logger.isDebugEnabled()){
				logger.error(e.getMessage());
			}
			return new RetObj(false,request);
		}
	}
	@RequestMapping("/updateMenuRank")
	@ResponseBody
	public RetObj updateMenuRank(HttpServletRequest request) {
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		try {			
			zdycdService.update(record);
			return new RetObj(true,request,record);
		} catch (Exception e) {
			if(logger.isDebugEnabled()){
				logger.error(e.getMessage());
			}
			return new RetObj(false,request);
		}
	
	}
	@RequestMapping("/updateAdminMenu")
	@ResponseBody
	public RetObj updateAdminMenu(HttpServletRequest request){
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		try{			
			record = zdycdService.updateAdminMenu(record);
			request.setAttribute("record",record);
			return new RetObj(true,request,record);
		}catch(Exception e){
			if(logger.isDebugEnabled()){
				logger.error(e.getMessage());
			}
			return new RetObj(false,request);
		} 
    }
	@RequestMapping("/updateChildMenu")
	@ResponseBody
	public RetObj updateChildMenu(HttpServletRequest request){
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		try{			
			record = zdycdService.updateChildMenu(record);
			request.setAttribute("record",record);
			return new RetObj(true,request,record);
		}catch(Exception e){
			if(logger.isDebugEnabled()){
				logger.error(e.getMessage());
			}
			return new RetObj(false,request);
		} 
    }
	/***
	 * 
	 * @Description: TODO
	 * @param @param request
	 * @param @param model
	 * @param @return   
	 * @return RetObj  
	 * @throws
	 * @author daiwk
	 * @date 2016年1月12日
	 */
	@RequestMapping("/publishMenu")
	@ResponseBody
    public RetObj publishMenu(HttpServletRequest request){  
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		try{
			Map loginGZH = (Map) request.getSession().getAttribute(LOGIN_IN_GZH_SESSION);
			String GZH_ID = (String) loginGZH.get("GZH_ID");
			record.put("GZH_ID", GZH_ID);
			record.put("GZH_AUTH_TYPE", loginGZH.get("GZH_AUTH_TYPE"));
			int i = zdycdService.publishMenu(record);
			//String json = JSONArray.fromObject(list).toString();
			if(i == 0){
				return new RetObj(true);
			}else{
				return new RetObj(false);
			}
        
		}catch(Exception e){
			if(logger.isDebugEnabled()){
				logger.error(e.getMessage());
			}
			return new RetObj(false,request);
		} 
    }
	@RequestMapping("/repealMenu")
	@ResponseBody
    public RetObj repealMenu(HttpServletRequest request){  
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		try{
			Map loginGZH = (Map) request.getSession().getAttribute(LOGIN_IN_GZH_SESSION);
			String GZH_ID = (String) loginGZH.get("GZH_ID");
			record.put("GZH_ID", GZH_ID);
			record.put("GZH_AUTH_TYPE", loginGZH.get("GZH_AUTH_TYPE"));
			int i = zdycdService.publishMenu(record);
			//String json = JSONArray.fromObject(list).toString();
			if(i == 0){
				return new RetObj(true);
			}else{
				return new RetObj(false);
			}
        
		}catch(Exception e){
			if(logger.isDebugEnabled()){
				logger.error(e.getMessage());
			}
			return new RetObj(false,request);
		} 
    }
}
