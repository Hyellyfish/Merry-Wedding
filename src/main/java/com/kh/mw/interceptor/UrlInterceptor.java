package com.kh.mw.interceptor;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;


public class UrlInterceptor extends HandlerInterceptorAdapter{
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
		String uri = request.getRequestURI(); // 입력한 url 알아내기
		int slashNum = uri.length() - uri.replace(String.valueOf("/"), "").length();
//		System.out.println("*Url인터셉터* slashNum: "+slashNum);
		int slashIndex = uri.lastIndexOf("/");
		String strUri = uri.substring(slashIndex+1); // url 키워드
//		System.out.println("*Url인터셉터* strUri: "+strUri);
		String queryString = request.getQueryString();
//		System.out.println("*Url인터셉터* queryString: " + queryString);
		String targetLoc = uri + "?" + queryString;
		if (queryString == null) {
			targetLoc = uri;
		}
		System.out.println("*Url인터셉터* targetLoc: " + targetLoc);
		session.setAttribute("targetLoc", targetLoc);
		if (slashNum == 2) { // home
			session.setAttribute("url_keyword", strUri);
			RequestDispatcher dispatcher = request.getRequestDispatcher("home");
			dispatcher.forward(request, response);
		} else if (slashNum == 3) { // ourstory, photos, ...
			// 슬래쉬 3개일 때, strUri가 키워드가 아닌 카테고리(ourstory, ...)로 저장된다
			// 각 index들을 구해 키워드를 찾고, strUri를 재설정한다
			List<Integer> indexList = new ArrayList<Integer> ();
			int index = uri.indexOf("/");
			while (index != -1) {
				indexList.add(index);
				index = uri.indexOf("/", index+1);
			}
//			System.out.println("*Url인터셉터* indexList: "+indexList);
			int startIndex = indexList.get(1);
			int endIndex = indexList.get(2);
			String keyword = uri.substring(startIndex+1, endIndex);
//			System.out.println("*Url인터셉터* keyword: " + keyword);
			session.setAttribute("url_keyword", keyword);
			return true;
		}
		return false;
//		return super.preHandle(request, response, handler);
	}
	
}
