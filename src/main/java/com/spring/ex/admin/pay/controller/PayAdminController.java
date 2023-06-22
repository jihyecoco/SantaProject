package com.spring.ex.admin.pay.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.spring.ex.pay.model.PayBean;
import com.spring.ex.pay.model.PayDao;

@Controller
public class PayAdminController {
	
	// 결제 승인 대기 내역들
	private final String command = "/pay/admin/waitlist.pay";
	private String getPage = "admin/pay/admin_waitpay";
	
	@Autowired
	PayDao pay_dao;
	
	@RequestMapping(command)
	public ModelAndView doAction() {
		ModelAndView mav = new ModelAndView();
		
		List<PayBean> paylist = pay_dao.getWaitPay();
		
		mav.addObject("paylist", paylist);
		mav.setViewName(getPage);
		return mav;
	}
	
	// 결제 승인 완료 내역들 (판매자 포인트 지급완료)
	
	
	// 결제 취소 내역(구매자 본인요청, 관리자 승인거절)
	
}
