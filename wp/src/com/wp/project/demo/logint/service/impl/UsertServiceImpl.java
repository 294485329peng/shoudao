package com.wp.project.demo.logint.service.impl;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.wp.project.demo.logint.dao.UsertDao;
import com.wp.project.demo.logint.entity.Usert;
import com.wp.project.demo.logint.service.UsertService;

@Transactional
@Service("usertService")
public class UsertServiceImpl implements UsertService{
	@Autowired 
	private UsertDao usertDao;

	@Override
	public Usert query(Usert usert) {
		// TODO Auto-generated method stub
		return usertDao.query(usert);
	}


}
