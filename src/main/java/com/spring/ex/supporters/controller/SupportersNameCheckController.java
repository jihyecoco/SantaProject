package com.spring.ex.supporters.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.ex.supporters.model.SupportersDao;


@Controller
public class SupportersNameCheckController {
	
	private final String command = "/supporters/admin/supportersname_check.su";

	@Autowired
	SupportersDao sdao;
	
	//ajax함수로 서포터즈명 중복체크
	@RequestMapping(value=command)
	@ResponseBody
	public String doAction(@RequestParam("input_name") String input_name) {
		int cnt = -1;
		cnt = sdao.checkSupportersname(input_name);
		if(cnt == 1) { // 이미 있는 이름
			return "NO";
		}else {
			return "YES";
		}
	}
	
	
}//
