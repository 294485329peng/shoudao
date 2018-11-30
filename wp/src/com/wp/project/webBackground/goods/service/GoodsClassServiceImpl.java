package com.wp.project.webBackground.goods.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wp.common.dao.IBaseDao;
import com.wp.common.page.PageView;
import com.wp.common.utils.DateUtils;
import com.wp.common.utils.StringUtils;
import com.wp.project.util.UUIDFactory;

@Service("GoodsClassServiceImpl")
public class GoodsClassServiceImpl implements IGoodsClassService {
	@Autowired
	private IBaseDao dao;

	@Override
	public Map get(String id) {
		// TODO Auto-generated method stub
		return (Map) dao.get("goodsClassSpace.get", id);
	}


	@Override
	public PageView queryPage(PageView pageView, Map paramMap) {
		List list = dao.queryPage("goodsClassSpace.queryPage",
				pageView, paramMap);
		pageView.setRecords(list);
		return pageView;
	}

	@Override
	public List<Map> query(Map paramMap) {
		// TODO Auto-generated method stub
		
		return dao.query("goodsClassSpace.queryPublish", paramMap);
	}

	@Override
	public int insert(Map record) {
		String GOODS_CLASSIFY_ID = StringUtils.uniqueKey36();
		String CREATE_TIME = DateUtils.getCurrentDate();
		record.put("GOODS_CLASSIFY_ID", GOODS_CLASSIFY_ID);
		record.put("CREATE_TIME", CREATE_TIME);
		int i = dao.insert_("goodsClassSpace.insert", record);
		return i;
	}

	@Override
	public int update(Map record) {
		
		return dao.update_("goodsClassSpace.update", record);
	}

	@Override
	public int delete(String id) {
		int i = dao.delete("goodsClassSpace.delete", id);
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
		return (Map) dao.update("goodsClassSpace.update", record);
	}


	@Override
	public PageView queryPageRank(PageView pageView, Map paramMap) {
		// TODO Auto-generated method stub
		List list = dao.queryPage("goodsClassSpace.queryPageRank",
				pageView, paramMap);
		pageView.setRecords(list);
		return pageView;
	}


	@Override
	public Map updateRank(Map record) {
		// TODO Auto-generated method stub
		List list = null;
		dao.batchUpdateList("goodsClassSpace.batchUpdateRank", list);
		return null;
	}


	@Override
	public int updateClass(Map record) {
		// TODO Auto-generated method stub
		if(record.get("PUBLISH") == null){
			record.put("PUBLISH", "off");
		}
		return dao.update_("goodsClassSpace.updateClass", record);
	}


	@Override
	public Map insertClass(Map record) {
		// TODO Auto-generated method stub
		String GOODS_CLASSIFY_ID = StringUtils.uniqueKey36();
		if(record.get("PUBLISH") == null){
			record.put("PUBLISH", "off");
		}
		String CREATE_TIME = DateUtils.getCurrentDate();
		record.put("GOODS_CLASSIFY_ID", GOODS_CLASSIFY_ID);
		record.put("CREATE_TIME", CREATE_TIME);
		int i = dao.insert_("goodsClassSpace.insertClass", record);
		String gzhId = record.get("GZH_ID").toString();
		
		record.put("classUrl", "http://www.wxplatform.top/wp/TWeb/goods/goodsList.htmls?store="+gzhId+"&CLASSIFY="+GOODS_CLASSIFY_ID);
		if(i == 0){
			return null;
		}
		return record;
		
	}


	@Override
	public int deleteClass(String id) {
		// TODO Auto-generated method stub
		int i = dao.delete("goodsClassSpace.deleteClass", id);
		return i;
	}


	@Override
	public Map getClass(String id) {
		// TODO Auto-generated method stub
		Map record = (Map) dao.get("goodsClassSpace.getClass", id);
		String gzhId = record.get("GZH_ID").toString();
		String GOODS_CLASSIFY_ID = record.get("GOODS_CLASSIFY_ID").toString();
		record.put("classUrl", "http://www.wxplatform.top/wp/TWeb/goods/goodsList.htmls?store="+gzhId+"&CLASSIFY="+GOODS_CLASSIFY_ID);

		return record;
	}


	@Override
	public PageView queryPageClass(PageView pageView, Map paramMap) {
		// TODO Auto-generated method stub
		List list = dao.queryPage("goodsClassSpace.classqueryPage", pageView, paramMap);
		pageView.setRecords(list);
		return pageView;
	}

}
