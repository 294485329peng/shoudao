package com.wp.project.background.AutoResponse.controller;

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
import com.wp.common.controller.BaseController;
import com.wp.common.page.PageView;
import com.wp.common.utils.DateUtils;
import com.wp.common.utils.HttpUtils;
import com.wp.common.utils.StringUtils;
import com.wp.project.background.AutoResponse.service.IAutoResponseService;
import com.wp.project.background.MaterialLibrary.service.IMaterialLibrary;

@Controller
@RequestMapping("/ar")
public class AutoResponseController extends BaseController {
	@Autowired
	private IAutoResponseService iAutoResponseService;
	@Autowired
	private IMaterialLibrary materialLibrary;

	@RequestMapping("/keyword")
	public String toKeyWord(HttpServletRequest request, PageView pageView) {
		Map<String, Object> record = HttpUtils.getRequestMap(request);
		Map loginGZH = (Map) request.getSession().getAttribute(LOGIN_IN_GZH_SESSION);
		String GZH_ID = (String) loginGZH.get("GZH_ID");
		record.put("GZH_ID", GZH_ID);
		pageView.setPageSize(10);
		try {
			pageView = iAutoResponseService.queryPage(pageView, record);

		} catch (Exception e) {
			e.printStackTrace();
		}
		request.setAttribute("pageView", pageView);
		request.setAttribute("record", record);
		return "client/autoresponse/keyword";
	}

	@RequestMapping("/insertKeyword")
	@ResponseBody
	public RetObj addKeyWord(HttpServletRequest request, Model model) {
		Map<String, Object> record = HttpUtils.getRequestMap(request);
		Map loginGZH = (Map) request.getSession().getAttribute(LOGIN_IN_GZH_SESSION);
		String GZH_ID = (String) loginGZH.get("GZH_ID");
		record.put("GZH_ID", GZH_ID);
		try {
			iAutoResponseService.insert(record);
			return new RetObj(true);
		} catch (Exception e) {
			if (logger.isDebugEnabled()) {
				logger.error(e.getMessage());
			}
			return new RetObj(false);

		}
	}

	@RequestMapping("/forShowUpdateMessage")
	public String forUpdateRule(HttpServletRequest request) {
		Map map = iAutoResponseService.get(request.getParameter("RULE_ID"));
		request.setAttribute("record", map);
		return "client/autoresponse/updateKeyWord";
	}

	@RequestMapping("/deleteKeyword")
	@ResponseBody
	public RetObj deleteKeyWord(HttpServletRequest request, Model model) {
		Map<String, Object> record = HttpUtils.getRequestMap(request);
		try {
			String RULE_ID = (String) record.get("RULE_ID");
			iAutoResponseService.delete(RULE_ID);
			return new RetObj(true);
		} catch (Exception e) {
			if (logger.isDebugEnabled()) {
				logger.error(e.getMessage());
			}
			return new RetObj(false);

		}
	}

	@RequestMapping("/addKeyWord")
	public String toAddKeyWord(HttpServletRequest request, Model model) {
		return "client/autoresponse/addKeyWord";
	}

	@RequestMapping("/update")
	@ResponseBody
	public RetObj update(HttpServletRequest request, Model model) {
		Map<String, Object> record = HttpUtils.getRequestMap(request);
		Map loginGZH = (Map) request.getSession().getAttribute(LOGIN_IN_GZH_SESSION);
		String GZH_ID = (String) loginGZH.get("GZH_ID");
		record.put("GZH_ID", GZH_ID);
		try {
			iAutoResponseService.update(record);
			return new RetObj(true);
		} catch (Exception e) {
			if (logger.isDebugEnabled()) {
				logger.error(e.getMessage());
			}
			return new RetObj(false);

		}
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
		return "client/autoresponse/selectIT";
	}
}