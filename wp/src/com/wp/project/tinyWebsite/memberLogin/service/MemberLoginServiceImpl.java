package com.wp.project.tinyWebsite.memberLogin.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import com.wp.common.dao.IBaseDao;
import com.wp.common.page.PageView;
import com.wp.common.utils.DateUtils;
import com.wp.common.utils.IsNullOrEmpty;
import com.wp.common.utils.Md5Util;
import com.wp.common.utils.StringUtils;
import com.wp.project.tinyWebsite.memberLogin.service.IMemberLoginService;

@Service("MemberLoginServiceImpl")
public class MemberLoginServiceImpl implements IMemberLoginService{
	@Autowired
	private IBaseDao dao;
	
	@Override
	public Map get(String id) {
		// TODO Auto-generated method stub
		
		return (Map) dao.get("memberBCSpace.getByMemberId", id);
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
		// TODO Auto-generated method stub
		String OPEN_ID = StringUtils.uniqueKey36();
		String CREATE_TIME = DateUtils.getCurrentDate();
		String LOGIN_PASSWORD = record.get("LOGIN_PASSWORD").toString();
		LOGIN_PASSWORD = Md5Util.string2MD5(LOGIN_PASSWORD);
		record.put("LOGIN_PASSWORD", LOGIN_PASSWORD);
		record.put("OPEN_ID", OPEN_ID);
		record.put("MEMBER_ID", OPEN_ID);
		record.put("DELETE_MEMBER", "1");
		record.put("USER_TYPE","2");
		record.put("CREATE_TIME", CREATE_TIME);
		int i = dao.insert_("memberBCSpace.insert", record);
		return i;
	}

	@Override
	public Map insert_map(Map record) {
		// TODO Auto-generated method stub
		String OPEN_ID = StringUtils.uniqueKey36();
		String CREATE_TIME = DateUtils.getCurrentDate();
		String LOGIN_PASSWORD = record.get("LOGIN_PASSWORD").toString();
		LOGIN_PASSWORD = Md5Util.string2MD5(LOGIN_PASSWORD);
		record.put("LOGIN_PASSWORD", LOGIN_PASSWORD);
		record.put("OPEN_ID", OPEN_ID);
		record.put("MEMBER_ID", OPEN_ID);
		record.put("DELETE_MEMBER", "1");
		record.put("USER_TYPE","2");
		record.put("CREATE_TIME", CREATE_TIME);
		dao.insert_("memberBCSpace.insertCard", OPEN_ID);
		return (Map) dao.insert("memberBCSpace.insert", record);
	}

	@Override
	public int update(Map record) {
		// TODO Auto-generated method stub
		return dao.update_("tinyMemberLoginSpace.update", record);
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
	public Map checkLogin(String userId, String password) {
		// TODO Auto-generated method stub
		Map<String,Object> paramMap = new HashMap<String,Object>();
        paramMap.put("LOGIN_NAME", userId);
        Map user=(Map) dao.get("memberBCSpace.getByMemberId", paramMap);
        if(IsNullOrEmpty.isNullOrEmpty(user)){
        	return null;
        }
        String psw = Md5Util.string2MD5(password);
        if(psw.equals(user.get("LOGIN_PASSWORD"))){
        	return user;
        }else{
        	paramMap.put("msg", "密码错误！");
        	return paramMap;
        } 
	}
	@Override
	public Map getByOpenIdGzh(Map record) {
		// TODO Auto-generated method stub
		return (Map) dao.get("memberBCSpace.getByOpenIdGzh", record);
	}

	@Override
	public int updatePassWord(Map record) {
		// TODO Auto-generated method stub
		Map user=(Map) dao.get("tinyMemberLoginSpace.get", record);
        if(IsNullOrEmpty.isNullOrEmpty(user)){
        	return 0;
        }
        String psw = Md5Util.string2MD5(record.get("OLD_PASSWORD").toString());
        if(psw.equals(user.get("LOGIN_PASSWORD"))){
        	return dao.update_("tinyMemberLoginSpace.updatePassWord", record);
        }else{
        	return 100;
        }
		
	}
}
