package com.wp.project.webBackground.orders.service;

import java.util.List;
import java.util.Map;

import com.wp.common.page.PageView;
import com.wp.common.service.IBaseService;

public interface IOrderService extends IBaseService{
	//查询订单处理状态
	public PageView dealTypequeryPage(PageView pageView, Map paramMap);
	//查询订单详情
	public Map getOrder(PageView pageView,Map paramMap);
	//根据订单创建时间查询降序
	public PageView ctimeDescqueryPage(PageView pageView,Map paramMap);
	//根据订单创建时间查询升序
	public PageView ctimeAscqueryPage(PageView pageView,Map paramMap);
	
	//时间范围内查询
	public PageView betweenTimepequeryPage(PageView pageView,Map paramMap);
	
	//查询顾客订单
	public PageView memberQueryPage(PageView pageView,Map paramMap);
}
