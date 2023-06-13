package com.spring.ex.crewboard.controller;

import java.security.Principal;
import java.util.List;

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
import com.spring.ex.crewboard.model.CrewBoardBean;
import com.spring.ex.crewboard.model.CrewBoardDao;

@Controller
public class CrewBoardInsertController {
	
	//private final String command = "/insert.bdcr";
	private final String command = "/crewboard/user/insert.bdcr";
	private String getPage ="/crewboard/crewboardInsertForm";
	private String gotoPage = "redirect:/crewboard/all/list.bdcr";
	
	@Autowired
	CrewDao cdao;
	
	@Autowired
	CrewBoardDao cbdao;
	
	//crewboardList.jsp에서 요청(글쓰기 버튼클릭) -> crewboardInsertForm.jsp
	@RequestMapping(value=command, method=RequestMethod.GET)
	public ModelAndView doAction(Principal principal) {
		
		ModelAndView mav = new ModelAndView();
		//1. 비회원 일때 (로그인 페이지로 가야함)
		
		//2. 회원 일때
		//내가 만든 크루 정보(로그인한 아이디로) 가져가야한다.
		String getUserId = principal.getName(); 
		List<CrewBean> myCrew = cdao.getCrewById(getUserId);
		
		
		mav.addObject("getUserId", getUserId);
		mav.addObject("myCrew", myCrew);
		mav.setViewName(getPage);
		
		//2-1. 만든크루가 없을때(크루 등록페이지로 가야함)
		//2-2. 이미 크루모집 게시글을 등록했을때(내가 쓴 게시글로)
		
		return mav;
	}
	
	//crewboardInsertForm.jsp(등록버튼) -> 크루모집 게시판 등록
	@RequestMapping(value=command, method=RequestMethod.POST)
	public ModelAndView doAction2(
			@ModelAttribute("cbb") @Valid CrewBoardBean cbb
			,BindingResult result, Principal principal) {
		
		ModelAndView mav = new ModelAndView();
		String getUserId = principal.getName();			
		// Principal은 자바의 표준 시큐리티 기술로, 로그인이 된 상태라면 계정 정보를 담고있다.
		//내가 만든 크루 정보(로그인한 아이디로) 가져가야한다.
		
		List<CrewBean> myCrew = cdao.getCrewById(getUserId);
		mav.addObject("myCrew", myCrew);
		
		if(result.hasErrors()) {
			//System.out.println("에러 발생");
			
			mav.setViewName(getPage);
		}else {
			int cnt = -1;
			cnt = cbdao.insertCrewboard(cbb);
			if(cnt != -1) { //등록 성공
				mav.setViewName(gotoPage);
			}else {//등록 실패
				mav.setViewName(getPage);
			}
		}
		return mav;
	}
}
