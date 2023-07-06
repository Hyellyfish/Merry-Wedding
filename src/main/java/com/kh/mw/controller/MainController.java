package com.kh.mw.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/main/*")
public class MainController {
	
	// 메인페이지 - Home
	@RequestMapping(value = "/home", method = RequestMethod.GET)
	public String main() {
		return "/main/home_form";
	}
	
	// 메인페이지 - Planner
	@RequestMapping(value = "/planner", method = RequestMethod.GET)
	public String planner() {
		return "/main/planner_form";
	}
	
	// 메인페이지 - Create
	@RequestMapping(value = "/create", method = RequestMethod.GET)
	public String createMyWeb() {
		return "/main/create_form";
	}
		
	// 메인페이지 - Log in
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login() {
		return "/main/login_form";
	}
	
}
