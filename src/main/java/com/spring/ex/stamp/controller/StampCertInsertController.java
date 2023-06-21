package com.spring.ex.stamp.controller;

import java.io.File;
import java.io.IOException;
import java.security.Principal;
import java.util.HashMap;
import java.util.Map;

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

import com.spring.ex.stamp.model.StampBean;
import com.spring.ex.stamp.model.StampDao;

@Controller
public class StampCertInsertController {

	//요청 값을 담은 변수
			private final String command = "/stamp/user/insert.stp";
			//이동할 jsp 페이지 변수
			private String getPage = "stamp/stampCertInsertForm";
			//redirect할 요청 변수
			private String gotoPage = "redirect:/stamp/user/list.stp";
			
			//MountainDao 객체 생성
			@Autowired
			StampDao sdao;
			
			//uploadPath를 가져오기 위한 ServletContext 객체 생성
			@Autowired
			ServletContext servletContext;
			
			//stamp 목록 => 완등인증 버튼 클릭 시
			@RequestMapping(value=command, method=RequestMethod.GET)
			public ModelAndView doAction(
					HttpSession session,Principal principal
					) {
				
				//로그인 정보 출력 테스트
				System.out.println("ID 정보 : "+principal.getName());

				//ModelAndView 객체 생성
				ModelAndView mav = new ModelAndView(); 
				
				if(principal.getName() == null) {
					//로그인 정보가 없으면
					//로그인 페이지로 넘어가서 다시 insert.qna 요청으로 돌아오도록 세션 설정
					session.setAttribute("destination","redirect:/stamp/user/list.stp");
					
					//로그인 페이지로 이동하도록 뷰 설정
					mav.setViewName("redirect:/loginForm");
				}else {
					//로그인 정보가 있으면

					//qna 작성 페이지로 이동
					mav.setViewName(getPage);
				}
				return mav;
			}
			
			//stampCertInsert에서 => 등록 버튼 클릭시
			@RequestMapping(value=command, method=RequestMethod.POST)
			public ModelAndView doAction(
					@RequestParam("mountainname") String mountainname,
					@ModelAttribute("stampBean") @Valid StampBean stampBean,
					BindingResult result, HttpServletRequest request,HttpSession session,
					Principal principal
					) {
				
				//ModelAndView 객체 생성
				ModelAndView mav = new ModelAndView(); 
				
				//현재 로그인된 아이디를 bean에 저장
				stampBean.setUsersid(principal.getName());
				
				String uploadPath = servletContext.getRealPath("/resources");
				System.out.println("uploadPath:"+uploadPath);
				//uploadPath:C:\\Users\\user\Downloads\spring-tool-suite-3.9.17.RELEASE\sts-bundle\pivotal-tc-server\instances\Spring3\wtpwebapps\20_Spring_MyBatis_Products\resources
				// C:\\Users~~~\resources\lemon.jpg
				
				System.out.println("*:"+uploadPath+File.separator+stampBean.getUpload().getOriginalFilename());
				
				
				File destination = new File(uploadPath+File.separator+stampBean.getUpload().getOriginalFilename());
				
				MultipartFile multi = stampBean.getUpload();
				
				if(result.hasErrors()) {
					//유효성 검사에 에러가 있으면
					System.out.println("유효성 검사 에러");
					
					//입력했던 정보가 남아있도록 Bean 정보 넘기기
					mav.addObject("mountainname",mountainname);
					//뷰 설정, 다시 mountainInsertForm으로 돌아감
					mav.setViewName(getPage);
				} else {
					//유효성 검사에 에러가 없으면
					System.out.println("유효성 검사 통과");
					
					int mountainnum = sdao.GetNumByName(mountainname);
					
					stampBean.setMountainnum(mountainnum);
					
					//결과를 cnt에 저장
					int cnt = sdao.insertStampCert(stampBean);
					
					if(cnt > 0) {
						//insert 성공 시
						System.out.println("insert성공");
						try {
							multi.transferTo(destination);
							
						} catch (IllegalStateException e) {
							e.printStackTrace();
						} catch (IOException e) {
							e.printStackTrace();
						}
						
						//뷰 설정, list.stp를 다시 요청
						mav.setViewName(gotoPage);
					} else {
						//insert 실패 시
						System.out.println("insert실패");
						mav.addObject("mountainname",mountainname);
						
						//뷰 설정, 다시 stmapCertInsertForm으로 돌아감
						mav.setViewName(getPage);
					}//if~else end
				}//if~else end
				    
				//mav 반환
				return mav;
			}
	
}
