/**
 * Copyright2015-2019 daiwk All Rights Reserved.
 */
package com.wp.base.om.om_group.service;

import java.util.List;
import java.util.Map;

import com.wp.common.service.IBaseService;
import com.wp.common.zTree.ZTreeNode;

/** 
 * @ClassName: IOmGroupService.java
 * @Description: 
 * @author daiwk 
 * @version 2015年9月24日 下午6:02:55 
 */
public interface IOmGroupService extends IBaseService{
	List<ZTreeNode> queryChildrenTreeNodes(String pId);
	
	/**
	 * 验证输入字段是否重复：修改
	 * @author: daiwk
	 */
	@SuppressWarnings("rawtypes")
	public List<Map> queryUpdate(Map paramMap);
}
