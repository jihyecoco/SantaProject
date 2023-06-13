<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common_top.jsp" %> 

    <!-- boardList.jsp<br> -->
    
<!-- Page Header Start -->
    <div class="container-fluid page-header py-5 mb-5 wow fadeIn" data-wow-delay="0.1s">
        <div class="container text-center py-5">
            <h1 class="display-3 text-white mb-4 animated slideInDown">자유 게시판</h1>
            <nav aria-label="breadcrumb animated slideInDown">
                <ol class="breadcrumb justify-content-center mb-0">
                    <li class="breadcrumb-item"><a href="">정보</a></li>
                    <li class="breadcrumb-item"><a href="">후기</a></li>
                    <li class="breadcrumb-item"><a href="">추천</a></li>
                    <li class="breadcrumb-item"><a href="">잡담</a></li>
                   <!--  <li class="breadcrumb-item active" aria-current="page">Free Quote</li> -->
                </ol>
            </nav>
        </div>
    </div>
<!-- Page Header End -->

<center>
<!-- Projects Start -->
<div class="container-xxl py-5">
	<div class="container">
		<div class="text-center mx-auto wow fadeInUp" data-wow-delay="0.1s" style="max-width: 500px;">
			<p class="fs-5 fw-bold text-primary"></p>
            <h3 class="display-5 mb-5">자유게시판 목록</h3>
        </div>           

		<nav class="navbar navbar-light bg-light">
  			<div class="container" style="display:table-cell; vertical-align:middle;">
   				<form class="d-flex" action="/board/all/list.br" method="get">
   				 	<div class="col-sm-2">
	   				 	<select name="whatColumn" class="form-select">
							<option value="">전체검색
							<option value="user_id">작성자
							<option value="category">카테고리
							<option value="subject">제목
							<option value="content">내용
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
	
	<!-- select 태그를 이용한 정렬 -->
		<form class="d-flex" action="/board/all/list.br" method="get">
		<div class="col-sm-2" align="right">
	   		<select name="Array" class="form-select">
				<option value="-1">정렬
				<option value="1">작성순
				<option value="2">조회수순
			 	<option value="3">댓글수순
				<option value="4">좋아요순
	   		</select>
   		</div>
   		</form><br>
	<!-- //select 태그를 이용한 정렬 -->
	
<table border="1" class="table">
	<tr>
		<th>No</th>
		<th>이미지</th>
		<th>카테고리</th>		
		<th>제목</th>
		<th>작성자</th>
		<th>조회수</th>
		<th>작성일</th>
	</tr>
	
	<c:if test="${fn:length(lists) == 0}">
		<tr>
			<td colspan="7" align="center">
				게시판에 게시된 글이 없습니다.
			</td>
		</tr>
	</c:if>
	
	<c:if test="${not empty lists}">
	<c:forEach var="board" items="${lists}">
		<tr>
			<td>${board.num}</td>
			<td>
				<img src="<%=request.getContextPath() %>/resources/${board.image}" width="100" height="100">
			</td>
			<td>${board.category}</td>
			<td><a href="/board/user/detail.br?num=${board.num}&pageNumber=${pageInfo.pageNumber}">${board.subject}</a></td>
			<td>${board.userid}</td>
			<td>${board.readcount}</td>
			<td>
				<fmt:parseDate var="newDay" value="${board.regdate}" pattern="yyyy-MM-dd"/>				
				<fmt:formatDate var="fNewDay" value="${newDay}" pattern="yyyy-MM-dd"/>
				${fNewDay }
			</td>
		</tr>
	</c:forEach>
	</c:if>		
	<tr>
		<td colspan="7" align="right">
			<input type="button" value="글쓰기" class="btn btn-success" onclick="location.href='/board/user/insert.br?pageNumber=${pageInfo.pageNumber}'">
		</td>
	</tr>
</table><br>
${pageInfo.pagingHtml}
</center>    
     </div>
</div>

<%@ include file="../common/common_bottom.jsp"%>