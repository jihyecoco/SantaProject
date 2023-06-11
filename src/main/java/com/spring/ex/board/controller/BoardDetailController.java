package com.spring.ex.board.controller;

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
	
	
	//boardList.jsp(글제목 클릭) -> detail.br 요청 -> boardDetailView.jsp로 이동
	@RequestMapping(value=command, method=RequestMethod.GET)
	public ModelAndView detail(@RequestParam("num") int num, 
			@RequestParam("pageNumber") int pageNumber, Model model) {
		
		ModelAndView mav = new ModelAndView();
		int cnt = bdao.updateCount(num); //글 클릭하면 조회수 1 증가하도록
				
		BoardBean board = bdao.getBoardByNum(num);
		mav.addObject("board", board);
		mav.addObject("pageNumber",pageNumber);

		mav.setViewName(getPage);
		
		return mav;
	}
	
	
}
