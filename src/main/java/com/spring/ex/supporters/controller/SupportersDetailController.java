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
import com.spring.ex.users.model.UsersBean;
import com.spring.ex.users.model.UsersDao;

@Controller
public class SupportersDetailController {
	
	private final String command = "/supporters/user/detail.su";
	private final String getPage = "/supporters/supportersDetailView";

	@Autowired
	SupportersDao sdao;

	@Autowired
	UsersDao udao;
	
	
	//1. boardList.jsp(글제목 클릭) -> detail.br 요청 -> boardDetailView.jsp로 이동
	//2. 수정하면 UpdateController을 거쳐 이곳으로 온다.
	//3. 마이페이지에서 서포터즈명을 클릭하면 이곳으로 이동한다
	@RequestMapping(value=command, method=RequestMethod.GET)
	public ModelAndView detail(@RequestParam("num") int num, 
			@RequestParam(value="pageNumber",required = false) Integer pageNumber,  
			Principal principal) {		
			//마이페이지에서 이동할때 pageNumber가 안넘어오므로 required = false 처리하고 타입을 int에서 Integer로 수정해야한다!!
		
		ModelAndView mav = new ModelAndView();
		
		int cnt = sdao.updateSupoCount(num); //글 클릭하면 조회수 1 증가하도록
				
		SupportersBean supporters = sdao.getSupportersByNum(num);//넘어온 게시글번호에 해당하는 supporters 레코드 한줄 가져오기
	
		UsersBean user = udao.getInfo(principal.getName());
		//getInfo() : 로그인한 사용자의 정보를 가져오는 메서드
		//로그인한 회원의 아이디를 이용해 로그인한 회원의 정보를 가져와서 user 변수에 저장
		System.out.println("user.getUserRole(): "+user.getUserRole());
				
		mav.addObject("supporters", supporters);
		mav.addObject("pageNumber",pageNumber);
		mav.addObject("loginId", principal.getName()); //로그인한 회원의 아이디
		mav.addObject("userRole", user.getUserRole()); //로그인한 회원의 등급
		
		mav.setViewName(getPage);
		
		return mav;
	}
	
	//apply_check.su
	
	
	
}
