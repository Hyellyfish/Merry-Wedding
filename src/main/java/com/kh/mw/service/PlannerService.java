package com.kh.mw.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.mw.dao.PlannerDao;
import com.kh.mw.vo.CheckVo;
import com.kh.mw.vo.P_PagingDto;
import com.kh.mw.vo.VendorVo;

@Service
public class PlannerService {
	
	@Autowired
	private PlannerDao pDao;
	
	// 총 Vendor 수 구하기
	public int getVendorsCount(P_PagingDto pagingDto) {
		return pDao.getVendorsCount(pagingDto);
	}
	
	// Vendor list 얻어오기
	public List<VendorVo> getList_vVo(P_PagingDto pagingDto) {
		List<VendorVo> list_vVo = pDao.getList_vVo(pagingDto);
		return list_vVo;
	}
	
	// v_no로 정보 얻어오기 - VendorVo
	public VendorVo getVvo_byVno(int v_no) {
		VendorVo vendorVo = pDao.getVvo_byVno(v_no);
		return vendorVo;
	}
	
	// Vendor 입력
	@Transactional
	public boolean vendor_register(VendorVo vendorVo) {
		int nextVal_v = pDao.getNextVal_v();
		vendorVo.setV_no(nextVal_v);
		boolean result = pDao.vendor_register(vendorVo);
		return result;
	}
	
	// Vendor 수정
	public boolean vendor_edit(VendorVo vendorVo) {
		boolean result = pDao.vendor_edit(vendorVo);
		return result;
	}
	
	// Vendor 삭제
	public boolean vendor_delete(int v_no) {
		boolean result = pDao.vendor_delete(v_no);
		return result;
	}
	
	// 아이디로 정보 얻어오기 - CheckVo
	public CheckVo getCheckVo_byId(String userid) {
		CheckVo checkVo = pDao.getCheckVo_byId(userid);
		return checkVo;
	}
	
	// 총 체크리스트 수 구하기
	public int getCheckCount(String userid) {
		return pDao.getCheckCount(userid);
	}
	
	// 체크리스트 입력
	public boolean insertCheck(CheckVo checkVo) {
		boolean result = pDao.insertCheck(checkVo);
		return result;
	}
	
	// 체크리스트 수정
	public boolean updateCheck(CheckVo checkVo) {
		boolean result = pDao.updateCheck(checkVo);
		return result;
	}
	
}
