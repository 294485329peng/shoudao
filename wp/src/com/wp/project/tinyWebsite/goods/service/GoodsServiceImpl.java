package com.wp.project.tinyWebsite.goods.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mysql.fabric.xmlrpc.base.Array;
import com.wp.common.dao.IBaseDao;
import com.wp.common.page.PageView;
import com.wp.common.service.IBaseService;
@Service("goodsServiceImpl")
public class GoodsServiceImpl implements IGoodsService{
	@Autowired
	private IBaseDao dao;
	@Override
	public Map get(String id) {
		return null;
	}
	@Override
	public PageView queryPage(PageView pageView, Map paramMap) {
		// TODO Auto-generated method stub
		List list = dao.queryPage("tinyWebGoodsSpace.queryPage",
				pageView, paramMap);
		pageView.setRecords(list);
		return pageView;
	}

	@Override
	public List<Map> query(Map paramMap) {
		// TODO Auto-generated method stub
		
		List<Map> list = dao.query("tinyWebGoodsSpace.queryGoodsDetailList",paramMap);
		List<Map> mainList = new ArrayList<>();
		List<Map> tempChildList = new ArrayList<>();
		//List<Map> tempList = new ArrayList<>();
		for (Map map : list) {
			if("1".equals((String)map.get("MAIN"))){
				mainList.add(map);
			}else{
				tempChildList.add(map);
			}
		}
		for (Map map : mainList) {
			List<Map> tempList = new ArrayList<>();
			String mainId = (String)map.get("MAIN_SPECIFICATION_ID");
			for (Map child : tempChildList) {
				if(mainId.equals(child.get("MAIN_SPECIFICATION_ID"))){
					tempList.add(child);
				}
			}
			map.put("childList", tempList);
		}
		return mainList;
	}

	@Override
	public int insert(Map record) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public Map insert_map(Map record) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int update(Map record) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public Map update_Map(Map record) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int delete(String id) {
		// TODO Auto-generated method stub
		return 0;
	}
	@Override
	public Map getGoods(Map record) {
		// TODO Auto-generated method stub
		Map map = (Map) dao.get("tinyWebGoodsSpace.getGoods", record);
		
		return map;
	}

}
