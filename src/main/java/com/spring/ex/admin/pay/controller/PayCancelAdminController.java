package com.spring.ex.admin.pay.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.spring.ex.pay.model.PayDao;

@Controller
public class PayCancelAdminController {
	private final String command = "/pay/admin/cancel.pay";
	private String gotoPage = "redirect:/pay/admin/cancellist.pay";
	private String gotoPage2 = "redirect:/pay/admin/waitlist.pay";
	
	@Autowired
	PayDao pay_dao;
	
	
	// 관리자 결제 승인 대기내역에서 취소버튼 => admin_cancelpay.jsp
	@RequestMapping(command)
	public ModelAndView doAction(@RequestParam("paynum") int paynum,
			HttpServletResponse response) {
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = null;
		
		ModelAndView mav = new ModelAndView();
		
		int cnt = pay_dao.updatePayStateByAdmin(paynum);
		if(cnt != -1) { // DB 수정 성공
			try {
				out = response.getWriter();
				out.println("<script>alert('결제 취소 되었습니다.');</script>");
				//out.flush(); -- 설정한 setViewName으로 넘어가지 않음
			} catch (IOException e) {
				e.printStackTrace();
			}
			mav.setViewName(gotoPage);
			
		}else { // DB 수정 실패
			try {
				out = response.getWriter();
				out.println("<script>alert('결제 취소 실패했습니다.');</script>");
				//out.flush(); -- 설정한 setViewName으로 넘어가지 않음
			} catch (IOException e) {
				e.printStackTrace();
			}
			mav.setViewName(gotoPage2);
		}
		
		return mav;
	}
}
