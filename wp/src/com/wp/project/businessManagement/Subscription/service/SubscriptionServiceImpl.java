package com.wp.project.businessManagement.Subscription.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import com.wp.common.dao.IBaseDao;
import com.wp.common.page.PageView;
import com.wp.common.utils.DateUtils;
import com.wp.common.utils.Md5Util;
import com.wp.common.utils.StringUtils;

@Service
public class SubscriptionServiceImpl implements ISubscriptionService{
	@Autowired
	private IBaseDao dao;

	@Override
	public Map get(String id) {
		// TODO Auto-generated method stub
		
		return (Map) dao.get("subscriptionSpace.getWXGzhByAdminId", id);
	}

	@Override
	public PageView queryPage(PageView pageView, Map paramMap) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Map> query(Map paramMap) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int insert(Map record) {
		// TODO Auto-generated method stub\
		return 0;
	}

	@Override
	public Map insert_map(Map record) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int update(Map record) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public Map update_Map(Map record) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int delete(String id) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public Map getGzhOpera(String id) {
		// TODO Auto-generated method stub
		Map<String,Object> record;
		record = (Map<String, Object>) dao.get("subscriptionSpace.getGzhOpera", id);
		return record;
	}

	@Override
	public Map getWXGzh(String id) {
		// TODO Auto-generated method stub
		Map<String,Object> record = new HashMap<>();
		record = (Map<String, Object>) dao.get("subscriptionSpace.getWXGzh", id);
		return record;
	}

	@Override
	public int insertWXGzh(Map record) {
		// TODO Auto-generated method stub
		String ADMIN_ID = StringUtils.uniqueKey36();
		String CREATE_TIME = DateUtils.getCurrentDate();
		record.put("CREATE_TIME", CREATE_TIME);
		record.put("ADMIN_ID", ADMIN_ID);
		String GZH_PASSWORD = record.get("GZH_PASSWORD").toString();
		GZH_PASSWORD = Md5Util.string2MD5(GZH_PASSWORD);
		record.put("GZH_PASSWORD", GZH_PASSWORD);
		return dao.insert_("subscriptionSpace.insert", record);
	}

	@Override
	public int insertGzhOperaAndWXGzh(Map record){
		// TODO Auto-generated method stub
		String ADMIN_ID = StringUtils.uniqueKey36();
		String CREATE_TIME = DateUtils.getCurrentDate();
		record.put("CREATE_TIME", CREATE_TIME);
		record.put("ADMIN_ID", ADMIN_ID);
		String GZH_OPERA_ID = StringUtils.uniqueKey36();
		record.put("GZH_OPERA_ID", GZH_OPERA_ID);
		String GZH_PASSWORD = record.get("GZH_PASSWORD").toString();
		GZH_PASSWORD = Md5Util.string2MD5(GZH_PASSWORD);
		record.put("GZH_PASSWORD", GZH_PASSWORD);
		dao.insert_("subscriptionSpace.insertGzhOpera", record);
		
		return dao.insert_("subscriptionSpace.insertWXGzh", record);
	}

	@Override
	public int updateGzhOpera(Map record) {
		// TODO Auto-generated method stub
		return dao.update_("subscriptionSpace.updateGzhOpera", record);
	}

	@Override
	public int updateWXGzh(Map record) {
		// TODO Auto-generated method stub
		return dao.update_("subscriptionSpace.updateGzhOpera", record);
	}

	@Override
	public int deleteGzhOpera(String id) {
		// TODO Auto-generated method stub
		return dao.delete("subscriptionSpace.deleteGzhOpera", id);
	}

	@Override
	public int insertGzhOpera(Map record) {
		// TODO Auto-generated method stub
		String GZH_OPERA_ID = StringUtils.uniqueKey36();
		record.put("GZH_OPERA_ID", GZH_OPERA_ID);
		return dao.insert_("subscriptionSpace.insertGzhOpera", record);
	}

	@Override
	public Map checkLogin(String gzh_id, String gzh_password) {
		// TODO Auto-generated method stub
		Map<String,Object> paramMap = new HashMap<String,Object>();
        paramMap.put("GZH_ID", gzh_id);
        Map wx_gzh=null;
        wx_gzh = (Map) dao.get("subscriptionSpace.getWXGzh", paramMap);
        if(wx_gzh == null){
        	return null;
        }
        String psw = Md5Util.string2MD5(gzh_password);
        if(psw.equals(wx_gzh.get("GZH_PASSWORD").toString())){
        	return wx_gzh;
        }else{
        	return null;
        }
	}

}
