package com.kh.mw.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.mw.dao.HmessageDao;
import com.kh.mw.vo.H_MessagesVo;
import com.kh.mw.vo.H_PagingDto;

@Service
public class HmessageService {
	
	@Autowired
	private HmessageDao mDao;
	
	// 메세지 좋아요
	public boolean like(int mno) {
		boolean result = mDao.like(mno);
		return result;
	}
	
	// 메세지 좋아요 취소
	public boolean likeCancel(int mno) {
		boolean result = mDao.likeCancel(mno);
		return result;
	}
	
	// 총 메세지 수 구하기
	public int getCount(String userid, H_PagingDto pagingDto) {
		return mDao.getCount(userid, pagingDto);
	}
	
	// 아이디로 정보 얻어오기 - H_MessagesVo
	public List<H_MessagesVo> getList_mVo_byId(String userid) {
		List<H_MessagesVo> list_mVo = mDao.getList_mVo_byId(userid);
		return list_mVo;
	}
	
	// 아이디, pagingDto로 정보 얻어오기 - H_MessagesVo
	public List<H_MessagesVo> getList_mVo(String userid, H_PagingDto pagingDto) {
		List<H_MessagesVo> list_mVo = mDao.getList_mVo(userid, pagingDto);
		return list_mVo;
	}
	
	// 메세지 입력
	@Transactional
	public boolean insertMsg(H_MessagesVo mVo) {
		int nextVal_m = mDao.getNextVal_m();
		mVo.setM_no(nextVal_m);
		boolean result = mDao.insertMsg(mVo);
		return result;
	}
	
	// 메세지 수정
	public boolean editMsg(H_MessagesVo mVo) {
		boolean result = mDao.editMsg(mVo);
		return result;
	}
	
	// 메세지 삭제
	public boolean deleteMsg(int mno) {
		boolean result = mDao.deleteMsg(mno);
		return result;
	}
	
	// 메세지 삭제(여러 개)
	public boolean deleteMsgs(List<Integer> mnos) {
		boolean result = mDao.deleteMsgs(mnos);
		return result;
	}
	
}
