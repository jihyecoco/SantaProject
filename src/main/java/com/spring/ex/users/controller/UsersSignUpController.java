package com.spring.ex.users.controller;

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

/* 회원가입 컨트롤러 */
@Controller
public class UsersSignUpController {

	private final String command = "/login/all/signUp.lg";
	private String getPage = "/users/signUpPage";
	private String gotoPage = "/login/loginPage";
	
	@Autowired
	UsersDao udao;
	
	//loginPage에서 회원가입 버튼 클릭
	@RequestMapping(value = command, method = RequestMethod.GET)
	public ModelAndView signUp() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName(getPage);// /users/signUpPage
		return mav;
	}//signUp - 화면 띄우기
	
	//signUpPage.jsp(status,userRole,udate,image를 제외한 모든 UsersBean) -> submit 요청
	@RequestMapping(value = command, method = RequestMethod.POST)
	public ModelAndView signUp(@ModelAttribute("usersBean") @Valid UsersBean usersBean, 
			BindingResult result) {
		
		ModelAndView mav = new ModelAndView();
		
		//유효성검사 통과X
		if(result.hasErrors()) {
			mav.setViewName(getPage);// /users/signUpPage
			
		}else {
		//유효성검사 통과O	
			int cnt = udao.signUp(usersBean);
			System.out.println("cnt : " + cnt);
			if(cnt == 1) {
				//회원가입 성공
				mav.setViewName(gotoPage);// /login/loginPage
				
			}else if(cnt != 1){
				//회원가입 실패
				mav.setViewName(getPage);// /users/signUpPage
				
			}
			
		}//else
		
		return mav;
	}//signUp - submit 클릭
	
}//UsersSignUpController
