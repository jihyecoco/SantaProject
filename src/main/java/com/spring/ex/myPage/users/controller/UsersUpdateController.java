package com.spring.ex.myPage.users.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.security.Principal;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.spring.ex.users.model.UsersBean;
import com.spring.ex.users.model.UsersDao;

/*
 로그인한 사용자가 회원정보관리-회원정보수정 클릭 -> 비밀번호를 확인하는 절차를 마친 후,
 회원정보 수정가능한 컨트롤러
*/

@Controller
public class UsersUpdateController {
	
	private final String command = "/users/user/usersUpdate.us";
	private String getPage 	= "/myPage/users/usersUpdate";	// 마이페이지 수정페이지
	private String gotoPage = "/myPage/users/myPage";		//	마이페이지 홈
	
	@Autowired
	UsersDao udao;
	
	@Autowired
	ServletContext servletContext;
	
	//마이페이지에서 '마이페이지 수정' 클릭 -> 현재 저장된 사용자 정보 띄우기
	@RequestMapping(value = command, method = RequestMethod.GET)
	public ModelAndView usersUpdate(Principal principal) {
		ModelAndView mav = new ModelAndView();
		String getUserId = principal.getName();
		System.out.println("myPage getUserId : " + getUserId);
		UsersBean usersBean = udao.getUsersByUserId(getUserId);
		mav.addObject("usersBean", usersBean);
		mav.setViewName(getPage);
		return mav;
	}//usersUpdate - 로그인한 사용자의 정보띄우기
	
	
	//수정
	@RequestMapping(value = command, method = RequestMethod.POST)
	public ModelAndView usersUpdate(@ModelAttribute("UsersBean") @Valid UsersBean usersBean,
			BindingResult result, 
			HttpServletRequest request, 
			HttpServletResponse response) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		//=>이미지를 선택하지않고 새로고침하면, 이미지가 날아가는 문제를 해결하기위해 기존의 이미지를 지정.
		if(usersBean.getImage().equals("")) { 
			//upload2 : 기존이미지
			usersBean.setImage(usersBean.getUpload2());
		} 
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		//유효성 검사 통과X
		if(result.hasErrors()) { 
			mav.setViewName(getPage);
		}
		else {
			//유효성 검사 통과O
			String filePath = servletContext.getRealPath("/resources");
			//삭제하려는 이미지(기존 이미지)
			File deleteImage = new File(filePath +File.separator+usersBean.getUpload2()); 
			//수정하려는(업로드할) 이미지
			File destination = new File(filePath + File.separator + usersBean.getUpload().getOriginalFilename()); 
			
			int cnt = udao.usersUpdate(usersBean);
			
			if(cnt > -1) {  
				//기존 이미지 삭제
				boolean flag = deleteImage.delete();
				
				MultipartFile multi = usersBean.getUpload();
				try {
					//업로드
					multi.transferTo(destination); 
					
				} catch (IllegalStateException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}
				
				out.println("<script>alert('회원정보가 수정되었습니다.');</script>");
				mav.setViewName(gotoPage); 	// /myPage/users/myPage
			}else { 
				out.println("<script>alert('회원정보 수정에 실패했습니다.');</script>");
				mav.setViewName(getPage);	// /myPage/users/usersUpdate
			}			
		}		
		out.flush();
		mav.addObject("usersBean", usersBean);
		return mav;	
	}//usersUpdate - 로그인한 사용자의 정보띄우기
	
}//UsersUpdateController
