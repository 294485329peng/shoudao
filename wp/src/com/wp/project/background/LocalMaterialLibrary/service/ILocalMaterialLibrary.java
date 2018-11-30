package com.wp.project.background.LocalMaterialLibrary.service;

import java.util.List;
import java.util.Map;

import com.wp.common.service.IBaseService;

public interface ILocalMaterialLibrary extends IBaseService{
	/*deleteByGroupId*/
	public int deleteByGroupId(String id);
	/*查找图文*/
	public List<Map> queryITByGroupID(Map paramMap);
	/*更新发布到微信端*/
	public int batchUpdate(Map paramMap);
}
