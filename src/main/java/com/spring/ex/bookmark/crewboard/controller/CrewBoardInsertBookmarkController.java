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
public class CrewBoardInsertBookmarkController {
	
	private final String command = "/bookmark/user/crewboard/insertBookmark.bk";
	
	@Autowired
	CrewBoardBookmarkDao cbbdao;
	
	//크루게시판 상세보기 crewboardDetailView.jsp(input_userId,input_idx) -> 좋아요(empty_bookmark) 아이콘 클릭 (ajax 요청)
	//empty_bookmark -> bookmark
	@RequestMapping(value=command, method = RequestMethod.POST)
	@ResponseBody
	public String CrewBoardInsertBookmark(
			@RequestParam("input_userId") String input_userId,
			@RequestParam("input_idx") int input_idx	) {
		System.out.println("---Controller CrewBoardInsertBookmark---");
		
		CrewBoardBookmarkBean cbhBean = new CrewBoardBookmarkBean();
		cbhBean.setCrewboardNum(input_idx);
		cbhBean.setUserId(input_userId);
		int cnt = -1;
		String result = "";
		try {
			cnt = cbbdao.crewBoardInsertBookmark(cbhBean);
			System.out.println("crewBoardInsertBookmark cnt : " + cnt);
			
			if(cnt == 1) { 
				result =  "success";
			}else {
				result =  "fail";
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return result;
		
	}//CrewBoardInsertBookmark
	
}//CrewBoardInsertBookmarkController
