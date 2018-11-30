/**
 * Copyright2015-2019 daiwk All Rights Reserved.
 */
package com.wp.base.om.om_organization.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wp.common.dao.IBaseDao;
import com.wp.common.page.PageView;
import com.wp.common.utils.StringUtils;
import com.wp.common.zTree.ZTreeNode;

/**
 * @ClassName: OmOrganizationServiceImpl
 * @Description: TODO
 * @author:daiwk 
 * @date: 2015年9月5日下午4:48:41
 */
@Service
public class OmOrganizationServiceImpl implements IOmOrganizationService {

	@Autowired
	private IBaseDao dao;
	
	@Override
	public Map get(String id) {
		// TODO Auto-generated method stub
		//return (Map) dao.get("omOrganizationSpace.get", operator_id);
		return (Map) dao.get("omOrganizationSpace.get", id);  
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
    	return dao.insert_("omOrganizationSpace.insert", record);
    }

    /**
     * 修改		一条记录
     * @param beanMap
     * @return
     */
    @Override
    public int update(Map record){
    	return dao.update_("omOrganizationSpace.update", record);
    }
    
    /**
	 * 删除		一条记录
	 * @param  	 
	 */	
    @Override
    public int delete(String id){
    	return dao.delete("omOrganizationSpace.delete", id);
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
		List list = (List) dao.query("omOrganizationSpace.query", paramMap);
		return list;
	}
	/**
	 * @Title: queryChildrenTreeNodes
	 * @author：daiwk 
	 * @date：2015年9月7日下午4:56:36
	 * @Description: 构建 机构 岗位 人员树
	 * @param paramMap
	 * @return
	 */
	public List<ZTreeNode> queryChildrenTreeNodes(Map<String,Object> paramMap){
		// TODO Auto-generated method stub
		List<ZTreeNode> list = null;
		if(StringUtils.isEmpty(paramMap.get("onlyOrg"))) {
			list = (List) dao.query("omOrganizationSpace.queryChildrenTreeNodes", paramMap);
		}else {
			list = (List) dao.query("omOrganizationSpace.queryOnlyOrgChildrenTreeNodes", paramMap);
		}
		
		String pId = paramMap.get("pId")==null?null:paramMap.get("pId").toString();
		//设置根节点打开
		if(pId==null||"-1".equals(pId)) {
			for(ZTreeNode node:list) {
				if("-1".equals(node.getpId())) {
					node.setOpen(true);
					break;
				}
			}
		}else {
			for(ZTreeNode n:list) {
				if(n.getId().equals(pId)) {
					n.setOpen(true);
					break;
				}
			}
		}

		String checkedOrgIdList = paramMap.get("checkedOrgIdList")==null?null:paramMap.get("checkedOrgIdList").toString();
		if(!StringUtils.isEmpty(checkedOrgIdList)) {
			String[] checkedArray = checkedOrgIdList.split(",");
			for(String corg:checkedArray) {
				for(ZTreeNode ztn:list) {
					if(ztn.getId().equals(corg)) {
						ztn.setChecked(true);
						break;
					}
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