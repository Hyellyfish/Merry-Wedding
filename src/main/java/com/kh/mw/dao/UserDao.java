package com.kh.mw.dao;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.mw.vo.UserVo;

@Repository
public class UserDao {
	private final String NAMESPACE = "mappers.user.";
	
	@Autowired
	private SqlSession sqlSession;
	
	// 회원가입
	public boolean registerRun(UserVo userVo) {
		System.out.println(userVo);
		int count = sqlSession.insert(NAMESPACE + "insertUser", userVo);
		System.out.println(count);
		if(count>0) {
			return true;
		}
		return false;
	}

	public UserVo login_run(String userid, String userpw) {
		Map<String, String> map = new HashMap<>();
		map.put("userid", userid);
		map.put("userpw", userpw);
		UserVo vo = sqlSession.selectOne(NAMESPACE + "login", map);
		return vo;
	}
	
	public boolean isExistId(String inputId) {
		int count = sqlSession.selectOne(NAMESPACE + "isExistId" , inputId);
		if(count > 0) {
			return true;
		}
		return false;
	}
	
	public boolean isExistUrl(String inputUrl) {
		int count = sqlSession.selectOne(NAMESPACE+"isExistUrl", inputUrl);
		if(count > 0) {
			return true;
		}
		return false;
	}
	
	public UserVo detail(String userid, String userpw) {
		Map<String, String> map = new HashMap<>();
		map.put("userid", userid);
		map.put("userpw", userpw);
		UserVo userVo = sqlSession.selectOne(NAMESPACE + "detail", map);
		return userVo;
	}
	
	// 회원정보 수정
	public boolean edit_run(UserVo userVo) {
		int count = sqlSession.update(NAMESPACE + "edit_run", userVo);
		if (count > 0) {
			return true;
		}
		return false;
	}
	
	// 회원정보 삭제
	public boolean delete_user(String userid) {
		int count = sqlSession.delete(NAMESPACE+"delete_user", userid);
		if (count > 0) {
			return true;
		}
		return false;
	}
}
