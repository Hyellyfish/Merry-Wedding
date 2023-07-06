package com.kh.mw.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.mw.dao.QnaDao;
import com.kh.mw.vo.PagingDto;
import com.kh.mw.vo.QnaVo;

@Service
public class QnaService {
	
	@Autowired
	private QnaDao qnaDao;
	
	public List<QnaVo> qnaList(PagingDto pagingDto){
		return qnaDao.qnaList(pagingDto);
	}
	
	public int getCount(PagingDto pagingDto) {
		return qnaDao.getCount(pagingDto);
	}
	
	@Transactional
	public boolean qnaRegister(QnaVo qnaVo) {
		int c_no = qnaDao.getNextVal();
		qnaVo.setC_no(c_no);
		return qnaDao.qnaRegister(qnaVo);
	}
	
	public QnaVo selectByCno(int c_no) {
		QnaVo qnaVo = qnaDao.selectByCno(c_no);
		return qnaVo;
	}
	
	public boolean qnaModify(QnaVo qnaVo) {
		return qnaDao.qnaModify(qnaVo);
	}

	public boolean qnaDelete(int c_no) {
		return qnaDao.qnaDelete(c_no);
	}
	
	public boolean insertReply(QnaVo qnaVo) {
		return qnaDao.insertReply(qnaVo);
	}
	
	public int updateViewcnt(int c_no) {
		return qnaDao.updateViewcnt(c_no);
	}
	
	public QnaVo getPassword(String c_password, int c_no) {
		return qnaDao.getPassword(c_password, c_no);
	}
	
}
