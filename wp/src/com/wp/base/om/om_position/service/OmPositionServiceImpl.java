/**
 * Copyright2015-2019 daiwk All Rights Reserved.
 */
package com.wp.base.om.om_position.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wp.common.dao.IBaseDao;
import com.wp.common.page.PageView;
import com.wp.common.zTree.ZTreeNode;

/**
 * @ClassName: OmPositionServiceImpl
 * @Description: TODO
 * @author:daiwk 
 * @date: 2015年9月5日下午4:48:41
 */
@Service
public class OmPositionServiceImpl implements IOmPositionService {

	private static final String MAPPER_SPACE_NAME = "omPositionSpace";
	
	@Autowired
	private IBaseDao dao;
	/*@Autowired
	private IAcApplicationService acApplicationService;
	public void testTransaction() {
		this.delete("2");
		acApplicationService.delete("2");
		int i = 1/0;
		return;
	}*/
	
	@Override
	public Map get(String id) {
		// TODO Auto-generated method stub
		//return (Map) dao.get("omPositionSpace.get", operator_id);
		return (Map) dao.get("omPositionSpace.get", id);  
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
    	return dao.insert_("omPositionSpace.insert", record);
    }

    /**
     * 修改		一条记录
     * @param beanMap
     * @return
     */
    @Override
    public int update(Map record){
    	return dao.update_("omPositionSpace.update", record);
    }
    
    /**
	 * 删除		一条记录
	 * @param  	 
	 */	
    @Override
    public int delete(String id){
    	return dao.delete("omPositionSpace.delete", id);
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
		List list = (List) dao.query("omPositionSpace.query", paramMap);
		return list;
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
