package com.spring.ex.products.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.spring.ex.products.model.ProductsBean;
import com.spring.ex.products.model.ProductsDao;

@Controller
public class ProductsListController {
	
	//private final String command = "/list.prd";
	private final String command = "/products/all/list.prd";
	private String getPage = "products/productsList";
	
	@Autowired
	ProductsDao pdao;
	
	//productInsertForm.jsp에서 등록시 요청
	@RequestMapping(value=command)
	public ModelAndView doAction() {
			ModelAndView mav = new ModelAndView();
			List<ProductsBean> plist = pdao.getAllProducts();
			mav.addObject("plist", plist);
			mav.setViewName(getPage);
			return mav;
		}
}
