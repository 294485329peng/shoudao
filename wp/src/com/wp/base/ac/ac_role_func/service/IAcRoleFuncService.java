/**
 * Copyright2015-2019 daiwk All Rights Reserved.
 */
package com.wp.base.ac.ac_role_func.service;

import java.util.List;
import java.util.Map;

import com.wp.common.service.IBaseService;

/**
 * @ClassName: IAcRoleFuncService
 * @Description: TODO
 * @author:daiwk 
 * @date: 2015年9月5日下午3:39:36
 */
public interface IAcRoleFuncService extends IBaseService {

	public int batchInsert(List<Map> list,Map deleteParam);
}
