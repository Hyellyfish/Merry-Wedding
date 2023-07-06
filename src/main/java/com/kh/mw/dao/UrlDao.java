package com.kh.mw.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.mw.vo.UserVo;

@Repository
public class UrlDao {
	private final String NAMESPACE = "mappers.url.";
	
	@Autowired
	private SqlSession sqlSession;
	
	// 입력한 url으로 UserVo 얻어오기
	public UserVo getUserVo_byUrl(String url) {
		UserVo userVo = sqlSession.selectOne(NAMESPACE+"getUserVo_byUrl", url);
		return userVo;
	}
}
