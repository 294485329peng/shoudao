package com.wp.project.weixin.gzhMessage.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.wp.project.weixin.gzhMessage.bean.GzhMessage;
import com.wp.project.weixin.gzhMessage.service.GzhMessageService;

@Controller
public class GzhMessageController {
	@Autowired
	private GzhMessageService gzhMessageService;
	public GzhMessage getGzhMessage(String GzhId) {
		return gzhMessageService.getGzhMessage(GzhId);
	}
	public int updateAccessToken(Map map){
		return gzhMessageService.updateAccessToken(map);
	}
	public String getAccessToken(String GzhId){
		return gzhMessageService.getAccessToken(GzhId);
	}
}
