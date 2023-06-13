package com.spring.ex.products.controller;

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

import com.spring.ex.products.model.ProductsBean;
import com.spring.ex.products.model.ProductsDao;
import com.spring.ex.utility.Paging;

@Controller
public class ProductsListController {
	
	//private final String command = "/list.prd";
	private final String command = "/products/all/list.prd";
	private String getPage = "products/productsList";
	
	@Autowired
	ProductsDao pdao;
	
	/*
	 1. 상단 메뉴바에서 거래 클릭시 요청
	 2. productsInsertForm.jsp에서 등록시 요청
	 3. productsList.jsp에서 검색시 요청
	 4.	productsDetailView에서 목록보기시 요청
	 */
	@RequestMapping(value=command)
	public ModelAndView doAction(
			@RequestParam(value="whatColumn", required=false) String whatColumn,
			@RequestParam(value="keyword", required=false) String keyword,
			@RequestParam(value="pageNumber", required=false) String pageNumber,
			HttpServletRequest request, Principal principal) {
		
			ModelAndView mav = new ModelAndView();
			
			//검색어 설정
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("whatColumn", whatColumn);
			map.put("keyword", "%"+keyword+"%");
			
			//페이지 설정
			int totalCount = pdao.getProductsTotalCount(map);
			String url = request.getContextPath()+command;
			Paging pageInfo = new Paging(pageNumber, "9", totalCount, url, whatColumn, keyword, null);
			
			List<ProductsBean> plist = pdao.getAllProducts(map, pageInfo);
			mav.addObject("plist", plist); // 상품리스트
			mav.addObject("pageInfo", pageInfo); // 페이징
			//mav.addObject("loginId", principal.getName()); // 로그인 아이디 -- 챙길 필요없음 DetailController에서 챙기면 가능
			mav.setViewName(getPage);
			return mav;
		}
}
