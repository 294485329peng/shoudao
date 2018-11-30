 package com.wp.project.webBackground.propagate.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mysql.fabric.xmlrpc.base.Array;
import com.wp.common.cSession.SessionUser;
import com.wp.common.dao.IBaseDao;
import com.wp.common.page.PageView;
import com.wp.common.service.IBaseService;
import com.wp.common.utils.DateUtils;
import com.wp.common.utils.StringUtils;
@Service("WebProServiceImpl")
public class WebProServiceImpl implements IWebProService{
	@Autowired
	private IBaseDao dao;
	@Override
	public Map get(String id) {
		return (Map) dao.get("WebProSpace.get", id);
	}
	@Override
	public PageView queryPage(PageView pageView, Map paramMap) {
		List list = dao.queryPage("WebProSpace.queryPage",
				pageView, paramMap);
		pageView.setRecords(list);
		return pageView;
	}

	@Override
	public List<Map> query(Map paramMap) {
		List<Map> list = dao.query("WebProSpace.query", paramMap);
		return list;
	}

	@Override
	public int insert(Map record) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public Map insert_map(Map record) {
		// TODO Auto-generated method stub
		String PRO_ID = StringUtils.uniqueKey36();
		String CREATE_TIME = DateUtils.getCurrentDate();
		record.put("PRO_ID", PRO_ID);
		record.put("CREATE_TIME", CREATE_TIME);
		record.put("GZH_ID", SessionUser.getSessionGzhId());
		record.put("IS_NAV","0");
		record.put("PUBLISH","on");
		int i = dao.insert_("WebProSpace.insert", record);
		if(i == 0){
			return null;
		}
		return record;
	}

	@Override
	public int update(Map record) {
		// TODO Auto-generated method stub
		
		return dao.update_("WebProSpace.update", record);
	}

	@Override
	public Map update_Map(Map record) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int delete(String id) {
		// TODO Auto-generated method stub
		
		return dao.delete("WebProSpace.delete", id);
	}
	@Override
	public int getCount(Map record) {
		// TODO Auto-generated method stub
		Map map = (Map) dao.get("WebProSpace.getCount", record);
		String N = map.get("COUNT").toString();
		Integer num = Integer.parseInt(N);
		return num;
	}

}
