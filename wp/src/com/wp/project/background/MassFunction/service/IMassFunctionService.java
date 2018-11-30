package com.wp.project.background.MassFunction.service;

import java.util.List;
import java.util.Map;

import com.wp.common.service.IBaseService;

public interface IMassFunctionService extends IBaseService{
	/* 判断当天或当月是否能发信息 */
	public List isMassMessage(Map record);
}
