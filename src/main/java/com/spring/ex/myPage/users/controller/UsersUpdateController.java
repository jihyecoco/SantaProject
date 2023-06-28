package com.spring.ex.myPage.users.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.security.Principal;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.spring.ex.users.model.UsersBean;
import com.spring.ex.users.model.UsersDao;

@Controller
public class UsersUpdateController {

    private final String command = "/users/user/usersUpdate.us";
    private String getPage = "/myPage/users/usersUpdate";  // 마이페이지 수정페이지
    private String gotoPage = "/myPage/users/myPage";      // 마이페이지 홈

    @Autowired
    UsersDao udao;

    @Autowired
    ServletContext servletContext;

    //마이페이지 사용자정보 update 화면띄우기
    @RequestMapping(value = command, method = RequestMethod.GET)
    public ModelAndView usersUpdate(Principal principal) {
        ModelAndView mav = new ModelAndView();
        String getUserId = principal.getName();
        System.out.println("myPage getUserId : " + getUserId);
        UsersBean usersBean = udao.getUsersByUserId(getUserId);
        String[] genderArr = {"남자", "여자"};        
        mav.addObject("genderArr", genderArr);
        mav.addObject("usersBean", usersBean);
        mav.setViewName(getPage);
        return mav;
    }//usersUpdate - GET

    //사용자가 sumbit을 클릭했을 때 한번 더 확인하는 confirmUpdate 함수 추가
	/*
	 * private boolean confirmUpdate(HttpServletRequest request) { return
	 * "true".equals(request.getParameter("confirmUpdate")); }
	 */
    
    // 마이페이지 사용자정보 update submit 클릭
    @RequestMapping(value = command, method = RequestMethod.POST)
    public ModelAndView usersUpdate(
            @ModelAttribute("usersBean") @Valid UsersBean usersBean,
            BindingResult result,
            HttpServletRequest request,
            HttpServletResponse response,
            HttpSession session) throws Exception {

        ModelAndView mav = new ModelAndView();
        //UsersBean existingUsersBean = udao.getUsersByUserId(usersBean.getUserId());
        //usersBean.setUserRole(usersBean.getUserRole());
        String[] genderArr = {"남자", "여자"};

        if (result.hasErrors()) {
            mav.addObject("usersBean", usersBean);
            mav.addObject("genderArr", genderArr);
            mav.setViewName(getPage);
            return mav;
        }

        String osName = System.getProperty("os.name").toLowerCase();
        String tempFilePath = null;
        if (osName.contains("win")) {
            tempFilePath = "C:/tempUpload/users";
        } else if (osName.contains("mac")) {
            tempFilePath = "/Users/ol7roeo/Documents/tempUpload/users";
        }

        //if (confirmUpdate(request)) {
        int cnt = udao.usersUpdate(usersBean);

        if (cnt == 1) {
            MultipartFile multi = usersBean.getUpload();
            if (multi != null && !multi.isEmpty()) {
                String uploadpath = servletContext.getRealPath("/resources/images/users");
                File destination = new File(uploadpath + File.separator + multi.getOriginalFilename());
                try {
                    multi.transferTo(destination);
                    FileCopyUtils.copy(destination, new File(tempFilePath + File.separator + multi.getOriginalFilename()));
                } catch (IllegalStateException e) {
                    e.printStackTrace();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }

            mav.addObject("successMessage", "사용자 정보가 수정되었습니다.");
        } else {
            mav.addObject("errorMessage", "사용자 정보 수정에 실패하였습니다.");
        }
       // }

        mav.addObject("usersBean", usersBean);
        mav.addObject("genderArr", genderArr);
        mav.setViewName(getPage);
        return mav;
    }


}//UsersUpdateController
