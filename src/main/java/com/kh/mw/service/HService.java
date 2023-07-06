package com.kh.mw.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.mw.dao.HDao;
import com.kh.mw.vo.H_HomeScheduleVo;
import com.kh.mw.vo.H_HomeVo;
import com.kh.mw.vo.H_OurstoryVo;
import com.kh.mw.vo.H_PhotosDataVo;
import com.kh.mw.vo.H_PhotosVo;
import com.kh.mw.vo.H_QnaDataVo;
import com.kh.mw.vo.H_QnaVo;
import com.kh.mw.vo.H_TempPhotosVo;
import com.kh.mw.vo.H_TravelVo;
import com.kh.mw.vo.UserVo;

@Service
public class HService {
	
	@Autowired
	private HDao hDao;
	
	// 아이디로 정보 얻어오기 - H_TempPhotosVo
	public H_TempPhotosVo getTpVo(String userid) {
		H_TempPhotosVo tpVo = hDao.getTpVo(userid);
		return tpVo;
	}
	
	// 아이디로 정보 얻어오기 - H_HomeVo
	public H_HomeVo getHvo(String userid) {
		H_HomeVo hVo = hDao.getHvo(userid);
		return hVo;
	}
	
	// h_no로 정보 얻어오기 - H_HomeScheduleVo
	public List<H_HomeScheduleVo> getList_hsVo(int h_no) {
		List<H_HomeScheduleVo> list_hsVo = hDao.getList_hsVo(h_no);
		return list_hsVo;
	}
	
	// 아이디로 정보 얻어오기 - H_OurstoryVo
	public H_OurstoryVo getOvo(String userid) {
		H_OurstoryVo oVo = hDao.getOvo(userid);
		return oVo;
	}
	
	// 아이디로 정보 얻어오기 - H_PhotosVo
	public H_PhotosVo getPvo(String userid) {
		H_PhotosVo pVo = hDao.getPvo(userid);
		return pVo;
	}
	
	// p_no로 정보 얻어오기 - H_PhotosDataVo
	public List<H_PhotosDataVo> getList_pdVo(int p_no) {
		List<H_PhotosDataVo> list_pdVo = hDao.getList_pdVo(p_no);
		return list_pdVo;
	}
	
	// 아이디로 정보 얻어오기 - H_QnaVo
	public H_QnaVo getQvo(String userid) {
		H_QnaVo qVo = hDao.getQvo(userid);
		return qVo;
	}
	
	// q_no로 정보 얻어오기 - H_QnaDataVo
	public List<H_QnaDataVo> getList_qdVo(int q_no) {
		List<H_QnaDataVo> list_qdVo = hDao.getList_qdVo(q_no);
		return list_qdVo;
	}
	
	// 아이디로 정보 얻어오기 - H_TravelVo
	public H_TravelVo getTvo(String userid) {
		H_TravelVo tVo = hDao.getTvo(userid);
		return tVo;
	}
	
	// 프로젝트 정보 입력
	@Transactional
	public boolean insertRun(H_TempPhotosVo tpVo, H_HomeVo hVo, 
			List<H_HomeScheduleVo> list_hsVo, H_OurstoryVo oVo, 
			H_PhotosVo pVo, List<H_PhotosDataVo> list_pdVo, 
			H_QnaVo qVo, List<H_QnaDataVo> list_qdVo, H_TravelVo tVo) {
		
		int nextVal_h = hDao.getNextVal_h();
		hVo.setH_no(nextVal_h);
		for (H_HomeScheduleVo hsVo : list_hsVo) {
			hsVo.setH_no(nextVal_h);
		}
		
		int nextVal_p = hDao.getNextVal_p();
		pVo.setP_no(nextVal_p);
		for (H_PhotosDataVo pdVo : list_pdVo) {
			pdVo.setP_no(nextVal_p);
		}
		
		int nextVal_q = hDao.getNextVal_q();
		qVo.setQ_no(nextVal_q);
		for (H_QnaDataVo qdVo : list_qdVo) {
			qdVo.setQ_no(nextVal_q);
		}
		
		boolean result = hDao.insertRun(tpVo, hVo, list_hsVo, oVo, 
				pVo, list_pdVo, qVo, list_qdVo, tVo);
		return result;
	}
	
	// 프로젝트 업데이트(입력+수정+삭제)
	@Transactional
	public boolean updateProject(H_TempPhotosVo tpVo, 
			H_HomeVo hVo, List<H_HomeScheduleVo> list_hsVo, H_OurstoryVo oVo, 
			List<H_PhotosDataVo> list_pdVo, List<H_QnaDataVo> list_qdVo, 
			H_TravelVo tVo) {
		System.out.println("create서비스-업데이트");
		boolean result = hDao.updateProject(tpVo, hVo, list_hsVo, oVo, 
				list_pdVo, list_qdVo, tVo);
		return result;
	}
	
	// 프로젝트 삭제
	@Transactional
	public boolean removeProject(String userid) {
		int h_no = hDao.getH_no(userid);
		int p_no = hDao.getP_no(userid);
		int q_no = hDao.getQ_no(userid);
		boolean result = hDao.removeProject(userid, h_no, p_no, q_no);
		return result;
	}
	
	// Pjnum 갱신
	public boolean updatePjnum(UserVo userVo) {
		boolean result = hDao.updatePjnum(userVo);
		return result;
	}
	
	// TempType 갱신
	public boolean updateTemptype(UserVo userVo) {
		boolean result = hDao.updateTemptype(userVo);
		return result;
	}
	
}
