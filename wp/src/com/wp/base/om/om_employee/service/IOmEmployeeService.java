/**
 * Copyright2015-2019 daiwk All Rights Reserved.
 */
package com.wp.base.om.om_employee.service;

import java.util.List;
import java.util.Map;

import com.wp.common.service.IBaseService;
import com.wp.common.zTree.ZTreeNode;

/**
 * @ClassName: IOmEmployeeService
 * @Description: TODO
 * @author:daiwk 
 * @date: 2015年9月5日下午3:39:36
 */
public interface IOmEmployeeService extends IBaseService {
	List<ZTreeNode> queryTreeNodes(Map paramMap);
	/**
	 * 
	 * @Title: queryOrgEmpTreeNodes
	 * @author：daiwk
	 * @date：2015年11月19日上午8:37:28
	 * @Description: 仅查询机构人员树，无岗位
	 * @param paramMap
	 * @return
	 */
	List<ZTreeNode> queryOrgEmpTreeNodes(Map paramMap);
	/***
	 * 
	 * @Description: 新用户注册
	 * @param @param record
	 * @param @return   
	 * @return int  
	 * @throws
	 * @author daiwk
	 * @date 2016年2月19日
	 */
	public int register(Map record);

}
