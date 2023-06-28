package com.spring.ex.stamp.controller;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.spring.ex.stamp.model.StampBean;
import com.spring.ex.stamp.model.StampDao;
import com.spring.ex.users.model.UsersBean;
import com.spring.ex.users.model.UsersDao;

@Controller
public class StampUpdateApplyController {
	//요청 값을 담은 변수
		private final String command = "/stamp/admin/updateapply.stp";
		
		//redirect할 요청 변수
		private String gotoPage = "redirect:/stamp/admin/adminlist.stp";
		
		//qnaDao 객체 생성
		@Autowired
		StampDao sdao;
		@Autowired
		UsersDao udao;
		
		@RequestMapping(value=command)
		public ModelAndView doAction(
				@RequestParam(value="stampnum") String stampnum,
				@RequestParam(value="stampapply") String stampapply,
				@RequestParam(value="pageNumber", required = false) String pageNumber,
				HttpSession session, Principal principal, HttpServletRequest request
				) {
			
			System.out.println("넘어온 apply 값 : "+stampapply);
			
			ModelAndView mav = new ModelAndView();
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("stampnum", stampnum);
			map.put("stampapply", stampapply);
			
			if(principal.getName() == null) {
				//로그인 정보가 없으면
				//로그인 페이지로 넘어가서 다시 list.mnt 요청으로 돌아오도록 세션 설정
				session.setAttribute("destination", gotoPage);
				
				//다시 원래 페이지로 돌아가기 위해 페이지 정보 넘기기            
				mav.addObject("pageNumber",pageNumber);
				//로그인 페이지로 이동하도록 뷰 설정
				mav.setViewName("redirect:/loginForm");
			}else {
				//로그인 정보가 있으면
				int cnt = sdao.updateApply(map);
				if(cnt > 0) {
					System.out.println(stampapply+" : 업데이트 성공");
					
					List<StampBean> applyCount = sdao.getApplyCountGroupById();
					System.out.println("applyCount"+applyCount);
					
					if(!applyCount.isEmpty()) {
						for(int i=0;i<applyCount.size();i++) {
							//만약 현재 아이디의 apply갯수가 10 이상이면
							if(principal.getName() == applyCount.get(i).getUsersid() && applyCount.get(i).getApplycount() >=10 ) {
								UsersBean usersBean = new UsersBean();
								int cnt2 = udao.usersUpdateUserRole(usersBean);
							}
						}
					}
					
					
					//다시 원래 페이지로 돌아가기 위해 페이지 정보 넘기기
					mav.addObject("pageNumber",pageNumber);
					//목록으로 이동
					mav.setViewName(gotoPage);
				}else {
					System.out.println(stampapply+" : 업데이트 실패");
					

					//다시 원래 페이지로 돌아가기 위해 페이지 정보 넘기기
					mav.addObject("pageNumber",pageNumber);
					//목록으로 이동
					mav.setViewName(gotoPage);
				}
			}
			
			return mav;
		}
}
