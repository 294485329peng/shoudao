package com.wp.project.tinyWebsite.memberLogin.service;

import java.util.List;
import java.util.Map;

import com.wp.common.service.IBaseService;

public interface IMemberLoginService extends IBaseService{
	public Map checkLogin(String userId, String passWord);
	public Map getByOpenIdGzh(Map record);
	public int updatePassWord(Map record);
}
