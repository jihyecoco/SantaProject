package com.spring.ex.board.controller;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.spring.ex.board.model.BoardBean;
import com.spring.ex.board.model.BoardDao;


@Controller
public class BoardDetailController {
	
	private final String command = "/board/user/detail.br";
	private final String getPage = "/board/boardDetailView";
	
	@Autowired
	BoardDao bdao;
	
	
	//1. boardList.jsp(글제목 클릭) -> detail.br 요청 -> boardDetailView.jsp로 이동
	//2. boardDetailView.jsp에서 댓글등록 클릭시 insert.bcmt을 요청하면, 
	//BoardCommentsInsertController에서 redirect:/detail.br을 거쳐서 이곳으로 넘어옴(command객체, num, 페이지번호)
	@RequestMapping(value=command, method=RequestMethod.GET)
	public ModelAndView detail(@RequestParam("num") int num, 
			@RequestParam("pageNumber") int pageNumber, Principal principal) {
		
		ModelAndView mav = new ModelAndView();
		
		int cnt = bdao.updateCount(num); //해당글 클릭하면 조회수 1 증가하도록
				
		BoardBean board = bdao.getBoardByNum(num);//넘어온 게시글번호에 해당하는 board 레코드 한줄 가져오기
		
		mav.addObject("board", board);
		mav.addObject("pageNumber",pageNumber);
		mav.addObject("userid", principal.getName()); //로그인 아이디

		mav.setViewName(getPage);
		
		return mav;
	}
	
	
}
