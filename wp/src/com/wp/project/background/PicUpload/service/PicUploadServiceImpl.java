package com.wp.project.background.PicUpload.service;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wp.common.RetObj;
import com.wp.common.cSession.SessionUser;
import com.wp.common.dao.IBaseDao;
import com.wp.common.deleteFile.DeleteFile;
import com.wp.common.page.PageView;
import com.wp.common.utils.DateUtils;
import com.wp.common.utils.StringUtils;
import com.wp.project.util.WeiXinUtil;
import com.wp.project.weixin.gzhMessage.service.impl.GzhMessageServiceImpl;

@Service("PicUploadServiceImpl")
public class PicUploadServiceImpl implements IPicUploadService {
	@Autowired
	private IBaseDao dao;
	@Autowired
	private GzhMessageServiceImpl gzhMessageServiceImpl;

	@Override
	public Map get(String id) {
		// TODO Auto-generated method stub

		return (Map) dao.get("picUploadSpace.get", id);
	}

	@Override
	public PageView queryPage(PageView pageView, Map paramMap) {
		// TODO Auto-generated method stub
		List list = dao.queryPage("picUploadSpace.queryPage", pageView,
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
		if (record.get("PIC_ID") == null || record.get("PIC_ID") == "") {
			String PIC_ID = StringUtils.uniqueKey36();
			record.put("PIC_ID", PIC_ID);
		}
		String CREATE_TIME = DateUtils.getCurrentDate();
		record.put("CREATE_TIME", CREATE_TIME);
		List<String> weixinCover = null;// 0是media_id,1是url
		try {
			/*InputStream inputStreamCover = WeiXinUtil
					.getInputStreamFromUrl("http://photocdn.sohu.com/20160109/Img433980924.jpeg");*/
			
			 InputStream inputStreamCover = WeiXinUtil
			 .getInputStreamFromUrl(record.get("PIC_URL_FWQ").toString());
			 
			// record.get("PIC_URL_FWQ").toString()
			// 开始取accesstoken
			String accessToken = gzhMessageServiceImpl
					.getComponentAccessToken(SessionUser.getSessionGzhId());
			if ("".equals(accessToken)) {
				return -1;
			}
			weixinCover = WeiXinUtil.addForeverMaterial(inputStreamCover,
					"image", accessToken);// 上传封面图片
			if (null == weixinCover) {
				return -1;// 上传图片失败结束本次图文消息上传
			} else {
				System.out.println(weixinCover.get(0) + weixinCover.get(1));
			}
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		}

		record.put("MEDIA_ID", weixinCover.get(0));
		record.put("PIC_URL_WX", weixinCover.get(1));
		int i = dao.insert_("picUploadSpace.insert", record);
		System.out.println(i);
		if (i == 0) {
			i = -1;
		}
		return i;
	}

	@Override
	public Map insert_map(Map record) {
		// TODO Auto-generated method stub
		if (record.get("PIC_ID") == null || record.get("PIC_ID") == "") {
			String PIC_ID = StringUtils.uniqueKey36();
			record.put("PIC_ID", PIC_ID);
		}
		String CREATE_TIME = DateUtils.getCurrentDate();
		record.put("CREATE_TIME", CREATE_TIME);
		int i = dao.insert_("picUploadSpace.insertWebPic", record);
		if (i == 0) {
			return null;
		}
		return record;
	}

	@Override
	public int update(Map record) {
		// TODO Auto-generated method stub
		String CREATE_TIME = DateUtils.getCurrentDate();
		record.put("CREATE_TIME", CREATE_TIME);
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
		// 这调用微信接口,
		String accessToken = gzhMessageServiceImpl
				.getComponentAccessToken(SessionUser.getSessionGzhId());
		if ("".equals(accessToken)) {
			return -1;
		}
		int result = WeiXinUtil.deleteMaterial(id, accessToken);// 0成功-1不成功
		if (-1 == result) {
			return -1;
		}
		Map record = (Map) dao.get("picUploadSpace.get", id);
		DeleteFile hfc = new DeleteFile();
		String path = record.get("PIC_URL_BD").toString();
		hfc.DeleteFolder(path);
		
		
		return dao.delete("picUploadSpace.delete", id);
	}

	@Override
	public Map getPicByUrl(String PIC_URL) {
		// TODO Auto-generated method stub

		return (Map) dao.get("picUploadSpace.getPicByUrl", PIC_URL);
	}

	@Override
	public Map getPicById(String PIC_ID) {
		// TODO Auto-generated method stub
		return (Map) dao.get("picUploadSpace.getPicById", PIC_ID);
	}

	@Override
	public int deleteWebPic(String PIC_ID) {
		// TODO Auto-generated method stub

		return dao.delete("picUploadSpace.deleteWebPic", PIC_ID);
	}

	@Override
	public Map getWebPicById(String PIC_ID) {
		// TODO Auto-generated method stub

		Map record = (Map) dao.get("picUploadSpace.getWebPicById", PIC_ID);
		return record;
	}

	@Override
	public Map getWebPicByUrl(String PIC_URL) {
		// TODO Auto-generated method stub

		return (Map) dao.get("picUploadSpace.getWebPicByUrl", PIC_URL);
	}

	@Override
	public Map updateWebPic(Map record) {
		// TODO Auto-generated method stub
		int i = dao.update_("picUploadSpace.updateWebPic", record);
		if (i == 0) {
			return null;
		}
		return record;
	}

}
