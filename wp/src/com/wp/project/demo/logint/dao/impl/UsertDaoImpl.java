package com.wp.project.demo.logint.dao.impl;

import org.springframework.stereotype.Repository;

import com.wp.project.demo.logint.dao.AbstractBaseDao;
import com.wp.project.demo.logint.dao.UsertDao;
import com.wp.project.demo.logint.entity.Usert;

@Repository("usertDao")
public class UsertDaoImpl extends AbstractBaseDao implements UsertDao{
	/*@Autowired
    public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
        super.setSqlSessionTemplate(sqlSessionTemplate);
    }
	*/
	public Usert query(Usert usert) {
		// TODO Auto-generated method stub
		return getSqlSession().selectOne("userspace.query",usert);
	}

}
