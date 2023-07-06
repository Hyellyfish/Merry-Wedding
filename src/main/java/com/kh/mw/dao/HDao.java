package com.kh.mw.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

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


@Repository
public class HDao {
	private final String NAMESPACE = "mappers.tempH.";
	
	// @Inject
	@Autowired
	private SqlSession sqlSession;
	
	// 아이디로 정보 얻어오기 - H_TempPhotosVo
	public H_TempPhotosVo getTpVo(String userid) {
		H_TempPhotosVo tpVo = sqlSession.selectOne(NAMESPACE+"getTpVo", userid);
		return tpVo;
	}
	
	// 아이디로 정보 얻어오기 - H_HomeVo
	public H_HomeVo getHvo(String userid) {
		H_HomeVo hVo = sqlSession.selectOne(NAMESPACE+"getHvo", userid);
		return hVo;
	}
	
	// h_no로 정보 얻어오기 - H_HomeScheduleVo
	public List<H_HomeScheduleVo> getList_hsVo(int h_no) {
		List<H_HomeScheduleVo> list_hsVo = sqlSession.selectList(NAMESPACE+"getList_hsVo", h_no);
		return list_hsVo;
	}
	
	// 아이디로 정보 얻어오기 - H_OurstoryVo
	public H_OurstoryVo getOvo(String userid) {
		H_OurstoryVo oVo = sqlSession.selectOne(NAMESPACE+"getOvo", userid);
		return oVo;
	}
	
	// 아이디로 정보 얻어오기 - H_PhotosVo
	public H_PhotosVo getPvo(String userid) {
		H_PhotosVo pVo = sqlSession.selectOne(NAMESPACE+"getPvo", userid);
		return pVo;
	}
	
	// p_no로 정보 얻어오기 - H_PhotosDataVo
	public List<H_PhotosDataVo> getList_pdVo(int p_no) {
		List<H_PhotosDataVo> list_pdVo = sqlSession.selectList(NAMESPACE+"getList_pdVo", p_no);
		return list_pdVo;
	}
	
	// 아이디로 정보 얻어오기 - H_QnaVo
	public H_QnaVo getQvo(String userid) {
		H_QnaVo qVo = sqlSession.selectOne(NAMESPACE+"getQvo", userid);
		return qVo;
	}
	
	// q_no로 정보 얻어오기 - H_QnaDataVo
	public List<H_QnaDataVo> getList_qdVo(int q_no) {
		List<H_QnaDataVo> list_qdVo = sqlSession.selectList(NAMESPACE+"getList_qdVo", q_no);
		return list_qdVo;
	}
	
	// 아이디로 정보 얻어오기 - H_TravelVo
	public H_TravelVo getTvo(String userid) {
		H_TravelVo tVo = sqlSession.selectOne(NAMESPACE+"getTvo", userid);
		return tVo;
	}
	
	// 프로젝트 정보 입력 처리
	@Transactional
	public boolean insertRun(H_TempPhotosVo tpVo, H_HomeVo hVo, 
			List<H_HomeScheduleVo> list_hsVo, H_OurstoryVo oVo, 
			H_PhotosVo pVo, List<H_PhotosDataVo> list_pdVo, 
			H_QnaVo qVo, List<H_QnaDataVo> list_qdVo, H_TravelVo tVo) {
		
		// int count
		int count_tpVo = sqlSession.insert(NAMESPACE+"insert_tpVo", tpVo);
		
		int count_hVo = sqlSession.insert(NAMESPACE+"insert_hVo", hVo);
		int[] arr_count_hsVo = new int[list_hsVo.size()];
		for (int i = 0; i < list_hsVo.size(); i++) {
			int count_hsVo = sqlSession.insert(
					NAMESPACE+"insert_hsVo", list_hsVo.get(i));
			arr_count_hsVo[i] = count_hsVo;
		}
		
		int count_oVo = sqlSession.insert(NAMESPACE+"insert_oVo", oVo);
		
		int count_pVo = sqlSession.insert(NAMESPACE+"insert_pVo", pVo);
		int[] arr_count_pdVo = new int[list_pdVo.size()];
		for (int i = 0; i < list_pdVo.size(); i++) {
			int count_pdVo = sqlSession.insert(
					NAMESPACE+"insert_pdVo", list_pdVo.get(i));
			arr_count_pdVo[i] = count_pdVo;
		}
		
		int count_qVo = sqlSession.insert(NAMESPACE+"insert_qVo", qVo);
		int[] arr_count_qdVo = new int[list_qdVo.size()];
		for (int i = 0; i < list_qdVo.size(); i++) {
			int count_qdVo = sqlSession.insert(
					NAMESPACE+"insert_qdVo", list_qdVo.get(i));
			arr_count_qdVo[i] = count_qdVo;
		}
		
		int count_tVo = sqlSession.insert(NAMESPACE+"insert_tVo", tVo);
		
		int count_hsVo = 0;
		for (int i = 0; i < arr_count_hsVo.length; i++) {
			if (arr_count_hsVo[i] == 0) {
				count_hsVo = 0;
				break;
			} else {count_hsVo = 1;}
		}
		
		int count_pdVo = 0;
		for (int i = 0; i < arr_count_pdVo.length; i++) {
			if (arr_count_pdVo[i] == 0) {
				count_pdVo = 0;
				break;
			} else {count_pdVo = 1;}
		}
		
		int count_qdVo = 0;
		for (int i = 0; i < arr_count_qdVo.length; i++) {
			if (arr_count_qdVo[i] == 0) {
				count_qdVo = 0;
				break;
			} else {count_qdVo = 1;}
		}
		
		// 모든 vo insert 성공시 true 리턴
		if (count_tpVo>0 && count_hVo>0 && count_hsVo>0 && count_oVo>0 && 
				count_pVo>0 && count_pdVo>0 && count_qVo>0 && count_qdVo>0 && count_tVo>0) {
			return true;
		} else { return false; }
	}
	
	public int getNextVal_h() {
		int nextVal_h = sqlSession.selectOne(NAMESPACE+"getNextVal_h");
		return nextVal_h;
	}
	
	public int getNextVal_p() {
		int nextVal_p = sqlSession.selectOne(NAMESPACE+"getNextVal_p");
		return nextVal_p;
	}
	
	public int getNextVal_q() {
		int nextVal_q = sqlSession.selectOne(NAMESPACE+"getNextVal_q");
		return nextVal_q;
	}
	
	public int getH_no(String userid) {
		int h_no = sqlSession.selectOne(NAMESPACE+"getH_no", userid);
		return h_no;
		
	}
	
	public int getP_no(String userid) {
		int p_no = sqlSession.selectOne(NAMESPACE+"getP_no", userid);
		return p_no;
	}
	
	public int getQ_no(String userid) {
		int q_no = sqlSession.selectOne(NAMESPACE+"getQ_no", userid);
		return q_no;
	}

	// Pjnum 갱신
	public boolean updatePjnum(UserVo userVo) {
		int count = sqlSession.update(NAMESPACE+"updatePjnum", userVo);
		if (count>0) {
			return true;
		} else { return false; }
	}
	
	// TempType 갱신
	public boolean updateTemptype(UserVo userVo) {
		int count = sqlSession.update(NAMESPACE+"updateTempType", userVo);
		if (count>0) {
			return true;
		} else { return false; }
	}
	
	// 프로젝트 삭제
	@Transactional
	public boolean removeProject(String userid, int h_no, int p_no, int q_no) {
		// int count
		int count_tpVo = sqlSession.delete(NAMESPACE+"remove_tpVo", userid);
		int count_hsVo = sqlSession.delete(NAMESPACE+"remove_hsVo", h_no);
		int count_hVo = sqlSession.delete(NAMESPACE+"remove_hVo", userid);
		int count_oVo = sqlSession.delete(NAMESPACE+"remove_oVo", userid);
		int count_pdVo = sqlSession.delete(NAMESPACE+"remove_pdVo", p_no);
		int count_pVo = sqlSession.delete(NAMESPACE+"remove_pVo", userid);
		int count_qdVo = sqlSession.delete(NAMESPACE+"remove_qdVo", q_no);
		int count_qVo = sqlSession.delete(NAMESPACE+"remove_qVo", userid);
		int count_tVo = sqlSession.delete(NAMESPACE+"remove_tVo", userid);
		
		// 모든 vo 삭제 성공시 true 리턴
		if (count_tpVo>0 && count_hVo>0 && count_hsVo>0 && count_oVo>0 && 
				count_pVo>0 && count_pdVo>0 && count_qVo>0 && count_qdVo>0 && count_tVo>0) {
			return true;
		} else { return false; }
	}
	
	// 프로젝트 업데이트(수정)
		@Transactional
		public boolean updateProject(H_TempPhotosVo tpVo, 
				H_HomeVo hVo, List<H_HomeScheduleVo> list_hsVo, H_OurstoryVo oVo, 
				List<H_PhotosDataVo> list_pdVo, List<H_QnaDataVo> list_qdVo, 
				H_TravelVo tVo) {
			
			// hsVo, qdVo - 갯수 비교
			// (같으면 수정, 적으면 삭제, 많으면 추가입력)
			String userid = tpVo.getUserid();
			
			// ->hsVo 업데이트
			int h_no = sqlSession.selectOne(NAMESPACE+"getH_no", userid);
			List<H_HomeScheduleVo> prev_list_hsVo = 
					sqlSession.selectList(NAMESPACE+"getList_hsVo", h_no);
			int new_hsVo_cnt = list_hsVo.size(); // 신규 hsVo
			int prev_hsVo_cnt = prev_list_hsVo.size(); // 기존 hsVo
			int[] arr_count_hsVo = new int[1]; // 성공 여부 카운트
			List<Integer> update_arr_hs_no = new ArrayList<>(); // 수정할 hs_no들
			List<Integer> remove_arr_hs_no = new ArrayList<>(); // 삭제할 hs_no들
			
			if (new_hsVo_cnt == prev_hsVo_cnt) { // ->수정
				System.out.println("다오-수정만");
				arr_count_hsVo = new int[list_hsVo.size()];
				for (H_HomeScheduleVo hsVo : prev_list_hsVo) {
					update_arr_hs_no.add(hsVo.getHs_no()); // 수정할 hs_no
				}
				for (int i = 0; i < list_hsVo.size(); i++) {
					Map<String, Object> map = new HashMap<>();
					map.put("hsVo", list_hsVo.get(i));
					map.put("hs_no", update_arr_hs_no.get(i));
					System.out.println("map: "+map);
					int count_hsVo = sqlSession.update(
							NAMESPACE+"update_hsVo", map);
					arr_count_hsVo[i] = count_hsVo;
				}
			} else if (new_hsVo_cnt < prev_hsVo_cnt) { // ->삭제+수정
				System.out.println("다오-삭제+수정");
				arr_count_hsVo = new int[prev_list_hsVo.size()];
				for (int i=0; i<(prev_hsVo_cnt-new_hsVo_cnt); i++) {
					H_HomeScheduleVo hsVo = prev_list_hsVo.get((prev_hsVo_cnt-1)-i);
					remove_arr_hs_no.add(hsVo.getHs_no()); // 삭제할 hs_no
				}
				System.out.println("삭제할 hs_no: "+remove_arr_hs_no);
				for (int i = 0; i < remove_arr_hs_no.size(); i++) {
					int hs_no = remove_arr_hs_no.get(i);
					int count_hsVo = sqlSession.delete( // 삭제
							NAMESPACE+"remove_hsVo_by_hs_no", hs_no);
					arr_count_hsVo[i] = count_hsVo;
				}
				for (int i=0; i<new_hsVo_cnt; i++) {
					H_HomeScheduleVo hsVo = prev_list_hsVo.get(i);
					update_arr_hs_no.add(hsVo.getHs_no()); // 수정할 hs_no
				}
				System.out.println("수정할 hs_no: "+update_arr_hs_no);
				for (int i = 0; i < update_arr_hs_no.size(); i++) { // 수정
					Map<String, Object> map = new HashMap<>();
					map.put("hsVo", list_hsVo.get(i));
					map.put("hs_no", update_arr_hs_no.get(i));
					System.out.println("map: "+map);
					int count_hsVo = sqlSession.update(
							NAMESPACE+"update_hsVo", map);
					arr_count_hsVo[remove_arr_hs_no.size()+i] = count_hsVo;
				}
			} else if (new_hsVo_cnt > prev_hsVo_cnt) { // ->추가+수정
				System.out.println("다오-추가+수정");
				arr_count_hsVo = new int[list_hsVo.size()]; // 성공 여부 카운트
				for (int i=0; i<prev_hsVo_cnt; i++) { 
					H_HomeScheduleVo hsVo = prev_list_hsVo.get(i);
					update_arr_hs_no.add(hsVo.getHs_no()); // 수정할 hs_no
				}
				System.out.println("수정할 hs_no: "+update_arr_hs_no);
				for (int i = 0; i < update_arr_hs_no.size(); i++) { // 수정
					Map<String, Object> map = new HashMap<>();
					map.put("hsVo", list_hsVo.get(i));
					map.put("hs_no", update_arr_hs_no.get(i));
					System.out.println("map: "+map);
					int count_hsVo = sqlSession.update(
							NAMESPACE+"update_hsVo", map);
					arr_count_hsVo[i] = count_hsVo;
				}
				for (int i=0; i<(new_hsVo_cnt-prev_hsVo_cnt); i++) {
					H_HomeScheduleVo hsVo = list_hsVo.get(prev_hsVo_cnt+i);
					hsVo.setH_no(h_no);
					int count_hsVo = sqlSession.insert( // 추가
							NAMESPACE+"insert_hsVo", hsVo);
					arr_count_hsVo[prev_hsVo_cnt+i] = count_hsVo;
				}
			}
			
			// ->pdVo 업데이트(기존 db의 pdVo들과 비교)
			// ->지웠으면 삭제, 같으면 수정, pdno가 0이면 추가
			int p_no = sqlSession.selectOne(NAMESPACE+"getP_no", userid);
			List<H_PhotosDataVo> prev_list_pdVo = 
					sqlSession.selectList(NAMESPACE+"getList_pdVo", p_no);
			List<Integer> new_pdnos = new ArrayList<>(); // 신규 pdVo의 pdno들
			List<Integer> prev_pdnos = new ArrayList<>(); // 기존 pdVo의 pdno들
			List<Integer> arr_count_pdVo = new ArrayList<>(); // 성공 여부 카운트
			List<Integer> update_arr_pd_no = new ArrayList<>(); // 수정할 pd_no들
			List<Integer> remove_arr_pd_no = new ArrayList<>(); // 삭제할 pd_no들
			
			for (H_PhotosDataVo pdVo : list_pdVo) {
				int new_pdno = pdVo.getPd_no();
				if (new_pdno != 0) {
					new_pdnos.add(new_pdno); // 신규 pd_no들(0 제외)					
				}
			}
			System.out.println("*HDao* 신규 pdno들(0 제외): "+new_pdnos);
			
			for (H_PhotosDataVo pdVo : prev_list_pdVo) {
				prev_pdnos.add(pdVo.getPd_no()); // 기존 pd_no들
				remove_arr_pd_no.add(pdVo.getPd_no());
			}
			System.out.println("*HDao* 기존 pdno들: "+prev_pdnos);
			
			for (int n_pdno : new_pdnos) { // 기존과 신규 pdno 비교 -> 수정,삭제 분류
				for (int p_pdno : prev_pdnos) {
					if (n_pdno == p_pdno) {
						update_arr_pd_no.add(p_pdno);
						remove_arr_pd_no.remove(Integer.valueOf(p_pdno));
						break;
					}
				}
			}
			System.out.println("*HDao* 삭제할 pdno들: "+remove_arr_pd_no);
			System.out.println("*HDao* 수정할 pdno들: "+update_arr_pd_no);
			
			// 삭제인 경우 -> 해당하는 기존 pdno의 pdVo 삭제
			if (remove_arr_pd_no.size() != 0) {
				for (int rpdno : remove_arr_pd_no) {
					int count_pdVo = sqlSession.delete( // 삭제
							NAMESPACE+"remove_pdVo_by_pd_no", rpdno);
					arr_count_pdVo.add(count_pdVo);
				}
			}
			
			// 수정인 경우 -> 해당 pdno의 pdVo 업데이트
			if (update_arr_pd_no.size() != 0) {
				for (H_PhotosDataVo pdVo : list_pdVo) {
					for (int updno : update_arr_pd_no) {
						if (pdVo.getPd_no() == updno) {
							Map<String, Object> map = new HashMap<>();
							map.put("pdVo", pdVo);
							map.put("pd_no", updno);
							System.out.println("map: "+map);
							int count_pdVo = sqlSession.update(
									NAMESPACE+"update_pdVo", map);
							arr_count_pdVo.add(count_pdVo);
						}
					}
				}
			}
			
			// 추가인 경우 -> pdno가 0인 pdVo들 입력
			for (H_PhotosDataVo pdVo : list_pdVo) {
				if (pdVo.getPd_no() == 0) {
					pdVo.setP_no(p_no);
					int count_pdVo = sqlSession.insert( // 추가
							NAMESPACE+"insert_pdVo", pdVo);
					arr_count_pdVo.add(count_pdVo);
				}
			}
			
			// ->qdVo 업데이트
			int q_no = sqlSession.selectOne(NAMESPACE+"getQ_no", userid);
			List<H_QnaDataVo> prev_list_qdVo = 
					sqlSession.selectList(NAMESPACE+"getList_qdVo", q_no);
			int new_qdVo_cnt = list_qdVo.size(); // 신규 qdVo
			int prev_qdVo_cnt = prev_list_qdVo.size(); // 기존 qdVo
			int[] arr_count_qdVo = new int[1]; // 성공 여부 카운트
			List<Integer> update_arr_qd_no = new ArrayList<>(); // 수정할 qd_no들
			List<Integer> remove_arr_qd_no = new ArrayList<>(); // 삭제할 qd_no들
			
			if (new_qdVo_cnt == prev_qdVo_cnt) { // ->수정
				System.out.println("다오-수정만");
				arr_count_qdVo = new int[list_qdVo.size()];
				for (H_QnaDataVo qdVo : prev_list_qdVo) {
					update_arr_qd_no.add(qdVo.getQd_no()); // 수정할 qd_no
				}
				for (int i = 0; i < list_qdVo.size(); i++) {
					Map<String, Object> map = new HashMap<>();
					map.put("qdVo", list_qdVo.get(i));
					map.put("qd_no", update_arr_qd_no.get(i));
					System.out.println("map: "+map);
					int count_qdVo = sqlSession.update(
							NAMESPACE+"update_qdVo", map);
					arr_count_qdVo[i] = count_qdVo;
				}
			} else if (new_qdVo_cnt < prev_qdVo_cnt) { // ->삭제+수정
				System.out.println("다오-삭제+수정");
				arr_count_qdVo = new int[prev_list_qdVo.size()];
				for (int i=0; i<(prev_qdVo_cnt-new_qdVo_cnt); i++) {
					H_QnaDataVo qdVo = prev_list_qdVo.get((prev_qdVo_cnt-1)-i);
					remove_arr_qd_no.add(qdVo.getQd_no()); // 삭제할 qd_no
				}
				System.out.println("삭제할 qd_no: "+remove_arr_qd_no);
				for (int i = 0; i < remove_arr_qd_no.size(); i++) {
					int qd_no = remove_arr_qd_no.get(i);
					int count_qdVo = sqlSession.delete( // 삭제
							NAMESPACE+"remove_qdVo_by_qd_no", qd_no);
					arr_count_qdVo[i] = count_qdVo;
				}
				for (int i=0; i<new_qdVo_cnt; i++) {
					H_QnaDataVo qdVo = prev_list_qdVo.get(i);
					update_arr_qd_no.add(qdVo.getQd_no()); // 수정할 qd_no
				}
				System.out.println("수정할 qd_no: "+update_arr_qd_no);
				for (int i = 0; i < update_arr_qd_no.size(); i++) { // 수정
					Map<String, Object> map = new HashMap<>();
					map.put("qdVo", list_qdVo.get(i));
					map.put("qd_no", update_arr_qd_no.get(i));
					System.out.println("map: "+map);
					int count_qdVo = sqlSession.update(
							NAMESPACE+"update_qdVo", map);
					arr_count_qdVo[remove_arr_qd_no.size()+i] = count_qdVo;
				}
			} else if (new_qdVo_cnt > prev_qdVo_cnt) { // ->추가+수정
				System.out.println("다오-추가+수정");
				arr_count_qdVo = new int[list_qdVo.size()]; // 성공 여부 카운트
				for (int i=0; i<prev_qdVo_cnt; i++) { 
					H_QnaDataVo qdVo = prev_list_qdVo.get(i);
					update_arr_qd_no.add(qdVo.getQd_no()); // 수정할 qd_no
				}
				System.out.println("수정할 qd_no: "+update_arr_qd_no);
				for (int i = 0; i < update_arr_qd_no.size(); i++) { // 수정
					Map<String, Object> map = new HashMap<>();
					map.put("qdVo", list_qdVo.get(i));
					map.put("qd_no", update_arr_qd_no.get(i));
					System.out.println("map: "+map);
					int count_qdVo = sqlSession.update(
							NAMESPACE+"update_qdVo", map);
					arr_count_qdVo[i] = count_qdVo;
				}
				for (int i=0; i<(new_qdVo_cnt-prev_qdVo_cnt); i++) {
					H_QnaDataVo qdVo = list_qdVo.get(prev_qdVo_cnt+i);
					qdVo.setQ_no(q_no);
					int count_qdVo = sqlSession.insert( // 추가
							NAMESPACE+"insert_qdVo", qdVo);
					arr_count_qdVo[prev_qdVo_cnt+i] = count_qdVo;
				}
			}
			
			// int count
			int count_tpVo = sqlSession.update(NAMESPACE+"update_tpVo", tpVo);
			int count_hVo = sqlSession.update(NAMESPACE+"update_hVo", hVo);
			int count_oVo = sqlSession.update(NAMESPACE+"update_oVo", oVo);
			int count_tVo = sqlSession.update(NAMESPACE+"update_tVo", tVo);
			
			int count_hsVo = 0;
			for (int i = 0; i < arr_count_hsVo.length; i++) {
				if (arr_count_hsVo[i] == 0) {
					count_hsVo = 0;
					break;
				} else {count_hsVo = 1;}
			}
			
			int count_pdVo = 0;
			for (int i = 0; i < arr_count_pdVo.size(); i++) {
				if (arr_count_pdVo.get(i) == 0) {
					count_pdVo = 0;
					break;
				} else {count_pdVo = 1;}
			}
			
			int count_qdVo = 0;
			for (int i = 0; i < arr_count_qdVo.length; i++) {
				if (arr_count_qdVo[i] == 0) {
					count_qdVo = 0;
					break;
				} else {count_qdVo = 1;}
			}
			
			if (count_hsVo > 0) {System.out.println("다오-hsVo 수정 성공!");}
			if (count_pdVo > 0) {System.out.println("다오-pdVo 수정 성공!");}
			if (count_qdVo > 0) {System.out.println("다오-qdVo 수정 성공!");}
//			
			// 모든 vo 업데이트 성공시 true 리턴
			if (count_tpVo>0 && count_hVo>0 && count_hsVo>0 && count_oVo>0 && 
					count_pdVo>0 && count_qdVo>0 && count_tVo>0) {
				return true;
			} else { return false; }
		}
	
}
