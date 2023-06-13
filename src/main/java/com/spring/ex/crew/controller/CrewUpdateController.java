package com.spring.ex.crew.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.spring.ex.crew.model.CrewBean;
import com.spring.ex.crew.model.CrewDao;
import com.spring.ex.crewboard.model.CrewBoardBean;
import com.spring.ex.crewboard.model.CrewBoardDao;


//1.crewboardList.jsp(신청하기)클릭시 요청
//2.crewboardDetailView.jsp(신청하기)클릭시 요청
@Controller
public class CrewUpdateController {
	
	//private final String command = "/update.cr";
	private final String command = "/crew/user/update.cr";
	private String getPage = "";
	private String gotoPage = "redirect:/crewboard/all/list.bdcr";
	
	@Autowired
	CrewDao cdao;
	@Autowired
	CrewBoardDao cbdao;
	
	@RequestMapping(value=command)
	public ModelAndView doAction(@RequestParam("crewname") String crewname) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName(gotoPage);
		//1.비회원 일때(로그인 페이지로)
		
		//2.회원일때(정기크루일때 : 이미 가입한 정기크루가 있으면 가입안됨)
		//크루이름과 본인아이디 가져가야함.(CrewBean에 담아감 crewname, crewmember)
		CrewBean cb = new CrewBean();
		cb.setCrewname(crewname);
		cb.setCrewmember(",test_crewmember"); // ,를 같이 붙여서 넣어주기
		
		int cnt = cdao.updateCrew(cb);
		if(cnt != -1) {// 가입성공
			// 1. 정원이 다 찼으면 모집완료로 바꾸기
			CrewBoardBean cbb = cbdao.getCrewboardByCrewname(crewname);
			if(cbb.getCrewnow()==cbb.getCrewlimit()) { //정원이 다 찼으면
				int result = cbdao.updateCrewboardState(crewname);
				if(result != -1) {
					System.out.println("모집완료 수정 성공");
				}else {
					System.out.println("모집완료 수정 실패");
				}
			}
			// 2. 마이페이지 크루가입 내역으로 가기
			
		}else { //가입실패
			//원래의 페이지로 돌아가기
		}
	
		return mav;
	}

}
