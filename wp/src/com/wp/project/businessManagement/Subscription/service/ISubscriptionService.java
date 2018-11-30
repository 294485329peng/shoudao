package com.wp.project.businessManagement.Subscription.service;

import com.wp.common.service.IBaseService;

import java.util.Map;

public interface ISubscriptionService extends IBaseService{
	//查询公众号管理员
	public Map getGzhOpera(String id);
	//查询公众号
	public Map getWXGzh(String id);
	//添加公众号管理员
	public int insertWXGzh(Map record);
	//添加公众号和管理员
	public int insertGzhOperaAndWXGzh(Map record);
	//添加公众号
	public int insertGzhOpera(Map record);
	//更新公众号管理员
	public int updateGzhOpera(Map record);
	//更新公众号
	public int updateWXGzh(Map record);
	//删除公众号管理员
	public int deleteGzhOpera(String id);
	//检查公众号信息
	public Map checkLogin(String gzh_id, String gzh_password);
}
