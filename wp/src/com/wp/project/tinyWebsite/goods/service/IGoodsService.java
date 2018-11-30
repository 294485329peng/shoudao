package com.wp.project.tinyWebsite.goods.service;

import java.util.Map;

import com.wp.common.service.IBaseService;

public interface IGoodsService extends IBaseService{
	
	public Map getGoods(Map record);
}
