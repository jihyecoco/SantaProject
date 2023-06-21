package com.spring.ex.admin.admin.controller;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.spring.ex.users.model.UsersBean;
import com.spring.ex.users.model.UsersDao;

@Controller
public class AdminInsertController {
	
	private final String command = "/admin/admin/adminInsertForm.us";
	private String getPage = "/admin/admin/adminInsertForm";
	private String gotoPage = "redirect:/admin/admin/adminList.us";
	
	@Autowired
	UsersDao udao;
	
	//관리자페이지 common_nav_admin에서 [관리자 관리-관리자 등록] 버튼 클릭
	@RequestMapping(value = command, method = RequestMethod.GET)
	public ModelAndView signUp() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName(getPage);// /admin/admin/adminInsertForm
		return mav;
	}//signUp - 화면 띄우기
	
	//adminInsertForm.jsp(status,userRole,udate,image를 제외한 모든 UsersBean) -> submit 요청
	@RequestMapping(value = command, method = RequestMethod.POST)
	public ModelAndView signUp(@ModelAttribute("usersBean") @Valid UsersBean usersBean, 
			BindingResult result) {
		
		ModelAndView mav = new ModelAndView();
		try {
			//유효성검사 통과X
			if(result.hasErrors()) {
				mav.setViewName(getPage);// /admin/admin/adminInsertForm
			}else {
			//유효성검사 통과O	
				int cnt = udao.adminInsert(usersBean);
				System.out.println("cnt : " + cnt);
				if(cnt == 1) {
					//회원가입 성공
					mav.setViewName(gotoPage);// redirect:/admin/admin/adminList.us
					
				}else if(cnt != 1){
					//회원가입 실패
					mav.setViewName(getPage);// /admin/admin/adminInsertForm
					
				}
				
			}//else
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return mav;
	}//signUp - submit 클릭
	
}//AdminInsertController
