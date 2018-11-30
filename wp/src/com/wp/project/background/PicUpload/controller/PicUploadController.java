package com.wp.project.background.PicUpload.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
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
import com.wp.project.background.WXReply.service.IAttentionReplyService;
import com.wp.project.background.WXReply.service.IAutoReplyService;
import com.wp.project.util.WeiXinUtil;

@Controller
@RequestMapping("/picUpload")
public class PicUploadController extends BaseController {
	@Autowired
	private IPicUploadService picUploadService;

	@RequestMapping("/forPicUpload")
	public String forAttentionReply(HttpServletRequest request, Model model) {
		Map<String, Object> record = HttpUtils.getRequestMap(request);

		return null;
	}

	@RequestMapping("/forQueryPage")
	public String forQueryPage(HttpServletRequest request, PageView pageView) {
		pageView.setPageSize(12);
		Map<String, Object> record = HttpUtils.getRequestMap(request);
		Map loginGZH = (Map) request.getSession().getAttribute(
				LOGIN_IN_GZH_SESSION);
		String GZH_ID = (String) loginGZH.get("GZH_ID");
		record.put("GZH_ID", GZH_ID);
		// 对应查询的mybatis的xml中的id必须以queryPage结尾，查询中加入select top 100
		// percent，结束时并按某个字段排序，否则不能进行分页
		try {
			pageView = picUploadService.queryPage(pageView, record);
			/*
			 * List<XtDict> dictList =
			 * xtDictService.querySysDictByDictcode("JSLX","","","1");
			 * model.addAttribute("dictList", dictList);
			 */
		} catch (Exception e) {
			e.printStackTrace();
		}
		/* model.addAttribute("acRole", acRole); */
		request.setAttribute("pageView", pageView);
		request.setAttribute("record", record);
		return "client/pic/forPicList";
	}

	@RequestMapping("/forSelectQueryPage")
	public String forSelectQueryPage(HttpServletRequest request,
			PageView pageView) {
		pageView.setPageSize(10);
		Map<String, Object> record = HttpUtils.getRequestMap(request);
		Map loginGZH = (Map) request.getSession().getAttribute(
				LOGIN_IN_GZH_SESSION);
		String GZH_ID = (String) loginGZH.get("GZH_ID");
		record.put("GZH_ID", GZH_ID);
		// 对应查询的mybatis的xml中的id必须以queryPage结尾，查询中加入select top 100
		// percent，结束时并按某个字段排序，否则不能进行分页
		try {
			pageView = picUploadService.queryPage(pageView, record);
			/*
			 * List<XtDict> dictList =
			 * xtDictService.querySysDictByDictcode("JSLX","","","1");
			 * model.addAttribute("dictList", dictList);
			 */
		} catch (Exception e) {
			e.printStackTrace();
		}
		/* model.addAttribute("acRole", acRole); */
		request.setAttribute("pageView", pageView);
		return "client/pic/selectPic";
	}

	@RequestMapping("/save")
	@ResponseBody
	public RetObj save(HttpServletRequest request, Model model) {
		Map<String, Object> record = HttpUtils.getRequestMap(request);

		return null;
	}

	@RequestMapping("/update")
	@ResponseBody
	public RetObj update(HttpServletRequest request, Model model) {
		Map<String, Object> record = HttpUtils.getRequestMap(request);

		return null;
	}

	@RequestMapping("/getPicByUrl")
	@ResponseBody
	public RetObj getPicByUrl(HttpServletRequest request, String PIC_URL) {
		// PIC_URL = "c:" + PIC_URL;
		Map record = picUploadService.getPicByUrl(PIC_URL);
		// String json = JSONArray.fromObject(list).toString();
		return new RetObj(true, request, record);
	}

	@RequestMapping("/getPicById")
	@ResponseBody
	public RetObj getPicById(HttpServletRequest request, String PIC_ID) {

		Map record = picUploadService.getPicById(PIC_ID);
		// String json = JSONArray.fromObject(list).toString();
		return new RetObj(true, request, record);
	}

	@RequestMapping("/deletByMediaId")
	@ResponseBody
	public RetObj deletByMediaId(HttpServletRequest request, String MEDIA_ID) {
		// Map<String,Object> record = picUploadService.get(MEDIA_ID);
		int result = picUploadService.delete(MEDIA_ID);
		if (0 != result || -1 != result) {
			return new RetObj(true);
		}
		return new RetObj(false);
	}
}
