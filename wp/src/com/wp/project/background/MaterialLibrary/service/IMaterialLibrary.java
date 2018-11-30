package com.wp.project.background.MaterialLibrary.service;

import java.util.List;
import java.util.Map;

import com.wp.common.service.IBaseService;

public interface IMaterialLibrary extends IBaseService{
	public String forUpdateIM(Map record);	
	/* 插入主图文信息 */
	public Map mainInsert(Map record);
	/*deleteByGroupId*/
	public int deleteByGroupId(String id);
	/*发布到微信端*/
	public Map publishIT(String id);
	/*查找子图文*/
	public List<Map> queryChiildIT(Map paramMap);
	/*查找图文*/
	public List<Map> queryITByGroupID(Map paramMap);
	/*根据IT_ID 查找 GROUP_ID*/
	public String getGroupIdByIT_ID(String IT_ID);
	/*更新发布到微信端*/
	public Map rePublishIT(String id);
}
