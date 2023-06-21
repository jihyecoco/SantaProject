<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../common/common_top.jsp"%>
<%@ include file="../../common/common_nav_admin.jsp"%>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery.js"></script>
<script type="text/javascript">
</script>	
<% 
	String[] thArr = {"번호", "아이디", "관리자명", "성별", "생년월일", "관리자승인일", "권한"};
%>

<div class="container-fluid py-5">
	<div class="container" style="display:table">
		<div class="text-center mx-auto wow fadeInUp" data-wow-delay="0.1s" style="max-width: 500px;">
			<h1 class="display-5 mb-5">관리자 목록</h1>
		</div>
		<!-- 검색 Start -->
		<nav class="navbar navbar-light bg-light" style="margin-bottom: 30px;">
			<div class="container" style="display: table-cell; vertical-align: middle;">
				<form class="d-flex" action="/admin/admin/adminList.us" method="post">

					<div class="col-sm-2">
						<select name="whatColumn" class="form-select">
							<option value="">전체</option>
							<option value="user_id">아이디</option>
							<option value="name">이름</option>
							<option value="gender">성별</option>
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
				
<!-- 관리자 목록 start -->
<div class="container">
	<!-- 정렬 -->
	<div align="right">
		<a href="#">최신순</a> / 
		<a href="#">조회순</a> / 
		<a href="#">댓글순</a>
		<br>
	</div>
	<!-- //정렬 -->
	<table class="table table-hover table-borded align-middle">
		<thead>
			<tr>
				<c:forEach var="th" items="<%= thArr %>">
					<th>${th}</th>
				</c:forEach>
			</tr>
		</thead>
		<tbody>
		  	<c:if test="${adminList == null || adminList.size() == 0}">
		  		 <tr>
			  		<td colspan="7" align="center">등록된 데이터가 없습니다.</td>
			  	</tr>
			  	</c:if>
			  	<c:if test="${adminList != null && adminList.size() != 0}">
				  	<c:forEach var="admin" items="${adminList}">
					    <tr>
							<td scope="col">${admin.userNum}</td>
							<td scope="col">
								<a href="#">${admin.userId}</a>
							</td>
							<td scope="col">${admin.name}</td>
							<td scope="col">${admin.gender}</td>
							<td scope="col">
								<fmt:parseDate var="parse_birth" value="${admin.birth}" pattern="yyyy-MM-dd"/>​
								<fmt:formatDate  var="fmt_birth" value="${parse_birth}" pattern="yyyy-MM-dd"/>
								${fmt_birth}
							</td>
							<td scope="col">
									<fmt:parseDate var="parse_udate" value="${admin.udate}" pattern="yyyy-MM-dd"/>​
									<fmt:formatDate  var="fmt_udate" value="${parse_udate}" pattern="yyyy-MM-dd"/>
									${fmt_udate}
							</td>
							<td scope="col">
								<c:if test="${admin.status eq 'Y'}">
									O
								</c:if>
								<c:if test="${admin.status eq 'N'}">
									X
								</c:if>
							</td>
					    </tr>
				  	</c:forEach>
			  	</c:if>
		</tbody>
	</table>
</div>
<!-- 관리자 목록 end -->
	
<!-- 페이지 start -->
<div align="center">${pageInfo.pagingHtml}</div>
<!-- //페이지 End -->

<%@ include file="../../common/common_bottom.jsp"%>