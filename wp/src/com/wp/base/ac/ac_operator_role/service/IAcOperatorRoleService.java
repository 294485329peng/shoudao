/**
 * Copyright2015-2019 daiwk All Rights Reserved.
 */
package com.wp.base.ac.ac_operator_role.service;

import java.util.List;
import java.util.Map;

import com.wp.common.service.IBaseService;

/**
 * @ClassName: IAcOperatorRoleService
 * @Description: TODO
 * @author:daiwk 
 * @date: 2015年9月5日下午3:39:36
 */
public interface IAcOperatorRoleService extends IBaseService {

	public int batchInsert(List<Map> list,Map deleteParam);
	public int delete(Map paramMap);
	/**
	 * 
	 * @Description: 插入普通公众号组
	 * @param @param record
	 * @param @return   
	 * @return int  
	 * @throws
	 * @author daiwk
	 * @date 2016年2月19日
	 */
	public int insertNormalGzhOrg(Map record);
}
