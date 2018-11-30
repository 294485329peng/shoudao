package com.wp.project.webBackground.activities.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wp.common.dao.IBaseDao;
import com.wp.common.page.PageView;
import com.wp.common.utils.DateUtils;
import com.wp.common.utils.IsNullOrEmpty;
import com.wp.common.utils.StringUtils;
import com.wp.project.util.UUIDFactory;

@Service("ActivityServiceImpl")
public class ActivityServiceImpl implements IActivityService {
	@Autowired
	private IBaseDao dao;

	@Override
	public Map get(String id) {
		// TODO Auto-generated method stub
		return (Map) dao.get("activitySpace.get", id);
	}


	@Override
	public PageView queryPage(PageView pageView, Map paramMap) {
		List list = dao.queryPage("activitySpace.queryPage",
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
		String ACTIVITY_ID = StringUtils.uniqueKey36();
		String CREATE_TIME = DateUtils.getCurrentDate();
		record.put("ACTIVITY_ID", ACTIVITY_ID);
		record.put("CREATE_TIME", CREATE_TIME);
		if(IsNullOrEmpty.isNullOrEmpty(record.get("PUBLISH"))){
			record.put("PUBLISH", "off");
		}
		int i = dao.insert_("activitySpace.insert", record);
		return i;
	}

	@Override
	public int update(Map record) {
		
		return dao.update_("activitySpace.update", record);
	}

	@Override
	public int delete(String id) {
		int i = dao.delete("activitySpace.delete", id);
		return i;
	}

	@Override
	public Map insert_map(Map record) {
		// TODO Auto-generated method stub
		String ACTIVITY_ID = StringUtils.uniqueKey36();
		String CREATE_TIME = DateUtils.getCurrentDate();
		record.put("ACTIVITY_ID", ACTIVITY_ID);
		record.put("CREATE_TIME", CREATE_TIME);
		if(IsNullOrEmpty.isNullOrEmpty(record.get("PUBLISH"))){
			record.put("PUBLISH", "off");
		}
		int i = dao.insert_("activitySpace.insert", record);
		if(i == 0){
			return null;
		}
		return record;
	}

	@Override
	public Map update_Map(Map record) {
		// TODO Auto-generated method stub
		if(IsNullOrEmpty.isNullOrEmpty(record.get("PUBLISH"))){
			record.put("PUBLISH", "off");
		}
		int i = dao.update_("activitySpace.update", record);
		if(i == 0){
			record = null;
			return record;
		}
		return record ;
	}


	@Override
	public PageView queryPageRank(PageView pageView, Map paramMap) {
		// TODO Auto-generated method stub
		List list = dao.queryPage("activitySpace.queryPageRank",
				pageView, paramMap);
		pageView.setRecords(list);
		return pageView;
	}


	@Override
	public Map updateRank(Map record) {
		// TODO Auto-generated method stub
		List list = null;
		dao.batchUpdateList("activitySpace.batchUpdateRank", list);
		return null;
	}

}
