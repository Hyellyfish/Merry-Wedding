package com.kh.mw.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.mw.dao.UrlDao;
import com.kh.mw.vo.UserVo;

@Service
public class UrlService {
	
	@Autowired
	private UrlDao urlDao;
	
	// 입력한 url으로 UserVo 얻어오기
	public UserVo getUserVo_byUrl(String url) {
		UserVo userVo = urlDao.getUserVo_byUrl(url);
		return userVo;
	}
	
}
