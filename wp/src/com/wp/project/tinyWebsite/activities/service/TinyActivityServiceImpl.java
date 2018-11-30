package com.wp.project.tinyWebsite.activities.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wp.common.dao.IBaseDao;
import com.wp.common.page.PageView;
import com.wp.common.utils.DateUtils;
import com.wp.common.utils.StringUtils;
import com.wp.project.util.UUIDFactory;

@Service("TinyActivityServiceImpl")
public class TinyActivityServiceImpl implements ITinyActivityService {
	@Autowired
	private IBaseDao dao;

	@Override
	public Map get(String id) {
		// TODO Auto-generated method stub
		return (Map) dao.get("tinyActivitySpace.get", id);
	}


	@Override
	public PageView queryPage(PageView pageView, Map paramMap) {
		List list = dao.queryPage("tinyActivitySpace.queryPage",
				pageView, paramMap);
		pageView.setRecords(list);
		return pageView;
	}

	@Override
	public List<Map> query(Map paramMap) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int insert(Map record) {
		return 0;
	}

	@Override
	public int update(Map record) {
		
		return 0;
	}

	@Override
	public int delete(String id) {
		
		return 0;
	}

	@Override
	public Map insert_map(Map record) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Map update_Map(Map record) {
		// TODO Auto-generated method stub
			return null;
	}


	@Override
	public PageView queryPageRank(PageView pageView, Map paramMap) {
		// TODO Auto-generated method stub
		paramMap.put("PUBLISH", "on");
		List list = dao.queryPage("tinyActivitySpace.queryPageRank",
				pageView, paramMap);
		pageView.setRecords(list);
		return pageView;
	}


	@Override
	public Map updateRank(Map record) {
		// TODO Auto-generated method stub
		return null;
	}

}
