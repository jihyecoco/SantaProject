package com.spring.ex.admin.admin.controller;

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
public class AdminListController {
	private final String command = "/admin/admin/adminList.us";
	private String gotoPage = "/admin/admin/adminList";
	
	@Autowired
	UsersDao udao;
	
	@RequestMapping(value = command)
	public ModelAndView adminList(
			@RequestParam(value="whatColumn", 	required=false) String whatColumn,
			@RequestParam(value="keyword", 		required=false) String keyword,
			@RequestParam(value="pageNumber", 	required=false) String pageNumber,
			HttpServletRequest request, Principal principal	) {
		
		ModelAndView mav = new ModelAndView();
	    Map<String, String> map = new HashMap<String, String>();
	
	    String url = "";
	    List<UsersBean> adminList = null;
	    Paging pageInfo = null;
	
	    try {
	        map.put("whatColumn", whatColumn);
	        map.put("keyword", "%" + keyword + "%");
	
	        int totalCount = udao.getAdminTotalCount(map);
	        url = request.getContextPath() + "/admin/admin/adminList.us";
	        pageInfo = new Paging(pageNumber, "5", totalCount, url, whatColumn, keyword, null);
	        adminList = udao.getAllAdminList(map, pageInfo);
	
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	
	    mav.addObject("adminList", adminList);
	    mav.addObject("pageInfo", pageInfo);
	    mav.setViewName(gotoPage);
	    return mav;
	}//adminList
	
}//AdminListController
