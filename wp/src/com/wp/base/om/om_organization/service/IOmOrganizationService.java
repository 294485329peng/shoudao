/**
 * Copyright2015-2019 daiwk All Rights Reserved.
 */
package com.wp.base.om.om_organization.service;

import java.util.List;
import java.util.Map;

import com.wp.common.service.IBaseService;
import com.wp.common.zTree.ZTreeNode;

/**
 * @ClassName: IOmOrganizationService
 * @Description: TODO
 * @author:daiwk 
 * @date: 2015年9月5日下午3:39:36
 */
public interface IOmOrganizationService extends IBaseService {

	List<ZTreeNode> queryChildrenTreeNodes(Map<String,Object> paramMap);
}
