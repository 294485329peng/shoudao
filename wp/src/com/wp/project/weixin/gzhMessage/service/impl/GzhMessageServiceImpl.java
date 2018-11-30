package com.wp.project.weixin.gzhMessage.service.impl;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.wp.common.cSession.SessionUser;
import com.wp.common.dao.IBaseDao;
import com.wp.common.utils.DateUtils;
import com.wp.project.message.AccessToken;
import com.wp.project.message.Component_Access_Token;
import com.wp.project.util.WeiXinUtil;
import com.wp.project.weixin.gzhMessage.bean.GzhMessage;
import com.wp.project.weixin.gzhMessage.service.GzhMessageService;

@Service("GzhMessageServiceImpl")
public class GzhMessageServiceImpl implements GzhMessageService {
	@Autowired
	private IBaseDao baseDao;

	@Override
	public GzhMessage getGzhMessage(String GzhId) {
		GzhMessage gzhMessage = new GzhMessage();
		Map map = (Map) baseDao.get("weixinGetMessageSpace.get", GzhId);
		gzhMessage.setGzhId(map.get("GZH_ID").toString());
		gzhMessage.setGzhAppId(map.get("GZH_APPID").toString());
		return gzhMessage;
	}

	@Override
	public int updateAccessToken(Map map) {
		// TODO Auto-generated method stub
		baseDao.update("weixinGetMessageSpace.updateAccessToken", map);
		return 0;
	}

	public String getComponentAccessToken(String GzhId) {
		String accessToken = "";
		Map map = (Map) baseDao.get("weixinGetMessageSpace.getACT", GzhId);
		String date = map.get("TOKEN_EXPIRES_IN").toString();
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		try {
			Date oldTime = df.parse(date);
			Date newTime = df.parse(DateUtils.getCurrentDate());
			long interval = (newTime.getTime() - oldTime.getTime()) / 1000;// 相差秒数
			if (interval >= 7000) {
				Map mapCAT=(Map) baseDao.get("authorizeSpace.getCAT","wxaa2727c6564bd038");
				Component_Access_Token component_Access_Token = new Component_Access_Token();
				component_Access_Token.setComponent_appid("wxaa2727c6564bd038");
				component_Access_Token.setAuthorizer_appid(map.get("GZH_APPID").toString());
				component_Access_Token.setAuthorizer_refresh_token(map.get("AUTHORIZATION_REFRESH_TOKEN").toString());
				JSONObject jsonObject= WeiXinUtil.refreshAuthToken(mapCAT.get("COMPOMENT_ACCESS_TOKEN").toString(),new Gson().toJson(component_Access_Token));
				if (null != jsonObject) {
					accessToken = jsonObject.getString("authorizer_access_token");
					Map<String, String> mapUp = new HashMap<String, String>();
					mapUp.put("GZH_ID", GzhId);
					mapUp.put("AUTHORIZATION_ACCESS_TOKEN", accessToken);
					mapUp.put("TOKEN_EXPIRES_IN",
							DateUtils.getCurrentDate());
					baseDao.update("weixinGetMessageSpace.updateCAccessToken", mapUp);
				}
			} else {
				accessToken = map.get("AUTHORIZATION_ACCESS_TOKEN").toString();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return accessToken;
	}

	@Override
	public String getAccessToken(String GzhId) {
		String accessToken = "";
		Map map = (Map) baseDao.get("weixinGetMessageSpace.get", GzhId);
		if (null == map.get("GZH_ACCESS_TOKEN")) {
			AccessToken accessToken2 = WeiXinUtil.getAccessToken(
					SessionUser.getSessionGzhAppId(),
					SessionUser.getSessionGzhAppSecret());
			if (null != accessToken2) {
				accessToken = accessToken2.getToken();
				Map<String, String> mapUp = new HashMap<String, String>();
				mapUp.put("GZH_ID", GzhId);
				mapUp.put("GZH_ACCESS_TOKEN", accessToken);
				mapUp.put("GZH_ACCESS_TOKEN_VALID", DateUtils.getCurrentDate());
				updateAccessToken(mapUp);
			}
		} else {
			String date = map.get("GZH_ACCESS_TOKEN_VALID").toString();
			DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			try {
				Date oldTime = df.parse(date);
				Date newTime = df.parse(DateUtils.getCurrentDate());
				long interval = (newTime.getTime() - oldTime.getTime()) / 1000;// 相差秒数
				if (interval >= 7000) {
					AccessToken accessToken2 = WeiXinUtil.getAccessToken(
							SessionUser.getSessionGzhAppId(),
							SessionUser.getSessionGzhAppSecret());
					if (null != accessToken2) {
						accessToken = accessToken2.getToken();
						Map<String, String> mapUp = new HashMap<String, String>();
						mapUp.put("GZH_ID", GzhId);
						mapUp.put("GZH_ACCESS_TOKEN", accessToken);
						mapUp.put("GZH_ACCESS_TOKEN_VALID",
								DateUtils.getCurrentDate());
						updateAccessToken(mapUp);
					}
				} else {
					accessToken = map.get("GZH_ACCESS_TOKEN").toString();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return accessToken;
	}

	public String getAccessTokenClient(String GzhId, String appId,
			String appScret) {
		String accessToken = "";
		Map map = (Map) baseDao.get("weixinGetMessageSpace.get", GzhId);
		if (null == map.get("GZH_ACCESS_TOKEN")
				|| "".equals(map.get("GZH_ACCESS_TOKEN"))) {
			AccessToken accessToken2 = WeiXinUtil.getAccessToken(appId,
					appScret);
			if (null != accessToken2) {
				accessToken = accessToken2.getToken();
				Map<String, String> mapUp = new HashMap<String, String>();
				mapUp.put("GZH_ID", GzhId);
				mapUp.put("GZH_ACCESS_TOKEN", accessToken);
				mapUp.put("GZH_ACCESS_TOKEN_VALID", DateUtils.getCurrentDate());
				updateAccessToken(mapUp);
			}
		} else {
			String date = map.get("GZH_ACCESS_TOKEN_VALID").toString();
			DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			try {
				Date oldTime = df.parse(date);
				Date newTime = df.parse(DateUtils.getCurrentDate());
				long interval = (newTime.getTime() - oldTime.getTime()) / 1000;// 相差秒数
				if (interval >= 7000) {
					AccessToken accessToken2 = WeiXinUtil.getAccessToken(appId,
							appScret);
					if (null != accessToken2) {
						accessToken = accessToken2.getToken();
						Map<String, String> mapUp = new HashMap<String, String>();
						mapUp.put("GZH_ID", GzhId);
						mapUp.put("GZH_ACCESS_TOKEN", accessToken);
						mapUp.put("GZH_ACCESS_TOKEN_VALID",
								DateUtils.getCurrentDate());
						updateAccessToken(mapUp);
					}
				} else {
					accessToken = map.get("GZH_ACCESS_TOKEN").toString();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return accessToken;
	}
}
