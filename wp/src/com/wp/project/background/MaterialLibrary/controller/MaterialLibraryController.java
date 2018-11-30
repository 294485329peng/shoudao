package com.wp.project.background.MaterialLibrary.controller;

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
import com.wp.common.cSession.SessionUser;
import com.wp.common.controller.BaseController;
import com.wp.common.page.PageView;
import com.wp.common.utils.DateUtils;
import com.wp.common.utils.HttpUtils;
import com.wp.common.utils.StringUtils;
import com.wp.project.background.MaterialLibrary.service.IMaterialLibrary;
import com.wp.project.background.PicUpload.service.IPicUploadService;
import com.wp.project.util.WeiXinUtil;
import com.wp.project.weixin.gzhMessage.service.impl.GzhMessageServiceImpl;

/**
 * ClassName: MaterialLibraryController
 * 
 * @Description: TODO
 * @author daiwk
 * @date 2015年11月18日
 */

@Controller
@RequestMapping("/ml")
public class MaterialLibraryController extends BaseController {
	@Autowired
	private IMaterialLibrary materialLibrary;
	@Autowired
	private IPicUploadService picUploadService;
	@Autowired
	private GzhMessageServiceImpl gzhMessageServiceImpl;

	@RequestMapping("/imageTextList")
	public String imageTextList(HttpServletRequest request, PageView pageView) {
		Map<String, Object> record = HttpUtils.getRequestMap(request);
		Map loginGZH = (Map) request.getSession().getAttribute(
				LOGIN_IN_GZH_SESSION);
		String GZH_ID = (String) loginGZH.get("GZH_ID");
		record.put("GZH_ID", GZH_ID);
		pageView.setPageSize(12);
		try {
			pageView = materialLibrary.queryPage(pageView, record);

		} catch (Exception e) {
			e.printStackTrace();
		}
		request.setAttribute("pageView", pageView);
		request.setAttribute("record", record);
		return "client/meteriallibrary/imageTextList";
	}

	@RequestMapping("/newMainAddMessage")
	public String newMainAddMessage(HttpServletRequest request) {
		return "client/meteriallibrary/newMainAddMessage";
	}

	@RequestMapping("/forShowAddMessage")
	public String forShowAddMessage(HttpServletRequest request, String IT_TYPE) {
		request.setAttribute("IT_TYPE", "1");
		return "client/meteriallibrary/showAddMessage";
	}

	@RequestMapping("/deleteIT")
	@ResponseBody
	public RetObj deleteIT(HttpServletRequest request) {
		return null;
	}

	@RequestMapping("/forShowUpdateMessage")
	public String forUpdateIT(HttpServletRequest request) {
		Map<String, Object> record = HttpUtils.getRequestMap(request);
		
		List itList = materialLibrary.queryITByGroupID(record);
		request.setAttribute("record", record);
		request.setAttribute("itList", itList);
		return "client/meteriallibrary/showUpdateMessage";
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
	@RequestMapping("/addIT")
	@ResponseBody
	public RetObj addIT(HttpServletRequest request) {
		Map<String, Object> record = HttpUtils.getRequestMap(request);
		try {
			Map loginGZH = (Map) request.getSession().getAttribute(
					LOGIN_IN_GZH_SESSION);
			String GZH_ID = (String) loginGZH.get("GZH_ID");
			record.put("GZH_ID", GZH_ID);
			Map pic_map = new HashMap();
			if (record.get("PIC_ID") == null || record.get("PIC_ID") == "") {
				pic_map = picUploadService.getPicByUrl(record.get("PIC_URL")
						.toString());
			} else {
				String picId = record.get("PIC_ID").toString();
				pic_map = picUploadService.getPicById(picId);
			}

			String MEDIA_ID = pic_map.get("MEDIA_ID").toString();
			String PIC_URL_WX = pic_map.get("PIC_URL_WX").toString();
			record.put("PIC_MEDIA_ID", MEDIA_ID);
			record.put("PIC_URL_WX", PIC_URL_WX);
			record = materialLibrary.insert_map(record);
			// record.get("PIC_URL").toString();
			request.setAttribute("record", record);
			return new RetObj(true, request, record);
		} catch (Exception e) {
			e.printStackTrace();
			if (logger.isDebugEnabled()) {
				logger.error(e.getMessage());
			}
			return new RetObj(false, request);
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
	@RequestMapping("/updateIT")
	@ResponseBody
	public RetObj updateIT(HttpServletRequest request) {
		Map<String, Object> record = HttpUtils.getRequestMap(request);
		try {
			Map pic_map = new HashMap();
			String picId = record.get("PIC_ID").toString();
			pic_map = picUploadService.getPicById(picId);
			String MEDIA_ID = pic_map.get("MEDIA_ID").toString();
			record.put("PIC_MEDIA_ID", MEDIA_ID);
			record = materialLibrary.update_Map(record);
			request.setAttribute("record", record);
			if(null == record){
				return new RetObj(false);
			}
			return new RetObj(true, request, record);
		} catch (Exception e) {
			if (logger.isDebugEnabled()) {
				logger.error(e.getMessage());
			}
			return new RetObj(false, request);
		}
	}

	/**
	 * 
	 * @Description: 发布到微信客户端
	 * @param @param request
	 * @param @return
	 * @return RetObj
	 * @throws
	 * @author daiwk
	 * @date 2016年1月4日
	 */
	@RequestMapping("/publishIT")
	@ResponseBody
	public RetObj publishIT(HttpServletRequest request, String IT_GROUP_ID) {
		Map<String, Object> record = HttpUtils.getRequestMap(request);
		try {
			record = materialLibrary.publishIT(IT_GROUP_ID);
			if (record == null) {
				return new RetObj(false, request, record);
			}
			return new RetObj(true, request, record);
		} catch (Exception e) {
			if (logger.isDebugEnabled()) {
				logger.error(e.getMessage());
			}
			e.printStackTrace();
			return new RetObj(false, request);
		}
	}

	/**
	 * 
	 * @Description: 更新发布图文
	 * @param @param request
	 * @param @param IT_GROUP_ID
	 * @param @return
	 * @return RetObj
	 * @throws
	 * @author daiwk
	 * @date 2016年1月30日
	 */
	@RequestMapping("/rePublishIT")
	@ResponseBody
	public RetObj rePublishIT(HttpServletRequest request, String IT_GROUP_ID) {
		Map<String, Object> record = HttpUtils.getRequestMap(request);
		try {
			record = materialLibrary.rePublishIT(IT_GROUP_ID);
			if (record == null) {
				return new RetObj(false, "更新发布失败！", record);
			}
			return new RetObj(true, request, record);
		} catch (Exception e) {
			if (logger.isDebugEnabled()) {
				logger.error(e.getMessage());
			}
			e.printStackTrace();
			return new RetObj(false, request);
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
	@RequestMapping("/queryById")
	@ResponseBody
	public RetObj queryById(HttpServletRequest request) {
		Map<String, Object> record = HttpUtils.getRequestMap(request);
		try {
			String IT_ID = (String) record.get("ImageText_ID");
			record = materialLibrary.get(IT_ID);
			return new RetObj(true, request, record);
		} catch (Exception e) {
			if (logger.isDebugEnabled()) {
				logger.error(e.getMessage());
			}
			return new RetObj(false, request);
		}
	}

	/**
	 * 
	 * @Description: TODO
	 * @param @param request
	 * @param @param model
	 * @param @return
	 * @return RetObj
	 * @throws
	 * @author daiwk
	 * @date 2016年1月4日
	 */
	@RequestMapping("/deleteById")
	@ResponseBody
	public RetObj deleteById(HttpServletRequest request, Model model) {
		Map<String, Object> record = HttpUtils.getRequestMap(request);
		try {
			String IT_ID = (String) record.get("ImageText_ID");
			materialLibrary.delete(IT_ID);
			return new RetObj(true, request, record);
		} catch (Exception e) {
			if (logger.isDebugEnabled()) {
				logger.error(e.getMessage());
			}
			return new RetObj(false, request);
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
	@RequestMapping("/deletByGroupId")
	@ResponseBody
	public RetObj deletByGroupId(HttpServletRequest request) {

		Map<String, Object> record = HttpUtils.getRequestMap(request);
		try {
			String IT_GROUP_ID = (String) record.get("IT_GROUP_ID");
			String MEDIA_ID = (String) record.get("MEDIA_ID"); // 如果有media_id就调用你微信接口
			// 这调用微信接口,
			if (null != MEDIA_ID) {
				String accessToken = gzhMessageServiceImpl
						.getComponentAccessToken(SessionUser.getSessionGzhId());
				if ("".equals(accessToken)) {
					return null;
				}
				int result = WeiXinUtil.deleteMaterial(MEDIA_ID, accessToken);// 0成功-1不成功
				if (1 == result) {
					return new RetObj(false, request);
				}
			}
			materialLibrary.deleteByGroupId(IT_GROUP_ID);
			return new RetObj(true, request);
		} catch (Exception e) {
			if (logger.isDebugEnabled()) {
				logger.error(e.getMessage());
			}
			return new RetObj(false, request);
		}
	}

	/**
	 * 
	 * @Description: TODO
	 * @param @param request
	 * @param @param model
	 * @param @return
	 * @return RetObj
	 * @throws
	 * @author daiwk
	 * @date 2016年1月4日
	 */
	@RequestMapping("/getAdminIT")
	@ResponseBody
	public RetObj getAdminIT(HttpServletRequest request, Model model) {
		Map<String, Object> record = HttpUtils.getRequestMap(request);
		// try{
		String IT_ID = (String) record.get("IT_ID");
		record = materialLibrary.get(IT_ID);
		return new RetObj(true, request, record);
		/*
		 * }catch(Exception e){ if(logger.isDebugEnabled()){
		 * logger.error(e.getMessage()); } return new RetObj(false,request); }
		 */
	}

	/**
	 * 
	 * @Description: TODO
	 * @param @param request
	 * @param @param model
	 * @param @return
	 * @return RetObj
	 * @throws
	 * @author daiwk
	 * @date 2016年1月4日
	 */
	@RequestMapping("/getChildIT")
	@ResponseBody
	public RetObj getChildIT(HttpServletRequest request, Model model) {
		Map<String, Object> record = HttpUtils.getRequestMap(request);
		// try{
		List list = materialLibrary.queryChiildIT(record);
		return new RetObj(true, request, list);
		/*
		 * }catch(Exception e){ if(logger.isDebugEnabled()){
		 * logger.error(e.getMessage()); } return new RetObj(false,request); }
		 */
	}
}