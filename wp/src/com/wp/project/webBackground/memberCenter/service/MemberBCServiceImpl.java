package com.wp.project.webBackground.memberCenter.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wp.common.dao.IBaseDao;
import com.wp.common.page.PageView;
import com.wp.common.utils.DateUtils;
import com.wp.common.utils.IsNullOrEmpty;
import com.wp.common.utils.Md5Util;
import com.wp.common.utils.StringUtils;

@Service("MemberBCServiceImpl")
public class MemberBCServiceImpl implements IMemberBCService {
	@Autowired
	private IBaseDao dao;

	@Override
	public Map get(String id) {
		// TODO Auto-generated method stub
		Map record = (Map) dao.get("memberBCSpace.get", id);
		record.put("LOGIN_PASSWORD", "*******");
		return record;
	}


	@Override
	public PageView queryPage(PageView pageView, Map paramMap) {
		if(IsNullOrEmpty.isNullOrEmpty(paramMap.get("CARD_ID"))){
			paramMap.put("CARD_ID", null);
		}
		List list = dao.queryPage("memberBCSpace.queryPage",pageView, paramMap);
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
		String OPEN_ID = StringUtils.uniqueKey36();
		String CREATE_TIME = DateUtils.getCurrentDate();
		record.put("OPEN_ID", OPEN_ID);
		record.put("MEMBER_ID", OPEN_ID);
		record.put("DELETE_MEMBER", "1");
		record.put("CREATE_TIME", CREATE_TIME);
		int i = dao.insert_("memberBCSpace.insert", record);
		return i;
	}
	/**
	 * 普通更新
	 */
	@Override
	public int update(Map record) {
		String LOGIN_PASSWORD = Md5Util.string2MD5(record.get("LOGIN_PASSWORD").toString());
		record.put("LOGIN_PASSWORD", LOGIN_PASSWORD);
		return dao.update_("memberBCSpace.updateStore", record);
	}

	@Override
	public int delete(String id) {
		int i = dao.update_("memberBCSpace.softDelete", id);
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
		return (Map) dao.update("memberBCSpace.update", record);
	}


	@Override
	public PageView subscribequeryPage(PageView pageView, Map paramMap) {
		// TODO Auto-generated method stub
		List list = dao.queryPage("memberBCSpace.subscribequeryPage",
				pageView, paramMap);
		pageView.setRecords(list);
		return pageView;
	}


	@Override
	public int updateMoney(Map record) {
		// TODO Auto-generated method stub
		//dao.update_("memberBCSpace.updateMoney", record);
		return dao.update_("memberBCSpace.updateMoney", record);
	}


	@Override
	public Map chongzhi(Map record) {
		// TODO Auto-generated method stub
		String RECORD_ID = StringUtils.uniqueKey36();
		String CREATE_TIME = DateUtils.getCurrentDate();
		String OPEN_ID = (String) record.get("OPEN_ID");
		record.put("RECORD_ID", RECORD_ID);
		record.put("CREATE_TIME", CREATE_TIME);
		record.put("TYPE", "1");
		Map user = (Map) dao.get("memberBCSpace.getMoneyPoint", OPEN_ID);
		
		//充值金额
		float cMoney = 0;
		if(! IsNullOrEmpty.isNullOrEmpty(record.get("MONEY"))){
			cMoney = Float.parseFloat(record.get("MONEY").toString());
		}
		//充值积分
		int cPoint = 0;
		if(! IsNullOrEmpty.isNullOrEmpty(record.get("POINT"))){
			cPoint = Integer.parseInt(record.get("POINT").toString());
		}
		
		float Money = 0;
		int Point = 0;
		if(IsNullOrEmpty.isNullOrEmpty(user.get("MONEY"))){
			Money = cMoney;
		}else{
			Money = Float.parseFloat(user.get("MONEY").toString()) + cMoney;
		}
		if(IsNullOrEmpty.isNullOrEmpty(user.get("POINT"))){
			Point = cPoint;
		}else{
			Point = Integer.parseInt(user.get("POINT").toString()) + cPoint;
		}
		String POINT = String.valueOf(Point);
		String MONEY = String.valueOf(Money);
		user.put("MONEY", MONEY);
		user.put("POINT", POINT);
		dao.insert_("memberBCSpace.insertMoneyRecord", record);
		dao.update("memberBCSpace.updateMoney", user);
		return user;
	}


	@Override
	public Map xiaofei(Map record) {
		// TODO Auto-generated method stub
		String RECORD_ID = StringUtils.uniqueKey36();
		String CREATE_TIME = DateUtils.getCurrentDate();
		String OPEN_ID = (String) record.get("OPEN_ID");
		record.put("RECORD_ID", RECORD_ID);
		record.put("CREATE_TIME", CREATE_TIME);
		record.put("TYPE", "2");
		
		Map user = (Map) dao.get("memberBCSpace.getMoneyPoint", OPEN_ID);
		float Money = 0;
		int Point = 0;
		
		//消费金额
		float cMoney = 0;
		if(! IsNullOrEmpty.isNullOrEmpty(record.get("MONEY"))){
			cMoney = Float.parseFloat(record.get("MONEY").toString());
		}
		
		//消费积分
		int cPoint = 0;
		if(! IsNullOrEmpty.isNullOrEmpty(record.get("POINT"))){
			cPoint = Integer.parseInt(record.get("POINT").toString());
		}
		if(IsNullOrEmpty.isNullOrEmpty(user.get("MONEY"))){
			Money =  Money - cMoney;
			if(Money < 0){
				user.put("msg", "余额不足！");
				return user;
			}
		}else{
			Money = Float.parseFloat(user.get("MONEY").toString()) - cMoney;
			if(Money < 0){
				user.put("msg", "余额不足！");
				return user;
			}
		}
		if(IsNullOrEmpty.isNullOrEmpty(user.get("POINT"))){
			Point = Point - cPoint;
			if(Point < 0){
				user.put("msg", "积分不足！");
				return user;
			}
		}else{
			Point = Integer.parseInt(user.get("POINT").toString()) - cPoint;
			if(Point < 0){
				user.put("msg", "积分不足！");
				return user;
			}
		}
		
		//消费获得积分
		int cGetPoint = 0;
		if(! IsNullOrEmpty.isNullOrEmpty(record.get("GET_POINT"))){
			cGetPoint = Integer.parseInt(record.get("GET_POINT").toString());
		}
		
		Point = cGetPoint + Point;
		String POINT = String.valueOf(Point);
		String MONEY = String.valueOf(Money);
		user.put("MONEY", MONEY);
		user.put("POINT", POINT);
		dao.insert_("memberBCSpace.insertMoneyRecord", record);
		dao.update("memberBCSpace.updateMoney", user);
		return user;
	}



	@Override
	public PageView moneyRecordqueryPage(PageView pageView, Map paramMap) {
		// TODO Auto-generated method stub
		List list = dao.queryPage("memberBCSpace.moneyRecordqueryPage",pageView, paramMap);
		pageView.setRecords(list);
		return pageView;
	}


}
