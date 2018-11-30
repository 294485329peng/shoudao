/**
 * Copyright2015-2019 daiwk All Rights Reserved.
 */
package com.wp.base.ac.ac_oper_func.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wp.common.dao.IBaseDao;
import com.wp.common.page.PageView;
import com.wp.common.zTree.ZTreeNode;

/**
 * @ClassName: AcOperFuncServiceImpl
 * @Description: TODO
 * @author:daiwk 
 * @date: 2015年9月5日下午4:48:41
 */
@Service
public class AcOperFuncServiceImpl implements IAcOperFuncService {

	@Autowired
	private IBaseDao dao;
	
	@Override
	public Map get(String id) {
		// TODO Auto-generated method stub
		//return (Map) dao.get("acOperFuncSpace.get", operator_id);
		return (Map) dao.get("acOperFuncSpace.get", id);  
	}
	/**
     * 查询	一页记录
     * @param rowSelection
     * @param map
     * @return
     */
	@Override
    public PageView queryPage(PageView pageView,Map paramMap){
    	return null;//分页待完善
    }


	/**
	 * 插入		一条记录
	 * @param beanMap
	 * @return
	 */    
    @Override
    public int insert(Map record){
    	return dao.insert_("acOperFuncSpace.insert", record);
    }

    /**
     * 修改		一条记录
     * @param beanMap
     * @return
     */
    @Override
    public int update(Map record){
    	return dao.update_("acOperFuncSpace.update", record);
    }
    
    /**
	 * 删除		一条记录
	 * @param  	 
	 */	
    @Override
    public int delete(String id){
    	return dao.delete("acOperFuncSpace.delete", id);
    }
	/**
	 * @Title: query
	 * @author：daiwk 
	 * @date：2015年9月5日下午3:51:13
	 * @Description: TODO
	 * @param paramMap
	 * @return
	 */
	@Override
	public List<Map> query(Map paramMap) {
		List list = (List) dao.query("acOperFuncSpace.query", paramMap);
		return list;
	}
	/**
	 * @Title: batchInsert
	 * @author：daiwk 
	 * @date：2015年9月27日下午2:06:18
	 * @Description: 批量插入
	 * @param list
	 * @return
	 */
	@Override
	public int batchInsert(List<Map> list,Map deleteParamMap) {
		this.dao.delete("acOperFuncSpace.delete", deleteParamMap);
		return dao.batchInsert("acOperFuncSpace.insert", list);
	}
	@Override
	public Map insert_map(Map record) {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public Map update_Map(Map record) {
		// TODO Auto-generated method stub
		return null;
	}
}
