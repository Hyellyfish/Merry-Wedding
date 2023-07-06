package com.kh.mw.controller;

import java.io.FileInputStream;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.mw.service.PlannerService;
import com.kh.mw.util.MyFileUploader;
import com.kh.mw.vo.CheckVo;
import com.kh.mw.vo.P_PagingDto;
import com.kh.mw.vo.UserVo;
import com.kh.mw.vo.VendorVo;

@Controller
@RequestMapping("/planner/*")
public class PlannerController {
	
	final String MANAGERID = "admin";
	
	
	@Autowired
	private PlannerService pService;
	
	// 이미지 표시
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
			e.printStackTrace();
		} finally {
			try {fis.close();} catch(Exception e) {}
		}
		return null;
	}
	
	// 웨딩업체 리스트 폼
	@RequestMapping(value = "/vendor_list", method = RequestMethod.GET)
	public String vendor_list_form(HttpSession session, Model model, 
										P_PagingDto pagingDto) {
		// 페이징 처리
		if (pagingDto.getSearch_type() == 0 
				&& pagingDto.getSearch_region() == 0) {
			pagingDto.setSearch_type(21); // 유형 초기값 : 웨딩홀로 설정
			pagingDto.setSearch_region(1); // 지역 초기값 : 서울로 설정
		}
		if (pagingDto.getOrderby() == null) {
			pagingDto.setOrderby("v_no"); // 정렬 초기값 : 최신순으로 설정
		}
		pagingDto.setPagingInfo(pagingDto.getPage(), 
				pService.getVendorsCount(pagingDto));
		List<VendorVo> list = pService.getList_vVo(pagingDto);
		System.out.println("*Planner컨트롤러* list: "+list);
		System.out.println("*Planner컨트롤러* pagingDto: "+pagingDto);
		
		model.addAttribute("list", list);
		model.addAttribute("pagingDto", pagingDto);
		
		return "planner/vendor_list";
	}
	
	// 웨딩업체 리스트 폼(관리자)
	@RequestMapping(value = "/vendor_list_admin", method = RequestMethod.GET)
	public String vendor_list_admin(HttpSession session, Model model, 
			P_PagingDto pagingDto) {
		// 페이징 처리
		if (pagingDto.getSearch_type() == 0 
				&& pagingDto.getSearch_region() == 0) {
			pagingDto.setSearch_type(21); // 유형 초기값 : 웨딩홀로 설정
			pagingDto.setSearch_region(1); // 지역 초기값 : 서울로 설정
		}
		if (pagingDto.getOrderby() == null) {
			pagingDto.setOrderby("v_no"); // 정렬 초기값 : 최신순으로 설정
		}
		pagingDto.setPagingInfo(pagingDto.getPage(), 
				pService.getVendorsCount(pagingDto));
		List<VendorVo> list = pService.getList_vVo(pagingDto);
		System.out.println("*Planner컨트롤러* list: "+list);
		System.out.println("*Planner컨트롤러* pagingDto: "+pagingDto);
		
		model.addAttribute("list", list);
		model.addAttribute("pagingDto", pagingDto);
		
		return "planner/vendor_list_admin";
	}
	
	// 웨딩업체 상세정보(관리자)
	@RequestMapping(value = "/vendor_detail", method = RequestMethod.GET)
	public String vendor_detail(HttpSession session, Model model, 
			int v_no) {
		VendorVo vendorVo = pService.getVvo_byVno(v_no);
//		System.out.println("*Planner컨트롤러* vendorVo: "+vendorVo);
		model.addAttribute("vendorVo", vendorVo);
		return "planner/vendor_detail";
	}
	
	// 웨딩업체 등록 폼(관리자)
	@RequestMapping(value = "/vendor_register", method = RequestMethod.GET)
	public String vendor_register(HttpSession session) {
		return "planner/vendor_register";
	}	
	
	// 웨딩업체 등록처리(관리자)
	@RequestMapping(value = "/vendor_register_run", method = RequestMethod.POST)
	public String vendor_register_run(HttpSession session, Model model, RedirectAttributes rttr, 
			VendorVo vendorVo, MultipartFile file) {
		System.out.println("*Planner컨트롤러* vendorVo: "+vendorVo);
		// 사진 업로드
		try {
			String originalFileName = file.getOriginalFilename();
			if (originalFileName != null && !originalFileName.equals("")) {
				String pic = MyFileUploader.uploadFile(
						"C:/workspace/mw_upload_img", originalFileName, file.getBytes());
				vendorVo.setV_pic(pic);
			}
		} catch (Exception e) { e.printStackTrace(); }
		
		boolean result = pService.vendor_register(vendorVo);
		if (result == true) { 
			System.out.println("*Planner컨트롤러* 등록 성공");
			String register_result = "register_success";
			rttr.addFlashAttribute("register_result", register_result);
		} else {
			System.out.println("*Planner컨트롤러* 등록 실패");
			String register_result = "register_fail";
			rttr.addFlashAttribute("register_result", register_result);
		}
		return "redirect:/planner/vendor_list_admin";
	}
	
	// 웨딩업체 수정처리(관리자)
	@RequestMapping(value = "/vendor_edit", method = RequestMethod.POST)
	public String vendor_edit(HttpSession session, Model model, RedirectAttributes rttr, 
			VendorVo vendorVo, MultipartFile file) {
		System.out.println("*Planner컨트롤러* vendorVo: "+vendorVo);
		
		// 사진 업로드
		try {
			String originalFileName = file.getOriginalFilename();
			if (originalFileName != null && !originalFileName.equals("")) {
				String pic = MyFileUploader.uploadFile(
						"C:/workspace/mw_upload_img", originalFileName, file.getBytes());
				vendorVo.setV_pic(pic);
			}
		} catch (Exception e) { e.printStackTrace(); }
		
		boolean result = pService.vendor_edit(vendorVo);
		if (result == true) { 
			System.out.println("*Planner컨트롤러* 수정 성공");
			String edit_result = "edit_success";
			rttr.addFlashAttribute("edit_result", edit_result);
		} else {
			System.out.println("*Planner컨트롤러* 수정 실패");
			String edit_result = "edit_fail";
			rttr.addFlashAttribute("edit_result", edit_result);
		}
		
		int v_no = vendorVo.getV_no();
		String path = "redirect:/planner/vendor_detail?v_no="+v_no;
		return path;
	}
	
	// 웨딩업체 삭제처리(관리자)
	@RequestMapping(value = "/vendor_delete", method = RequestMethod.GET)
	public String vendor_edit(HttpSession session, Model model, RedirectAttributes rttr, 
			int v_no) {
		boolean result = pService.vendor_delete(v_no);
		if (result == true) { 
			System.out.println("*Planner컨트롤러* 삭제 성공");
			String delete_result = "delete_success";
			rttr.addFlashAttribute("delete_result", delete_result);
		} else {
			System.out.println("*Planner컨트롤러* 삭제 실패");
			String delete_result = "delete_fail";
			rttr.addFlashAttribute("delete_result", delete_result);
		}
		String path = "redirect:/planner/vendor_list_admin";
		return path;
	}
	
	// 체크리스트 폼
	@RequestMapping(value = "/checklist", method = RequestMethod.GET)
	public String checklist(HttpSession session, Model model) {
		UserVo userVo = (UserVo)session.getAttribute("loginInfo");
		// 로그인 했다면 체크리스트 불러오기
		if (userVo != null) {
			CheckVo checkVo = pService.getCheckVo_byId(userVo.getUserid());
			model.addAttribute("checkVo", checkVo);
		}
		return "planner/checklist";
	}
	
	// 체크리스트 저장
	@RequestMapping(value="/saveCheck", method=RequestMethod.POST)
	public String saveCheck(CheckVo checkVo, HttpSession session, 
									RedirectAttributes rttr) {
		UserVo userVo = (UserVo)session.getAttribute("loginInfo");
		String userid = userVo.getUserid();
		checkVo.setUserid(userid);
		System.out.println("*Planner컨트롤러* checkVo: " + checkVo);
		
		boolean result = false;
		if (pService.getCheckCount(userid) == 0) { // 입력
			result = pService.insertCheck(checkVo);
		} else if (pService.getCheckCount(userid) == 1) { // 업데이트
			result = pService.updateCheck(checkVo);
		}
		rttr.addFlashAttribute("save_result", result);
		return "redirect:/planner/checklist";
	}
	
	
}
