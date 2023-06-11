package com.spring.ex.crewcomments.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.ex.crewcomments.model.CrewCommentsBean;
import com.spring.ex.crewcomments.model.CrewCommentsDao;

@Controller
public class CrewCommentsListController {
	
	//private final String command = "/list.ccmt";
	private final String command = "/crewcomments/user/list.ccmt";
	
	@Autowired
	CrewCommentsDao ccmt_dao;
	
	@RequestMapping(value=command)
	@ResponseBody
	public List<CrewCommentsBean> doAction(@RequestParam("idx") int idx){
		System.out.println("idx:"+idx);
		List<CrewCommentsBean> comments = new ArrayList<CrewCommentsBean>();
		comments = ccmt_dao.getCrewCommentsByIdx(idx);
		System.out.println("comments size : "+comments.size());
		return comments;
	}
}
