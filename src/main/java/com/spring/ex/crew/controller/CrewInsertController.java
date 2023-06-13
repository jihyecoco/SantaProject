package com.spring.ex.crew.controller;

import java.security.Principal;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.spring.ex.crew.model.CrewBean;
import com.spring.ex.crew.model.CrewDao;

@Controller
public class CrewInsertController {
	//private final String command = "/insert.cr";
	private final String command = "/crew/user/insert.cr";
	private String getPage = "/crew/crewInsertForm";
	private String gotoPage = "redirect:/crewboard/all/list.bdcr"; //list없어서 안나오는 상태
	
	@Autowired
	CrewDao cdao;
	
	//메뉴에서 크루신청 클릭시 -> crewInsertForm.jsp로감
	@RequestMapping(value=command, method=RequestMethod.GET)
	public ModelAndView doAction(Principal principal) {
		
		ModelAndView mav = new ModelAndView();
		//1. 비회원일때
		
		//2. 회원일때
		String loginId = principal.getName();
		mav.addObject("loginId", loginId);
		mav.setViewName(getPage);
		return mav;
	}
	
	//crewInsertForm.jsp(등록하기 클릭) -> list.bdcr 요청
	@RequestMapping(value=command, method=RequestMethod.POST)
	public ModelAndView doAction(@ModelAttribute("cb") @Valid CrewBean cb,
			BindingResult result,
			Principal principal) {
		
		ModelAndView mav = new ModelAndView();
		String loginId = principal.getName();
		mav.addObject("loginId", loginId);
		
		if(result.hasErrors()) { //유효성 검사 에러일때
			mav.setViewName(getPage);
		}else {
			int cnt = -1;
			cnt = cdao.insertCrew(cb);
			if(cnt != -1) {
				//크루 모집게시판으로 감
				mav.setViewName(gotoPage);
			}else {
				mav.setViewName(getPage);
			}
		}
		return mav;
	}
}
