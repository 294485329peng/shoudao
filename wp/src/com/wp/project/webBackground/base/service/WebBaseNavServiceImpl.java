package com.wp.project.webBackground.base.service;

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

@Service("WebBCNavServiceImpl")
public class WebBaseNavServiceImpl implements IWebBaseNavService {
	@Autowired
	private IBaseDao dao;

	@Override
	public Map get(String id) {
		// TODO Auto-generated method stub
		return (Map) dao.get("WebBcNavSpace.get", id);
	}


	@Override
	public PageView queryPage(PageView pageView, Map paramMap) {
		List list = dao.queryPage("WebBcNavSpace.queryPage",
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
		String NAV_ID = StringUtils.uniqueKey36();
		String CREATE_TIME = DateUtils.getCurrentDate();
		record.put("NAV_ID", NAV_ID);
		record.put("CREATE_TIME", CREATE_TIME);
		int i = dao.insert_("WebBcNavSpace.insert", record);
		return i;
	}

	@Override
	public int update(Map record) {
		
		return dao.update_("WebBcNavSpace.update", record);
	}

	@Override
	public int delete(String id) {
		//String NAV_ID = id;
		int i = dao.delete("WebBcNavSpace.deleteNav", id);
		return i;
	}

	@Override
	public Map insert_map(Map record) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Map update_Map(Map record) {
		// TODO Auto-generated method stub
		return (Map) dao.update("WebBcNavSpace.update", record);
	}


	@Override
	public PageView rankqueryPage(PageView pageView, Map paramMap) {
		// TODO Auto-generated method stub
		List list = dao.queryPage("WebBcNavSpace.queryPageRank",
				pageView, paramMap);
		pageView.setRecords(list);
		return pageView;
	}


	@Override
	public Map updateRank(Map record) {
		// TODO Auto-generated method stub
		List list = null;
		dao.batchUpdateList("WebBcNavSpace.batchUpdateRank", list);
		return null;
	}

}
