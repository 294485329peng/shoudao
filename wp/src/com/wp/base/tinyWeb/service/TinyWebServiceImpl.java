package com.wp.base.tinyWeb.service;

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

@Service("TinyWebServiceImpl")
public class TinyWebServiceImpl implements ITinyWebService {
	@Autowired
	private IBaseDao dao;

	@Override
	public Map get(String id) {
		// TODO Auto-generated method stub
		return (Map) dao.get("tinyWebSpace.get", id);
	}


	@Override
	public PageView queryPage(PageView pageView, Map paramMap) {
		List list = dao.queryPage("tinyWebSpace.queryPageAll",
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
		record.put("TEMPLATE_ID", UUIDFactory.getUUID());
		record.put("CREATE_TIME", DateUtils.getCurrentDate());
		
		return dao.insert_("tinyWebSpace.insert", record);
	}

	@Override
	public int update(Map record) {
		
		return dao.update_("tinyWebSpace.update", record);
	}

	@Override
	public int delete(String id) {
		//String NAV_ID = id;
		int i = dao.delete("tinyWebSpace.delete", id);
		return i;
	}

	@Override
	public Map insert_map(Map record) {
		// TODO Auto-generated method stub
		record.put("TEMPLATE_ID", UUIDFactory.getUUID());
		record.put("CREATE_TIME", DateUtils.getCurrentDate());
		return (Map) dao.insert("tinyWebSpace.insert", record);
	}

	@Override
	public Map update_Map(Map record) {
		// TODO Auto-generated method stub
		return (Map) dao.update("tinyWebSpace.update", record);
	}


	@Override
	public int updateGzhTemp(Map record) {
		// TODO Auto-generated method stub
		return dao.update_("tinyWebSpace.updateGzhTemp", record);
	}


}
