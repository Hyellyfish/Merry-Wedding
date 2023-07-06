package com.kh.mw.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.kh.mw.vo.UserVo;

@Controller
@RequestMapping("/create/*")
public class CreateController {
	
	// 페이지 만들기 - 새 프로젝트 만들기 버튼 클릭
	@RequestMapping(value = "/newproject", method = RequestMethod.GET)
	public String newproject(HttpSession session) {
		System.out.println("*Create컨트롤러* newproject");
		return "redirect:/main/create";
	}
	
	// 페이지 만들기 - 템플릿 선택 페이지
	@RequestMapping(value = "/choose_temp", method = RequestMethod.GET)
	public String chooseTemp(HttpSession session) {
		UserVo userVo = (UserVo)session.getAttribute("loginInfo");
		System.out.println("*Create컨트롤러* userVo: "+userVo);
		return "/create/choose_temp";
	}
	
	// 템플릿 선택 페이지 - 템플릿 미리보기 페이지(tempY)
	@RequestMapping(value = "/preview_tempY", method = RequestMethod.GET)
	public String preview_tempY() {
		return "redirect:/preview/y_home";
	}
	
	// 템플릿 선택 페이지 - 템플릿 미리보기 페이지(tempH)
	@RequestMapping(value = "/preview_tempH", method = RequestMethod.GET)
	public String preview_tempH() {
		return "redirect:/preview/h_home";
	}
}
