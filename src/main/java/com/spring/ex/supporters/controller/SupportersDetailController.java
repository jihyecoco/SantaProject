package com.spring.ex.supporters.controller;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.spring.ex.supporters.model.SupportersBean;
import com.spring.ex.supporters.model.SupportersDao;

@Controller
public class SupportersDetailController {
	
	private final String command = "/supporters/user/detail.su";
	private final String getPage = "/supporters/supportersDetailView";

	@Autowired
	SupportersDao sdao;
	
	
	//1. boardList.jsp(글제목 클릭) -> detail.br 요청 -> boardDetailView.jsp로 이동
	@RequestMapping(value=command, method=RequestMethod.GET)
	public ModelAndView detail(@RequestParam("num") int num, 
			@RequestParam("pageNumber") int pageNumber, Principal principal) {
		
		ModelAndView mav = new ModelAndView();
		
		int cnt = sdao.updateSupoCount(num); //해당글 클릭하면 조회수 1 증가하도록
				
		SupportersBean supporters = sdao.getSupportersByNum(num);//넘어온 게시글번호에 해당하는 supporters 레코드 한줄 가져오기
		
		mav.addObject("supporters", supporters);
		mav.addObject("pageNumber",pageNumber);
		mav.addObject("userid", principal.getName());//로그인 아이디

		mav.setViewName(getPage);
		
		return mav;
	}
	
	
	
}
