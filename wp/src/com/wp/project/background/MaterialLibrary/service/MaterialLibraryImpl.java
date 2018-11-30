package com.wp.project.background.MaterialLibrary.service;

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
import com.wp.common.RetObj;
import com.wp.common.cSession.SessionUser;
import com.wp.common.dao.IBaseDao;
import com.wp.common.page.PageView;
import com.wp.common.utils.DateUtils;
import com.wp.common.utils.IsNullOrEmpty;
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
@Service("MaterialLibraryImpl")
public class MaterialLibraryImpl implements IMaterialLibrary {

	@Autowired
	private IBaseDao dao;
	@Autowired
	private GzhMessageServiceImpl gzhMessageServiceImpl;

	@Override
	public Map get(String id) {
		// TODO Auto-generated method stub
		return (Map) dao.get("materialLibrarySpace.get", id);
	}

	@Override
	public PageView queryPage(PageView pageView, Map paramMap) {
		// TODO Auto-generated method stub
		List list = dao.queryPage("materialLibrarySpace.queryPage", pageView,
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
	public int update(Map record) {
		// TODO Auto-generated method stub
		String now = DateUtils.getCurrentDate();
		record.put("CREATE_TIME", now);
		return dao.update_("materialLibrarySpace.update", record);
	}

	@Override
	public int delete(String id) {
		// TODO Auto-generated method stub
		dao.delete("materialLibrarySpace.deleteById", id);
		return 0;
	}

	@Override
	public String forUpdateIM(Map record) {
		// TODO Auto-generated method stub
		if (record.get("operation") == "editor") {
			// request.setAttribute("", arg1);
		}
		return null;
	}

	@Override
	// @Transactional
	public Map mainInsert(Map record) {
		// TODO Auto-generated method stub

		return null;
	}

	@Override
	public Map insert_map(Map record) {
		// TODO Auto-generated method stub
		img_src is = new img_src();
		String IT_ID = StringUtils.uniqueKey36();
		String IT_GROUP_ID = StringUtils.uniqueKey36();
		record.put("IT_ID", IT_ID);
		record.put("SHOW_COVER_PIC", "0");
		String GROUP_ID = (String) record.get("IT_GROUP_ID");
		if (null == GROUP_ID || "" == GROUP_ID) {
			record.put("IT_GROUP_ID", IT_GROUP_ID);
		}
		String now = DateUtils.getCurrentDate();
		record.put("CREATE_TIME", now);
		// dao.insert_("materialLibrarySpace.mainInsert", record);
		// WeiXinUtil.addForeverImage("");
		String content_Url = record.get("CONTENT").toString();
		List<String> urlList = is.getImgSrc(content_Url);
		List<String> weixinUrl = new ArrayList<>();
		try {
			for (int i = 0; i < urlList.size(); i++) {// 上传content图片
				InputStream inputStream = WeiXinUtil
						.getInputStreamFromUrl(urlList.get(i));
				if (null == inputStream) {
					return null;// 上传图片失败结束本次图文消息上传
				}
				// 开始取accesstoken
				String accessToken = gzhMessageServiceImpl
						.getComponentAccessToken(SessionUser.getSessionGzhId());
				if ("".equals(accessToken)) {
					return null;
				}
				String url = WeiXinUtil.addForeverImage(inputStream,
						WeiXinUtil.addImage_url, accessToken);
				if ("".equals(url)) {
					return null;// 上传图片失败结束本次图文消息上传
				} else {
					weixinUrl.add(url);
					// System.out.println("++++++"+urlList.get(i));
					ReplaceUtils replaceUtil = new ReplaceUtils();
					content_Url = replaceUtil.replace(content_Url, url,
							urlList.get(i));
					// content_Url.replace(urlList.get(i), "123123");
				}
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		record.put("WX_CONTENT", content_Url);
		dao.insert_("materialLibrarySpace.mainInsert", record);
		return record;
	}

	@Override
	public Map update_Map(Map record) {
		// 给我mediaid和index
		// 里面封装了MEDIA_ID,IT_INDEX. 你根据MEDIA_ID是否为空判断是否发布了。没发布就不用更新微信! 你再看看删除
		String now = DateUtils.getCurrentDate();
		record.put("CREATE_TIME", now);
		
		if (!IsNullOrEmpty.isNullOrEmpty(record.get("MEDIA_ID"))) {
			String accessToken = gzhMessageServiceImpl.getComponentAccessToken(SessionUser.getSessionGzhId());
			if ("".equals(accessToken)) {
				return null;
			}
			WeiXinNewsMessage weiXinNewsMessage = new WeiXinNewsMessage();
			weiXinNewsMessage.setMedia_id(record.get("MEDIA_ID").toString());
			weiXinNewsMessage.setIndex(Integer.parseInt(record.get("IT_INDEX").toString()));
			WeiXinArticle weiXinArticle = new WeiXinArticle();
			weiXinArticle.setTitle(record.get("TITLE").toString());
			weiXinArticle.setAuthor(record.get("AUTHOR").toString());
			weiXinArticle.setThumb_media_id(record.get("PIC_MEDIA_ID").toString());
			if ("0".equals(record.get("IT_INDEX").toString())) {
				weiXinArticle.setDigest(record.get("DESCRIPTION").toString());
			}
			weiXinArticle.setShow_cover_pic("0");
			weiXinArticle.setContent(record.get("CONTENT").toString());
			weiXinArticle.setContent_source_url(record.get("SOURCE_URL").toString());
			weiXinNewsMessage.setABCarticleCBA(weiXinArticle);
			int result1 = WeiXinUtil.updateMaterial(weiXinNewsMessage, accessToken);
			if (0 == result1) {
				dao.update_("materialLibrarySpace.update", record);
				return record;
			} else {
				return null;
			}
		} else {
			dao.update_("materialLibrarySpace.update", record);
			return record;
		}
	}

	@Override
	public int deleteByGroupId(String id) {
		// TODO Auto-generated method stub
		return dao.delete("materialLibrarySpace.deleteByGroupId", id);
	}

	@Override
	public Map publishIT(String id) {
		List<Map> list = dao.query("materialLibrarySpace.queryPublishIT", id);
		WeiXinNewsMessage weiXinNewsMessage = new WeiXinNewsMessage();
		List<WeiXinArticle> weiXinArticles = new ArrayList<>();
		for (int i = 0; i < list.size(); i++) {
			Map map = list.get(i);
			WeiXinArticle weiXinArticle = new WeiXinArticle();
			weiXinArticle.setTitle(map.get("TITLE").toString());
			weiXinArticle.setAuthor(map.get("AUTHOR").toString());
			weiXinArticle.setThumb_media_id(map.get("PIC_MEDIA_ID").toString());
			if (list.size() < 2) {
				weiXinArticle.setDigest(map.get("DESCRIPTION").toString());
			}
			weiXinArticle.setShow_cover_pic(map.get("SHOW_COVER_PIC")
					.toString());
			weiXinArticle.setContent(map.get("WX_CONTENT").toString());
			weiXinArticle.setContent_source_url(map.get("SOURCE_URL")
					.toString());
			weiXinArticles.add(weiXinArticle);
		}
		weiXinNewsMessage.setArticles(weiXinArticles);
		// 开始取accesstoken
		String accessToken = gzhMessageServiceImpl
				.getComponentAccessToken(SessionUser.getSessionGzhId());
		if ("".equals(accessToken)) {
			return null;
		}
		String mediaId = WeiXinUtil.addForeverNewsMessage(weiXinNewsMessage,
				accessToken);// 正确情况返回图文ID
		if ("".equals(mediaId)) {
			return null;
		}
		Map record = new HashMap();
		record.put("IT_GROUP_ID", id);
		record.put("MEDIA_ID", mediaId);
		record.put("PUBLISH", "1");
		// dao.update("materialLibrarySpace.publishIT", record);
		// 开始取accesstoken
		List<String> urlList = WeiXinUtil.getMarterialByMediaId(mediaId,
				accessToken);
		List<Object> publishList = new ArrayList<>();
		for (int i = 0; i < list.size(); i++) {
			Map publishMap = list.get(i);
			String PUBLISH_URL = urlList.get(i);
			publishMap.put("MEDIA_ID", mediaId);
			publishMap.put("PUBLISH_URL", PUBLISH_URL);
			// publishMap.put("IT_ORDER", i);
			publishList.add(publishMap);
		}
		dao.batchUpdateList("materialLibrarySpace.publishIT", publishList);
		return record;
	}

	@Override
	public List<Map> queryChiildIT(Map paramMap) {
		// TODO Auto-generated method stub
		List list = dao.query("materialLibrarySpace.queryChiildIT", paramMap);
		return list;
	}

	@Override
	public List<Map> queryITByGroupID(Map paramMap) {
		// TODO Auto-generated method stub
		List list = dao
				.query("materialLibrarySpace.queryITByGroupID", paramMap);
		return list;
	}

	@Override
	public String getGroupIdByIT_ID(String IT_ID) {
		// TODO Auto-generated method stub
		String IT_GROUP_ID = (String) dao.get(
				"materialLibrarySpace.getGroupIdByIT_ID", IT_ID);
		return IT_GROUP_ID;
	}

	@Override
	public Map rePublishIT(String id) {
		// TODO Auto-generated method stub
		List<Map> list = dao.query("materialLibrarySpace.queryPublishIT", id);
		// dao.batchUpdateList("materialLibrarySpace.publishIT",
		// publishList);//用户更新发布后的信息
		return null;
	}

}
