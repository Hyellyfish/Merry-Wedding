package com.kh.mw.dao;

import java.util.List;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.mw.vo.CheckVo;
import com.kh.mw.vo.P_PagingDto;
import com.kh.mw.vo.VendorVo;

@Repository
public class PlannerDao {
	private final String NAMESPACE = "mappers.planner.";
	
	// @Inject
	@Autowired
	private SqlSession sqlSession;
	
	// 총 Vendor 수 구하기
	public int getVendorsCount(P_PagingDto pagingDto) {
		int count = sqlSession.selectOne(NAMESPACE+"getVendorsCount", pagingDto);
		return count;
	}
	
	public int getNextVal_v() {
		int nextVal_v = sqlSession.selectOne(NAMESPACE+"getNextVal_v");
		return nextVal_v;
	}
	
	// Vendor list 얻어오기
	public List<VendorVo> getList_vVo(P_PagingDto pagingDto) {
		List<VendorVo> list_vVo = 
				sqlSession.selectList(NAMESPACE+"getList_vVo", pagingDto);
		return list_vVo;
	}
	
	// v_no로 정보 얻어오기 - VendorVo
	public VendorVo getVvo_byVno(int v_no) {
		VendorVo vendorVo = sqlSession.selectOne(NAMESPACE+"getVvo_byVno", v_no);
		return vendorVo;
	}
	
	// Vendor 입력 처리
	public boolean vendor_register(VendorVo vendorVo) {
		int count = sqlSession.insert(NAMESPACE+"vendor_register", vendorVo);
		if (count > 0) {
			return true;
		} else { return false; }
	}
	
	// Vendor 수정
	public boolean vendor_edit(VendorVo vendorVo) {
		int count = sqlSession.update(NAMESPACE+"vendor_edit", vendorVo);
		if (count > 0) {
			return true;
		}
		return false;
	}
	
	// Vendor 삭제
	public boolean vendor_delete(int v_no) {
		int count = sqlSession.delete(NAMESPACE+"vendor_delete", v_no);
		if (count > 0) {
			return true;
		}
		return false;
	}
	
	// 아이디로 정보 얻어오기 - CheckVo
	public CheckVo getCheckVo_byId(String userid) {
		CheckVo checkVo = sqlSession.selectOne(NAMESPACE+"getCheckVo_byId", userid);
		return checkVo;
	}
	
	// 총 체크리스트 수 구하기
	public int getCheckCount(String userid) {
		int count = sqlSession.selectOne(NAMESPACE+"getCheckCount", userid);
		return count;
	}
	
	// 체크리스트 입력
	public boolean insertCheck(CheckVo checkVo) {
		int count = sqlSession.insert(NAMESPACE+"insertCheck", checkVo);
		if (count > 0) {
			return true;
		} else { return false; }
	}
	
	// 체크리스트 수정
	public boolean updateCheck(CheckVo checkVo) {
		int count = sqlSession.update(NAMESPACE+"updateCheck", checkVo);
		if (count > 0) {
			return true;
		}
		return false;
	}	
	
}
