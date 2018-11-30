package com.wp.project.background.PicUpload.service;

import com.wp.common.service.IBaseService;
import java.util.Map;

public interface IPicUploadService extends IBaseService{
	public Map getPicByUrl(String  PIC_URL);
	public Map getPicById(String  PIC_ID);
	//WebPic
	public int deleteWebPic(String PIC_ID);
	public Map getWebPicById(String PIC_ID);
	public Map getWebPicByUrl(String PIC_URL);
	public Map updateWebPic(Map record);
}
