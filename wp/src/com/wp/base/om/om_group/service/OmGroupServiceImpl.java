/**
 * Copyright2015-2019 daiwk All Rights Reserved.
 */
package com.wp.base.om.om_group.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wp.common.dao.IBaseDao;
import com.wp.common.page.PageView;
import com.wp.common.zTree.ZTreeNode;

/** 
 * @ClassName: OmGroupServiceImpl.java
 * @Description: 
 * @author daiwk 
 * @version 2015年9月24日 下午6:16:47 
 */
@Service
public class OmGroupServiceImpl implements IOmGroupService{

	@Autowired
	private IBaseDao dao;
	
	@SuppressWarnings("rawtypes")
	@Override
	public Map get(String id) {
		return (Map) dao.get("omGroupSpace.get", id);  
	}
	
	/**
     * 查询	一页记录
     * @param rowSelection
     * @param map
     * @return
     */
	@SuppressWarnings("rawtypes")
	@Override
    public PageView queryPage(PageView pageView,Map paramMap){
    	return null;//分页待完善
    }

	/**
	 * 插入       一条记录
	 * @param beanMap
	 * @return
	 */    
    @Override
    public int insert(Map record){
    	return dao.insert_("omGroupSpace.insert", record);
    }

    /**
     * 修改	  一条记录
     * @param beanMap
     * @return
     */
    @Override
    public int update(Map record){
    	return dao.update_("omGroupSpace.update", record);
    }
    
    /**
	 * 删除	一条记录
	 * @param  	 
	 */	
    @Override
    public int delete(String id){
    	return dao.delete("omGroupSpace.delete", id);
    }
	/**
	 * @Title: query
	 * @param paramMap
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public List<Map> query(Map paramMap) {
		List list = (List) dao.query("omGroupSpace.query", paramMap);
		return list;
	}
	
	/**
	 * @Title: query for update
	 * @author：daiwk
	 * @date：2015年9月30日下午4:51:13
	 * @Description: TODO
	 * @param paramMap
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public List<Map> queryUpdate(Map paramMap) {
		List list = (List) dao.query("omGroupSpace.queryUpdate", paramMap);
		return list;
	}
	
	/**
	 * @Title: queryChildrenTreeNodes
	 * @param pid
	 * @return
	 */
	@Override
	public List<ZTreeNode> queryChildrenTreeNodes(String pId) {
		@SuppressWarnings({ "unchecked", "rawtypes" })
		List<ZTreeNode> list = (List) dao.query("omGroupSpace.queryChildrenTreeNodes", pId);
		//设置根节点打开
		if(pId==null) {
			for(ZTreeNode node:list) {
				if("-1".equals(node.getpId())) {
					node.setOpen(true);
					break;
				}
			}
		}
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
