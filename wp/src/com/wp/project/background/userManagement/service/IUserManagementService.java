package com.wp.project.background.userManagement.service;

import java.util.List;
import java.util.Map;

import com.wp.common.service.IBaseService;

public interface IUserManagementService extends IBaseService{
	public int insertUserInfo (Map paramMap);
	public int updateUserInfo (Map paramMap);
	/*软删除，只更改状态。*/
	public int softDeleteUserInfo (Map paramMap);
}
