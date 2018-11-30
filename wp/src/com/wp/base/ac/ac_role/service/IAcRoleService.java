/**
 * Copyright2015-2019 daiwk All Rights Reserved.
 */
package com.wp.base.ac.ac_role.service;

import com.wp.common.service.IBaseService;

/**
 * @ClassName: IAcRoleService
 * @Description: TODO
 * @author:daiwk 
 * @date: 2015年9月5日下午3:39:36
 */
public interface IAcRoleService extends IBaseService {
	public int batchDelete(String ids);
}
