package com.wp.project.background.LocalMaterialLibrary.controller;

import java.util.List;
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
import com.wp.project.background.LocalMaterialLibrary.service.ILocalMaterialLibrary;
import com.wp.project.background.PicUpload.service.IPicUploadService;
import com.wp.project.weixin.gzhMessage.service.impl.GzhMessageServiceImpl;

/**
 * ClassName: MaterialLibraryController
 * @Description: TODO
 * @author daiwk
 * @date 2015年11月18日
 */

@Controller  
@RequestMapping("/localML") 
public class LocalMaterialLibraryController extends BaseController{
	@Autowired
	private ILocalMaterialLibrary localMaterialLibrary;
	@Autowired
	private IPicUploadService picUploadService;
	@Autowired 
	private GzhMessageServiceImpl gzhMessageServiceImpl;
	@RequestMapping("/localITList") 
    public String localITList(HttpServletRequest request,PageView pageView){  
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		Map loginGZH = (Map) request.getSession().getAttribute(LOGIN_IN_GZH_SESSION);
		record.put("GZH_ID", (String) loginGZH.get("GZH_ID"));
		pageView.setPageSize(12);
		try {
			pageView = localMaterialLibrary.queryPage(pageView, record);

		} catch (Exception e) {
			e.printStackTrace();
		}
		request.setAttribute("pageView", pageView);
		request.setAttribute("record", record);
        return "client/localML/localITList";  
    }
	@RequestMapping("/getLocalIT") 
	@ResponseBody
    public RetObj getLocalIT(HttpServletRequest request,String LOCAL_IT_ID){  
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		try {
			record = localMaterialLibrary.get(LOCAL_IT_ID);
			return new RetObj(true,request,record);
		} catch (Exception e) {
			e.printStackTrace();
			return new RetObj(false,request);
		}
    }
	@RequestMapping("/selectLocalITList") 
    public String selectLocalITList(HttpServletRequest request,PageView pageView){  
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		Map loginGZH = (Map) request.getSession().getAttribute(LOGIN_IN_GZH_SESSION);
		String GZH_ID = (String) loginGZH.get("GZH_ID");
		record.put("GZH_ID", GZH_ID);
		pageView.setPageSize(12);
		try {
			pageView = localMaterialLibrary.queryPage(pageView, record);

		} catch (Exception e) {
			e.printStackTrace();
		}
		request.setAttribute("pageView", pageView);
		request.setAttribute("record", record);
        return "client/localML/selectLocalIT";  
    }
	@RequestMapping("/deleteById")
	@ResponseBody
    public RetObj deleteById(HttpServletRequest request,String LOCAL_IT_ID){
		try{
			int i =localMaterialLibrary.delete(LOCAL_IT_ID);
			if(i == 0){
				return new RetObj(false,request);
			}
			return new RetObj(true,request);
		}catch(Exception e){
			if(logger.isDebugEnabled()){
				logger.error(e.getMessage());
			}
			return new RetObj(false,request);
		}
		
    }
	@RequestMapping("/deleteByGroupId")
	@ResponseBody
    public RetObj deleteByGroupId(HttpServletRequest request,String GROUP_ID){
		try{
			int i =localMaterialLibrary.deleteByGroupId(GROUP_ID);
			if(i == 0){
				return new RetObj(false,request);
			}
			return new RetObj(true,request);
		}catch(Exception e){
			if(logger.isDebugEnabled()){
				logger.error(e.getMessage());
			}
			return new RetObj(false,request);
		}
		
    }
	/**
	 * @Description: TODO
	 * @param @param request
	 * @param @param model
	 * @param @return   
	 * @return RetObj  
	 * @throws
	 * @author daiwk
	 * @date 2015年11月20日
	 */
	@RequestMapping("/save")
	@ResponseBody
    public RetObj save(HttpServletRequest request){
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		try{	
				if(null == record.get("LOCAL_IT_ID") || "".equals(record.get("LOCAL_IT_ID").toString())){
					Map loginGZH = (Map) request.getSession().getAttribute(LOGIN_IN_GZH_SESSION);
					String GZH_ID = (String) loginGZH.get("GZH_ID");
					record.put("GZH_ID", GZH_ID);
					record = localMaterialLibrary.insert_map(record);
					if(null == record){
						return new RetObj(false);
					}
					request.setAttribute("record",record);
					return new RetObj(true,request,record);
				}
				int i = localMaterialLibrary.update(record);
				if(i == 0){
					return new RetObj(false);
				}
				return new RetObj(true,request,record);
		}catch(Exception e){
			e.printStackTrace();
			if(logger.isDebugEnabled()){
				logger.error(e.getMessage());
			}
			return new RetObj(false,request);
		}	 
    }
	/**
	 * 
	 * @Description: TODO
	 * @param @param request
	 * @param @return   
	 * @return RetObj  
	 * @throws
	 * @author daiwk
	 * @date 2016年1月4日
	 */
	@RequestMapping("/update")
	@ResponseBody
	public RetObj updateIT(HttpServletRequest request){
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		try{			
			int i = localMaterialLibrary.update(record);
			if(i == 0){
				return new RetObj(false);
			}
			return new RetObj(true);
		}catch(Exception e){
			if(logger.isDebugEnabled()){
				logger.error(e.getMessage());
			}
			return new RetObj(false,request);
		}	 
    }
	/**
	 * 
	 * @Description: TODO
	 * @param @param request
	 * @param @return   
	 * @return RetObj  
	 * @throws
	 * @author daiwk
	 * @date 2016年1月4日
	 */
	@RequestMapping("/queryITByGroupID")
    public String queryITByGroupID(HttpServletRequest request){  
		Map<String,Object> record = HttpUtils.getRequestMap(request);
		try{
			List itList = localMaterialLibrary.queryITByGroupID(record);
			request.setAttribute("itList", itList);
			return null;
		}catch(Exception e){
			if(logger.isDebugEnabled()){
				logger.error(e.getMessage());
			}
			return null;
		}
    }
	/**
	 * 
	 * @Description: TODO
	 * @param @param request
	 * @param @return   
	 * @return RetObj  
	 * @throws
	 * @author daiwk
	 * @date 2016年1月4日
	 */
	@RequestMapping("/get")
    public String get(HttpServletRequest request,String LOCAL_IT_ID){  
		Map<String,Object> record = HttpUtils.getRequestMap(request);
			record = localMaterialLibrary.get(LOCAL_IT_ID);
			request.setAttribute("record", record);
			return "client/localML/localIT"; 
    }
	@RequestMapping("/forAdd")
    public String forAdd(HttpServletRequest request,String LOCAL_IT_ID){ 
			return "client/localML/localIT"; 
    }
}