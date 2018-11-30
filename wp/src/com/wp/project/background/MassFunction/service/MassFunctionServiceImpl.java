package com.wp.project.background.MassFunction.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.enterprise.inject.New;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.wp.common.cSession.SessionUser;
import com.wp.common.dao.IBaseDao;
import com.wp.common.page.PageView;
import com.wp.common.utils.DateUtils;
import com.wp.common.utils.StringUtils;
import com.wp.project.message.Mass;
import com.wp.project.util.UUIDFactory;
import com.wp.project.util.WeiXinUtil;
import com.wp.project.weixin.gzhMessage.service.impl.GzhMessageServiceImpl;

@Service("MassFunctionServiceImpl")
public class MassFunctionServiceImpl implements IMassFunctionService {
	@Autowired
	private IBaseDao dao;
	@Autowired 
	private GzhMessageServiceImpl gzhMessageServiceImpl;
	@Override
	public Map get(String id) {
		// TODO Auto-generated method stub
		return (Map) dao.get("massFunctionSpace.getByMassId", id);
	}

	public Map getKeyWord(Map mapRequest) {
		
		return null;
	}

	@Override
	public PageView queryPage(PageView pageView, Map paramMap) {
		List list = dao.queryPage("massFunctionSpace.queryPage", pageView,
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
		
		return 0;
	}

	@Override
	public int update(Map record) {
		
		return 0;
	}

	@Override
	public int delete(String id) {
		
		return 0;
	}

	@Override
	public Map insert_map(Map record) {
		String MASS_ID = StringUtils.uniqueKey36();
		record.put("MASS_ID", MASS_ID);
		//System.out.println(record);
		String CREATE_TIME = DateUtils.getCurrentDateDay();
		record.put("CREATE_TIME", CREATE_TIME);
		Mass mass=new Mass();
		mass.getFilter().setIs_to_all(true);
		mass.getFilter().setGroup_id("");
		if("10".equals(record.get("TYPE").toString())){//图文
			String media_Id=record.get("IT_MEDIA_ID").toString();
			mass.getMpnews().setMedia_id(media_Id);
			mass.setMsgtype("mpnews");
		}
		else if("1".equals(record.get("TYPE").toString())){//文字
			String content=record.get("SAYTEXT").toString();
			mass.getText().setContent(content);
			mass.setMsgtype("text");
		}
		else {//图片
			String media_Id=record.get("PIC_MEDIA_ID").toString();
			mass.getImage().setMedia_id(media_Id);
			mass.setMsgtype("image");
		}
		Gson gson = new GsonBuilder().disableHtmlEscaping().create();
		//开始取accesstoken
		String accessToken=gzhMessageServiceImpl.getComponentAccessToken(SessionUser.getSessionGzhId());
		if("".equals(accessToken)){
			return null;
		}
		int isSend=WeiXinUtil.SendMass(gson.toJson(mass),accessToken);//0成功,-1失败
		if (isSend == 0){
			dao.insert("massFunctionSpace.insert", record);
			return record;
		}
		return null;
	}

	@Override
	public Map update_Map(Map record) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List isMassMessage(Map record) {
		// TODO Auto-generated method stub
		String CREATE_TIME = DateUtils.getCurrentDateDay();
		if("21".equals(record.get("GZH_AUTH_TYPE").toString())){
			CREATE_TIME = CREATE_TIME.substring(0,7);
			record.put("CREATE_TIME", CREATE_TIME);
		}else{
			record.put("CREATE_TIME", CREATE_TIME);
		}
		List list = dao.query("massFunctionSpace.getByDate", record);
		return list;
	}

}
