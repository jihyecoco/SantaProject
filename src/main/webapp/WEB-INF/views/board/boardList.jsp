<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common_top.jsp" %> 

    <!-- boardList.jsp<br> -->
    
<script type="text/javascript">

	//정렬 select-option에서 클릭할때
	function clickSelect(){ //get방식 요청
		
		document.array.submit();
		
	}
		
</script>


<!-- Page Header Start -->
    <div class="container-fluid page-header py-5 mb-5 wow fadeIn" data-wow-delay="0.1s">
        <div class="container text-center py-5">
            <h1 class="display-3 text-white mb-4 animated slideInDown">자유 게시판</h1>
            <nav aria-label="breadcrumb animated slideInDown">
                <ol class="breadcrumb justify-content-center mb-0">
                </ol>
            </nav>
        </div>
    </div>
<!-- Page Header End -->

 <%@ include file ="../common/common_nav_board.jsp"%>
 

<!-- Projects Start -->
<div class="container-xxl py-5">
	<div class="container">
		<div class="text-center mx-auto wow fadeInUp" data-wow-delay="0.1s" style="max-width: 500px;">
			<p class="fs-5 fw-bold text-primary"></p>
            <h3 class="display-5 mb-5">자유 게시판</h3>
        </div>           
		<!-- 검색창 -->
		<nav class="navbar navbar-light bg-light">
  			<div class="container" style="display:table-cell; vertical-align:middle;">
   				<form class="d-flex" action="/board/all/list.br" method="get">
   				 	<div class="col-sm-2">
	   				 	<select name="whatColumn" class="form-select">
							<option value="">전체검색
							<option value="user_id">작성자
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
		<!-- //검색창 -->
		
		<!-- select-option 태그를 이용한 정렬 
		<form class="d-flex" action="/board/all/list.br" method="get">
		<div class="col-sm-2" align="right">
	   		<select name="whatColumn" class="form-select">
				<option value="">정렬
				<option value="reg_date">최신순
				<option value="readcount">조회수순
			 	<option value="#">댓글수순
				<option value="#">좋아요순
	   		</select>
   		</div>
   		</form>
		 //select-option 태그를 이용한 정렬 -->
		
		<!-- select-option 태그를 이용한 정렬 -->
		<form class="d-flex" action="/board/all/list.br" method="get" name="keyword">
			<div class="col-sm-2" align="right">
				<select name="whatColumn" class="form-select" onchange="clickSelect()">
					<option value="">--정렬--</option>
					<option value="reg_date">최신순</option>
					<option value="readcount">조회수순</option>
					<option value="#">댓글수순</option>
					<option value="#">좋아요순</option>
				</select>
			</div>
		</form>		
		<!-- //select-option 태그를 이용한 정렬 -->		
	</div>
</div>
<!-- //Projects Start -->	
	

<!-- 자유게시판 글 목록 출력 -->
<div class="container">
<table border="1" class="table">
	<tr align="center">
		<th>No</th>
		<th>카테고리</th>	
		<th>이미지</th>	
		<th>제목</th>
		<th>작성자</th>
		<th>조회수</th>
		<th>작성일</th>
	</tr>
	
	<c:if test="${fn:length(lists) == 0}">
		<tr>
			<td colspan="7" align="center">
				등록된 게시글이 없습니다.
			</td>
		</tr>
	</c:if>
	
	<c:if test="${not empty lists}">
	<c:forEach var="board" items="${lists}">
		<tr align="center">
			<td>${board.num}</td>
			<td>[${board.category}]</td>
			<td>
				<img src="<%=request.getContextPath() %>/resources/${board.image}" width="100" height="100">
			</td>		
			<td align="left">
				<a href="/board/user/detail.br?num=${board.num}&pageNumber=${pageInfo.pageNumber}">${board.subject}</a>
			</td>
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
</table>
</div>
<!-- //자유게시판 글 목록 출력 -->

<!-- 페이지 표시 -->
<div align="center">
	${pageInfo.pagingHtml}
</div>
<!-- //페이지 표시 -->
  


<%@ include file="../common/common_bottom.jsp"%>