package com.spring.ex.supporters.controller;

import java.io.File;
import java.io.IOException;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;


import com.spring.ex.supporters.model.SupportersBean;
import com.spring.ex.supporters.model.SupportersDao;

@Controller
public class SupportersUpdateController {
	
	private final String command = "/supporters/admin/update.su";
	private final String getPage = "/supporters/supportersUpdateForm";
	private final String gotoPage = "redirect:/supporters/all/list.su";
	
	@Autowired
	SupportersDao sdao;
	
	
	//supportersDetailView.jsp(수정 버튼 클릭) -> update.su 요청(get방식) -> supportersUpdateForm.jsp로 이동
	@RequestMapping(value=command, method = RequestMethod.GET)
	public String update(@RequestParam("num") int num, Model model,
			@RequestParam("pageNumber") int pageNumber) {

		System.out.println("수정 서포터즈 num: "+num);

		SupportersBean supporters = sdao.getSupportersByNum(num);

		model.addAttribute("supporters", supporters);
		model.addAttribute("pageNumber",pageNumber);

		return getPage;
	}
	
	
	//supportersUpdateForm.jsp(수정 버튼 클릭) -> detail.su 요청(post방식) -> 수정 성공하면 -> list.br 재요청
	@RequestMapping(value=command, method = RequestMethod.POST)
	public ModelAndView update(@RequestParam("pageNumber") int pageNumber,
			@ModelAttribute("supporters") @Valid SupportersBean supporters, BindingResult result) {

		ModelAndView mav = new ModelAndView();
		mav.addObject("pageNumber", pageNumber);

		System.out.println("result.hasErrors(): "+result.hasErrors());
		if(result.hasErrors()) { //에러 있음
			mav.setViewName(getPage);
		}
		else {//에러 없음
			int cnt = sdao.updateSupporter(supporters);
			System.out.println("수정 cnt: "+ cnt);

			if(cnt > -1) {  // DB 테이블에서 수정 성공
				mav.setViewName(gotoPage);
			}else { //수정 실패
				mav.setViewName(getPage);
			}			
		}		
		return mav;	
	}//
	
	
}
