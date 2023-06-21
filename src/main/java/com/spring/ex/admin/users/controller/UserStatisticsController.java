package com.spring.ex.admin.users.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.spring.ex.users.model.UsersDao;

@Controller
public class UserStatisticsController {
	
	private final String command = "/users/admin/userStatistics.us";
	private String gotoPage = "/admin/users/userStatistics";
	
	@Autowired
	UsersDao udao;
	
	@RequestMapping(value = command)
	public ModelAndView usersList() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName(gotoPage);
		return mav;
	}//usersList
	

}//UserStatisticsController
