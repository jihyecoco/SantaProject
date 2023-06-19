package com.spring.ex.crewboard.controller;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.spring.ex.crew.model.CrewBean;
import com.spring.ex.crew.model.CrewDao;
import com.spring.ex.crewboard.model.CrewBoardBean;
import com.spring.ex.crewboard.model.CrewBoardDao;


@Controller
public class CrewBoardDetailController { 
	
	//private final String command = "/detail.bdcr";
	
	private final String command = "/crewboard/user/detail.bdcr";
	private String getPage = "/crewboard/crewboardDetailView";
	
	@Autowired
	CrewBoardDao cbdao;
	
	@Autowired
	CrewDao cdao;
	
	//crewboardList.jsp(제목클릭)에서 요청(num, pageNumber) => crewboardDetailView.jsp
	@RequestMapping(value=command)
	public ModelAndView doAction(@RequestParam(value="num") int num, 
			@RequestParam(value="pageNumber", required=false) String pageNumber,
			@RequestParam(value="crewname", required=false) String crewname,
			Principal principal) {
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("pageNumber", pageNumber); // 페이지
		mav.addObject("loginId", principal.getName()); // 로그인 아이디
		
		String loginId = principal.getName();
		List<CrewBean> join_crew = cdao.getJoinCrewById(loginId);
		mav.addObject("join_crew", join_crew);
			
		CrewBoardBean cbb = cbdao.getCrewboardByNum(num);
		if(num == 0) { // 마이페이지에서 모집글 눌렀을때
			cbb = cbdao.getCrewboardByCrewname(crewname);
		}
		mav.addObject("cbb", cbb);
		mav.setViewName(getPage);
		
		return mav;
	}
	
}
