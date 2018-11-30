package com.wp.project.tinyWebsite.memberCenter.service;

import java.util.Map;

import com.wp.common.service.IBaseService;

public interface IWebMcenterService extends IBaseService{
	public Map getMemberDetail(String openId);
}
