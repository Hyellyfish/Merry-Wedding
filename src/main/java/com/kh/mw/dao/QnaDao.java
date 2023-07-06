package com.kh.mw.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.mw.vo.PagingDto;
import com.kh.mw.vo.QnaVo;

@Repository
public class QnaDao {
	private final String NAMESPACE = "mappers.qna.";
	
	@Autowired
	private SqlSession sqlSession;

	public List<QnaVo> qnaList(PagingDto pagingDto){
		return sqlSession.selectList(NAMESPACE + "qnaList", pagingDto);
	}
	
	public int getCount(PagingDto pagingDto) {
		int count = sqlSession.selectOne(NAMESPACE + "getCount", pagingDto);
		return count;
	}
	
	public boolean qnaRegister(QnaVo qnaVo) {
		int count = sqlSession.insert(NAMESPACE + "qnaRegister", qnaVo);
		if(count > 0) {
			return true;
		}
		return false;
	}
	
	public int getNextVal() {
		return sqlSession.selectOne(NAMESPACE + "getNextVal");
	}
	
	public QnaVo selectByCno(int c_no) {
		return sqlSession.selectOne(NAMESPACE + "selectByCno", c_no);
	}
	
	public boolean qnaModify(QnaVo qnaVo) {
		int count = sqlSession.update(NAMESPACE + "qnaModify", qnaVo);
		if(count > 0) {
			return true;
		}
		return false;
	}
	
	public boolean qnaDelete(int c_no) {
		int count = sqlSession.delete(NAMESPACE + "qnaDelete", c_no);
		if(count > 0) {
			return true;
		}
		return false;
	}
	
	public boolean insertReply(QnaVo qnaVo) {
		int count = sqlSession.insert(NAMESPACE + "insertReply", qnaVo);
		if(count > 0) {
			return true;
		}
		return false;
	}
	
	public int updateViewcnt(int c_no) {
		return sqlSession.update(NAMESPACE + "updateViewcnt", c_no);
	}
	
	public QnaVo getPassword(String c_password, int c_no) {
		Map<String, Object> map = new HashMap<>();
		map.put("c_password", c_password);
		map.put("c_no", c_no);
		return sqlSession.selectOne(NAMESPACE + "getPassword", map);
	}
}
