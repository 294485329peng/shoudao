package com.wp.project.weixin.gzhMessage.service;
import java.util.Map;

import com.wp.project.weixin.gzhMessage.bean.GzhMessage;

public interface GzhMessageService{
	GzhMessage getGzhMessage(String GzhId);
	int updateAccessToken(Map map);
	String getAccessToken(String GzhId);
}
