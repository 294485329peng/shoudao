package com.wp.project.background.AutoResponse.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wp.common.cSession.SessionUser;
import com.wp.common.dao.IBaseDao;
import com.wp.common.page.PageView;
import com.wp.common.utils.DateUtils;
import com.wp.project.util.UUIDFactory;

@Service("AutoResponseServiceImpl")
public class AutoResponseServiceImpl implements IAutoResponseService {
	@Autowired
	private IBaseDao baseDao;

	@Override
	public Map get(String id) {
		// TODO Auto-generated method stub
		return (Map) baseDao.get("autoResponseSpace.get", id);
	}

	public Map getKeyWord(Map mapRequest) {
		List list = baseDao.query("autoResponseSpace.getKeyWord", mapRequest);
		if (null != list && list.size() > 0) {
			for (int i = 0; i < list.size(); i++) {
				Map map = (Map) list.get(i);
				if ("1".equals(map.get("MATCHTYPE").toString())) {// 完全匹配
					if (mapRequest.get("KEYWORD").toString()
							.equals(map.get("KEYWORD").toString())) {
						Map ruleMap = get((String) map.get("RULE_ID"));
						return ruleMap;
					}
				} else {// 模糊匹配
					if (mapRequest.get("KEYWORD").toString()
							.contains(map.get("KEYWORD").toString())) {
						Map ruleMap = get((String) map.get("RULE_ID"));
						return ruleMap;
					}
				}
			}
		}
		return null;
	}

	@Override
	public PageView queryPage(PageView pageView, Map paramMap) {
		List list = baseDao.queryPage("autoResponseSpace.queryPageList",
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
		record.put("RULE_ID", UUIDFactory.getUUID());
		record.put("ENABLED", "0");
		record.put("CREATE_TIME", DateUtils.getCurrentDate());
		List<Map<String, String>> keyList = new ArrayList<>();
		String[] array = record.get("KEYWORD_LIST").toString().split("\\ ");
		String key = "";
		for (int i = 0; i < array.length; i++) {
			if ("".equals(array[i])) {
				continue;
			} else {
				Map<String, String> record_Key = new HashMap<>();
				record_Key.put("KEYWORD_ID", UUIDFactory.getUUID());
				record_Key.put("RULE_ID", (String) record.get("RULE_ID"));
				record_Key.put("KEYWORD", array[i]);
				record_Key.put("MATCHTYPE", record.get("MATCHTYPE").toString());
				record_Key.put("GZH_ID", record.get("GZH_ID").toString());
				record_Key.put("CREATE_TIME", record.get("CREATE_TIME")
						.toString());
				keyList.add(record_Key);
				key = key + array[i] + " ";
			}
			record.put("KEYWORD_LIST", key);
		}
		baseDao.insert("autoResponseSpace.insert", record);
		baseDao.insert("autoResponseSpace.insert_key", keyList);
		return 0;
	}

	@Override
	public int update(Map record) {
		record.put("CREATE_TIME", DateUtils.getCurrentDate());
		List<Map<String, String>> keyList = new ArrayList<>();
		String[] array = record.get("KEYWORD_LIST").toString().split("\\ ");
		String key = "";
		baseDao.delete("autoResponseSpace.deleteKeyword",
				(String) record.get("RULE_ID"));
		for (int i = 0; i < array.length; i++) {
			if ("".equals(array[i])) {
				continue;
			} else {
				Map<String, String> record_Key = new HashMap<>();
				record_Key.put("KEYWORD_ID", UUIDFactory.getUUID());
				record_Key.put("RULE_ID", (String) record.get("RULE_ID"));
				record_Key.put("KEYWORD", array[i]);
				record_Key.put("MATCHTYPE", record.get("MATCHTYPE").toString());
				record_Key.put("GZH_ID", record.get("GZH_ID").toString());
				record_Key.put("CREATE_TIME", record.get("CREATE_TIME")
						.toString());
				keyList.add(record_Key);
				key = key + array[i] + " ";
			}
		}
		record.put("KEYWORD_LIST", key);
		baseDao.update_("autoResponseSpace.update", record);
		baseDao.insert("autoResponseSpace.insert_key", keyList);
		return 0;
	}

	@Override
	public int delete(String id) {
		baseDao.delete("autoResponseSpace.delete", id);
		baseDao.delete("autoResponseSpace.deleteKeyword", id);
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

}
