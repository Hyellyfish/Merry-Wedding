package com.kh.mw.controller;

import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.mw.service.HmessageService;
import com.kh.mw.service.UserService;
import com.kh.mw.vo.H_MessagesVo;
import com.kh.mw.vo.H_PagingDto;
import com.kh.mw.vo.UserVo;

@Controller
@RequestMapping("/user/*")
public class UserController {
	
	final String MANAGERID = "admin";
	
	@Autowired
	UserService userService;
	
	@Autowired
	private HmessageService mService;
	
	// 로그인 처리
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login_run(String userid, String userpw, String saveId, 
			HttpSession session, RedirectAttributes rttr, HttpServletResponse response) {
		session.setAttribute("loginResult", "");
		UserVo vo = userService.login_run(userid, userpw);
		System.out.println("*User컨트롤러* userVo: "+vo);
		if (vo == null) { // 로그인이 불가능한 경우
			rttr.addFlashAttribute("loginResult","fail");
			return "redirect:/main/login";
		} else { // 로그인이 가능한 경우
			session.setAttribute("loginInfo", vo);		
			if (vo.getUserid().equals(MANAGERID)) {
				session.setAttribute("loginResult", "manager");
			}
		}
		
		// 아이디 저장 기능(쿠키에 저장)
		Cookie cookie = new Cookie("userid", userid);
		cookie.setPath("/");
		if (saveId != null) { // 아이디 저장 체크했을 경우
			cookie.setMaxAge(60*60*24*7);
		} else {
			cookie.setMaxAge(0);
		}
		response.addCookie(cookie);
		
		// 로그인 시 페이지 상태 유지
		String targetLocation = (String)session.getAttribute("targetLocation");
		System.out.println("*User컨트롤러* targetLoc: "+targetLocation);
		String page = "";
		if (targetLocation != null && !targetLocation.equals("")) {
			page = "redirect:" + targetLocation;
		} else {
			page = "redirect:/main/home";
		}
		return page;
	}
	
	// 로그아웃
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/main/home";
	}
	
	// 회원가입 폼
	@RequestMapping(value ="/register", method = RequestMethod.GET)
	public String register() {
		return "user/register_form";
	}
	
	// 회원가입 처리
	@RequestMapping(value = "/register_run", method = RequestMethod.POST)
	public String registerRun(UserVo userVo, RedirectAttributes rttr) {
		System.out.println(userVo);
		boolean result = userService.registerRun(userVo);
		System.out.println("*User컨트롤러* 회원가입처리: "+result);
		if (result) {
			rttr.addFlashAttribute("register_result", "success");
		}
		return "redirect:/main/login";
	}
	
	// 아이디 존재 여부 확인
	@RequestMapping(value = "/isExistId", method = RequestMethod.GET)
	@ResponseBody
	public String checkId(String inputId) {
		System.out.println("*User컨트롤러* inputId: "+inputId);
		boolean result = userService.isExistId(inputId);
		String strResult = "";
		if (result == true) {
			strResult = "true";
		} else {
			strResult = "false";
		}
		return strResult;
	}
	
	// url 존재 여부 확인
	@RequestMapping(value = "/isExistUrl", method = RequestMethod.GET)
	@ResponseBody
	public String checkUrl(String inputUrl) {
		System.out.println("*User컨트롤러* inputUrl: "+inputUrl);
		boolean result = userService.isExistUrl(inputUrl);
		String strResult = "";
		if (result ==true) {
			strResult = "true";
		} else {
			strResult = "false";
		}
		return strResult;
	}
	
	// 마이페이지 - 나만의 페이지 관리
	@RequestMapping(value = "/url_manage", method = RequestMethod.GET)
	public String url_manage(HttpSession session, HttpServletRequest request, 
			Model model, H_PagingDto pagingDto) {
		UserVo userVo = (UserVo)session.getAttribute("loginInfo");
		if (userVo.getPjnum() != 0) {
			if (pagingDto.getSearchName() != null) {
				if (pagingDto.getSearchName().equals("")) {
					pagingDto.setSearchName(null);					
				}
			}
			pagingDto.setPerPage(10);
			pagingDto.setPagingInfo(
					pagingDto.getPage(), mService.getCount(userVo.getUserid(), pagingDto));
			List<H_MessagesVo> list_mVo = 
					mService.getList_mVo(userVo.getUserid(), pagingDto);
			System.out.println("pagingDto: "+pagingDto);
			model.addAttribute("list_mVo", list_mVo);
			model.addAttribute("pagingDto", pagingDto);
		}
		return "/user/url_manage";
	}
	
	// 비밀번호 입력 페이지
	@RequestMapping(value = "/input_password", method = RequestMethod.GET)
	public String inputpassword(HttpSession session) {
		return "/user/input_password";
	}
	
	// 비밀번호 입력 처리
	@RequestMapping(value = "/input_password_run", method = RequestMethod.POST)
	public String input_password_run(HttpSession session, String inputPw, RedirectAttributes rttr) {
		UserVo userVo = (UserVo)session.getAttribute("loginInfo");
		String userpw = userVo.getUserpw();
		System.out.println("userpw: "+userpw);
		System.out.println("inputPw: "+inputPw);
		
		if (!userpw.equals(inputPw)) { // 비밀번호가 일치하지 않는 경우
			rttr.addFlashAttribute("checkPw","wrong");
			return "redirect:/user/input_password";
		} else { // 비밀번호가 일치하는 경우
			// 페이지 상태 유지
			String targetLocation = (String)session.getAttribute("pw_targetLocation");
			System.out.println("*User컨트롤러* pw_targetLocation: "+targetLocation);
			String page = "redirect:" + targetLocation;
			return page;
		}
	}
	
	// 회원정보 수정 페이지(비밀번호 입력 전)
	@RequestMapping(value = "/edit", method = RequestMethod.GET)
	public String userinfo(HttpSession session) {
		return null;
	}
	
	// 회원정보 수정 페이지
	@RequestMapping(value = "/edit_form", method = RequestMethod.GET)
	public String userinfo_form(HttpSession session) {
		return "/user/user_info";
	}
	
	// 회원정보 수정 처리
	@RequestMapping(value="/edit_run", method = RequestMethod.POST)
	public String edit_run(UserVo userVo, RedirectAttributes rttr, HttpSession session) {
		boolean result = userService.edit_run(userVo);
		System.out.println("*User컨트롤러* 회원정보 수정처리: "+result);
		if (result == true) {
			rttr.addFlashAttribute("update_result", "success");
			UserVo prevVo = (UserVo)session.getAttribute("loginInfo");
			UserVo newVo = userService.login_run(prevVo.getUserid(), prevVo.getUserpw());
			session.setAttribute("loginInfo", newVo);	
		} else {
			rttr.addFlashAttribute("update_result", "fail");		
			return null;
		}
		session.invalidate();
		return "redirect:/main/home";
	}
	
	// 회원탈퇴(비밀번호 입력 전)
	@RequestMapping(value="/delete_user", method = RequestMethod.GET)
	public String delete_user(HttpSession session, RedirectAttributes rttr) {
		return null;
	}
	
	// 회원탈퇴
	@RequestMapping(value="/delete_run", method = RequestMethod.GET)
	public String delete_run(HttpSession session, RedirectAttributes rttr) {
		UserVo userVo = (UserVo)session.getAttribute("loginInfo");
		boolean result = userService.delete_user(userVo.getUserid());
		System.out.println("*User컨트롤러* 회원탈퇴처리: "+result);
		if (result == true) {
			rttr.addFlashAttribute("delete_result", "success");						
		} else {
			rttr.addFlashAttribute("delete_result", "fail");			
		}
		session.invalidate();
		return "redirect:/main/home";
	}
	
	
}
