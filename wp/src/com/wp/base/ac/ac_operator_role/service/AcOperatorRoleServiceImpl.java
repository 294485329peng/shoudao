/**
 * Copyright2015-2019 daiwk All Rights Reserved.
 */
package com.wp.base.ac.ac_operator_role.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import com.wp.common.dao.IBaseDao;
import com.wp.common.page.PageView;
import com.wp.common.zTree.ZTreeNode;

/**
 * @ClassName: AcOperatorRoleServiceImpl
 * @Description: TODO
 * @author:daiwk 
 * @date: 2015年9月5日下午4:48:41
 */
@Service
public class AcOperatorRoleServiceImpl implements IAcOperatorRoleService {

	@Autowired
	private IBaseDao dao;
	
	@Override
	public Map get(String id) {
		// TODO Auto-generated method stub
		//return (Map) dao.get("acOperatorRoleSpace.get", operator_id);
		/*return (Map) dao.get("acOperatorRoleSpace.get", id);*/
		return null;
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
    	return dao.insert_("acOperatorRoleSpace.insert", record);
    }

    /**
     * 修改		一条记录
     * @param beanMap
     * @return
     */
    @Override
    public int update(Map record){
    	/*return dao.update_("acOperatorRoleSpace.update", record);*/
    	return 0;
    }
    
    /**
	 * 删除		一条记录
	 * @param  	 
	 */	
    @Override
    public int delete(String id){
    	throw new RuntimeException("删除不合法");
    }
    @Override
    public int delete(Map paramMap){
    	return this.dao.delete("acOperatorRoleSpace.delete", paramMap);
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
		List list = (List) dao.query("acOperatorRoleSpace.query", paramMap);
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
	public int batchInsert(List<Map> list,Map deleteParam) {
		if(deleteParam!=null) {
			this.dao.delete("acOperatorRoleSpace.delete", deleteParam);
		}
		if(!CollectionUtils.isEmpty(list)) {
			//2015年10月16日09:25:26 修改
			//修改前
			//return dao.batchInsert("acOperatorRoleSpace.insert", list);
			//修改后
			return dao.insert_("acOperatorRoleSpace.batchInsert", list);
		}
		return 0;
		
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
	@Override
	public int insertNormalGzhOrg(Map record) {
		// TODO Auto-generated method stub
		return dao.insert_("acOperatorRoleSpace.insert", record);
	}
}
