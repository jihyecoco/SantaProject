<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common_top.jsp" %> 

    <!-- noticeDetailView.jsp<br> -->
    
<script type="text/javascript">
	
	function deletenotice(num, pageNumber){ //get방식 요청
		
		//confirm 창 띄워서 삭제하겠나고 물어보기
		//true면 -> 컨트롤러로 이동
		var isDel = confirm("정말 삭제하시겠습니까?"); //확인:true, 취소:false
		if(isDel == true){
			location.href="/notice/admin/delete.no?num="+num+"&pageNumber="+pageNumber;
		}			
	}
</script>

<!-- Page Header Start -->
    <div class="container-fluid page-header py-5 mb-5 wow fadeIn" data-wow-delay="0.1s">
        <div class="container text-center py-5">
            <h1 class="display-3 text-white mb-4 animated slideInDown">공지사항 게시판</h1>
            <nav aria-label="breadcrumb animated slideInDown">
                <ol class="breadcrumb justify-content-center mb-0">
                </ol>
            </nav>
        </div>
    </div>
<!-- Page Header End -->


<h2>글내용 보기</h2>    
<table border="1" class="table">
	<tr>
		<td>글번호</td>
		<td>${notice.num }</td>		
	</tr>
	<tr>
		<td>조회수</td>
		<td>${notice.readcount }</td>
	</tr>
	<tr>
		<td>작성자</td>
		<td>${notice.userid}</td>
	</tr>
	<tr>
		<td>작성일</td>
		<td>
			<fmt:parseDate var="newDay" value="${notice.regdate}" pattern="yyyy-MM-dd"/>				
			<fmt:formatDate var="fNewDay" value="${newDay}" pattern="yyyy-MM-dd"/>
			${fNewDay }
		</td>
	</tr>
	<tr>
		<td>글제목</td>
		<td>${notice.subject }</td>
	</tr>
	<tr>
		<td>글내용</td>
		<td><pre>${notice.content }</pre></td>
	</tr>
	<tr>
		<td colspan="2" align="center">		
			<input type="button" value="수정" class="btn btn-success" onClick="location.href='/notice/admin/update.no?num=${notice.num}&pageNumber=${pageNumber}'">
			<input type="button" value="삭제" class="btn btn-success" onClick="deletenotice('${notice.num}','${pageNumber}')">
			<input type="button" value="목록" class="btn btn-success" onclick="location.href='/notice/all/list.no?pageNumber=${pageNumber}'">
		</td>
	</tr>
</table>
  

<%@ include file="../common/common_bottom.jsp"%>  