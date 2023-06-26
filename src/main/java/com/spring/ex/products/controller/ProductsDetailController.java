package com.spring.ex.products.controller;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.spring.ex.heart.products.model.ProductsHeartBean;
import com.spring.ex.heart.products.model.ProductsHeartDao;
import com.spring.ex.products.model.ProductsBean;
import com.spring.ex.products.model.ProductsDao;


@Controller
public class ProductsDetailController {
	private final String command = "/products/user/detail.prd";
	private String getPage = "products/productsDetailView";
	
	@Autowired
	ProductsDao pdao;
	
	//좋아요
	@Autowired
	ProductsHeartDao phdao;
		
	//productsList.jsp에서 제목 클릭시 요청
	@RequestMapping(value=command)
	public ModelAndView doAction(@RequestParam("num") int num,
			@RequestParam(value="pageNumber", required=false) String pageNumber,
			Principal principal) {
		
		ModelAndView mav = new ModelAndView();
		String loginId = principal.getName();
		mav.addObject("pageNumber", pageNumber); // 페이지
		mav.addObject("loginId", principal.getName()); // 로그인 아이디
		
		ProductsBean pb = pdao.getProductsByNum(num);
		
		/* 좋아요 */
		int getHeartCnt = 0;
		int getHeartTotal = 0;
		try {
			ProductsHeartBean phBean = new ProductsHeartBean();
			phBean.setProductsNum(num);	//게시글번호
			phBean.setUserId(loginId);		//사용자아이디
			
			//crewBoardCheckHeart : 현재 로그인한 사용자(loginId)의 해당 게시글(num) 좋아요 클릭여부
			//getHeartCnt : 좋아요 여부 전달 1:좋아요클릭, 0:좋아요클릭X
			getHeartCnt = phdao.productsCheckHeart(phBean);
			
			//현재 게시글의 좋아요 수 확인
			getHeartTotal = phdao.getProductsHeartTotal(phBean);
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		
		mav.addObject("pb", pb);
		//좋아요
		mav.addObject("getHeartCnt",getHeartCnt);
		mav.addObject("getHeartTotal",getHeartTotal);
		
		mav.setViewName(getPage);
		
		return mav;
	}
}
