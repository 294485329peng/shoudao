package com.wp.project.webBackground.goods.service;

import java.util.List;
import java.util.Map;

import com.wp.common.page.PageView;
import com.wp.common.service.IBaseService;

public interface IGoodsClassService extends IBaseService{
	//查询已经发布的排序活动列表排序
	public PageView queryPageRank(PageView pageView, Map paramMap);
	//批量修改排序
	public Map updateRank(Map record);
	//修改分类
	public int updateClass(Map record);
	//添加分类
	public Map insertClass(Map record);
	//删除分类
	public int deleteClass(String id);
	//查询分类
	public Map getClass(String id);
	//查询分类列表
	public PageView queryPageClass(PageView pageView, Map paramMap);
	
}
