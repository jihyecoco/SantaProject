package com.spring.ex.boardcomments.controller;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.spring.ex.boardcomments.model.BoardCommentsBean;
import com.spring.ex.boardcomments.model.BoardCommentsDao;



@Controller
public class BoardCommentsInsertController {
	
	private final String command = "/boardcomments/user/insert.bcmt";
	//private String gotoPage = "redirect:/board/user/list.bcmt";
	private String gotoPage = "redirect:/board/user/detail.br";
	private String getPage = "/board/boardDetailView";
	
	@Autowired
	BoardCommentsDao bcmt_dao;
	
	
	//boardDetailView.jsp에서 댓글등록 클릭시 요청(내용, 게시글번호, 아이디, 페이지번호 4개를 챙겨서 옴)
	@RequestMapping(value=command, method=RequestMethod.POST)
	public ModelAndView doAction(@ModelAttribute("boardcomments") @Valid BoardCommentsBean boardcomments, BindingResult result,
			@RequestParam("pageNumber") String pageNumber) {
		
		System.out.println("boardcomments.getBoardnum(): "+boardcomments.getBnum()); //11
		System.out.println("boardcomments.getUserid(): "+boardcomments.getUserid()); //admin
		System.out.println("boardcomments.regdate(): "+boardcomments.getRegdate()); //null 
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("pageNumber", pageNumber);
		mav.addObject("num", boardcomments.getBnum()); //게시글의 번호(bnum) 11을 num으로 보낸다.
		//detail.br에서는 게시글 번호를 num으로 받고 있기 때문이다.
		
		System.out.println("result.hasErrors(): "+result.hasErrors()); 
		if(result.hasErrors()) { //에러 있음
			//mav.setViewName(getPage);
		}
		else {//유효성검사 통과
			int cnt = -1;
			cnt = bcmt_dao.insertBoardComments(boardcomments);
			
			System.out.println("삽입후 boardcomments의 userid: "+boardcomments.getUserid()); //admin
			System.out.println("삽입후 boardcomments의 regdate: "+boardcomments.getRegdate());//null
			System.out.println("cnt: "+cnt); //1 
			
			if(cnt != -1) { //댓글 insert 성공
				System.out.println("댓글 insert 성공");
				mav.setViewName(gotoPage);
			}
			else { //insert 실패
				System.out.println("댓글 insert 실패");
				//mav.setViewName(getPage);
			}		
		}
		return mav;
	}
	
	
}
