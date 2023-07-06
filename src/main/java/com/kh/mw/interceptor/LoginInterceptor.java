package com.kh.mw.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.kh.mw.vo.UserVo;

public class LoginInterceptor extends HandlerInterceptorAdapter{
	
	@Override
	public boolean preHandle(HttpServletRequest request, 
			HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
		UserVo userVo = (UserVo)session.getAttribute("loginInfo");
		// 로그인 되어있지 않다면
		if (userVo == null) {
			String uri = request.getRequestURI();
//			System.out.println("*Login인터셉터* uri: " + uri);
			String queryString = request.getQueryString();
//			System.out.println("*Login인터셉터* queryString: " + queryString);
			String targetLocation = uri + "?" + queryString;
			if (queryString == null) {
				targetLocation = uri;
			}
			if (targetLocation.equals("/planner/saveCheck")) {
				targetLocation = "/planner/checklist";
			}
			System.out.println("*Login인터셉터* targetLocation: " + targetLocation);			
			session.setAttribute("targetLocation", targetLocation);
			response.sendRedirect("/main/login");
			return false;
		} 
		return true;
	}
	
}
