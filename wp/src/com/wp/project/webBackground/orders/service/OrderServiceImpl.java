package com.wp.project.webBackground.orders.service;

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

@Service("OrderServiceImpl")
public class OrderServiceImpl implements IOrderService {
	@Autowired
	private IBaseDao dao;

	@Override
	public Map get(String id) {
		// TODO Auto-generated method stub
		return null;
	}


	@Override
	public PageView queryPage(PageView pageView, Map paramMap) {
		if(IsNullOrEmpty.isNullOrEmpty(paramMap.get("DEAL_TYPE"))){
			paramMap.put("DEAL_TYPE", null);
		}
		List list = dao.queryPage("orderSpace.queryPage",pageView, paramMap);
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
		/*String ACTIVITY_ID = StringUtils.uniqueKey36();
		String CREATE_TIME = DateUtils.getCurrentDate();
		record.put("ACTIVITY_ID", ACTIVITY_ID);
		record.put("CREATE_TIME", CREATE_TIME);
		int i = dao.insert_("activitySpace.insert", record);
		if(i == 0){
			return null;
		}
		return record;*/
		return null;
	}

	@Override
	public Map update_Map(Map record) {
		int i = dao.update_("orderSpace.update", record);
		if(i == 0){
			record = null;
			return record;
		}
		return record ;
	}


	@Override
	public PageView dealTypequeryPage(PageView pageView, Map paramMap) {
		// TODO Auto-generated method stub
		List list = dao.queryPage("orderSpace.dealTypequeryPage",pageView, paramMap);
		pageView.setRecords(list);
		return pageView;
	}

	@Override
	public Map getOrder(PageView pageView, Map paramMap) {
		// TODO Auto-generated method stub
		Map recordOrder = (Map) dao.get("orderSpace.getOrder", paramMap);
		Map record = new HashMap<>();
		String OPEN_ID = paramMap.get("OPEN_ID").toString();
		List list = dao.queryPage("orderGoodsSpace.queryPage",pageView, paramMap);
		Map recordMember = (Map) dao.get("memberBCSpace.getOrderMemb", OPEN_ID);
		pageView.setRecords(list);
		record.put("pageView", pageView);
		record.put("recordOrder", recordOrder);
		record.put("recordMember", recordMember);
		return record;
	}


	@Override
	public PageView ctimeAscqueryPage(PageView pageView, Map paramMap) {
		// TODO Auto-generated method stub
		List list = dao.queryPage("orderSpace.ctimeAscqueryPage",pageView, paramMap);
		pageView.setRecords(list);
		return pageView;
	}


	@Override
	public PageView betweenTimepequeryPage(PageView pageView, Map paramMap) {
		// TODO Auto-generated method stub
		List list = dao.queryPage("orderSpace.betweenTimepequeryPage",pageView, paramMap);
		pageView.setRecords(list);
		return pageView;
	}


	@Override
	public PageView ctimeDescqueryPage(PageView pageView, Map paramMap) {
		// TODO Auto-generated method stub
		List list = dao.queryPage("orderSpace.ctimeDescqueryPage",pageView, paramMap);
		pageView.setRecords(list);
		return pageView;
	}


	@Override
	public PageView memberQueryPage(PageView pageView, Map paramMap) {
		// TODO Auto-generated method stub
		List list = dao.queryPage("orderSpace.memberqueryPage",pageView, paramMap);
		pageView.setRecords(list);
		return pageView;
	}

}
