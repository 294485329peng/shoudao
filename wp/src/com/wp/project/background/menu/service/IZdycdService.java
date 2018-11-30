package com.wp.project.background.menu.service;

import java.util.List;
import java.util.Map;

import com.wp.common.service.IBaseService;

public interface IZdycdService extends IBaseService{
	 public Map insert_adminMenu(Map<String,Object> record);
	 public Map insert_childMenu(Map<String,Object> record);
	 public int deleteMenuByGroupId(String id);
	 public List<Map> queryChildMenu(Map<String,Object> record);
	 public Map updateAdminMenu(Map<String,Object> record);
	 public Map updateChildMenu(Map<String,Object> record);
	 public int deleteAdminMenu(String id);
	 public int deleteChildMenu(String id);
	 public int publishMenu(Map<String,Object> record);
	 public int repealMenu(Map<String,Object> record);
	 public Map getAdminMenuByMenuID(String id);
	 public Map getChildMenuByMenuID(String id);
	 public int deleteAllAdminMenu(String id);
	 public int deleteAllChildMenu(String id);
}
