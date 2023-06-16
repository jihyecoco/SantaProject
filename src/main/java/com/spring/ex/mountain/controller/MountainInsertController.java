package com.spring.ex.mountain.controller;

import java.io.File;
import java.io.IOException;
import java.security.Principal;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.spring.ex.mountain.model.MountainBean;
import com.spring.ex.mountain.model.MountainDao;

@Controller
public class MountainInsertController {

		//요청 값을 담은 변수
		private final String command = "/mountain/admin/insert.mnt";
		//이동할 jsp 페이지 변수
		private String getPage = "mountain/mountainInsertForm";
		//redirect할 요청 변수
		private String gotoPage = "redirect:/mountain/all/list.mnt";
		
		//MountainDao 객체 생성
		@Autowired
		MountainDao mdao;
		
		//uploadPath를 가져오기 위한 ServletContext 객체 생성
		@Autowired
		ServletContext servletContext;
		
		//mountain 목록 => 질문하기 버튼 클릭 시
		@RequestMapping(value=command, method=RequestMethod.GET)
		public ModelAndView doAction(
				@RequestParam(value="pageNumber", required = false) String pageNumber,
				HttpSession session,Principal principal
				) {
			
			//로그인 정보 출력 테스트
			System.out.println("ID 정보 : "+principal.getName());

			//ModelAndView 객체 생성
			ModelAndView mav = new ModelAndView(); 
			
			if(principal.getName() == null) {
				//로그인 정보가 없으면
				//로그인 페이지로 넘어가서 다시 insert.qna 요청으로 돌아오도록 세션 설정
				session.setAttribute("destination","redirect:/mountain/admin/insert.mnt");
				
				//다시 원래 페이지로 돌아가기 위해 페이지 정보 넘기기
				mav.addObject("pageNumber",pageNumber);
				//로그인 페이지로 이동하도록 뷰 설정
				mav.setViewName("redirect:/loginForm");
			}else {
				//로그인 정보가 있으면

				//다시 원래 페이지로 돌아가기 위해 페이지 정보 넘기기
				mav.addObject("pageNumber",pageNumber);
				//qna 작성 페이지로 이동
				mav.setViewName(getPage);
			}
			return mav;
		}
		
		//mountainInsert에서 => 등록 버튼 클릭시
		@RequestMapping(value=command, method=RequestMethod.POST)
		public ModelAndView doAction(
				@RequestParam(value="pageNumber", required = false) String pageNumber,
				@ModelAttribute("mountainBean") @Valid MountainBean mountainBean,
				BindingResult result, HttpServletRequest request,HttpSession session,
				Principal principal
				) {
			
			//ModelAndView 객체 생성
			ModelAndView mav = new ModelAndView(); 
			
			String uploadPath = servletContext.getRealPath("/resources");
			System.out.println("uploadPath:"+uploadPath);
			//uploadPath:C:\\Users\\user\Downloads\spring-tool-suite-3.9.17.RELEASE\sts-bundle\pivotal-tc-server\instances\Spring3\wtpwebapps\20_Spring_MyBatis_Products\resources
			// C:\\Users~~~\resources\lemon.jpg
			
			System.out.println("*:"+uploadPath+File.separator+mountainBean.getUpload().getOriginalFilename());
			
			
			File destination = new File(uploadPath+File.separator+mountainBean.getUpload().getOriginalFilename());
			
			MultipartFile multi = mountainBean.getUpload();
			
			if(result.hasErrors()) {
				//유효성 검사에 에러가 있으면
				System.out.println("유효성 검사 에러");
				
				//입력했던 정보가 남아있도록 Bean 정보 넘기기
				mav.addObject("mountainBean",mountainBean);
				//뷰 설정, 다시 mountainInsertForm으로 돌아감
				mav.setViewName(getPage);
			} else {
				//유효성 검사에 에러가 없으면
				System.out.println("유효성 검사 통과");
				
				//mdao의 insertMountain 메서드 결과를 cnt에 저장
				int cnt = mdao.insertMountain(mountainBean);
				
				if(cnt > 0) {
					//insert 성공 시
					
					try {
						multi.transferTo(destination);
						
					} catch (IllegalStateException e) {
						e.printStackTrace();
					} catch (IOException e) {
						e.printStackTrace();
					}
					
					//다시 목록으로 가기 위해 정보 넘기기
					mav.addObject("pageNumber",pageNumber);				
					//뷰 설정, list.mnt를 다시 요청
					mav.setViewName(gotoPage);
				} else {
					//insert 실패 시

					//다시 원래 페이지로 돌아가기 위해 정보 넘기기
					mav.addObject("pageNumber",pageNumber);				
					mav.addObject("mountainBean",mountainBean);
					
					//뷰 설정, 다시 mountainInsertForm으로 돌아감
					mav.setViewName(getPage);
				}//if~else end
			}//if~else end
			    
			//mav 반환
			return mav;
		}
	
}
