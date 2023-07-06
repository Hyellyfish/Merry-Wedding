package com.kh.mw.controller;

import java.io.FileInputStream;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.kh.mw.service.HService;
import com.kh.mw.util.MyFileUploader;
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

@Controller
@RequestMapping("/tempH/*")
public class HController {
	
	@Autowired
	private HService hService;
	
	// 페이지 만들기 - 프로젝트 페이지
	@RequestMapping(value = "/insert_info", method = RequestMethod.GET)
	public String insertInfo(HttpSession session, Model model) {
		UserVo userVo = (UserVo)session.getAttribute("loginInfo");
		System.out.println("*H컨트롤러* userVo: "+userVo);
		if (userVo.getPjnum() != 0) {
			H_TempPhotosVo tpVo = hService.getTpVo(userVo.getUserid());
			H_HomeVo hVo = hService.getHvo(userVo.getUserid());
			List<H_HomeScheduleVo> list_hsVo = hService.getList_hsVo(hVo.getH_no());
			H_OurstoryVo oVo = hService.getOvo(userVo.getUserid());
			H_PhotosVo pVo = hService.getPvo(userVo.getUserid());
			List<H_PhotosDataVo> list_pdVo = hService.getList_pdVo(pVo.getP_no());
			H_QnaVo qVo = hService.getQvo(userVo.getUserid());
			List<H_QnaDataVo> list_qdVo = hService.getList_qdVo(qVo.getQ_no());
			H_TravelVo tVo = hService.getTvo(userVo.getUserid());
			
			model.addAttribute("tpVo", tpVo);
			model.addAttribute("hVo", hVo);
			model.addAttribute("list_hsVo", list_hsVo);
			model.addAttribute("oVo", oVo);
			model.addAttribute("pVo", pVo);
			model.addAttribute("list_pdVo", list_pdVo);
			model.addAttribute("qVo", qVo);
			model.addAttribute("list_qdVo", list_qdVo);
			model.addAttribute("tVo", tVo);
		}
		return "/create/h_insert_info";
	}
	
	// 프로젝트 페이지 - 이미지 표시
	@RequestMapping(value="/displayImage", method=RequestMethod.GET)
	@ResponseBody
	public byte[] displayImage(String pic) {
		FileInputStream fis = null;
		try {
			fis = new FileInputStream(pic);
			// org.apache.common.io.IOUtils
			byte[] bytes = IOUtils.toByteArray(fis);
			return bytes;
		} catch(Exception e) {
//			System.out.println("*H컨트롤러* 이미지 표시오류");
			e.printStackTrace();
		} finally {
			try {fis.close();} catch(Exception e) {}
		}
		return null;
	}
	
	// 프로젝트 페이지 - 정보 입력 처리
	@RequestMapping(value = "/insert_run", method = RequestMethod.POST)
	public String insertRun(
			HttpSession session, String action,
			@RequestParam("files_tempphotos") List<MultipartFile> files_tempphotos,
			MultipartFile file_home,
			MultipartFile file_ourstory,
			@RequestParam("files_photos") List<MultipartFile> files_photos,
			String h_year, String h_month, String h_date, 
			@RequestParam("start_ampm") List<String> start_ampms, 
			@RequestParam("start_time") List<String> start_times, 
			@RequestParam("end_ampm") List<String> end_ampms, 
			@RequestParam("end_time") List<String> end_times, 
			@RequestParam("wedevent") List<String> wedevents, 
			@RequestParam("pyear") List<String> pyears, 
			@RequestParam("pmonth") List<String>pmonths, 
			@RequestParam("pdate") List<String> pdates,
			@RequestParam("ptext") List<String> ptexts,
			@RequestParam("ptitle") List<String> ptitles,
			@RequestParam("pdno") List<Integer> pdnos,
			@RequestParam("q") List<String> qs, @RequestParam("a") List<String> as,
			
			H_TempPhotosVo tpVo, H_HomeVo hVo, H_OurstoryVo oVo, 
			H_PhotosVo pVo, H_QnaVo qVo, H_TravelVo tVo) {
		
		// preview / insert
		System.out.println("*H컨트롤러* action: "+action);
		UserVo userVo = (UserVo)session.getAttribute("loginInfo");
		
		// TempPhotosVo
		tpVo.setUserid(userVo.getUserid());
		H_TempPhotosVo prev_TpVo = hService.getTpVo(userVo.getUserid());
		try {
			for (int i = 0; i < files_tempphotos.size(); i++) {
				String originalFileName = files_tempphotos.get(i).getOriginalFilename();
				if (originalFileName != null && !originalFileName.equals("")) {
					String pic = MyFileUploader.uploadFile(
							"C:/workspace/mw_upload_img", originalFileName, files_tempphotos.get(i).getBytes());
					switch (i) {
					case 0:
						tpVo.setTp_htitlepic(pic);
						break;
					case 1:
						tpVo.setTp_hspic(pic);
						break;
					case 2:
						tpVo.setTp_mpic(pic);
						break;
					case 3:
						tpVo.setTp_titlepic(pic);
						break;
					}
				} else { // 이미지가 null인 경우
					if (action.equals("preview") && userVo.getPjnum() != 0) {
						String pic = "";
						switch (i) {
						case 0:
							pic = prev_TpVo.getTp_htitlepic();
							if (pic != null) {
								tpVo.setTp_htitlepic(pic);								
							}
							break;
						case 1:
							pic = prev_TpVo.getTp_hspic();
							if (pic != null) {
								tpVo.setTp_hspic(pic);								
							}
							break;
						case 2:
							pic = prev_TpVo.getTp_mpic();
							if (pic != null) {
								tpVo.setTp_mpic(pic);								
							}
							break;
						case 3:
							pic = prev_TpVo.getTp_titlepic();
							if (pic != null) {
								tpVo.setTp_titlepic(pic);							
							}
							break;
						}
					}
				}
			}
		} catch (Exception e) { e.printStackTrace(); }
		System.out.println("tpVo: "+tpVo);
		
		// H_HomeVo
		H_HomeVo prev_hVo = hService.getHvo(userVo.getUserid());
		hVo.setUserid(userVo.getUserid());
		if (action.equals("preview")) {
			hVo.setH_no(1);
		}
		try {
			String originalFileName = file_home.getOriginalFilename();
			if (originalFileName != null && !originalFileName.equals("")) {
				String pic = MyFileUploader.uploadFile(
						"C:/workspace/mw_upload_img", originalFileName, file_home.getBytes());
				hVo.setH_pic(pic);
			} else { // 이미지가 null일 경우
				if (action.equals("preview") && userVo.getPjnum() != 0) {
					String pic = prev_hVo.getH_pic();
					hVo.setH_pic(pic);
				}
			}
		} catch (Exception e) { e.printStackTrace(); }
		
		String h_weddate = h_year + "년 " + h_month + "월 " + h_date + "일";
		hVo.setH_weddate(h_weddate);
		System.out.println("hVo: "+hVo);
		
		// H_HomeScheduleVo
		List<String> starttimes = new ArrayList<String>();
		List<String> endtimes = new ArrayList<String>();
		
		for (int i = 0; i < start_ampms.size(); i++) {
			String s_ampm = start_ampms.get(i);
			String s_time = start_times.get(i);
			String e_ampm = end_ampms.get(i);
			String e_time = end_times.get(i);
			String starttime = s_ampm + " " + s_time;
			String endtime = e_ampm + " " + e_time;
			starttimes.add(starttime);
			endtimes.add(endtime);
		}
		
		if (wedevents.size() == 0) { wedevents.add(""); }
		List<H_HomeScheduleVo> list_hsVo = new ArrayList<H_HomeScheduleVo>();
		for (int i = 0; i < starttimes.size(); i++) {
			H_HomeScheduleVo vo = new H_HomeScheduleVo();
			vo.setHs_starttime(starttimes.get(i));
			vo.setHs_endtime(endtimes.get(i));
			vo.setHs_event(wedevents.get(i));
			if (action.equals("preview")) {
				vo.setH_no(1);
				vo.setHs_no(i+1);
			}
			list_hsVo.add(vo);
		}
		
		for (int i = 0; i < list_hsVo.size(); i++) {
			System.out.println("list_hsVo["+i+"]: "+list_hsVo.get(i));			
		}
		
		// H_OurstoryVo
		H_OurstoryVo prev_oVo = hService.getOvo(userVo.getUserid());
		oVo.setUserid(userVo.getUserid());
		try {
			String originalFileName = file_ourstory.getOriginalFilename();
			if (originalFileName != null && !originalFileName.equals("")) {
				String pic = MyFileUploader.uploadFile(
						"C:/workspace/mw_upload_img", originalFileName, file_ourstory.getBytes());
				oVo.setO_pic(pic);
			} else { // 이미지가 null인 경우
				if (action.equals("preview") && userVo.getPjnum() != 0) {
					String pic = prev_oVo.getO_pic();
					oVo.setO_pic(pic);
				}
			}
		} catch (Exception e) { e.printStackTrace(); }
		System.out.println("oVo: "+oVo);
		
		// H_PhotosVo
		H_PhotosVo prev_pVo = hService.getPvo(userVo.getUserid());
		pVo.setUserid(userVo.getUserid());
		if (action.equals("preview")) {
			pVo.setP_no(1);
		}
		System.out.println("pVo: "+pVo);
		
		// H_PhotosDataVo
		List<H_PhotosDataVo> prev_list_pdVo =  new ArrayList<H_PhotosDataVo>();
		if (userVo.getPjnum() != 0) {
			prev_list_pdVo = hService.getList_pdVo(prev_pVo.getP_no());
		}
		List<H_PhotosDataVo> list_pdVo = new ArrayList<H_PhotosDataVo>();
		try {
			for (int i = 0; i < files_photos.size(); i++) {
				H_PhotosDataVo vo = new H_PhotosDataVo();
				vo.setPd_no(pdnos.get(i));
				String originalFileName = files_photos.get(i).getOriginalFilename();
				if (originalFileName != null && !originalFileName.equals("")) {
					String pic = MyFileUploader.uploadFile(
							"C:/workspace/mw_upload_img", originalFileName, files_photos.get(i).getBytes());
					vo.setPd_pic(pic);
				} else { // 넘어온 이미지가 null일때 
						 //-> 기존이미지를 변경하지 않았거나, 기존이미지를 삭제하고 새로 만든경우
					if (prev_list_pdVo.size() != 0) { // 기존 db 데이터가 있을 경우(pjnum!=0일 때)
						if (action.equals("preview") && prev_list_pdVo.size()>i
								&& userVo.getPjnum() != 0 && vo.getPd_no()!=0) { // pdno가 0이면 새로입력한 이미지
							for (H_PhotosDataVo ppdvo : prev_list_pdVo) {
								if (vo.getPd_no() == ppdvo.getPd_no()) {
									String pic = ppdvo.getPd_pic();
									vo.setPd_pic(pic);
									break;
								}
							}
						}
					}
				}
				if (action.equals("preview")) {
					vo.setP_no(1);
					vo.setPd_no(i+1);
				}
				list_pdVo.add(vo);
			}
		} catch (Exception e) { e.printStackTrace(); }
		
		List<String> pd_pdates = new ArrayList<String>();
		for (int i = 0; i < pyears.size(); i++) {
			String s_year= pyears.get(i);
			String s_month = pmonths.get(i);
			String s_date = pdates.get(i);
			String pddate = s_year + "년 " + s_month + "월 " + s_date + "일";
			pd_pdates.add(pddate);
		}
		if (ptexts.size() == 0) { ptexts.add(""); }
		if (ptitles.size() == 0) { ptitles.add(""); }
		for (int i = 0; i < pd_pdates.size(); i++) {
			H_PhotosDataVo vo = list_pdVo.get(i);
			vo.setPd_pdate(pd_pdates.get(i));
			String replace_ptext = ptexts.get(i).replace("\r\n", "<br>"); // 개행문자 처리
			replace_ptext = replace_ptext.replace("\"", "<ttaompyo>"); // 따옴표 처리
			vo.setPd_text(replace_ptext);
			String replace_ptext2 = ptitles.get(i).replace("\"", "<ttaompyo>"); // 따옴표 처리/(\n|\r\n)/g
			vo.setPd_title(replace_ptext2);
		}
		
		for (int i = 0; i < list_pdVo.size(); i++) {
			System.out.println("list_pdVo["+i+"]: "+list_pdVo.get(i));			
		}
		
		// H_QnaVo
		qVo.setUserid(userVo.getUserid());
		if (action.equals("preview")) {
			qVo.setQ_no(1);
		}
		System.out.println("qVo: "+qVo);
				
		// H_QnaDataVo
		if (qs.size() == 0) { qs.add(""); }
		if (as.size() == 0) { as.add(""); }
		List<H_QnaDataVo> list_qdVo = new ArrayList<H_QnaDataVo>();
		for (int i = 0; i < qs.size(); i++) {
			H_QnaDataVo vo = new H_QnaDataVo();
			vo.setQd_q(qs.get(i));
			vo.setQd_a(as.get(i));
			if (action.equals("preview")) {
				vo.setQ_no(1);
				vo.setQd_no(i+1);
			}
			list_qdVo.add(vo);
		}
		for (int i = 0; i < list_qdVo.size(); i++) {
			System.out.println("list_qdVo["+i+"]: "+list_qdVo.get(i));			
		}
		
		// H_TravelVo
		tVo.setUserid(userVo.getUserid());
		String replace_ttext = tVo.getT_text().replace("\r\n", "<br>"); // 개행문자 처리
		tVo.setT_text(replace_ttext);
		System.out.println("tVo: " + tVo);
		
		// 미리보기 분기처리(preview) - 위 정보를 가지고 미리보기 페이지로 이동
		if (action.equals("preview")) {
			session.setAttribute("prev_tpVo", tpVo);
			session.setAttribute("prev_hVo", hVo);
			session.setAttribute("prev_list_hsVo", list_hsVo);
			session.setAttribute("prev_oVo", oVo);
			session.setAttribute("prev_pVo", pVo);
			session.setAttribute("prev_list_pdVo", list_pdVo);
			session.setAttribute("prev_qVo", qVo);
			session.setAttribute("prev_list_qdVo", list_qdVo);
			session.setAttribute("prev_tVo", tVo);
			return "redirect:/preview/h_home";
		}
		
		// 미리보기 분기처리(insert) - 위 정보(vo들)를 db에 입력
		boolean result = false;
		if (userVo.getPjnum() == 0) { // 입력
			result = hService.insertRun(
					tpVo, hVo, list_hsVo, oVo, pVo, list_pdVo, qVo, list_qdVo, tVo);
		} else if (userVo.getPjnum() == 1) { // 업데이트(수정,삭제,추가)
			result = hService.updateProject(
					tpVo, hVo, list_hsVo, oVo, list_pdVo, list_qdVo, tVo);
		}
		if (result == true) { 
			System.out.println("저장 성공");
			if (userVo.getPjnum() == 0) {
				userVo.setPjnum(1);
				userVo.setTemptype("H");
				boolean rs_udpjn = hService.updatePjnum(userVo);
				boolean rs_udtmt = hService.updateTemptype(userVo);
				if (rs_udpjn == true && rs_udtmt == true) {
					System.out.println("pjnum, temptype 갱신 성공");
				} else { System.out.println("pjnum, temptype 갱신 실패"); }
			}
		} else { System.out.println("저장 실패"); }
		return "redirect:/tempH/insert_info";
	}
	
	// 프로젝트 페이지 - 프로젝트 삭제 처리
	@RequestMapping(value = "/remove", method = RequestMethod.GET)
	public String removeProject(HttpSession session) {
		UserVo userVo = (UserVo)session.getAttribute("loginInfo");
		boolean result = hService.removeProject(userVo.getUserid());
		if (result) {
			System.out.println("삭제 성공");
			userVo.setPjnum(0);
			userVo.setTemptype(null);
			boolean rs_udpjn = hService.updatePjnum(userVo);
			boolean rs_udtmt = hService.updateTemptype(userVo);
			if (rs_udpjn == true && rs_udtmt == true) {
				System.out.println("pjnum, temptype 갱신 성공");
			} else { System.out.println("pjnum, temptype 갱신 실패"); }
		} else { System.out.println("삭제 실패"); }
		return "redirect:/main/create";
	}
		
}
