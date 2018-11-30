package com.wp.project.webBackground.homeButton.service;

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

@Service("HmBtServiceImpl")
public class HmBtServiceImpl implements IHmBtService {
	@Autowired
	private IBaseDao dao;

	@Override
	public Map get(String id) {
		// TODO Auto-generated method stub
		return (Map) dao.get("HmBtSpace.get", id);
	}


	@Override
	public PageView queryPage(PageView pageView, Map paramMap) {
		List list = dao.queryPage("HmBtSpace.queryPage",
				pageView, paramMap);
		pageView.setRecords(list);
		return pageView;
	}

	@Override
	public List<Map> query(Map paramMap) {
		// TODO Auto-generated method stub
		List list = dao.query("HmBtSpace.query", paramMap);
		return list;
	}

	@Override
	public int insert(Map record) {
		String BT_ID = StringUtils.uniqueKey36();
		String CREATE_TIME = DateUtils.getCurrentDate();
		record.put("CREATE_TIME", CREATE_TIME);
		record.put("BT_ID", BT_ID);
		if(record.get("PUBLISH") == null || record.get("PUBLISH") == ""){
			record.put("PUBLISH", "off");
		}
		int i = dao.insert_("HmBtSpace.insert", record);
		return i;
	}

	@Override
	public int update(Map record) {
		
		return dao.update_("HmBtSpace.update", record);
	}

	@Override
	public int delete(String id) {
		int i = dao.delete("HmBtSpace.delete", id);
		return i;
	}

	@Override
	public Map insert_map(Map record) {
		// TODO Auto-generated method stub
		String BT_ID = StringUtils.uniqueKey36();
		String CREATE_TIME = DateUtils.getCurrentDate();
		record.put("CREATE_TIME", CREATE_TIME);
		record.put("BT_ID", BT_ID);
		if(record.get("PUBLISH") == null || record.get("PUBLISH") == ""){
			record.put("PUBLISH", "off");
		}
		record = (Map) dao.insert("HmBtSpace.insert", record);
		return null;
	}

	@Override
	public Map update_Map(Map record) {
		// TODO Auto-generated method stub
		String CREATE_TIME = DateUtils.getCurrentDate();
		record.put("CREATE_TIME", CREATE_TIME);
		if(record.get("PUBLISH") == null || record.get("PUBLISH") == ""){
			record.put("PUBLISH", "off");
		}
		return (Map) dao.update("HmBtSpace.update", record);
	}
}
