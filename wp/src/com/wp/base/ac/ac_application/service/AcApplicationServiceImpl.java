/**
 * Copyright2015-2019 daiwk All Rights Reserved.
 */
package com.wp.base.ac.ac_application.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wp.common.dao.IBaseDao;
import com.wp.common.page.PageView;
import com.wp.common.zTree.ZTreeNode;

/**
 * @ClassName: AcApplicationServiceImpl
 * @Description: TODO
 * @author:daiwk 
 * @date: 2015年9月5日下午4:48:41
 */
@Service
public class AcApplicationServiceImpl implements IAcApplicationService {

	@Autowired
	private IBaseDao dao;
	
	@Override
	public Map get(String id) {
		// TODO Auto-generated method stub
		//return (Map) dao.get("acApplicationSpace.get", operator_id);
		return (Map) dao.get("acApplicationSpace.get", id);  
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
    	return dao.insert_("acApplicationSpace.insert", record);
    }

    /**
     * 修改		一条记录
     * @param beanMap
     * @return
     */
    @Override
    public int update(Map record){
    	return dao.update_("acApplicationSpace.update", record);
    }
    
    /**
	 * 删除		一条记录
	 * @param  	 
	 */	
    @Override
    public int delete(String id){
    	return dao.delete("acApplicationSpace.delete", id);
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
		List list = (List) dao.query("acApplicationSpace.query", paramMap);
		return list;
	}
/*	*//**
	 * @Title: query for update
	 * @author：daiwk
	 * @date：2015年9月30日下午4:51:13
	 * @Description: TODO
	 * @param paramMap
	 * @return
	 *//*
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public List<Map> queryUpdate(Map paramMap) {
		List list = (List) dao.query("acApplicationSpace.queryUpdate", paramMap);
		return list;
	}*/
	/**
	 * @Title: queryChildrenTreeNodes
	 * @author：daiwk 
	 * @date：2015年9月7日下午4:56:36
	 * @Description: 构建 机构 岗位 人员树
	 * @param pid
	 * @return
	 */
	@Override
	public List<ZTreeNode> queryChildrenTreeNodes(String pId) {
		// TODO Auto-generated method stub
		List<ZTreeNode> list = (List) dao.query("acApplicationSpace.queryChildrenTreeNodes", pId);
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
