package com.spring.ex.admin.users.controller;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.spring.ex.users.model.UsersBean;
import com.spring.ex.users.model.UsersDao;
import com.spring.ex.utility.Paging;

@Controller
public class UsersWithdrawalListController {

	private final String command = "/users/admin/usersWithdrawalList.us";
	private String gotoPage = "/admin/users/usersWithdrawalList";
	
	@Autowired
	UsersDao udao;
	
	@RequestMapping(value = command)
	public ModelAndView usersList(
			@RequestParam(value="whatColumn", required=false) String whatColumn,
			@RequestParam(value="keyword", required=false) String keyword,
			@RequestParam(value="pageNumber", required=false) String pageNumber,
			HttpServletRequest request, Principal principal	) {
		
		ModelAndView mav = new ModelAndView();
		Map<String, String> map = new HashMap<String, String>();
		
		int totalCount 	= 0;
		String url 		= "";
		Paging pageInfo = null;
		List<UsersBean> usersWithdrawalList = null;
		try {
			map.put("whatColumn", whatColumn);
			map.put("keyword", "%"+keyword+"%");
			
			totalCount = udao.getUserWithdrawalTotalCount(map);
			url = request.getContextPath()+command;
			pageInfo = new Paging(pageNumber, "5", totalCount, url, whatColumn, keyword, null);
			usersWithdrawalList = udao.getAllUserWithdrawalList(map, pageInfo);

		} catch (Exception e) {
			e.printStackTrace();
		}
		
		mav.addObject("usersWithdrawalList", usersWithdrawalList);
		mav.addObject("pageInfo", pageInfo);
		mav.setViewName(gotoPage);
		return mav;
	}//usersList
	
}//UsersWithdrawalListController
