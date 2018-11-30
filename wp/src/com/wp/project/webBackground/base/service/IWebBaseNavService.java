package com.wp.project.webBackground.base.service;

import java.util.List;
import java.util.Map;

import com.wp.common.page.PageView;
import com.wp.common.service.IBaseService;

public interface IWebBaseNavService extends IBaseService{
	//查询已经发布的排序活动列表排序
	public PageView rankqueryPage(PageView pageView, Map paramMap);
	//批量修改排序
	public Map updateRank(Map record);
}
