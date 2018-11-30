package com.wp.project.webBackground.memberCenter.service;

import java.util.List;
import java.util.Map;

import com.wp.common.page.PageView;
import com.wp.common.service.IBaseService;

public interface IMemberBCService extends IBaseService{
	//查询关注的用户
	public PageView subscribequeryPage(PageView pageView, Map paramMap);
	//特别修改金钱
	public int updateMoney(Map record);
	//用户充值
	public Map chongzhi(Map record);
	//用户消费
	public Map xiaofei(Map record);
	//查询用户消费充值记录
	public PageView moneyRecordqueryPage(PageView pageView, Map paramMap);
}
