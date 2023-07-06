package com.kh.mw.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.kh.mw.vo.H_MessagesVo;
import com.kh.mw.vo.H_PagingDto;

@Repository
public class HmessageDao {
	private final String NAMESPACE = "mappers.hmsg.";
	
	// @Inject
	@Autowired
	private SqlSession sqlSession;
	
	// 메세지 좋아요
	public boolean like(int mno) {
		int count = sqlSession.update(NAMESPACE+"like", mno);
		if (count > 0) {
			return true;
		} else { return false; }
	}
	
	// 메세지 좋아요 취소
	public boolean likeCancel(int mno) {
		int count = sqlSession.update(NAMESPACE+"likeCancel", mno);
		if (count > 0) {
			return true;
		} else { return false; }
	}
	
	// 총 메세지 수 구하기
	public int getCount(String userid, H_PagingDto pagingDto) {
		Map<String, Object> map = new HashMap<>();
		map.put("userid", userid);
		map.put("pagingDto", pagingDto);
		int count = sqlSession.selectOne(NAMESPACE+"getCount", map);
		return count;
	}
	
	// 아이디로 정보 얻어오기 - H_MessagesVo
	public List<H_MessagesVo> getList_mVo_byId(String userid) {
		List<H_MessagesVo> list_mVo = sqlSession.selectList(NAMESPACE+"getList_mVo_byId", userid);
		return list_mVo;
	}
	
	// 아이디, pagingDto로 정보 얻어오기 - H_MessagesVo
	public List<H_MessagesVo> getList_mVo(String userid, H_PagingDto pagingDto) {
		Map<String, Object> map = new HashMap<>();
		map.put("userid", userid);
		map.put("pagingDto", pagingDto);
		List<H_MessagesVo> list_mVo = 
				sqlSession.selectList(NAMESPACE+"getList_mVo", map);
		return list_mVo;
	}
	
	// 메세지 입력 처리
	public boolean insertMsg(H_MessagesVo mVo) {
		int count_mVo = sqlSession.insert(NAMESPACE+"insert_mVo", mVo);
		if (count_mVo > 0) {
			return true;
		} else { return false; }
	}
	
	// 메세지 수정
	public boolean editMsg(H_MessagesVo mVo) {
		int count = sqlSession.update(NAMESPACE+"editMsg", mVo);
		if (count > 0) {
			return true;
		}
		return false;
	}
	
	// 메세지 삭제
	public boolean deleteMsg(int mno) {
		int count = sqlSession.delete(NAMESPACE+"deleteMsg", mno);
		if (count > 0) {
			return true;
		}
		return false;
	}
	
	@Transactional
	// 메세지 삭제(여러 개)
	public boolean deleteMsgs(List<Integer> mnos) {
		int[] arr_count_mnos = new int[mnos.size()];
		for (int i = 0; i < mnos.size(); i++) {
			int count = sqlSession.delete(
					NAMESPACE+"deleteMsg", mnos.get(i));
			arr_count_mnos[i] = count;
		}
		
		// count 성공여부 검사
		int count_mno = 0;
		for (int i = 0; i < arr_count_mnos.length; i++) {
			if (arr_count_mnos[i] == 0) {
				count_mno = 0;
				break;
			} else {count_mno = 1;}
		}
		
		// 모든 insert 성공시 true 리턴
		if (count_mno > 0) {
			return true;
		} else { return false; }
	}
	
	public int getNextVal_m() {
		int nextVal_m = sqlSession.selectOne(NAMESPACE+"getNextVal_m");
		return nextVal_m;
	}
}
