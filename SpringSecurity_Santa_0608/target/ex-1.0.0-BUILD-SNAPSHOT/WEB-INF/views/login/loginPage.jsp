<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>로그인</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<meta content="" name="keywords">
<meta content="" name="description">


<!-- Favicon & Stylesheet & Font-->
<%@ include file="../common/common_Stylesheet.jsp"%>
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
	<%@ include file="../common/common_Topbar.jsp"%>
	<!-- //Topbar End -->


	<!-- Navbar Start -->
	<%@ include file="../common/common_Navbar.jsp"%>
	<!-- //Navbar End -->


	<!-- Page Header Start -->
	<%@ include file="../common/common_Header.jsp"%>
	<!-- //Page Header End -->


	<!-- Login Start -->
	<div class="container-fluid py-5">
		<div class="container">
			<div class="text-center mx-auto wow fadeInUp" data-wow-delay="0.1s"
				style="max-width: 500px;">
				<!-- <p class="fs-5 fw-bold text-primary">로그인</p> -->
				<h1 class="display-5 mb-5">로그인</h1>
			</div>

			<div class="row justify-content-center">
				<div class="col-lg-7">
					<div class="bg-light rounded p-4 p-sm-5 wow fadeInUp"
						data-wow-delay="0.1s">
						<div class="row g-3 " >
							<form class="form-signin" action="/login.lg" method="POST">
								<div class="col-12 col-md-9 mx-auto">
									<div class="form-floating">
										<input type="text" name="userId" id="userId"
											class="form-control  border-0" placeholder="ID" required
											autofocus> <label for="userId">userId</label>
									</div>
								</div>
								<br>
								<div class="col-12 col-md-9 mx-auto">
									<div class="form-floating">
										<input type="password" name="password" id="password"
											class="form-control border-0" placeholder="Password" required>
										<label for="password">password</label>
									</div>
								</div>

								<div class="col-12 text-center">
									<button class="btn btn-primary py-3 px-4" type="submit">로그인</button>
									<c:if test="${param.err == true}">
										<p style="color: red">ID와 Password를 확인해주세요.</p>
									</c:if>
								</div>
							</form>
					
						</div><!-- row g-3 -->
					</div><!-- bg-light rounded p-4 p-sm-5 wow fadeInUp -->
					
					
				</div><!-- col-lg-7 -->
			</div><!-- row justify-content-center -->
		</div><!-- container -->
	</div><!-- container-fluid py-5-->
	<!-- //Login End -->


	<!-- Footer Start -->
	<%@ include file="../common/common_Footer.jsp"%>
	<!-- //Footer End -->


	<!-- Copyright Start -->
	<%@ include file="../common/common_Copyright.jsp"%>
	<!-- //Copyright End -->


	<!-- Back to Top -->
	<a href="#" class="btn btn-lg btn-primary btn-lg-square rounded-circle back-to-top"><i class="bi bi-arrow-up"></i></a>


	<!-- JavaScript Libraries & Template Javascript-->
	<%@ include file="../common/common_JS.jsp"%>
	<!-- //JavaScript Libraries & Template Javascript-->
</body>

</html>