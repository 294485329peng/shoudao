package com.wp.project.webBackground.memberCard.service;

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

@Service("MemberCardServiceImpl")
public class MemberCardServiceImpl implements IMemberCardService {
	@Autowired
	private IBaseDao dao;

	@Override
	public Map get(String id) {
		// TODO Auto-generated method stub
		return (Map) dao.get("memberCardSpace.get", id);
	}


	@Override
	public PageView queryPage(PageView pageView, Map paramMap) {
		List list = dao.queryPage("memberCardSpace.queryPage",pageView, paramMap);
		pageView.setRecords(list);
		return null;
	}

	@Override
	public List<Map> query(Map paramMap) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int insert(Map record) {
		String CARD_ID = StringUtils.uniqueKey36();
		String CREATE_TIME = DateUtils.getCurrentDate();
		record.put("CARD_ID", CARD_ID);
		record.put("CREATE_TIME", CREATE_TIME);
		int i = dao.insert_("memberCardSpace.insert", record);
		return i;
	}
	/**
	 * 普通更新
	 */
	@Override
	public int update(Map record) {
		
		return dao.update_("memberCardSpace.update", record);
	}

	@Override
	public int delete(String id) {
		
		return 0;
	}

	@Override
	public Map insert_map(Map record) {
		// TODO Auto-generated method stub
		String CARD_ID = StringUtils.uniqueKey36();
		String CREATE_TIME = DateUtils.getCurrentDate();
		record.put("CARD_ID", CARD_ID);
		record.put("CREATE_TIME", CREATE_TIME);
		return (Map) dao.insert("memberCardSpace.insert", record);
	}

	@Override
	public Map update_Map(Map record) {
		// TODO Auto-generated method stub
		return null;
	}


	@Override
	public Map getPic(String id) {
		// TODO Auto-generated method stub
		return (Map) dao.get("memberCardSpace.getPic", id);
	}

}
