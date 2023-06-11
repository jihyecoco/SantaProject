package com.spring.ex.products.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.spring.ex.products.model.ProductsBean;
import com.spring.ex.products.model.ProductsDao;


@Controller
public class ProductsDetailController {
	private final String command = "/products/user/detail.prd";
	private String getPage = "products/productsDetailView";
	
	@Autowired
	ProductsDao pdao;
	
	//productsList.jsp에서 제목 클릭시 요청
	@RequestMapping(value=command)
	public ModelAndView doAction(@RequestParam("num") int num) {
		ModelAndView mav = new ModelAndView();
		
		ProductsBean pb = pdao.getProductsByNum(num);
		mav.addObject("pb", pb);
		
		mav.setViewName(getPage);
		return mav;
	}
}
