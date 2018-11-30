/**
 * Copyright2015-2019 daiwk All Rights Reserved.
 */
package com.wp.base.ac.ac_role_func.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.wp.base.ac.ac_role_func.service.IAcRoleFuncService;
import com.wp.common.RetObj;
import com.wp.common.controller.BaseController;
import com.wp.common.utils.DateUtils;
import com.wp.common.utils.HttpUtils;
import com.wp.common.utils.StringUtils;

/**
 * @ClassName: AcRoleFuncController
 * @Description: TODO
 * @author:daiwk 
 * @date: 2015年9月27日上午10:53:55
 */
@Controller
@RequestMapping("/acRoleFunc")
public class AcRoleFuncController extends BaseController {

	@Autowired
	private IAcRoleFuncService acRoleFuncService;
	@RequestMapping("/queryRoleFunc")
	@ResponseBody
	public List forCheckTreeForRole(HttpServletRequest request) {
		Map<String,Object> paramMap = HttpUtils.getRequestMap(request);
		request.setAttribute("record", paramMap);
		List<Map> list = acRoleFuncService.query(paramMap);
		return list;
	}
	
	@RequestMapping("/batchInsert")
	@ResponseBody
	public RetObj batchInsert(HttpServletRequest request,String roleFuncJsonStr,String roleId) {
		List<Map> dataList = JSON.parseArray(roleFuncJsonStr, Map.class);
		Map<String,String> paramMap=new HashMap<String, String>();
		paramMap.put("ROLE_ID", roleId);
		try {
			acRoleFuncService.batchInsert(dataList,paramMap);
			return new RetObj(true,request);
		} catch (Exception e) {
			if(logger.isDebugEnabled()){
				logger.error(e.getMessage());
			}
			return new RetObj(false,request);
		}
		
		
	}
}
