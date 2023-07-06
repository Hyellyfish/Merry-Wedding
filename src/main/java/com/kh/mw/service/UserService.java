package com.kh.mw.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.mw.dao.UserDao;
import com.kh.mw.vo.UserVo;

@Service
public class UserService {
	
	@Autowired
	UserDao userDao;
	
	public boolean registerRun(UserVo userVo) {
		boolean result = userDao.registerRun(userVo);
		return result;
	}

	public UserVo login_run(String userid, String userpw) {
		UserVo vo = userDao.login_run(userid, userpw);
		return vo;
	}
	
	public boolean isExistId(String inputId) {
		boolean result = userDao.isExistId(inputId);
		return result;
	}
	
	public boolean isExistUrl(String inputUrl) {
		boolean result = userDao.isExistUrl(inputUrl);
		return result;
	}
	
	public UserVo detail(String userid, String userpw) {
		UserVo userVo = userDao.detail(userid, userpw);
		return userVo;
	}
	
	public boolean edit_run(UserVo userVo) {
		boolean result = userDao.edit_run(userVo);
		return result;
	}
	
	public boolean delete_user(String userid) {
		boolean result = userDao.delete_user(userid);
		return result;
	}
	
}
