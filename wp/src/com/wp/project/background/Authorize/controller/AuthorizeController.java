package com.wp.project.background.Authorize.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import test.upload.pic_test;

import com.wp.common.RetObj;
import com.wp.common.cSession.SessionUser;
import com.wp.common.controller.BaseController;
import com.wp.common.page.PageView;
import com.wp.common.utils.DateUtils;
import com.wp.common.utils.HttpUtils;
import com.wp.common.utils.StringUtils;
import com.wp.project.background.Authorize.service.IAuthorizeService;
import com.wp.project.background.AutoResponse.service.IAutoResponseService;
import com.wp.project.background.MaterialLibrary.service.IMaterialLibrary;
import com.wp.project.util.MessageUtil;
import com.wp.project.util.WeiXinUtil;
import com.wp.project.util.aes.WXBizMsgCrypt;

@Controller
@RequestMapping("/au")
public class AuthorizeController extends BaseController {
	@Autowired
	private IAuthorizeService authorizeService;

	@RequestMapping(value = "/AuthorizeRequest", method = { RequestMethod.POST })
	public String AuthorizeRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		Map map = MessageUtil.parseXml(request);
		map.put("msg_signature", request.getParameter("msg_signature"));
		map.put("timestamp", request.getParameter("timestamp"));
		map.put("nonce", request.getParameter("nonce"));
		authorizeService.updateCVT(map);
		PrintWriter out = response.getWriter();
		out.print("success");
		out.close();
		return "success";
	}

	@RequestMapping(value = "/AuthorizeBack", method = { RequestMethod.GET })
	public String AuthorizeBack(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String operatorId=SessionUser.getSessionOperatorId();
		System.out.println(operatorId);
		String auth_code = request.getParameter("auth_code");
		int success = authorizeService.saveAuthCode(auth_code);
		if (0 == success) {// 成功
				int result = authorizeService.getAuthToken(auth_code,operatorId);
				if (0 == result) {
					return "AuthorizeSuccess";
				} else {
					return "AuthorizeError";
				}
		} else {// 失败
			return "AuthorizeError";
		}
	}

}