package com.wp.project.background.Authorize.service;

import java.util.List;
import java.util.Map;

import com.wp.common.service.IBaseService;

public interface IAuthorizeService extends IBaseService{
	public void updateCVT(Map map);
	public Map getUrlData();
	public int saveAuthCode(String authCode);
	public int getAuthToken(String authCode,String operatorId);
}
