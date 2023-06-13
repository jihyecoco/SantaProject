package com.spring.ex.qna.controller;


import java.io.File;
import java.io.IOException;
import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.spring.ex.qna.model.QnaBean;
import com.spring.ex.qna.model.QnaDao;

@Controller
public class QnaInsertQuestionController {
	
	//요청 값을 담은 변수
	private final String command = "/qna/user/insertQuestion.qna";
	//이동할 jsp 페이지 변수
	private String getPage = "/qna/qnaInsertQuestionForm";
	//redirect할 요청 변수
	private String gotoPage = "redirect:/qna/all/list.qna";
	
	//qnaDao 객체 생성
	@Autowired
	QnaDao qdao;
	
	//uploadPath를 가져오기 위한 ServletContext 객체 생성
	@Autowired
	ServletContext servletContext;
	
	//qna 목록 => 질문하기 버튼 클릭 시
	@RequestMapping(value=command, method=RequestMethod.GET)
	public ModelAndView doAction(
			HttpSession session,
			Principal principal
			) {
		
		//로그인 정보 출력 테스트
		//System.out.println("ID 정보 : "+principal.getName());

		//ModelAndView 객체 생성
		ModelAndView mav = new ModelAndView(); 
		
		if(principal.getName() == null) {
			//로그인 정보가 없으면
			//로그인 페이지로 넘어가서 다시 insert.qna 요청으로 돌아오도록 세션 설정
			session.setAttribute("destination","redirect:/insertq.qna");
			//로그인 페이지로 이동하도록 뷰 설정
			mav.setViewName("redirect:/loginForm");
		}else {
			//로그인 정보가 있으면
			//qna 작성 페이지로 이동
			mav.setViewName(getPage);
		}
		return mav;
	}
	
	//qnaInsertQForm에서 => 질문등록 버튼 클릭시
	@RequestMapping(value=command, method=RequestMethod.POST)
	public ModelAndView doAction(
			@ModelAttribute("qnaBean") @Valid QnaBean qnaBean,
			BindingResult result, HttpSession session,
			Principal principal
			) {
		
		//ModelAndView 객체 생성
		ModelAndView mav = new ModelAndView(); 

		if(result.hasErrors()) {
			//유효성 검사에 에러가 있으면
			//뷰 설정, 다시 qnaInsertQForm으로 돌아감
			mav.setViewName(getPage);
		} else {
			//유효성 검사에 에러가 없으면
			
			//이미지 파일이 올라갈 경로 변수에 저장, 테스트 출력
			String uploadPath = servletContext.getRealPath("/resources");
			System.out.println("uploadPath:"+uploadPath);
			
			//업로드 경로에 저장된 원본 파일 이름 File 객체 변수에 저장, 테스트 출력
			File destination = new File(uploadPath+File.separator+"uploadFiles");
			System.out.println("destination:"+uploadPath+File.separator+"uploadFiles");
			
			//폴더가 없으면 폴더 생성
			if(!destination.exists()) destination.mkdir();
			
			//원래 코드
			//업로드한 파일의 정보를 담는 MultipartFile 객체 생성
			//List<MultipartFile> multi = qnaBean.getUpload();
			
			//수정 코드
			//map 타입의 변수를 담는 List 객체 생성
			List<Map<String,String>> fileList = new ArrayList<Map<String,String>>();
			
			//bean에 저장된 배열의 사이즈만큼 반복
			for(int i = 0; i<qnaBean.getUpload().size(); i++) {
				//i번째 원래 파일 이름을 담는 변수 정의
				String originFile = qnaBean.getUpload().get(i).getOriginalFilename();
				//마지막 "."을 기준으로 이름을 분할하는 변수 정의(확장자)
				String ext = originFile.substring(originFile.lastIndexOf("."));
				//랜덤한 uuid를 부여해 문자열로 바꾼 변수 정의
				String changeFile = UUID.randomUUID().toString()+ext;
				
				//원본 파일명과 uuid로 다시 정의된 파일명을 map으로 저장
				Map<String, String> map = new HashMap<>();
				map.put("originFile", originFile);
				map.put("changeFile", changeFile);
				
				//저장한 map을 아까 만든 list 변수에 저장
				fileList.add(map);
			}//for end
		
			//현재 로그인한 아이디를 Bean에 저장
			qnaBean.setUsersid(principal.getName());
			
			//qdao의 insertQ 메서드 결과를 cnt에 저장
			int cnt = qdao.insertQuestion(qnaBean);
			
			if(cnt > 0) {
				//insert 성공 시
				
				//Byte형태의 데이터를 i만큼 반복해서
				//File객체에 설정한 파일 경로에 전송
				try {
					for(int i = 0; i<qnaBean.getUpload().size(); i++) {
						qnaBean.setUpload2(new File(destination+File.separator+fileList.get(i).get("chageFile")));
						qnaBean.getUpload().get(i).transferTo(qnaBean.getUpload2());
					
						System.out.println("다중 파일 업로드 성공");
					}//for end
				} catch(IllegalStateException | IOException e) {
					System.out.println("다중 파일 업로드 실패");
					
					//업로드 실패 시 i만큼 반복해서 파일 삭제
					for(int i = 0; i<qnaBean.getUpload().size(); i++) {
						new File(destination+File.separator+fileList.get(i).get("chageFile")).delete();
					}//for end
					e.printStackTrace();
				}//try~catch end
				
				//뷰 설정, list.qna를 다시 요청
				mav.setViewName(gotoPage);
			} else {
				//insert 실패 시
				
				//뷰 설정, 다시 qnaInsertQForm으로 돌아감
				mav.setViewName(getPage);
				
			}//if~else end
		}//if~else end
		    
		//mav 반환
		return mav;
	}
	
}
