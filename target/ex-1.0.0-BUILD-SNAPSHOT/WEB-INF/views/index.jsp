<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="common/common.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>로그인</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<meta content="" name="keywords">
<meta content="" name="description">


<!-- Favicon & Stylesheet & Font-->
<%@ include file="common/common_Stylesheet.jsp"%>
<!-- //Favicon & Stylesheet & Font-->
<body>
	<!-- Spinner Start -->
	<div id="spinner"
		class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
		<div class="spinner-border text-primary" role="status"
			style="width: 3rem; height: 3rem;"></div>
	</div>
	<!-- //Spinner End -->


	<!-- Topbar Start -->
	<%@ include file="common/common_Topbar.jsp"%>
	<!-- //Topbar End -->


	<!-- Navbar Start -->
	<%@ include file="common/common_Navbar.jsp"%>
	<!-- //Navbar End -->


	<!-- Page Header Start -->
	<%@ include file="common/common_Header.jsp"%>
	<!-- //Page Header End -->
	
	<h1>HOME!</h1>
	<p> The time on the server is ${serverTime} </p>
	<h3>계정 ${userInfo.userId} / 이름 ${userInfo.name} / 권한 ${userInfo.userRole}  님 반값습니다.</h3>
	
	<form:form action="${pageContext.request.contextPath}/logout" method="POST"> 
		<input type="submit" value="로그아웃" /> 
	</form:form>


<!-- Footer Start -->
	<%@ include file="common/common_Footer.jsp"%>
	<!-- //Footer End -->


	<!-- Copyright Start -->
	<%@ include file="common/common_Copyright.jsp"%>
	<!-- //Copyright End -->


	<!-- Back to Top -->
	<a href="#" class="btn btn-lg btn-primary btn-lg-square rounded-circle back-to-top"><i class="bi bi-arrow-up"></i></a>


	<!-- JavaScript Libraries & Template Javascript-->
	<%@ include file="common/common_JS.jsp"%>
	<!-- //JavaScript Libraries & Template Javascript-->
</body>

</html>