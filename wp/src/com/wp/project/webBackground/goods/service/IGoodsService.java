package com.wp.project.webBackground.goods.service;

import java.util.List;
import java.util.Map;

import com.wp.common.page.PageView;
import com.wp.common.service.IBaseService;

public interface IGoodsService extends IBaseService{
	//查询已经发布的排序列表
	public PageView queryPageRank(PageView pageView, Map paramMap);
	//查询分类
	public PageView queryPageClass(PageView pageView, Map paramMap);
	//批量修改排序
	public Map updateRank(Map record);
	//修改,更新商品
	public int updateGoods(Map record);
	//添加商品
	public Map insertGoods(Map record);
	//删除商品
	public int deleteGoods(String id);
	//查询单个商品
	public Map getGoods(String id);
	//查询商品，根据时间
	public PageView queryPageGoodsTime(PageView pageView, Map paramMap);
	//添加商品
	public Map insertGoodsDetail(Map<String,Object> record);
	//查询商品详情
	public Map queryGoodsDetail(String id);
	//删除单个商品详情
	public int deleteGoodsDetail(String id);
	//删除主规格相同的商品详情
	public int deleteGoodsDetailByMainId(String id);
	//修改商品详情
	public int batchUpdateGoodsDetail(Map<String,Object> record);
	//查询商品    主规格商品详情
	public List queryGoodsDetailMainList(String id);
	
	
}
