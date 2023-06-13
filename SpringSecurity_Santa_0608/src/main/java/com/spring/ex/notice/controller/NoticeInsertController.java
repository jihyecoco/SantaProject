package com.spring.ex.notice.controller;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.spring.ex.notice.model.NoticeBean;
import com.spring.ex.notice.model.NoticeDao;

@Controller
public class NoticeInsertController {

	private final String command = "/notice/admin/insert.no";
	private final String getPage = "/notice/noticeInsertForm";
	private final String gotoPage = "redirect:/notice/all/list.no";

	@Autowired
	NoticeDao ndao;

	
	//noticeList.jsp(목록에서 글쓰기 버튼 클릭) -> insert.no 요청(get방식) -> noticeInsertForm.jsp로 이동
	@RequestMapping(value=command, method=RequestMethod.GET)
	public String insert() {

		return getPage;
	}


	//noticeInsertForm.jsp(글쓰기 버튼 클릭) -> detail.no 요청(post방식) -> 삽입성공시 list.no 요청
	@RequestMapping(value=command, method=RequestMethod.POST)
	public ModelAndView insert(@ModelAttribute("notice") @Valid NoticeBean notice, BindingResult result) {

		ModelAndView mav = new ModelAndView();

		System.out.println("result.hasErrors(): "+result.hasErrors());
		if(result.hasErrors()) { //에러 있음
			mav.setViewName(getPage);			
		}
		else { //에러 없음
			int cnt = ndao.insertNotice(notice);

			if(cnt != -1) {//삽입 성공
				mav.setViewName(gotoPage);
			}else {//삽입 실패
				mav.setViewName(getPage);	
			}
		}		
		return mav;
	}//

}
