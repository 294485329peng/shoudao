package com.wp.project.tinyWebsite.memberCenter.service;

import java.util.List;
import java.util.Map;

import com.wp.common.page.PageView;
import com.wp.common.service.IBaseService;

public interface IWebMFinishOrderService extends IBaseService{
	public List getOrder(Map record,PageView pageView);
	public List getOrderByType(Map record,PageView pageView);
}
