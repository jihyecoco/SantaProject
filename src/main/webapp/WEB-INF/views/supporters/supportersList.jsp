<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common_top.jsp"%>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery.js"></script>
<script type="text/javascript">
	
	
</script>


	<!-- suppotersList.jsp<br> -->

<!-- Page Header Start -->
<div class="container-fluid page-header py-5 mb-5 wow fadeIn"
	data-wow-delay="0.1s">
	<div class="container text-center py-5">
		<h1 class="display-3 text-white mb-4 animated slideInDown">서포터즈 게시판</h1>
		<nav aria-label="breadcrumb animated slideInDown">
			<ol class="breadcrumb justify-content-center mb-0">
			</ol>
		</nav>
	</div>
</div>
<!-- Page Header End -->
    
    <%@ include file ="../common/common_nav_supporters.jsp"%>


<!-- Projects Start -->
<div class="container-xxl py-5">
	<div class="container">
		<div class="text-center mx-auto wow fadeInUp" data-wow-delay="0.1s" style="max-width: 500px;">
			<p class="fs-5 fw-bold text-primary"></p>
            <h3 class="display-5 mb-5">서포터즈 게시판</h3>
        </div>
    
    <!-- 검색 기능 창 -->
    <div class="col-12 text-center">
		<nav class="navbar navbar-light bg-light">
			<div class="container" style="display: table-cell; vertical-align: middle;">
				<form class="d-flex" action="/supporters/all/list.su" method="post">
					<div class="col-sm-2">
						<select name="whatColumn" class="form-select">
							<option value="">전체</option>
							<option value="supporters_name">서포터즈명</option>
							<option value="content">내용</option>
						</select>
					</div>
					<div class="col-sm-8">
						<input class="form-control me-2" type="text" name="keyword">
					</div>
					<div class="col-sm-2" align="center">
						<button class="btn btn-outline-success" type="submit">Search</button>
					</div>
				</form>
			</div>
		</nav><br>
	</div>
	<!-- //검색 기능 창 -->	

	<div align="right">
		<!-- 글쓰기 버튼은 관리자에게만 보이도록 -->
			<input type="button" value="글쓰기" class="btn btn-success" onclick="location.href='/supporters/admin/insert.su?pageNumber=${pageInfo.pageNumber}'">
	</div><br>
	
	
<!-- 목록보기 -->
<table border="1" class="table">
	<tr>
		<th>No</th>
		<th>모집 상태</th>
		<th>서포터즈명</th>		
		<th>신청 인원</th>
		<th>모집 마감일</th>
		<th>조회수</th>
		<th>작성일</th>
	</tr>
	
	<c:if test="${fn:length(lists) == 0}">
		<tr>
			<td colspan="8" align="center">
				게시판에 게시된 글이 없습니다.
			</td>
		</tr>
	</c:if>
	
	<c:if test="${not empty lists}">
	<c:forEach var="supporters" items="${lists}">
		<tr>
			<td>${supporters.num}</td>			
			<td>
				<!-- 디폴트는 모집중(0), 인원이 다 차면 모집완료(1), 모집기한이 지나면 모집마감(2) -->
				<c:if test="${supporters.state == 0}"><font color="blue">[모집중]</font></c:if>
	    		<c:if test="${supporters.state == 1}"><font color="red">[모집완료]</font></c:if>
	    		<c:if test="${supporters.state == 2}"><font color="black">[모집기한 마감]</font></c:if>			
			</td>
			<td>
				<a href="/supporters/user/detail.su?num=${supporters.num}&pageNumber=${pageInfo.pageNumber}">${supporters.supportersname}</a>
			</td>			
			<td>${supporters.applicant}/${supporters.limit}</td>
			<td>
				<fmt:parseDate var="newDay2" value="${supporters.deadline}" pattern="yyyy-MM-dd"/>				
				<fmt:formatDate var="fNewDay2" value="${newDay2}" pattern="yyyy-MM-dd"/>
				${fNewDay2 }
			</td>
			<td>${supporters.readcount}</td>
			<td>
				<fmt:parseDate var="newDay" value="${supporters.regdate}" pattern="yyyy-MM-dd"/>				
				<fmt:formatDate var="fNewDay" value="${newDay}" pattern="yyyy-MM-dd"/>
				${fNewDay }
			</td>
		</tr>
	</c:forEach>
	</c:if>		
</table>
<!-- //목록보기 -->
     </div>
</div>

<!-- 페이지 표시 -->
<div align="center">
	${pageInfo.pagingHtml}
</div>
<!-- //페이지 표시 -->
	

<%@ include file="../common/common_bottom.jsp"%> 