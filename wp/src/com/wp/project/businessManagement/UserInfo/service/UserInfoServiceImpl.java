package com.wp.project.businessManagement.UserInfo.service;

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
public class UserInfoServiceImpl implements IUserInfoService{
	@Autowired
	private IBaseDao dao;

	@Override
	public Map get(String id) {
		// TODO Auto-generated method stub
		
		return (Map) dao.get("userInfoSpace.get", id);
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
		String CREATE_TIME = DateUtils.getCurrentDate();
		record.put("CREATE_TIME", CREATE_TIME);
		
		return dao.insert_("userInfoSpace.insert", record);
	}

	@Override
	public Map insert_map(Map record) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int update(Map record) {
		// TODO Auto-generated method stub
		return dao.update_("userInfoSpace.update", record);
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

	
}
