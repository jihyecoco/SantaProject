<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../common/common_top.jsp"%>
<%@ include file="../../common/common_nav_admin.jsp"%>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery.js"></script>
<script type="text/javascript">
</script>	

	<div class="container-fluid py-5">
		<div class="container">
			<div class="text-center mx-auto wow fadeInUp" data-wow-delay="0.1s"
				style="max-width: 500px;">
				<h1 class="display-5 mb-5">회원 통계</h1>
			</div>
			<!-- 검색 Start -->
			<nav class="navbar navbar-light bg-light"
				style="margin-bottom: 30px;">
				<div class="container"
					style="display: table-cell; vertical-align: middle;">
					<form class="d-flex" action="/users/admin/usersList.us" method="post">
						<div class="col-sm-2">
							<select name="whatColumn" class="form-select">
								<!-- <option value="">전체</option>
								<option value="userId">아이디</option>
								<option value="name">이름</option>
								<option value="userRole">등급</option>
								<option value="gender">성별</option> -->
							</select>
						</div>
						<div class="col-sm-8">
							<input class="form-control me-2" type="text" name="keyword">
						</div>
						<div class="col-sm-2" align="center">
							<button class="btn btn-outline-success" type="submit">Search</button>
						</div>
					</form>
				</div><!-- //container -->
			</nav><!-- //navbar -->
        </div><!-- //container - display:table -->
    </div><!-- //container-fluid -->
	<!-- //검색 End -->


<%@ include file="../../common/common_bottom.jsp"%>