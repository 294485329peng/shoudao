package com.wp.base.ac.ac_operator.service;

import java.util.Map;

import com.wp.common.service.IBaseService;

public interface IAcOperatorService extends IBaseService {
	public Map checkLogin(String userId, String passWord);
	public Boolean checkRegister(String userId);
}
