package com.kh.mw.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.mw.dao.GuestDao;
import com.kh.mw.vo.GuestVo;

@Service
public class GuestService {
	
	@Autowired
	private GuestDao guestDao;
	
	// 하객 명단 조회
	public List<GuestVo> guestList(String userid){
		return guestDao.guestList(userid);
	}
	
	// 하객 등록
	@Transactional
	public boolean guestRegister(GuestVo guestVo) {
		int g_no = guestDao.getNextVal();
		guestVo.setG_no(g_no);
		System.out.println(guestVo);
		return guestDao.guestRegister(guestVo);
	}
	
	// 하객 삭제
	public boolean guestDelete(int[] arr_g_no) {
		return guestDao.guestDelete(arr_g_no);
	}
	
	// 하객 정보 수정
	public boolean guestModify(GuestVo guestVo) {
		return guestDao.guestModify(guestVo);
	}
	
	public int getCount(String userid) {
		return guestDao.getCount(userid);
	}
	
}
