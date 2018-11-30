/**
 * Copyright2015-2019 daiwk All Rights Reserved.
 */
package com.wp.base.om.om_emp_group.service;

import java.util.List;
import java.util.Map;

import com.wp.common.service.IBaseService;

/**
 * @ClassName: IOmEmpGroupService
 * @Description: TODO
 * @author:daiwk 
 * @date: 2015年9月5日下午3:39:36
 */
public interface IOmEmpGroupService extends IBaseService {

	public int batchInsert(List<Map> list,Map deleteParam);
	public int delete(Map paramMap);
}
