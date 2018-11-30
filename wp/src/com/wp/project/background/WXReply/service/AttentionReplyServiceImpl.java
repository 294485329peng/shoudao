package com.wp.project.background.WXReply.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wp.common.dao.IBaseDao;
import com.wp.common.page.PageView;
import com.wp.common.utils.DateUtils;
import com.wp.common.utils.StringUtils;

@Service("AttentionReplyServiceImpl")
public class AttentionReplyServiceImpl implements IAttentionReplyService{
	@Autowired
	private IBaseDao dao;

	@Override
	public Map get(String id) {
		// TODO Auto-generated method stub
		Map<String,Object> record;
		record = (Map<String, Object>) dao.get("attentionReplySpace.get", id);
		return record;
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
		String ATTENTION_REPLY_ID = StringUtils.uniqueKey36();
		String CREATE_TIME = DateUtils.getCurrentDate();
		record.put("CREATE_TIME", CREATE_TIME);
		record.put("ATTENTION_REPLY_ID", ATTENTION_REPLY_ID);
		return dao.insert_("attentionReplySpace.insert", record);
	}

	@Override
	public Map insert_map(Map record) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int update(Map record) {
		// TODO Auto-generated method stub
		String CREATE_TIME = DateUtils.getCurrentDate();
		record.put("CREATE_TIME", CREATE_TIME);
		
		return dao.update_("attentionReplySpace.update", record);
	}

	@Override
	public Map update_Map(Map record) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int delete(String id) {
		// TODO Auto-generated method stub
		return dao.delete("attentionReplySpace.deleteAttentionReply", id);
	}

}
