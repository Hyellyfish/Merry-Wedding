package com.kh.mw.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.mw.vo.GuestVo;

@Repository
public class GuestDao {
	private final String NAMESPACE = "mappers.guest.";
	
	@Autowired
	private SqlSession sqlSession;

	public int getNextVal() {
		return sqlSession.selectOne(NAMESPACE + "getNextVal");
	}
	
	// 하객 명단 조회
	public List<GuestVo> guestList(String userid){
		return sqlSession.selectList(NAMESPACE + "guestList", userid);
	}
	
	// 하객 등록
	public boolean guestRegister(GuestVo guestVo) {
		int count = sqlSession.insert(NAMESPACE + "guestRegister", guestVo);
		if(count > 0) {
			return true;
		}
		return false;
		
	}
	
	// 하객 삭제
	public boolean guestDelete(int[] arr_g_no) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("arr_g_no", arr_g_no);
		int count = sqlSession.delete(NAMESPACE + "guestDelete", map);
		if(count > 0) {
			return true;
		}
		return false;
	}
	
	// 하객 정보 수정
	public boolean guestModify(GuestVo guestVo) {
		int count = sqlSession.update(NAMESPACE + "guestModify", guestVo);
		if(count > 0) {
			return true;
		}
		return false;
	}
	
	public int getCount(String userid) {
		return sqlSession.selectOne(NAMESPACE + "getCount", userid);
	}
}
