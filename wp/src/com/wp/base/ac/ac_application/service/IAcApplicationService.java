/**
 * Copyright2015-2019 daiwk All Rights Reserved.
 */
package com.wp.base.ac.ac_application.service;

import java.util.List;
import java.util.Map;

import com.wp.common.service.IBaseService;
import com.wp.common.zTree.ZTreeNode;

/**
 * @ClassName: IAcApplicationService
 * @Description: TODO
 * @author:daiwk 
 * @date: 2015年9月2日下午7:05:55
 */
public interface IAcApplicationService extends IBaseService {
	List<ZTreeNode> queryChildrenTreeNodes(String pId);
	
	/**
	 * 验证输入字段是否重复：修改
	 * @author: daiwk
	 */
//	@SuppressWarnings("rawtypes")
//	public List<Map> queryUpdate(Map paramMap);
}
