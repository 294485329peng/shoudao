package com.wp.project.background.menu.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.enterprise.inject.New;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.wp.common.cSession.SessionUser;
import com.wp.common.dao.IBaseDao;
import com.wp.common.page.PageView;
import com.wp.common.utils.DateUtils;
import com.wp.common.utils.StringUtils;
import com.wp.project.background.Authorize.service.AuthorizeServiceImpl;
import com.wp.project.background.WXReply.service.AttentionReplyServiceImpl;
import com.wp.project.message.Button;
import com.wp.project.message.ClickButton;
import com.wp.project.message.ComplexButton;
import com.wp.project.message.Component_Access_Token;
import com.wp.project.message.CustomService;
import com.wp.project.message.Menu;
import com.wp.project.message.Text;
import com.wp.project.message.UrlButton;
import com.wp.project.util.WeiXinUtil;
import com.wp.project.weixin.gzhMessage.service.impl.GzhMessageServiceImpl;

@Service("ZdycdServiceImpl")
public class ZdycdServiceImpl implements IZdycdService {
	@Autowired
	private IBaseDao dao;
	@Autowired
	private GzhMessageServiceImpl gzhMessageServiceImpl;

	/*
	 * @Override public void insert(Map<String, Object> record) { // TODO
	 * Auto-generated method stub record.put("BUTTON_ID","1");
	 * record.put("GZH_ID", "a53bf54d-c5b3-4615-a6d9-069b3d78319a");
	 * dao.insert("zdycdSpace.insert", record); }
	 */

	@Override
	public Map get(String id) {
		// TODO Auto-generated method stub
		return (Map) dao.get("zdycdSpace.getById", id);
	}

	@Override
	public PageView queryPage(PageView pageView, Map paramMap) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Map> query(Map paramMap) {
		// TODO Auto-generated method stub
		List list = (List) dao.query("zdycdSpace.query", paramMap);
		for (int i = 0; i < list.size(); i++) {
			Map map = (Map) list.get(i);
		}
		return list;
	}

	@Override
	public int insert(Map record) {
		record.put("BUTTON_ID", "1aaaad");
		record.put("GZH_ID", "a53bf54d-c5b3-4615-a6d9-069b3d78319a");
		return dao.insert_("zdycdSpace.insert", record);
	}

	@Override
	public int update(Map record) {
		// TODO Auto-generated method stub

		return dao.update_("zdycdSpace.updateMenuRank", record);
	}

	@Override
	public int delete(String id) {
		// TODO Auto-generated method stub

		return dao.delete("zdycdSpace.deleteMenu", id);
	}

	@Override
	public Map insert_map(Map record) {
		// TODO Auto-generated method stub

		return null;
	}

	@Override
	public Map update_Map(Map record) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int deleteMenuByGroupId(String id) {
		// TODO Auto-generated method stub
		return dao.delete("zdycdSpace.deleteMenuByGroupId", id);
	}

	@Override
	public List<Map> queryChildMenu(Map<String, Object> record) {
		// TODO Auto-generated method stub
		List list = (List) dao.query("zdycdSpace.queryChildMenu", record);
		return list;
	}

	@Override
	public Map insert_adminMenu(Map<String, Object> record) {
		// TODO Auto-generated method stub
		String MENU_ID = StringUtils.uniqueKey36();
		String SCD_MENU_GROUP_ID = StringUtils.uniqueKey36();
		String CREATE_TIME = DateUtils.getCurrentDate();
		String IT_ID = (String) record.get("IT_ID");
		String TRIGGER_ACTION = (String) record.get("TRIGGER_ACTION");
		record.put("MENU_ID", MENU_ID);
		record.put("SCD_MENU_GROUP_ID", SCD_MENU_GROUP_ID);
		record.put("CREATE_TIME", CREATE_TIME);
		dao.insert("zdycdSpace.insertAdminMenu", record);
		/*
		 * if(TRIGGER_ACTION == "\"1\""){ Map IT_MAP = (Map)
		 * dao.get("zdycdSpace.getById", IT_ID); record.put("IT_TITLE",
		 * IT_MAP.get("TITLE")); record.put("IT_PIC_URL",
		 * IT_MAP.get("PIC_URL")); record.put("IT_AUTHOR",
		 * IT_MAP.get("AUTHOR")); record.put("IT_CREATE_TIME",
		 * IT_MAP.get("CREATE_TIME")); record.put("IT_COUNT",
		 * IT_MAP.get("IT_COUNT")); }
		 */

		return record;
	}

	@Override
	public Map insert_childMenu(Map<String, Object> record) {
		// TODO Auto-generated method stub
		String MENU_ID = StringUtils.uniqueKey36();
		String CREATE_TIME = DateUtils.getCurrentDate();
		record.put("MENU_ID", MENU_ID);
		record.put("CREATE_TIME", CREATE_TIME);
		dao.insert("zdycdSpace.insertChildMenu", record);
		/*
		 * if(TRIGGER_ACTION == "\"1\""){ Map IT_MAP = (Map)
		 * dao.get("zdycdSpace.getById", IT_ID); record.put("IT_TITLE",
		 * IT_MAP.get("TITLE")); record.put("IT_PIC_URL",
		 * IT_MAP.get("PIC_URL")); record.put("IT_AUTHOR",
		 * IT_MAP.get("AUTHOR")); record.put("IT_CREATE_TIME",
		 * IT_MAP.get("CREATE_TIME")); record.put("IT_COUNT",
		 * IT_MAP.get("IT_COUNT")); }
		 */

		return record;
	}

	@Override
	public Map updateAdminMenu(Map<String, Object> record) {
		// TODO Auto-generated method stub
		String CREATE_TIME = DateUtils.getCurrentDate();
		record.put("CREATE_TIME", CREATE_TIME);
		dao.update("zdycdSpace.updateAdminMenu", record);
		return record;
	}

	@Override
	public Map updateChildMenu(Map<String, Object> record) {
		// TODO Auto-generated method stub
		String CREATE_TIME = DateUtils.getCurrentDate();
		record.put("CREATE_TIME", CREATE_TIME);
		dao.update("zdycdSpace.updateChildMenu", record);
		return record;
	}

	@Override
	public int deleteAdminMenu(String id) {
		// TODO Auto-generated method stub
		return dao.delete("zdycdSpace.deleteAdminMenu", id);
	}

	@Override
	public int deleteChildMenu(String id) {
		// TODO Auto-generated method stub
		return dao.delete("zdycdSpace.deleteChildMenu", id);
	}

	@Override
	public int publishMenu(Map<String, Object> record) {
		String gzhType = record.get("GZH_AUTH_TYPE").toString();
		List list = (List) dao.query("zdycdSpace.query", record);
		List listMenu = new ArrayList<>();
		for (int i = 0; i < list.size(); i++) {
			List listMap = new ArrayList<>();
			Map map0 = (Map) list.get(i);
			String adminId = "";
			if ("2".equals(map0.get("RESPONSE_ACTION").toString())
					&& "1".equals(map0.get("TRIGGER_ACTION").toString())
					&& "10".equals(gzhType)) {// 未认证跳转本地图片
				adminId = (String) dao.get("picUploadSpace.getMediaId", map0
						.get("PIC_ID").toString());
			} else if ("10".equals(map0.get("RESPONSE_ACTION").toString())
					&& "1".equals(map0.get("TRIGGER_ACTION").toString())
					&& "10".equals(gzhType)) {// 未认证跳转图文
				adminId = (String) dao.get("materialLibrarySpace.getMediaId",
						map0.get("IT_ID").toString());
			}
			if ("".equals(adminId)
					&& "1".equals(map0.get("TRIGGER_ACTION").toString())
					&& "10".equals(gzhType)) {
				return -1;
			} else if ("1".equals(map0.get("TRIGGER_ACTION").toString())
					&& "10".equals(gzhType)) {
				map0.put("NO_MEDIA_ID", adminId);
			}
			listMap.add(map0);
			List listChild = dao.query("zdycdSpace.queryChildMenu", map0);
			for (int j = 0; j < listChild.size(); j++) {
				Map map1 = (Map) listChild.get(j);
				String childId = "";
				if ("2".equals(map0.get("RESPONSE_ACTION").toString())
						&& "1".equals(map0.get("TRIGGER_ACTION").toString())
						&& "10".equals(gzhType)) {// 未认证图片
					childId = (String) dao.get("picUploadSpace.getMediaId",
							map0.get("PIC_ID").toString());
				} else if ("10".equals(map0.get("RESPONSE_ACTION").toString())
						&& "1".equals(map0.get("TRIGGER_ACTION").toString())
						&& "10".equals(gzhType)) {// 未认证图文
					childId = (String) dao.get(
							"materialLibrarySpace.getMediaId", map0
									.get("IT_ID").toString());
				}
				if ("".equals(childId)
						&& "1".equals(map0.get("TRIGGER_ACTION").toString())
						&& "10".equals(gzhType)) {
					return -1;
				} else if ("1".equals(map0.get("TRIGGER_ACTION").toString())
						&& "10".equals(gzhType)) {
					map1.put("NO_MEDIA_ID", childId);
				}
				listMap.add(map1);
			}
			listMenu.add(listMap);
		}
		Menu menu = new Menu();
		Button[] buttons = new Button[listMenu.size()];
		for (int i = 0; i < listMenu.size(); i++) {
			List listWei = (List) listMenu.get(i);
			if (listWei.size() < 2) {// 只有主菜单
				Map map = (Map) listWei.get(0);
				if ("1".equals(map.get("TRIGGER_ACTION").toString())) {// 发送图文或图片
					ClickButton clickButton = new ClickButton();
					clickButton.setName(map.get("MENU_NAME").toString());
					if ("10".equals(gzhType)) {
						clickButton.setType("media_id");
					} else {
						clickButton.setType("click");
					}
					if ("10".equals(map.get("RESPONSE_ACTION").toString())) {// 发送图文
						if ("10".equals(gzhType)) {
							clickButton.setMedia_id((map.get(
									"NO_MEDIA_ID").toString()));
						} else {
							clickButton.setKey("sendMat"
									+ map.get("MENU_ID").toString());
						}
					} else if ("2"
							.equals(map.get("RESPONSE_ACTION").toString())) {// 发送图片
						if ("10".equals(gzhType)) {
							clickButton.setMedia_id((map.get(
									"NO_MEDIA_ID").toString()));
						} else {
							clickButton.setKey("sendPic"
									+ map.get("MENU_ID").toString());
						}
					} else if ("1"
							.equals(map.get("RESPONSE_ACTION").toString())) {// 文字
						clickButton.setKey("sendTex"
								+ map.get("MENU_ID").toString());
					}
					buttons[i] = clickButton;
				} else if ("2".equals(map.get("TRIGGER_ACTION").toString())) {// 跳转url
					UrlButton urlButton = new UrlButton();
					urlButton.setName(map.get("MENU_NAME").toString());
					urlButton.setType("view");
					urlButton.setUrl(map.get("SOURCE_URL").toString());
					buttons[i] = urlButton;
				} else if ("3".equals(map.get("TRIGGER_ACTION").toString())) {// 跳转微网站
					ClickButton clickButton = new ClickButton();
					clickButton.setName("跳转微网站");
					clickButton.setType("click");
					clickButton.setKey("sendWeb");
					buttons[i] = clickButton;
				} else {// 回复本地图文
					ClickButton clickButton = new ClickButton();
					clickButton.setName(map.get("MENU_NAME").toString());
					clickButton.setType("click");
					clickButton.setKey("sendLoc"+map.get("LOCAL_IT_ID").toString());
					buttons[i] = clickButton;
				}
			} else {// 有子菜单
				ComplexButton complexButton = new ComplexButton();
				Button[] buttonList = new Button[listWei.size() - 1];// 子菜单
				for (int j = 0; j < listWei.size(); j++) {
					Map map = (Map) listWei.get(j);
					if (j == 0) {// 主菜单
						complexButton.setName(map.get("MENU_NAME").toString());
					} else {// 子菜单
						if ("1".equals(map.get("TRIGGER_ACTION").toString())) {// 发送图文或图片
							ClickButton clickButton = new ClickButton();
							clickButton.setName(map.get("MENU_NAME").toString());
							if ("10".equals(gzhType)) {
								clickButton.setType("media_id");
							} else {
								clickButton.setType("click");
							}
							if ("10".equals(map.get("RESPONSE_ACTION")
									.toString())) {// 发送图文
								if ("10".equals(gzhType)) {
									clickButton.setMedia_id((map
											.get("NO_MEDIA_ID").toString()));
								} else {
									clickButton.setKey("sendMat"
											+ map.get("MENU_ID").toString());
								}
							} else if ("2".equals(map.get("RESPONSE_ACTION")
									.toString())) {// 发送图片
								if ("10".equals(gzhType)) {
									clickButton.setMedia_id(( map
											.get("NO_MEDIA_ID").toString()));
								} else {
									clickButton.setKey("sendPic"
											+ map.get("MENU_ID").toString());
								}
							} else if ("1".equals(map.get("RESPONSE_ACTION")
									.toString())) {// 文字
								clickButton.setKey("sendTex"
										+ map.get("MENU_ID").toString());
							}
							buttonList[j - 1] = clickButton;
						} else if ("2".equals(map.get("TRIGGER_ACTION")
								.toString())) {// 跳转url
							UrlButton urlButton = new UrlButton();
							urlButton.setName(map.get("MENU_NAME").toString());
							urlButton.setType("view");
							urlButton.setUrl(map.get("SOURCE_URL").toString());
							buttonList[j - 1] = urlButton;
						} else if ("3".equals(map.get("TRIGGER_ACTION")
								.toString())) {// 跳转微网站
							ClickButton clickButton = new ClickButton();
							clickButton.setName("跳转微网站");
							clickButton.setType("click");
							clickButton.setKey("sendWeb");
							buttonList[j - 1] = clickButton;
						} else {
							ClickButton clickButton = new ClickButton();
							clickButton
									.setName(map.get("MENU_NAME").toString());
							clickButton.setType("click");
							clickButton.setKey("sendLoc"+map.get("LOCAL_IT_ID").toString());
							buttonList[j - 1] = clickButton;
						}
					}
				}
				complexButton.setSub_button(buttonList);
				buttons[i] = complexButton;
			}
		}
		menu.setButton(buttons);
		// 开始取accesstoken
		String accessToken = gzhMessageServiceImpl
				.getComponentAccessToken(SessionUser.getSessionGzhId());
		if ("".equals(accessToken)) {
			return -1;
		}
		Gson gson = new GsonBuilder().disableHtmlEscaping().create();
		int result = WeiXinUtil.createMenu(gson.toJson(menu), accessToken);
		return result;
	}

	@Override
	public Map getAdminMenuByMenuID(String id) {
		// TODO Auto-generated method stub
		Map record = (Map) dao.get("zdycdSpace.getAdminMenuByMenuID", id);
		return record;
	}

	@Override
	public Map getChildMenuByMenuID(String id) {
		// TODO Auto-generated method stub
		Map record = (Map) dao.get("zdycdSpace.getChildMenuByMenuID", id);
		return record;
	}

	@Override
	public int deleteAllAdminMenu(String id) {
		// TODO Auto-generated method stub
		dao.delete("zdycdSpace.deleteAllAdminMenu", id);
		return 0;
	}

	@Override
	public int deleteAllChildMenu(String id) {
		// TODO Auto-generated method stub
		dao.delete("zdycdSpace.deleteAllChildlMenu", id);
		return 0;
	}

	@Override
	public int repealMenu(Map<String, Object> record) {
		// 开始取accesstoken
		String accessToken = gzhMessageServiceImpl
				.getComponentAccessToken(SessionUser.getSessionGzhId());
		if ("".equals(accessToken)) {
			return -1;
		}
		int result = WeiXinUtil.cancelMenu(accessToken);
		return result;
	}
}
