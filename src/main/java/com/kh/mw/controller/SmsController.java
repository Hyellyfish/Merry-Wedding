package com.kh.mw.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.mw.service.HService;
import com.kh.mw.service.SmsService;
import com.kh.mw.vo.H_HomeVo;
import com.kh.mw.vo.UserVo;

import net.nurigo.java_sdk.exceptions.CoolsmsException;

@Controller
@RequestMapping("/sms/*")
public class SmsController {
	
	@Autowired
	private SmsService smsService;
	
	@Autowired
	private HService hService;
	
	@RequestMapping(value = "/send", method = RequestMethod.POST)
	@ResponseBody
	public String sendMessage(@RequestParam(value="arr_g_no[]") String[] arr_g_no, String userid, 
			HttpSession session) throws CoolsmsException {	// 15번 가능 -> 14
		System.out.println(arr_g_no);
		UserVo uVo = (UserVo)session.getAttribute("loginInfo");
		H_HomeVo vo = hService.getHvo(userid);
		
		String phonenumber = String.join(",", arr_g_no);
		String to = phonenumber.replaceAll("-", "");
		String web_addr = "192.168.219.118/url/"+uVo.getUrl();
		
		System.out.println(vo);
		String groomNm = vo.getH_gname();
		String brideNm = vo.getH_bname();
		String webdate = vo.getH_weddate();
		String webtime = "";
		String webaddr = vo.getH_wedloc();
		
		String text = "저희 결혼합니다♥\n" + groomNm + "♥" + brideNm + 
						" 결혼식에 초대합니다.\n" + "일시 : " + webdate + webtime + 
						"\n장소 : " + webaddr +"\n청첩장 : " + web_addr;
		System.out.println(text);
//		System.out.println("newlen : " + newlen);
		
//		010-2222-2222
//		010-4445-6564 -> - 제거하고 ,로 붙여서 from으로 smsService에 넘기기
		
//		String to = "01066483012";
		smsService.certifiedPhoneNumber(to, text);		
		return null;
//		return "success";
	}
	
}
