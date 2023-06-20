package com.spring.ex.pay.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class PayFailController {
	private final String command = "/pay/user/fail.pay";
	
	// 오랜시간 로딩으로 결제 실패했을때
	@RequestMapping(command)
	public void doAction(HttpServletResponse response) {
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = null;
		
		try {
			out = response.getWriter();
			out.println("<script>alert('요청시간 초과로 결제 실패했습니다.');alert('다시 결제 시도해주세요');window.close();</script>");
			out.flush();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}	
