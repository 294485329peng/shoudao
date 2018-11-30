package com.wp.project.background.Authorize.service;

import java.io.PrintWriter;
import java.io.StringWriter;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONObject;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ctc.wstx.util.DataUtil;
import com.google.gson.Gson;
import com.wp.common.cSession.SessionUser;
import com.wp.common.dao.IBaseDao;
import com.wp.common.page.PageView;
import com.wp.common.utils.DateUtils;
import com.wp.common.utils.StringUtils;
import com.wp.project.message.Component_Access_Token;
import com.wp.project.util.MessageUtil;
import com.wp.project.util.UUIDFactory;
import com.wp.project.util.WeiXinUtil;
import com.wp.project.util.aes.AesException;
import com.wp.project.util.aes.WXBizMsgCrypt;

@Service("AuthorizeServiceImpl")
public class AuthorizeServiceImpl implements IAuthorizeService {
	@Autowired
	private IBaseDao baseDao;
	private String appid = "wxaa2727c6564bd038";
	private String appscret = "dfaaf7dfb85e15a2c70c4dbdcea370c5";
	private String encodingAesKey = "GJQyLXn13yLpmcQghCM0HIBN4FDGGtbyIosdohj2hpj";

	@Override
	public Map get(String id) {
		// TODO Auto-generated method stub
		return null;
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
	public void updateCVT(Map map) {
		// TODO Auto-generated method stub
		try {
			WXBizMsgCrypt pc = new WXBizMsgCrypt("weixinCourse",
					encodingAesKey, appid);
			String format = "<xml><ToUserName><![CDATA[toUser]]></ToUserName><Encrypt><![CDATA[%1$s]]></Encrypt></xml>";
			String fromXML = String.format(format, map.get("Encrypt")
					.toString());
			String result2 = pc.DecryptMsg(map.get("msg_signature").toString(),
					map.get("timestamp").toString(), map.get("nonce")
							.toString(), fromXML);
			Document doc = (Document) DocumentHelper.parseText(result2);
			Element books = doc.getRootElement();
			if ("unauthorized".equals(books.elementText("InfoType"))) {// 取消授权
				System.out.println("cancel");
				Map mapUpdateUn = new HashMap<>();
				mapUpdateUn.put("GZH_APPID",
						books.elementText("AuthorizerAppid"));
				baseDao.update("authorizeSpace.updateUnAuth", mapUpdateUn);
			} else {
				Map mapUpdate = new HashMap<>();
				mapUpdate.put("COMPONENT_APPID", appid);
				mapUpdate.put("COMPONENT_VERIFY_TICKET",
						books.elementText("ComponentVerifyTicket"));
				baseDao.update("authorizeSpace.updateCVT", mapUpdate);
				Map mapCAT = (Map) baseDao.get("authorizeSpace.getCAT", appid);
				String date = mapCAT.get("EXPIRES_IN").toString();
				DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				Date oldTime = df.parse(date);
				Date newTime = df.parse(DateUtils.getCurrentDate());
				long interval = (newTime.getTime() - oldTime.getTime()) / 1000;// 相差秒数
				if (interval >= 6000) {
					Component_Access_Token component_Access_Token = new Component_Access_Token();
					component_Access_Token.setComponent_appid(appid);
					component_Access_Token.setComponent_appsecret(appscret);
					component_Access_Token.setComponent_verify_ticket(books
							.elementText("ComponentVerifyTicket"));
					String cat = WeiXinUtil.getCAT(new Gson()
							.toJson(component_Access_Token));
					if (!"".equals(cat)) {
						updateCAT(cat);
					}
				}

			}
		} catch (AesException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public Map getUrlData() {
		Map map = new HashMap<>();
		String cat = getCATFromDb();
		if ("".equals(cat)) {
			Component_Access_Token component_Access_Token = new Component_Access_Token();
			component_Access_Token.setComponent_appid(appid);
			component_Access_Token.setComponent_appsecret(appscret);
			String cvt = getCVT();
			if ("".equals(cvt)) {
				return null;
			}
			component_Access_Token.setComponent_verify_ticket(cvt);
			String token = WeiXinUtil.getCAT(new Gson()
					.toJson(component_Access_Token));
			if ("".equals(token)) {
				return null;
			} else {
				cat = token;
				updateCAT(cat);
			}
		}
		Component_Access_Token component_Access_Token = new Component_Access_Token();
		component_Access_Token.setComponent_appid(appid);
		String pac = WeiXinUtil.getPAC(cat,
				new Gson().toJson(component_Access_Token));
		if ("".equals(pac)) {
			return null;
		} else {
			map.put("pre_auth_code", pac);
			map.put("component_appid", appid);
			map.put("redirect_uri",
					"http://www.wxplatform.top/wp/au/AuthorizeBack.do");
			return map;
		}
	}

	public void updateCAT(String cat) {
		Map map = new HashMap<>();
		map.put("COMPOMENT_ACCESS_TOKEN", cat);
		map.put("EXPIRES_IN", DateUtils.getCurrentDate());
		map.put("COMPONENT_APPID", appid);
		baseDao.update("authorizeSpace.updateCAT", map);
	}

	public String getCATFromDb() {
		Map cat = (Map) baseDao.get("authorizeSpace.getCAT", appid);
		if (null == cat) {
			return "";
		}
		String date = cat.get("EXPIRES_IN").toString();
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		try {
			Date oldTime = df.parse(date);
			Date newTime = df.parse(DateUtils.getCurrentDate());
			long interval = (newTime.getTime() - oldTime.getTime()) / 1000;// 相差秒数
			if (interval >= 7000) {
				return "";
			} else {
				return cat.get("COMPOMENT_ACCESS_TOKEN").toString();
			}
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return "";
	}

	public String getCVT() {
		String cvt = (String) baseDao.get("authorizeSpace.getCVT", appid);
		return cvt;
	}

	@Override
	public int saveAuthCode(String authCode) {
		Map map = (Map) baseDao.get("authorizeSpace.getAuthCode",
				SessionUser.getSessionOperatorId());
		Map insertMap = new HashMap<>();
		insertMap.put("OPERATOR_ID", SessionUser.getSessionOperatorId());
		insertMap.put("AUTHORIZATION_CODE", authCode);
		insertMap.put("CODE_EXPIRE_IN", DateUtils.getCurrentDate());
		if (null == map) {
			int result = baseDao.insert_("authorizeSpace.insertAuthCode",
					insertMap);
			if (1 == result) {
				return 0;
			}
		} else {
			int result = baseDao.update_("authorizeSpace.updateAuthCode",
					insertMap);
			if (1 == result) {
				return 0;
			}
		}
		return -1;
	}

	public void getGzhInfo(String gzhId, String token, String adminId,String operatorId) {
		Component_Access_Token component_Access_Token = new Component_Access_Token();
		component_Access_Token.setComponent_appid(appid);
		component_Access_Token.setAuthorizer_appid(gzhId);
		JSONObject jsonObject = WeiXinUtil.getAuthGzhInfo(token,
				new Gson().toJson(component_Access_Token));
		if (null == jsonObject) {
			return;
		} else {
			System.out.println(jsonObject.get("authorizer_info"));
			System.out.println(jsonObject.get("authorization_info"));
			Map map = new HashMap<>();
			map.put("GZH_NICK_NAME", jsonObject
					.getJSONObject("authorizer_info").get("nick_name")
					.toString());
			map.put("GZH_HEADER_IMG",
					jsonObject.getJSONObject("authorizer_info").get("head_img")
							.toString());
			map.put("GZH_TYPE", jsonObject.getJSONObject("authorizer_info")
					.getJSONObject("service_type_info").get("id").toString());
			map.put("GZH_VERIFY_TYPE",
					jsonObject.getJSONObject("authorizer_info")
							.getJSONObject("verify_type_info").get("id")
							.toString());
			map.put("GZH_ID",
					jsonObject.getJSONObject("authorizer_info")
							.get("user_name").toString());
			map.put("GZH_WECHAT_ID", jsonObject
					.getJSONObject("authorizer_info").get("alias").toString());
			map.put("GZH_QRCODE_URL", jsonObject.getJSONObject("authorizer_info").getString("qrcode_url"));
			map.put("GZH_APPID", jsonObject.getJSONObject("authorization_info").getString("authorizer_appid"));
			map.put("OPERATOR_ID",operatorId);
			String left = jsonObject.getJSONObject("authorizer_info")// 公众号类型1订阅号2服务号
					.getJSONObject("service_type_info").get("id").toString();
			String right = jsonObject.getJSONObject("authorizer_info")// -1未认证0认证
					.getJSONObject("verify_type_info").get("id").toString();
			if ("1".equals(left)||"0".equals(left)) {
				if ("0".equals(right)||"1".equals(right)||"2".equals(right)) {
					map.put("GZH_AUTH_TYPE", "11");
				} else {
					map.put("GZH_AUTH_TYPE", "10");
				}
			} else {
				if ("0".equals(right)||"1".equals(right)||"2".equals(right)) {
					map.put("GZH_AUTH_TYPE", "21");
				} else {
					map.put("GZH_AUTH_TYPE", "20");
				}
			}
			System.out.println(map);
			int result=baseDao.update_("authorizeSpace.updateGzhInfo", map);
		}
	}

	@Override
	public int getAuthToken(String authCode,String operatorId) {
		String cat = getCATFromDb();
		if ("".equals(cat)) {
			Component_Access_Token component_Access_Token = new Component_Access_Token();
			component_Access_Token.setComponent_appid(appid);
			component_Access_Token.setComponent_appsecret(appscret);
			String cvt = getCVT();
			if ("".equals(cvt)) {
				return -1;
			}
			component_Access_Token.setComponent_verify_ticket(cvt);
			String token = WeiXinUtil.getCAT(new Gson()
					.toJson(component_Access_Token));
			if ("".equals(token)) {
				return -1;
			} else {
				cat = token;
				updateCAT(cat);
			}
		}
		System.out.println(cat);
		Component_Access_Token component_Access_Token = new Component_Access_Token();
		component_Access_Token.setComponent_appid(appid);
		component_Access_Token.setAuthorization_code(authCode);
		JSONObject jsonObject = WeiXinUtil.getAuthToken(cat,
				new Gson().toJson(component_Access_Token));
		if (null == jsonObject) {
			return -1;
		}
		System.out.println(jsonObject.get("authorization_info"));
		String appid = (String) baseDao.get(
				"authorizeSpace.getAppId",
				jsonObject.getJSONObject("authorization_info").getString(
						"authorizer_appid"));
		Map map = new HashMap<>();
		map.put("ADMIN_ID", StringUtils.uniqueKey36());
		map.put("AUTHORIZATION_ACCESS_TOKEN",
				jsonObject.getJSONObject("authorization_info").getString(
						"authorizer_access_token"));
		map.put("AUTHORIZATION_REFRESH_TOKEN",
				jsonObject.getJSONObject("authorization_info").getString(
						"authorizer_refresh_token"));
		map.put("TOKEN_EXPIRES_IN", DateUtils.getCurrentDate());
		map.put("GZH_APPID", jsonObject.getJSONObject("authorization_info")
				.getString("authorizer_appid"));
		map.put("GZH_AUTH_STATUS", "1");// 授权成功
		int result = 0;
		if (null == appid || "".equals(appid)) {// insert
			result = baseDao.insert_("authorizeSpace.insertAuthToken", map);
		} else {// update
			result = baseDao.update_("authorizeSpace.updateAuthToken", map);
		}
		if (1 == result) {
			getGzhInfo(jsonObject.getJSONObject("authorization_info")
					.getString("authorizer_appid"), cat, map.get("ADMIN_ID")
					.toString(),operatorId);
			return 0;
		} else {
			return -1;
		}
	}
}
