 package com.wp.project.tinyWebsite.propagete.service;

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
@Service("WebProsServiceImpl")
public class WebProsServiceImpl implements IWebProsService{
	@Autowired
	private IBaseDao dao;
	@Override
	public Map get(String id) {
		Map map=(Map) dao.get("WebProsSpace.get",id);
		return map;
	}
	@Override
	public PageView queryPage(PageView pageView, Map paramMap) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Map> query(Map paramMap) {
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
