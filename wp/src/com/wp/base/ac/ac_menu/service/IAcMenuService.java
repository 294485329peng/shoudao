/**
 * Copyright2015-2019 daiwk All Rights Reserved.
 */
package com.wp.base.ac.ac_menu.service;

import java.util.List;
import java.util.Map;

import com.wp.common.service.IBaseService;
import com.wp.common.zTree.ZTreeNode;

/**
 * @ClassName: IAcMenuService
 * @Description: TODO
 * @author:daiwk 
 * @date: 2015年9月2日下午7:05:55
 */
@SuppressWarnings("rawtypes")
public interface IAcMenuService extends IBaseService {
	List<ZTreeNode> queryChildrenTreeNodes(String pId);
	
	/**
	 * 
	 * @Title: queryPermitted
	 * @author：daiwk 
	 * @date：2015年10月4日上午11:58:32
	 * @Description: 根据OPERATOR_ID、PARENT_ID获取所有有访问权限的数据
	 * @param paramMap
	 * @return
	 */
	public List<Map> queryPermitted(Map paramMap);
}
