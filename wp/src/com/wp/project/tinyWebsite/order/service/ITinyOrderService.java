package com.wp.project.tinyWebsite.order.service;

import java.util.Map;

import com.wp.common.service.IBaseService;

public interface ITinyOrderService extends IBaseService{
	public Map getGoods(String id);
	public int enterOrder(String id);
	public int cancelOrder(String id);
}
