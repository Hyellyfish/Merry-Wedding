package com.kh.mw.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.mw.service.GuestService;
import com.kh.mw.vo.GuestVo;
import com.kh.mw.vo.UserVo;

@Controller
@RequestMapping("/guest/*")
public class GuestController {
	
	@Autowired
	private GuestService guestService;
	
	// 하객 목록
	@RequestMapping(value = "/guestlist", method = RequestMethod.GET)
	public String list(Model model, HttpSession session, RedirectAttributes rttr) {
		UserVo userVo = (UserVo)session.getAttribute("loginInfo");
		System.out.println("하객 : " + userVo);
		if(userVo == null) {
			return "user/login";
		}
		String userid = userVo.getUserid();
		List<GuestVo> list = guestService.guestList(userid);
		model.addAttribute("list", list);
		int count = guestService.getCount(userid);
		model.addAttribute("count", count);
		System.out.println("GuestController, list " + list);
		return "guest/guest_list";
	}
	
	
	// 하객 등록
	@RequestMapping(value = "/register", method = RequestMethod.POST)
	@ResponseBody
	public String guestRegister(GuestVo guestVo, HttpSession session) {
		UserVo userVo = (UserVo)session.getAttribute("loginInfo");
		guestVo.setUserid(userVo.getUserid());
		System.out.println("게스트 등록 : " + guestVo);
		boolean result = guestService.guestRegister(guestVo);
		return String.valueOf(result);
	}
	
	// 하객 삭제
	@RequestMapping(value="/delete", method = RequestMethod.POST)
	@ResponseBody
	public String delete(@RequestParam(value="arr_g_no[]") int[] arr_g_no) {
		System.out.println(arr_g_no);
		for(int msg_no : arr_g_no) {
			System.out.println(msg_no);
		}
		boolean result = guestService.guestDelete(arr_g_no);
		return String.valueOf(result);
	}
	
	// 하객 정보 수정
	@RequestMapping(value = "/modify", method = RequestMethod.POST)
	@ResponseBody
	public String modify(GuestVo guestVo) {
		System.out.println("Controller, modify : " + guestVo);
		boolean result = guestService.guestModify(guestVo);
		return String.valueOf(result);
	}
	
}
