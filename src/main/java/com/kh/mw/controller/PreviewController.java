package com.kh.mw.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.kh.mw.vo.H_HomeScheduleVo;
import com.kh.mw.vo.H_HomeVo;
import com.kh.mw.vo.H_OurstoryVo;
import com.kh.mw.vo.H_PhotosDataVo;
import com.kh.mw.vo.H_PhotosVo;
import com.kh.mw.vo.H_QnaDataVo;
import com.kh.mw.vo.H_QnaVo;
import com.kh.mw.vo.H_TempPhotosVo;
import com.kh.mw.vo.H_TravelVo;

@Controller
@RequestMapping("/preview/*")
public class PreviewController {
	
	// 미리보기 페이지(tempH) - Home 
	@RequestMapping(value = "/h_home", method = RequestMethod.GET)
	public String h_home(HttpSession session, Model model) {
		H_TempPhotosVo tpVo = (H_TempPhotosVo)session.getAttribute("prev_tpVo");
		H_HomeVo hVo = (H_HomeVo)session.getAttribute("prev_hVo");
		@SuppressWarnings("unchecked")
		List<H_HomeScheduleVo> list_hsVo = (List<H_HomeScheduleVo>)session.getAttribute("prev_list_hsVo");
		if (tpVo != null) {
			model.addAttribute("tpVo", tpVo);
			model.addAttribute("hVo", hVo);		
			model.addAttribute("list_hsVo", list_hsVo);		
		}
		return "/create/temp_h/h_home";
	}
	
	// 미리보기 페이지(tempH) - Ourstory
	@RequestMapping(value = "/h_ourstory", method = RequestMethod.GET)
	public String h_ourstory(HttpSession session, Model model) {
		H_TempPhotosVo tpVo = (H_TempPhotosVo)session.getAttribute("prev_tpVo");
		H_HomeVo hVo = (H_HomeVo)session.getAttribute("prev_hVo");
		H_OurstoryVo oVo = (H_OurstoryVo)session.getAttribute("prev_oVo");
		if (tpVo != null) {
			model.addAttribute("tpVo", tpVo);
			model.addAttribute("hVo", hVo);
			model.addAttribute("oVo", oVo);			
		}
		return "/create/temp_h/h_ourstory";
	}
	
	// 미리보기 페이지(tempH) - Photos
	@RequestMapping(value = "/h_photos", method = RequestMethod.GET)
	public String h_photos(HttpSession session, Model model) {
		H_TempPhotosVo tpVo = (H_TempPhotosVo)session.getAttribute("prev_tpVo");
		H_HomeVo hVo = (H_HomeVo)session.getAttribute("prev_hVo");
		H_PhotosVo pVo = (H_PhotosVo)session.getAttribute("prev_pVo");
		@SuppressWarnings("unchecked")
		List<H_PhotosDataVo> list_pdVo = (List<H_PhotosDataVo>)session.getAttribute("prev_list_pdVo");		
		if (tpVo != null) {
			model.addAttribute("tpVo", tpVo);
			model.addAttribute("hVo", hVo);
			model.addAttribute("pVo", pVo);		
			model.addAttribute("list_pdVo", list_pdVo);		
		}
		return "/create/temp_h/h_photos";
	}
	
	// 미리보기 페이지(tempH) - Q + A
	@RequestMapping(value = "/h_qna", method = RequestMethod.GET)
	public String h_qna(HttpSession session, Model model) {
		H_TempPhotosVo tpVo = (H_TempPhotosVo)session.getAttribute("prev_tpVo");
		H_HomeVo hVo = (H_HomeVo)session.getAttribute("prev_hVo");
		H_QnaVo qVo = (H_QnaVo)session.getAttribute("prev_qVo");
		@SuppressWarnings("unchecked")
		List<H_QnaDataVo> list_qdVo = (List<H_QnaDataVo>)session.getAttribute("prev_list_qdVo");
		if (tpVo != null) {
			model.addAttribute("tpVo", tpVo);
			model.addAttribute("hVo", hVo);
			model.addAttribute("qVo", qVo);		
			model.addAttribute("list_qdVo", list_qdVo);		
		}
		return "/create/temp_h/h_qna";
	}
	
	// 미리보기 페이지(tempH) - Travel
	@RequestMapping(value = "/h_travel", method = RequestMethod.GET)
	public String h_travel(HttpSession session, Model model) {
		H_TempPhotosVo tpVo = (H_TempPhotosVo)session.getAttribute("prev_tpVo");
		H_HomeVo hVo = (H_HomeVo)session.getAttribute("prev_hVo");
		H_TravelVo tVo = (H_TravelVo)session.getAttribute("prev_tVo");
		if (tpVo != null) {
			model.addAttribute("tpVo", tpVo);
			model.addAttribute("hVo", hVo);	
			model.addAttribute("tVo", tVo);			
		}
		return "/create/temp_h/h_travel";
	}
	
	// 미리보기 페이지(tempH) - Messages
	@RequestMapping(value = "/h_messages", method = RequestMethod.GET)
	public String h_messages(HttpSession session, Model model) {
		H_TempPhotosVo tpVo = (H_TempPhotosVo)session.getAttribute("prev_tpVo");
		H_HomeVo hVo = (H_HomeVo)session.getAttribute("prev_hVo");
		if (tpVo != null) {
			model.addAttribute("tpVo", tpVo);	
			model.addAttribute("hVo", hVo);
		}
		return "/create/temp_h/h_messages";
	}
}
