package com.spring.ex.bookmark.crewboard.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.ex.bookmark.crewboard.model.CrewBoardBookmarkBean;
import com.spring.ex.bookmark.crewboard.model.CrewBoardBookmarkDao;

@Controller
public class CrewBoardBookmarkCheckController {

	private final String command = "/bookmark/user/crewboard/checkBookmark.bk";
	
	@Autowired
	CrewBoardBookmarkDao cdao;
	
	//크루게시판 상세보기 crewboardDetailView.jsp(input_userId,input_idx)가 로드될 때 게시글의 좋아요 상태 확인
	@RequestMapping(value=command, method = RequestMethod.POST)
	@ResponseBody
	public String CrewBoardCheckBookmark(
	  @RequestParam("input_userId") String input_userId,
	  @RequestParam("input_idx") int input_idx
	 	
		) {
		System.out.println("1---CrewBoardCheckBookmark---");
		
		/*
		 * String input_userId = ""; int input_idx = 0;
		 */
        
		CrewBoardBookmarkBean cbhBean = new CrewBoardBookmarkBean();
		cbhBean.setCrewboardNum(input_idx);
		cbhBean.setUserId(input_userId);
		int cnt = -1;
		System.out.println("2---check input_idx : "+ input_idx);
		System.out.println("3---check input_idx : "+ input_userId);
		System.out.println("4---crewBoardCheckBookmark! ");
		cnt = cdao.crewBoardCheckBookmark(cbhBean);
		System.out.println("5---crewBoardCheckBookmark cnt : " + cnt);
		String result = "";
		if(cnt == 1) { 
 			result =  "check";
		}else {
			result =  "fail";
		}
		System.out.println("6---crewBoardCheckBookmark result : " + result);
		return result;
		
	}//CrewBoardCheckBookmark
	
}//CrewBoardBookmarkCheckController

