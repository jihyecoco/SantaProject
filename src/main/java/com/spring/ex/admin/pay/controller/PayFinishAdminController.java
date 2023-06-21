package com.spring.ex.admin.pay.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.spring.ex.pay.model.PayDao;

@Controller
public class PayFinishAdminController {
	private final String command = "/pay/admin/finishlist.pay";
	private String getPage = "admin/pay/admin_finishpay";
	
	@Autowired
	PayDao pay_dao;
	
	/* 
	 관리자 결제 승인 완료내역 클릭 => admin_finishpay.jsp
	 */
	@RequestMapping(command)
	public ModelAndView doAction() {
		ModelAndView mav = new ModelAndView();
		return mav;
	}
}
