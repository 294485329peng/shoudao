package com.wp.project.tinyWebsite.shopCart.service;

import java.util.Map;

import com.wp.common.service.IBaseService;

public interface IShopCartService extends IBaseService{
	public int getShopCartCount(Map record); 
	public int batchDelete(Map record);
}
