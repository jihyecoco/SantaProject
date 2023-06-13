package com.spring.ex.qna.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class QnaInsertAnswerController {
	
	//요청 값을 담은 변수
	private final String command = "/qna/admin/inserta.qna";
	//이동할 jsp 페이지 변수
	private String getPage = "/qna/qnaInsertAForm";
	//redirect할 요청 변수
	private String gotoPage = "redirect:/qna/list.qna";
	
	@RequestMapping(value=command, method=RequestMethod.GET)
	public ModelAndView doAction(HttpSession session) {
		
		//로그인 정보 출력 테스트
		System.out.println(session.getAttribute("loginInfo"));

		//ModelAndView 객체 생성
		ModelAndView mav = new ModelAndView(); 
		
		if(session.getAttribute("loginInfo")==null) {
			//로그인 정보가 없으면
			//로그인 페이지로 넘어가서 다시 insert.qna 요청으로 돌아오도록 세션 설정
			session.setAttribute("destination","redirect:/inserta.qna");
			//로그인 페이지로 이동하도록 뷰 설정
			mav.setViewName("redirect:/login/loginPage.lg");
		}else {
			//로그인 정보가 있으면
			//qna 작성 페이지로 이동
			mav.setViewName(getPage);
		}
		return mav;
	}
	
}
