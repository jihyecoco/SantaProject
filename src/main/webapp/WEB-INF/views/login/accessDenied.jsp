<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>권한없음(접근 제한 페이지)</title>
<!-- 로그인페이지(loginPage.jsp) -> 회원가입 클릭(signUp.jsp)  -->
<%@ include file="../common/common_top.jsp"%>
	<h3>권한없음(접근 제한 페이지)</h3>
	    <!-- 404 Start -->
    <div class="container-xxl py-5 wow fadeInUp" data-wow-delay="0.1s">
        <div class="container text-center">
            <div class="row justify-content-center">
                <div class="col-lg-6">
                    <i class="bi bi-exclamation-triangle display-1 text-primary"></i>
                    <h1 class="display-1">404</h1>
                    <h1 class="mb-4">Page Not Found</h1>
                    <p class="mb-4">We’re sorry, the page you have looked for does not exist in our website! Maybe go to our home page or try to use a search?</p>
                    <a class="btn btn-primary py-3 px-4" href="">Go Back To Home</a>
                </div>
            </div>
        </div>
    </div>
    <!-- 404 End -->

<%@ include file="../common/common_bottom.jsp"%>
</html>