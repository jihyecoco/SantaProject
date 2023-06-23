package com.spring.ex.stamp.controller;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.spring.ex.stamp.model.CertBean;
import com.spring.ex.stamp.model.StampBean;
import com.spring.ex.stamp.model.StampDao;

@Controller
public class StampUserListController {
	
		//요청 값을 담은 변수
		private final static String command = "/stamp/user/list.stp";
		//이동할 jsp 페이지 변수
		private String getPage = "/stamp/stampUserList";
		
		@Autowired
		StampDao sdao;
		
			//마이페이지에서 완등내역 클릭 시 요청 발생=>stampList.jsp로 이동
			@RequestMapping(value=command)
			public ModelAndView doAction(
					Principal principal
					) {
				System.out.println("StampUserListController()");
				//ModelAndView 객체 생성
				ModelAndView mav = new ModelAndView();
				
				//현재 로그인된 아이디를 변수에 저장
				String userid = principal.getName();
				System.out.println("userid : "+userid);
				
				//현재 로그인된 아이디로 stamp 목록 불러옴
				List<StampBean> stampList = sdao.getAllStampById(userid);
				System.out.println("stampList:"+stampList);
				
				//userid를 이용해서 등급 불러오기
				String userRole = sdao.getUserRoleById(userid);
				System.out.println("userRole : "+userRole);
				
				//userid를 이용해서 등급 불러오기
				List<CertBean> certList = sdao.getCertListById(userid);
				
				//*null인 컬럼은 일단 조회되지 않음.
				//필요 시 api성공 여부에 따라 mountain_num = null인 컬럼 해결하기
//				for(int i=0;i<stampList.size();i++) {
//					if(stampList.get(i).getMountainnum() == 0) {
//						
//					}
//				}
				
				//mav에 저장해서 넘길 값 설정
				mav.addObject("stampList", stampList); // 현재 유저의 스탬프 테이블
				mav.addObject("certList", certList); //현재 유저의 인증 신청 목록(산 이름, 인증 사진, 인증 상태)
				mav.addObject("userRole", userRole); //현재 유저의 등급
				mav.addObject("principal", principal); //현재 로그인 정보
				
				//뷰 설정
				mav.setViewName(getPage);
				
				//mav 반환, mountainList.jsp로 이동
				return mav;
			}//doAction end
	
}
