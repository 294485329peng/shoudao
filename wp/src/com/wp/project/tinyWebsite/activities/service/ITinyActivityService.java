package com.wp.project.tinyWebsite.activities.service;

import java.util.List;
import java.util.Map;

import com.wp.common.page.PageView;
import com.wp.common.service.IBaseService;

public interface ITinyActivityService extends IBaseService{
	//查询已经发布的排序活动列表排序
	public PageView queryPageRank(PageView pageView, Map paramMap);
	//批量修改排序
	public Map updateRank(Map record);
	
}
