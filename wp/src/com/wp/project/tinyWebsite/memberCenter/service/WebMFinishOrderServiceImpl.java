package com.wp.project.tinyWebsite.memberCenter.service;

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
@Service("WebMFinishOrderServiceImpl")
public class WebMFinishOrderServiceImpl implements IWebMFinishOrderService{
	@Autowired
	private IBaseDao dao;
	@Override
	public Map get(String id) {
		return null;
	}
	@Override
	public List getOrder(Map record, PageView pageView) {
		List<Map> list=dao.queryPage("memberMFinishOrderSpace.orderqueryPage", pageView,record);
		for (Map map : list) {
			List<Map> goodList=dao.query("memberMFinishOrderSpace.get",map.get("ORDER_ID").toString());
			map.put("good",goodList);
		}
		return list;
	}
	@Override
	public List getOrderByType(Map record, PageView pageView) {
		String type=record.get("type").toString();
		List<Map> list=new ArrayList<>();
		if("1".equals(type)){//全部
			record.put("DEAL_TYPE",null);
		}else if("3".equals(type)) {
			List dealType = new ArrayList<>();
			dealType.add("3");
			record.put("DEAL_TYPE",dealType);
		}else{
			List dealType = new ArrayList<>();
			dealType.add("0");
			dealType.add("1");
			dealType.add("2");
			dealType.add("10");
			dealType.add("20");
			dealType.add("21");
			dealType.add("22");
			dealType.add("30");
			record.put("DEAL_TYPE",dealType);
		}
		list=dao.queryPage("memberMFinishOrderSpace.queryPage", pageView,record);
		for (Map map : list) {
			List<Map> goodList=dao.query("memberMFinishOrderSpace.get",map.get("ORDER_ID").toString());
			map.put("good",goodList);
		}
		return list;
	}
	@Override
	public PageView queryPage(PageView pageView, Map paramMap) {
		return null;
	}

	@Override
	public List<Map> query(Map paramMap) {
		// TODO Auto-generated method stub
		return null;
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
}
