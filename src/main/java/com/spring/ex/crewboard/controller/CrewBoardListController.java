package com.spring.ex.crewboard.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.spring.ex.crewboard.model.CrewBoardBean;
import com.spring.ex.crewboard.model.CrewBoardDao;
import com.spring.ex.utility.Paging;


@Controller
public class CrewBoardListController {
	
	//private final String command = "/list.bdcr";
	private final String command = "/crewboard/all/list.bdcr";
	private final String getPage = "/crewboard/crewboardList";
	
	@Autowired
	CrewBoardDao cbdao;
	
	//1. 크루등록완료(list.bdcr요청)
		//2. crewboardList.jsp 에서 검색시
		//3. 크루모집 게시판 메뉴 클릭시 요청
	@RequestMapping(value=command)
	public ModelAndView doAction(@RequestParam(value="whatColumn", required=false) String whatColumn,
			@RequestParam(value="keyword", required=false) String keyword,
			@RequestParam(value="pageNumber", required=false) String pageNumber,
			HttpServletRequest request) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("whatColumn", whatColumn);
		map.put("keyword", "%"+keyword+"%");
		
		int totalCount = cbdao.getTotalCount(map);
		String url = request.getContextPath()+command;
		Paging pageInfo = new Paging(pageNumber, "5", totalCount, url, whatColumn, keyword, null);
		
		List<CrewBoardBean> crewboard_list = cbdao.getAllCrewboard(map, pageInfo);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("crewboard_list", crewboard_list);
		mav.addObject("pageInfo", pageInfo);
		mav.setViewName(getPage);
		
		return mav;
	}
}
