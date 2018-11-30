package com.wp.project.webBackground.background.service;

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

@Service("WebBcServiceImpl")
public class WebBcServiceImpl implements IWebBcService {
	@Autowired
	private IBaseDao dao;

	@Override
	public Map get(String id) {
		// TODO Auto-generated method stub
		return (Map) dao.get("WebBcSpace.get", id);
	}


	@Override
	public PageView queryPage(PageView pageView, Map paramMap) {
		List list = dao.queryPage("WebBCAcSpace.queryPage",
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
		String CREATE_TIME = DateUtils.getCurrentDate();
		record.put("CREATE_TIME", CREATE_TIME);
		int i = dao.insert_("WebBcSpace.insert", record);
		return i;
	}

	@Override
	public int update(Map record) {
		
		return dao.update_("WebBcSpace.update", record);
	}

	@Override
	public int delete(String id) {
		int i = dao.delete("WebBcSpace.delete", id);
		return i;
	}

	@Override
	public Map insert_map(Map record) {
		// TODO Auto-generated method stub
		String CREATE_TIME = DateUtils.getCurrentDate();
		record.put("CREATE_TIME", CREATE_TIME);
		record = (Map) dao.insert("WebBcSpace.insert", record);
		return null;
	}

	@Override
	public Map update_Map(Map record) {
		// TODO Auto-generated method stub
		return (Map) dao.update("WebBcSpace.update", record);
	}
}
