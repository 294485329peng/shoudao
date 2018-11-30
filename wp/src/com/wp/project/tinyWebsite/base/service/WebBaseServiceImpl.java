package com.wp.project.tinyWebsite.base.service;

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
@Service("WebBaseServiceImpl")
public class WebBaseServiceImpl implements IWebBaseService{
	@Autowired
	private IBaseDao dao;
	@Override
	public Map get(String id) {
		List<Map> mapNav = dao.query("WebHomeSpace.getNav",id);
		List<Map> mapHac = dao.query("WebHomeSpace.getHac",id);
		List<Map> mapHmBt = dao.query("HmBtSpace.query", id);
		Map home=new HashMap<>();
		home.put("mapNav", mapNav);
		home.put("mapHac",mapHac);
		home.put("mapHmBt",mapHmBt);
		return home;
	}
	@Override
	public PageView queryPage(PageView pageView, Map paramMap) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Map> query(Map paramMap) {
		// TODO Auto-generated method stub
		List list=new ArrayList<>();
		list=dao.query("WebHomeSpace.getNav",paramMap);
		return list;
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
