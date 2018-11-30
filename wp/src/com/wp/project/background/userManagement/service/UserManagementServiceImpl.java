package com.wp.project.background.userManagement.service;

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
import com.wp.project.util.WeiXinUtil;
import com.wp.project.weixin.gzhMessage.service.impl.GzhMessageServiceImpl;

@Service("UserManagementServiceImpl")
public class UserManagementServiceImpl implements IUserManagementService {
	@Autowired
	private IBaseDao dao;
	@Autowired
	private GzhMessageServiceImpl gzhMessageServiceImpl;

	@Override
	public Map get(String id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public PageView queryPage(PageView pageView, Map paramMap) {
		// TODO Auto-generated method stub
		List list = dao.queryPage("userManagementSpace.queryPage", pageView,
				paramMap);
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
		// TODO Auto-generated method stub
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
	public int insertUserInfo(Map paramMap) {
		Map old=paramMap;
		String openid = paramMap.get("OPEN_ID").toString();
		String gzh_id = paramMap.get("GZH_ID").toString();
		String accessToken = gzhMessageServiceImpl.getComponentAccessToken(gzh_id);
		if ("".equals(accessToken)) {
			return -1;
		}
		paramMap = WeiXinUtil.getUserInfo(openid, gzh_id, accessToken);
		if(null==paramMap){
			paramMap=old;
		}
		paramMap.put("CREATE_TIME", DateUtils.getCurrentDate().toString());
		paramMap.put("DELETE_MEMBER", "1");
		Map map = (Map) dao.get("userManagementSpace.getUserInfo", paramMap);
		if (map == null) {
			System.out.println("666");
			dao.insert_("userManagementSpace.insertUserInfo", paramMap);
		} else {
			dao.update_("userManagementSpace.updateUserInfo", paramMap);
		}

		return 0;
	}

	@Override
	public int updateUserInfo(Map paramMap) {
		// TODO Auto-generated method stub
		paramMap.put("CREATE_TIME", DateUtils.getCurrentDate().toString());
		dao.update_("userManagementSpace.updateUserInfo", paramMap);
		return 0;
	}

	@Override
	public int softDeleteUserInfo(Map paramMap) {
		// TODO Auto-generated method stub
		paramMap.put("CANCEL_TIME", DateUtils.getCurrentDate().toString());
		dao.update_("userManagementSpace.softDeleteUserInfo", paramMap);
		return 0;
	}

}
