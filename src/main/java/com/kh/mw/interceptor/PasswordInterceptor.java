package com.kh.mw.interceptor;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class PasswordInterceptor extends HandlerInterceptorAdapter{
	
	@Override
	public boolean preHandle(HttpServletRequest request, 
			HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
		String uri = request.getRequestURI();
		String queryString = request.getQueryString();
		String pw_targetLocation = uri + "?" + queryString;
		if (queryString == null) {
			pw_targetLocation = uri;
		}
//		System.out.println("*Password인터셉터* targetLocation: " + pw_targetLocation);			
		switch (pw_targetLocation) {
			case "/user/edit":
				pw_targetLocation = "/user/edit_form";
				break;
			case "/user/delete_user":
				pw_targetLocation = "/user/delete_run";
				break;
		}
		session.setAttribute("pw_targetLocation", pw_targetLocation);
		response.sendRedirect("/user/input_password");
		return false;
	}
	
}
