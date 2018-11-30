package com.wp.project.request;

import java.io.PrintWriter;
import java.io.StringWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javassist.expr.NewArray;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONObject;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.omg.CORBA.PUBLIC_MEMBER;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.alibaba.druid.sql.dialect.oracle.ast.stmt.OracleIfStatement.Else;
import com.fasterxml.jackson.annotation.JsonTypeInfo.None;
import com.google.gson.Gson;
import com.wp.project.background.Authorize.service.AuthorizeServiceImpl;
import com.wp.project.background.AutoResponse.service.AutoResponseServiceImpl;
import com.wp.project.background.LocalMaterialLibrary.service.LocalMaterialLibraryImpl;
import com.wp.project.background.MaterialLibrary.service.MaterialLibraryImpl;
import com.wp.project.background.PicUpload.service.PicUploadServiceImpl;
import com.wp.project.background.WXReply.controller.AttentionReplyController;
import com.wp.project.background.WXReply.service.AttentionReplyServiceImpl;
import com.wp.project.background.WXReply.service.AutoReplyServiceImpl;
import com.wp.project.background.menu.service.ZdycdServiceImpl;
import com.wp.project.background.userManagement.service.UserManagementServiceImpl;
import com.wp.project.message.Article;
import com.wp.project.message.Component_Access_Token;
import com.wp.project.message.CustomService;
import com.wp.project.message.ImagePic;
import com.wp.project.message.NewsMessage;
import com.wp.project.message.PicMessage;
import com.wp.project.message.Text;
import com.wp.project.message.TextMessage;
import com.wp.project.util.MessageUtil;
import com.wp.project.util.WeiXinUtil;
import com.wp.project.util.aes.AesException;
import com.wp.project.util.aes.WXBizMsgCrypt;
import com.wp.project.weixin.gzhMessage.bean.GzhMessage;
import com.wp.project.weixin.gzhMessage.controller.GzhMessageController;
import com.wp.project.weixin.gzhMessage.service.impl.GzhMessageServiceImpl;

/**
 * 核心服务类
 * 
 */
public class CoreService {
	private static GzhMessageServiceImpl gzhMessageServiceImpl;
	private static AttentionReplyServiceImpl attentionReplyServiceImpl;
	private static AutoResponseServiceImpl autoResponseServiceImpl;
	private static MaterialLibraryImpl materialLibraryImpl;
	private static ZdycdServiceImpl zdycdServiceImpl;
	private static PicUploadServiceImpl picUploadServiceImpl;
	private static AutoReplyServiceImpl autoReplyServiceImpl;
	private static UserManagementServiceImpl userManagementServiceImpl;
	private static LocalMaterialLibraryImpl localMaterialLibraryImpl;
	private static String fromUserName;
	private static String toUserName;
	private static String respContent = null;
	private static ApplicationContext context = null;
	private static WXBizMsgCrypt pc = null;

	/**
	 * 处理微信发来的请求
	 * 
	 * @param request
	 * @return
	 */
	public static String processRequest(HttpServletRequest request) {
		try {
			// 默认返回的文本消息内容
			respContent = "";
			// 第三方用户唯一凭证
			String appId = "";
			// 第三方用户唯一凭证密钥
			// String appSecret = "";
			// xml请求解析
			Map<String, String> requestMap = MessageUtil.parseXml(request);
			requestMap.put("msg_signature",
					request.getParameter("msg_signature"));
			requestMap.put("timestamp", request.getParameter("timestamp"));
			requestMap.put("nonce", request.getParameter("nonce"));
			Element element = Decrypt(requestMap);
			// 发送方帐号（open_id）
			fromUserName = element.elementText("FromUserName");
			// 公众帐号
			toUserName = element.elementText("ToUserName");
			// 消息类型
			String msgType = element.elementText("MsgType");
			List<Article> articleList = new ArrayList<Article>();
			// 回复文本消息
			TextMessage textMessage = new TextMessage();
			textMessage.setToUserName(fromUserName);
			textMessage.setFromUserName(toUserName);
			textMessage.setCreateTime(new Date().getTime());
			textMessage.setMsgType(MessageUtil.RESP_MESSAGE_TYPE_TEXT);
			context = WebApplicationContextUtils
					.getWebApplicationContext(request.getServletContext());
			if (null == gzhMessageServiceImpl) {
				gzhMessageServiceImpl = (GzhMessageServiceImpl) context
						.getBean("GzhMessageServiceImpl");
			}

			GzhMessage gzhMessage = gzhMessageServiceImpl
					.getGzhMessage(toUserName);
			if ("".equals(gzhMessage.getGzhId())
					|| null == gzhMessage.getGzhId()) {
				return respContent = MessageUtil.textMessageToXml(textMessage);
			} else {
				if ("gh_3c884a361561".equals(fromUserName)) {
					appId = "wx570bc396a51b8ff8";
				} else {
					appId = gzhMessage.getGzhAppId();
				}
			}
			// 文本消息
			if (msgType.equals(MessageUtil.REQ_MESSAGE_TYPE_TEXT)) {
				String content = element.elementText("Content");
				List<String> keyWord = KeyWordReply(content);
				if (null != keyWord) {
					if ("text".equals(keyWord.get(0))) {
						textMessage.setContent(keyWord.get(1));
						return Encrypt(
								MessageUtil.textMessageToXml(textMessage),
								request.getParameter("timestamp"),
								request.getParameter("nonce"));
					} else if ("news".equals(keyWord.get(0))) {
						return Encrypt(keyWord.get(1),
								request.getParameter("timestamp"),
								request.getParameter("nonce"));
					} else {
						return Encrypt(keyWord.get(1),
								request.getParameter("timestamp"),
								request.getParameter("nonce"));
					}
				} else {
				}
			}

			// 图片消息
			else if (msgType.equals(MessageUtil.REQ_MESSAGE_TYPE_IMAGE)) {
				respContent = "您发送的是图片消息！\n回复“?”显示此帮助菜单";
			}
			// 地理位置消息
			else if (msgType.equals(MessageUtil.REQ_MESSAGE_TYPE_LOCATION)) {
				respContent = "您发送的是地理位置消息！\n回复“?”显示此帮助菜单";
			}
			// 链接消息
			else if (msgType.equals(MessageUtil.REQ_MESSAGE_TYPE_LINK)) {
				respContent = "您发送的是链接消息！\n回复“?”显示此帮助菜单";
			}
			// 音频消息
			else if (msgType.equals(MessageUtil.REQ_MESSAGE_TYPE_VOICE)) {
				respContent = "您发送的是音频消息！\n回复“?”显示此帮助菜单";
			}
			// 事件推送
			else if (msgType.equals(MessageUtil.REQ_MESSAGE_TYPE_EVENT)) {
				// 事件类型
				String eventType = element.elementText("Event");
				// 订阅
				if (eventType.equals(MessageUtil.EVENT_TYPE_SUBSCRIBE)) {
					addUserInfo(fromUserName, appId);
					if (null == attentionReplyServiceImpl) {
						attentionReplyServiceImpl = (AttentionReplyServiceImpl) context
								.getBean("AttentionReplyServiceImpl");
					}
					Map map = attentionReplyServiceImpl.get(toUserName);
					if (null == map) {

					} else if ("1".equals(map.get("TYPE").toString())) {
						String subscribe = map.get("SAYTEXT").toString();
						textMessage.setContent(subscribe);
						return Encrypt(
								MessageUtil.textMessageToXml(textMessage),
								request.getParameter("timestamp"),
								request.getParameter("nonce"));
					} else if ("10".equals(map.get("TYPE").toString())) {
						if (null == materialLibraryImpl) {
							materialLibraryImpl = (MaterialLibraryImpl) context
									.getBean("MaterialLibraryImpl");
						}
						Map itGroupId = new HashMap<>();
						itGroupId.put("IT_GROUP_ID", map.get("IT_GROUP_ID")
								.toString());
						List<Map> mapNews = materialLibraryImpl
								.queryITByGroupID(itGroupId);
						if (null != mapNews) {
							return Encrypt(
									MessageUtil
											.newsMessageToXml(getNewsMessage(
													fromUserName, toUserName,
													mapNews)),
									request.getParameter("timestamp"), request
											.getParameter("nonce"));
						}

					} else {
						if (null == picUploadServiceImpl) {
							picUploadServiceImpl = (PicUploadServiceImpl) context
									.getBean("PicUploadServiceImpl");
						}
						Map mapPic = picUploadServiceImpl.getPicById(map.get(
								"PIC_ID").toString());
						if (null != mapPic) {
							return Encrypt(
									MessageUtil
											.picMessageToXml(getPicMessage(
													fromUserName, toUserName,
													mapPic.get("MEDIA_ID")
															.toString())),
									request.getParameter("timestamp"), request
											.getParameter("nonce"));
						}
					}
				}
				// 取消订阅
				else if (eventType.equals(MessageUtil.EVENT_TYPE_UNSUBSCRIBE)) {
					// TODO 取消订阅后用户再收不到公众号发送的消息，因此不需要回复消息
					if (null == userManagementServiceImpl) {
						userManagementServiceImpl = (UserManagementServiceImpl) context
								.getBean("UserManagementServiceImpl");
					}
					Map<String, String> map = new HashMap<>();
					map.put("OPEN_ID", fromUserName);
					userManagementServiceImpl.softDeleteUserInfo(map);
					return Encrypt("success",
							request.getParameter("timestamp"),
							request.getParameter("nonce"));
				}
				// 自定义菜单点击事件
				else if (eventType.equals(MessageUtil.EVENT_TYPE_CLICK)) {
					if (null == zdycdServiceImpl) {
						zdycdServiceImpl = (ZdycdServiceImpl) context
								.getBean("ZdycdServiceImpl");
					}
					String eventKey = element.elementText("EventKey");
					System.out.println(eventKey);
					String menuId = eventKey.substring(7);
					Map map = zdycdServiceImpl.getAdminMenuByMenuID(menuId);
					if (null == map) {
						map = zdycdServiceImpl.getChildMenuByMenuID(menuId);
					}
					if (eventKey.contains("sendMat")) {// 回复图文
						if (null == materialLibraryImpl) {
							materialLibraryImpl = (MaterialLibraryImpl) context
									.getBean("MaterialLibraryImpl");
						}
						String itGroupId = materialLibraryImpl
								.getGroupIdByIT_ID(map.get("IT_ID").toString());
						if (null != itGroupId && !"".equals(itGroupId)) {
							Map itGroupIdMap = new HashMap<>();
							itGroupIdMap.put("IT_GROUP_ID", itGroupId);
							List<Map> mapNews = materialLibraryImpl
									.queryITByGroupID(itGroupIdMap);
							if (null != mapNews) {
								return Encrypt(
										MessageUtil.newsMessageToXml(getNewsMessage(
												fromUserName, toUserName,
												mapNews)),
										request.getParameter("timestamp"),
										request.getParameter("nonce"));
							}
						}

					} else if (eventKey.contains("sendPic")) {// 回复图片
						if (null == picUploadServiceImpl) {
							picUploadServiceImpl = (PicUploadServiceImpl) context
									.getBean("PicUploadServiceImpl");
						}
						Map mapPic = picUploadServiceImpl.getPicById(map.get(
								"PIC_ID").toString());
						if (null != mapPic) {
							return Encrypt(
									MessageUtil
											.picMessageToXml(getPicMessage(
													fromUserName, toUserName,
													mapPic.get("MEDIA_ID")
															.toString())),
									request.getParameter("timestamp"), request
											.getParameter("nonce"));
						}
					} else if (eventKey.contains("sendTex")) {
						textMessage.setContent(map.get("SAYTEXT").toString());
						return Encrypt(
								MessageUtil.textMessageToXml(textMessage),
								request.getParameter("timestamp"),
								request.getParameter("nonce"));
					} else if (eventKey.contains("sendWeb")) {// 回复图文跳转微网站

					} else {// 回复本地图文
						if (null == localMaterialLibraryImpl) {
							localMaterialLibraryImpl = (LocalMaterialLibraryImpl) context
									.getBean("LocalMaterialLibraryImpl");
						}
						System.out.println(menuId);
						String localItGroupId = localMaterialLibraryImpl
								.getGroupId(menuId);
						Map maplocal = new HashMap<>();
						maplocal.put("GROUP_ID", localItGroupId);
						List localMat = localMaterialLibraryImpl
								.queryITByGroupID(maplocal);
						return Encrypt(
								MessageUtil.newsMessageToXml(getNewsMessageLocal(
										fromUserName, toUserName, localMat)),
								request.getParameter("timestamp"),
								request.getParameter("nonce"));
					}
				}
				// 自定义菜单链接事件推送
				else if (eventType.equals(MessageUtil.EVENT_TYPE_URL)) {

				}
			}
			// 默认回复
			List<String> auto = AutoReply();
			if (null != auto) {
				if ("text".equals(auto.get(0))) {
					textMessage.setContent(auto.get(1));
					return Encrypt(MessageUtil.textMessageToXml(textMessage),
							request.getParameter("timestamp"),
							request.getParameter("nonce"));
				} else if ("news".equals(auto.get(0))) {
					return Encrypt(auto.get(1),
							request.getParameter("timestamp"),
							request.getParameter("nonce"));
				} else {
					return Encrypt(auto.get(1),
							request.getParameter("timestamp"),
							request.getParameter("nonce"));
				}
			}
			textMessage.setContent(respContent);
			respContent = MessageUtil.textMessageToXml(textMessage);
			respContent = Encrypt(respContent,
					request.getParameter("timestamp"),
					request.getParameter("nonce"));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return respContent;
	}

	// 添加用户信息
	public static void addUserInfo(String openid, String appId) {
		Map<String, String> map = new HashMap<>();
		map.put("OPEN_ID", openid);
		map.put("GZH_ID", toUserName);
		map.put("APPID", appId);
		map.put("USER_TYPE", "1");// 微信用户
		if (null == userManagementServiceImpl) {
			userManagementServiceImpl = (UserManagementServiceImpl) context
					.getBean("UserManagementServiceImpl");
		}
		userManagementServiceImpl.insertUserInfo(map);
	}

	// 关键词回复
	public static List KeyWordReply(String content) {
		if (null == autoResponseServiceImpl) {
			autoResponseServiceImpl = (AutoResponseServiceImpl) context
					.getBean("AutoResponseServiceImpl");
		}
		Map mapRequest = new HashMap<String, String>();
		mapRequest.put("GZH_ID", toUserName);
		mapRequest.put("KEYWORD", content);
		Map map = (Map) autoResponseServiceImpl.getKeyWord(mapRequest);
		if (null != map) {
			if ("1".equals(map.get("REPLY_TYPE").toString())) {// 文字
				List<String> list = new ArrayList<>();
				list.add("text");
				list.add(map.get("SAYTEXT").toString());
				return list;
			} else if ("2".equals(map.get("REPLY_TYPE").toString())) {// 图文
				if (null == materialLibraryImpl) {
					materialLibraryImpl = (MaterialLibraryImpl) context
							.getBean("MaterialLibraryImpl");
				}
				Map itGroupId = new HashMap<>();
				itGroupId.put("IT_GROUP_ID", map.get("IT_GROUP_ID").toString());
				List<Map> mapNews = materialLibraryImpl
						.queryITByGroupID(itGroupId);
				if (null != mapNews) {
					List<String> list = new ArrayList<>();
					list.add("news");
					list.add(MessageUtil.newsMessageToXml(getNewsMessage(
							fromUserName, toUserName, mapNews)));
					return list;
				}
			} else if ("3".equals(map.get("REPLY_TYPE").toString())) {// 本地图文
				if (null == localMaterialLibraryImpl) {
					localMaterialLibraryImpl = (LocalMaterialLibraryImpl) context
							.getBean("LocalMaterialLibraryImpl");
				}
				String localItGroupId = localMaterialLibraryImpl.getGroupId(map
						.get("IT_ID").toString());
				Map maplocal = new HashMap<>();
				maplocal.put("GROUP_ID", localItGroupId);
				List localMat = localMaterialLibraryImpl
						.queryITByGroupID(maplocal);
				List<String> list = new ArrayList<>();
				list.add("localnews");
				list.add(MessageUtil.newsMessageToXml(getNewsMessageLocal(
						fromUserName, toUserName, localMat)));
				return list;
			}
		}
		return null;
	}

	// 加密
	public static String Encrypt(String replyMsg, String timestamp, String nonce)
			throws AesException {
		if (null == pc) {
			pc = new WXBizMsgCrypt("weixinCourse",
					"GJQyLXn13yLpmcQghCM0HIBN4FDGGtbyIosdohj2hpj",
					"wxaa2727c6564bd038");
		}
		String mingwen = pc.EncryptMsg(replyMsg, timestamp, nonce);
		return mingwen;
	}

	// 解密
	public static Element Decrypt(Map map) throws AesException,
			DocumentException {
		if (null == pc) {
			pc = new WXBizMsgCrypt("weixinCourse",
					"GJQyLXn13yLpmcQghCM0HIBN4FDGGtbyIosdohj2hpj",
					"wxaa2727c6564bd038");
		}
		String format = "<xml><ToUserName><![CDATA[toUser]]></ToUserName><Encrypt><![CDATA[%1$s]]></Encrypt></xml>";
		String fromXML = String.format(format, map.get("Encrypt").toString());
		String result2 = pc.DecryptMsg(map.get("msg_signature").toString(), map
				.get("timestamp").toString(), map.get("nonce").toString(),
				fromXML);
		Document doc = (Document) DocumentHelper.parseText(result2);
		Element books = doc.getRootElement();
		return books;
	}

	// 默认回复
	public static List AutoReply() {
		if (null == autoReplyServiceImpl) {
			autoReplyServiceImpl = (AutoReplyServiceImpl) context
					.getBean("AutoReplyServiceImpl");
		}
		Map map = autoReplyServiceImpl.get(toUserName);
		if (null == map) {
			return null;
		}
		if ("0".equals(map.get("PUBLISH").toString())) {
			return null;
		}
		if ("1".equals(map.get("TYPE").toString())) {
			List<String> list = new ArrayList<>();
			list.add("text");
			list.add(map.get("SAYTEXT").toString());
			return list;
		} else if ("10".equals(map.get("TYPE").toString())) {// 图文
			if (null == materialLibraryImpl) {
				materialLibraryImpl = (MaterialLibraryImpl) context
						.getBean("MaterialLibraryImpl");
			}
			Map itGroupId = new HashMap<>();
			itGroupId.put("IT_GROUP_ID", map.get("IT_GROUP_ID").toString());
			List<Map> mapNews = materialLibraryImpl.queryITByGroupID(itGroupId);
			if (null != mapNews) {
				List<String> list = new ArrayList<>();
				list.add("news");
				list.add(MessageUtil.newsMessageToXml(getNewsMessage(
						fromUserName, toUserName, mapNews)));
				return list;
			}
		} else {
			if (null == picUploadServiceImpl) {
				picUploadServiceImpl = (PicUploadServiceImpl) context
						.getBean("PicUploadServiceImpl");
			}
			Map mapPic = picUploadServiceImpl.getPicById(map.get("PIC_ID")
					.toString());
			if (null != mapPic) {
				List<String> list = new ArrayList<>();
				list.add("image");
				list.add(MessageUtil.picMessageToXml(getPicMessage(
						fromUserName, toUserName, mapPic.get("MEDIA_ID")
								.toString())));
				return list;
			}
		}
		return null;
	}

	// 返回图片信息
	public static PicMessage getPicMessage(String fromUserName,
			String toUserName, String mediaId) {
		PicMessage picMessage = new PicMessage();
		picMessage.setToUserName(fromUserName);
		picMessage.setFromUserName(toUserName);
		picMessage.setCreateTime(System.currentTimeMillis());
		picMessage.setMsgType(MessageUtil.REQ_MESSAGE_TYPE_IMAGE);
		ImagePic image = new ImagePic();
		image.setMediaId(mediaId);
		picMessage.setImage(image);
		return picMessage;
	}

	// 返回图文信息
	public static NewsMessage getNewsMessageLocal(String fromUserName,
			String toUserName, List<Map> list) {
		// 创建图文消息
		List<Article> articleList = new ArrayList<Article>();
		NewsMessage newsMessage = new NewsMessage();
		newsMessage.setToUserName(fromUserName);
		newsMessage.setFromUserName(toUserName);
		newsMessage.setCreateTime(System.currentTimeMillis());
		newsMessage.setMsgType(MessageUtil.RESP_MESSAGE_TYPE_NEWS);
		for (int i = 0; i < list.size(); i++) {
			Map map = list.get(i);
			Article article = new Article();
			article.setTitle(map.get("TITLE").toString());
			if (i < 1) {
				article.setDescription(map.get("DESCRIPTION").toString());
			} else {
				article.setDescription("");
			}
			article.setPicUrl(map.get("PIC_URL").toString());
			// if ("1".equals(map.get("USER_INFO").toString())) {
			if (!map.get("URL").toString().contains("?")) {
				article.setUrl(map.get("URL").toString());
				/*
				 * article.setUrl(map.get("URL").toString() + "?customer=" +
				 * fromUserName);
				 */
			} else {
				article.setUrl(map.get("URL").toString() + "&store="
						+ toUserName);
				/*
				 * article.setUrl(map.get("URL").toString() + "&customer=" +
				 * fromUserName + "&store=" + toUserName);
				 */
			}

			/*
			 * } else { article.setUrl(map.get("URL").toString()); }
			 */
			articleList.add(article);
		}
		newsMessage.setArticleCount(articleList.size());
		newsMessage.setArticles(articleList);
		return newsMessage;
	}

	// 返回图文信息
	public static NewsMessage getNewsMessage(String fromUserName,
			String toUserName, List<Map> list) {
		// 创建图文消息
		List<Article> articleList = new ArrayList<Article>();
		NewsMessage newsMessage = new NewsMessage();
		newsMessage.setToUserName(fromUserName);
		newsMessage.setFromUserName(toUserName);
		newsMessage.setCreateTime(System.currentTimeMillis());
		newsMessage.setMsgType(MessageUtil.RESP_MESSAGE_TYPE_NEWS);
		for (int i = 0; i < list.size(); i++) {
			Map map = list.get(i);
			Article article = new Article();
			article.setTitle(map.get("TITLE").toString());
			if (i < 1) {
				article.setDescription(map.get("DESCRIPTION").toString());
			} else {
				article.setDescription("");
			}
			article.setPicUrl(map.get("PIC_URL_WX").toString());
			article.setUrl(map.get("PUBLISH_URL").toString());
			articleList.add(article);
		}
		newsMessage.setArticleCount(articleList.size());
		newsMessage.setArticles(articleList);
		return newsMessage;
	}

	public static String getErrorInfoFromException(Exception e) {
		try {
			StringWriter sw = new StringWriter();
			PrintWriter pw = new PrintWriter(sw);
			e.printStackTrace(pw);
			return "\r\n" + sw.toString() + "\r\n";
		} catch (Exception e2) {
			return "bad getErrorInfoFromException";
		}
	}
}
