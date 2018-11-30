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

@Service("WebBCAcServiceImpl")
public class WebBaseAcServiceImpl implements IWebBaseAcService {
	@Autowired
	private IBaseDao dao;

	@Override
	public Map get(String id) {
		// TODO Auto-generated method stub
		return (Map) dao.get("WebBCAcSpace.get", id);
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
		String HAC_ID = StringUtils.uniqueKey36();
		String CREATE_TIME = DateUtils.getCurrentDate();
		record.put("HAC_ID", HAC_ID);
		record.put("CREATE_TIME", CREATE_TIME);
		int i = dao.insert_("WebBCAcSpace.insert", record);
		return i;
	}

	@Override
	public int update(Map record) {
		
		return dao.update_("WebBCAcSpace.update", record);
	}

	@Override
	public int delete(String id) {
		int i = dao.delete("WebBCAcSpace.delete", id);
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
		return (Map) dao.update("WebBCAcSpace.update", record);
	}


	@Override
	public PageView rankqueryPage(PageView pageView, Map paramMap) {
		// TODO Auto-generated method stub
		List list = dao.queryPage("WebBCAcSpace.queryPageRank",
				pageView, paramMap);
		pageView.setRecords(list);
		return pageView;
	}


	@Override
	public Map updateRank(Map record) {
		// TODO Auto-generated method stub
		List list = null;
		dao.batchUpdateList("WebBCAcSpace.batchUpdateRank", list);
		return null;
	}

}
