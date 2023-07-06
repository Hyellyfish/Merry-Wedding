package com.kh.mw.controller;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.mw.service.HmessageService;
import com.kh.mw.service.UrlService;
import com.kh.mw.util.MyFileUploader;
import com.kh.mw.vo.H_MessagesVo;
import com.kh.mw.vo.UserVo;

@Controller
@RequestMapping("/hMessage/*")
public class HmessageController {
	
	@Autowired
	private UrlService urlService;
	
	@Autowired
	private HmessageService mService;
	
	// 메세지 좋아요
	@RequestMapping(value = "/like", method = RequestMethod.GET)
	@ResponseBody
	public String like(int mno) {
		String result = String.valueOf(mService.like(mno));
		return result;
	}

	// 메세지 좋아요 취소
	@RequestMapping(value = "/likeCancel", method = RequestMethod.GET)
	@ResponseBody
	public String likeCancel(int mno) {
		String result = String.valueOf(mService.likeCancel(mno));
		return result;
	}
	
	// 메세지 입력
	@RequestMapping(value = "/insertMsg", method = RequestMethod.POST)
	public String insertMsg(HttpSession session, H_MessagesVo mVo, 
			MultipartFile mpic, RedirectAttributes rttr) {
		String url_keyword = (String)session.getAttribute("url_keyword");
		UserVo userVo = urlService.getUserVo_byUrl(url_keyword);
		System.out.println("*Hmessage컨트롤러* userVo: "+userVo);
		
		// mVo
		mVo.setM_admin(userVo.getUserid());
		
		LocalDateTime now = LocalDateTime.now();
        String mtime = now.format(DateTimeFormatter.ofPattern("yyyy년 MM월 dd일, HH:mm"));
        System.out.println("mtime: "+mtime);
        mVo.setM_time(mtime);
        
		try {
			String originalFileName = mpic.getOriginalFilename();
			if (originalFileName != null && !originalFileName.equals("")) {
				String pic = MyFileUploader.uploadFile(
						"C:/workspace/mw_upload_img", originalFileName, mpic.getBytes());
				mVo.setM_pic(pic);
			}
		} catch (Exception e) { e.printStackTrace(); }
		System.out.println("*Hmessage컨트롤러* mVo: "+mVo);
		
		// 입력 처리
		boolean result = mService.insertMsg(mVo);
		if (result == true) { 
			System.out.println("*Hmessage컨트롤러* 저장 성공");
			String msg_result = "insert_success";
			rttr.addFlashAttribute("msg_result", msg_result);
		} else {
			System.out.println("*Hmessage컨트롤러* 저장 실패");
			String msg_result = "insert_fail";
			rttr.addFlashAttribute("msg_result", msg_result);
		}
		
		// 페이지 상태 유지
		String targetLoc = (String)session.getAttribute("targetLoc");
		String page = "redirect:" + targetLoc;
		return page;
	}
	
	// 메세지 수정
	@RequestMapping(value = "/editMsg", method = RequestMethod.POST)
	public String editMsg(HttpSession session, H_MessagesVo mVo, 
			MultipartFile mpic, RedirectAttributes rttr) {
		System.out.println("*Hmessage컨트롤러* 메세지 수정");
		String url_keyword = (String)session.getAttribute("url_keyword");
		UserVo userVo = urlService.getUserVo_byUrl(url_keyword);
		
		// mVo
		mVo.setM_admin(userVo.getUserid());
		try {
			String originalFileName = mpic.getOriginalFilename();
			if (originalFileName != null && !originalFileName.equals("")) {
				String pic = MyFileUploader.uploadFile(
						"C:/workspace/mw_upload_img", originalFileName, mpic.getBytes());
				mVo.setM_pic(pic);
			}
		} catch (Exception e) { e.printStackTrace(); }
		System.out.println("mVo: "+mVo);
		
		// 수정 처리
		boolean result = mService.editMsg(mVo);
		if (result == true) { 
			System.out.println("*Hmessage컨트롤러* 수정 성공");
			String msg_result = "edit_success";
			rttr.addFlashAttribute("msg_result", msg_result);
		} else {
			System.out.println("*Hmessage컨트롤러* 수정 실패");
			String msg_result = "edit_fail";
			rttr.addFlashAttribute("msg_result", msg_result);
		}
		
		// 페이지 상태 유지
		String targetLoc = (String)session.getAttribute("targetLoc");
		String page = "redirect:" + targetLoc;
		return page;
	}
	
	// 메세지 삭제
	@RequestMapping(value = "/delete", method = RequestMethod.GET)
	public String deleteMsg(HttpSession session, RedirectAttributes rttr, 
								int mno) {
		System.out.println("*Hmessage컨트롤러* 메세지 삭제");
		boolean result = mService.deleteMsg(mno);
		if (result) {
			System.out.println("*Hmessage컨트롤러* 삭제 성공");
			String msg_result = "delete_success";
			rttr.addFlashAttribute("msg_result", msg_result);
		} else {
			System.out.println("*Hmessage컨트롤러* 삭제 실패");
			String msg_result = "delete_fail";
			rttr.addFlashAttribute("msg_result", msg_result);
		}
		
		// 페이지 상태 유지
		String targetLoc = (String)session.getAttribute("targetLoc");
		String page = "redirect:" + targetLoc;
		return page;
	}
	
	// 메세지 삭제(여러 개, 관리자 페이지에서)
	@RequestMapping(value = "/deleteMsgs", method = RequestMethod.POST)
	public String deleteMsgs(HttpSession session, RedirectAttributes rttr, 
			@RequestParam("mnos") List<Integer> mnos, int sNum) {
		System.out.println("*Hmessage컨트롤러* 메세지 여러 개 삭제");
		System.out.println("*Hmessage컨트롤러* mnos: "+mnos);
		System.out.println("*Hmessage컨트롤러* sNum: "+sNum);
		
		boolean result = mService.deleteMsgs(mnos);
		if (result) {
			System.out.println("*Hmessage컨트롤러* 삭제 성공");
			String msg_result = "delete_success";
			String msg_sNum = sNum+"개의 메세지가 삭제되었습니다.";
			rttr.addFlashAttribute("msg_result", msg_result);
			rttr.addFlashAttribute("msg_sNum", msg_sNum);
		} else {
			System.out.println("*Hmessage컨트롤러* 삭제 실패");
			String msg_result = "delete_fail";
			rttr.addFlashAttribute("msg_result", msg_result);
		}
		return "redirect:/user/url_manage";
	}
		
}
