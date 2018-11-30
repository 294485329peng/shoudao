package com.wp.project.background.LocalMaterialLibrary.service;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.google.gson.JsonObject;
import com.mysql.fabric.Server;
import com.wp.common.cSession.SessionUser;
import com.wp.common.dao.IBaseDao;
import com.wp.common.page.PageView;
import com.wp.common.utils.DateUtils;
import com.wp.common.utils.ReplaceUtils;
import com.wp.common.utils.StringUtils;
import com.wp.project.message.AccessToken;
import com.wp.project.message.WeiXinArticle;
import com.wp.project.message.WeiXinNewsMessage;
import com.wp.project.util.WeiXinUtil;
import com.wp.project.weixin.gzhMessage.service.impl.GzhMessageServiceImpl;
import com.wp.common.img_src.img_src;

/**
 * 
 * @author Dizero
 * 
 */
@Service("LocalMaterialLibraryImpl")
public class LocalMaterialLibraryImpl implements ILocalMaterialLibrary {

	@Autowired
	private IBaseDao dao;
	@Autowired 
	private GzhMessageServiceImpl gzhMessageServiceImpl;
	@Override
	public Map get(String id) {
		// TODO Auto-generated method stub
		return (Map) dao.get("localITSpace.get", id);
	}
	public String getGroupId(String id){
		return (String) dao.get("localITSpace.getGroupId", id);
	}
	@Override
	public PageView queryPage(PageView pageView, Map paramMap) {
		// TODO Auto-generated method stub
		List list = dao.queryPage("localITSpace.queryPage", pageView,
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
		String LOCAL_IT_ID = StringUtils.uniqueKey36();
		record.put("LOCAL_IT_ID", LOCAL_IT_ID);
		String now = DateUtils.getCurrentDate();
		record.put("CREATE_TIME", now);
		return dao.insert_("localITSpace.insert", record);
	}

	@Override
	public int update(Map record) {
		// TODO Auto-generated method stub
		String now = DateUtils.getCurrentDate();
		record.put("CREATE_TIME", now);
		return dao.update_("localITSpace.update", record);
	}

	@Override
	public int delete(String id) {
		// TODO Auto-generated method stub
		dao.delete("localITSpace.deleteById", id);
		return 0;
	}
	@Override
	public Map insert_map(Map record) {
		// TODO Auto-generated method stub
		String LOCAL_IT_ID = StringUtils.uniqueKey36();
		record.put("LOCAL_IT_ID", LOCAL_IT_ID);
		record.put("GROUP_ID", LOCAL_IT_ID);
		String now = DateUtils.getCurrentDate();
		record.put("CREATE_TIME", now);
		dao.insert("localITSpace.insert", record);
		return record;
	}

	@Override
	public Map update_Map(Map record) {
		return null;
	}

	@Override
	public int deleteByGroupId(String id) {
		// TODO Auto-generated method stub
		return dao.delete("localITSpace.deleteByGroupId", id);
	}
	
	@Override
	public List<Map> queryITByGroupID(Map paramMap) {
		// TODO Auto-generated method stub
		List list = dao.query("localITSpace.queryITByGroupID", paramMap);
		return list;
	}

	@Override
	public int batchUpdate(Map paramMap) {
		// TODO Auto-generated method stub
		//dao.batchUpdateList("", list);
		return 0;
	}
	
}
